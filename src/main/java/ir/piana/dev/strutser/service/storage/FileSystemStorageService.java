package ir.piana.dev.strutser.service.storage;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;

@Service
public class FileSystemStorageService implements StorageService {
    private final Path rootLocation;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    StorageProperties storageProperties;

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        storageProperties = properties;
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @Override
    public void store(MultipartFile file, String group, Object[] sqlParams) {
        this.store(file, group, sqlParams, null, null);
    }

    public void store(MultipartFile file, String group, Object[] sqlParams, Integer width, Integer height) {
        String format = file.getOriginalFilename()
                .substring(file.getOriginalFilename().lastIndexOf(".") + 1);
        String random = RandomStringUtils.randomAlphanumeric(64).concat(".").concat(format);
        String filePath = ""
                .concat(storageProperties.getGroups().get(group).getFolder()).concat(File.separator).concat(random);
        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        try {
            if (file.isEmpty()) {
                throw new StorageException("Failed to store empty file " + filename);
            }
            if (filename.contains("..")) {
                // This is a security check
                throw new StorageException(
                        "Cannot store file with relative path outside current directory "
                                + filename);
            }
            try (InputStream inputStream = file.getInputStream()) {
                InputStream is = null;
                if(width != null && height != null) {
                    BufferedImage originalImage = ImageIO.read(inputStream);
//                    BufferedImage scaledImg = Scalr.resize(
//                            originalImage, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_WIDTH, 2000, 750);
                    int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB
                            : originalImage.getType();
                    BufferedImage scaledImg = resizeImage(originalImage, type, width, height);
//                    ImageIO.write(scaledImg, format, new File(filePath));
                    ByteArrayOutputStream os = new ByteArrayOutputStream();
                    ImageIO.write(scaledImg, format, os);
                    // Passing: ​(RenderedImage im, String formatName, OutputStream output)
                    is = new ByteArrayInputStream(os.toByteArray());
                } else {
                    is = inputStream;
                }
                Files.copy(is, this.rootLocation.resolve(filePath),
                            StandardCopyOption.REPLACE_EXISTING);

                jdbcTemplate.update(storageProperties.getGroups().get(group).getSql(),
                        ArrayUtils.addAll(new Object[]{filePath}, sqlParams));
            }//jdbcTemplate.queryForList("select * from header where id in (select id from (SELECT max(id) id, orders FROM header GROUP BY orders))")
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file " + filename, e);
        }
    }

    private static BufferedImage resizeImage(BufferedImage originalImage, int type,
                                             Integer img_width, Integer img_height)
    {
        BufferedImage resizedImage = new BufferedImage(img_width, img_height, type);
        Graphics2D g = resizedImage.createGraphics();
        g.drawImage(originalImage, 0, 0, img_width, img_height, null);
        g.dispose();

        return resizedImage;
    }

    @Override
    public Stream<Path> loadAll() {
        try {
            return Files.walk(this.rootLocation, 1)
                    .filter(path -> !path.equals(this.rootLocation))
                    .map(this.rootLocation::relativize);
        }
        catch (IOException e) {
            throw new StorageException("Failed to read stored files", e);
        }

    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            Resource resource = new UrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            }
            else {
                throw new StorageFileNotFoundException(
                        "Could not read file: " + filename);

            }
        }
        catch (MalformedURLException e) {
            throw new StorageFileNotFoundException("Could not read file: " + filename, e);
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    @Override
    public void init() {
        try {
            if(!Files.exists(rootLocation)) {
                Files.createDirectories(rootLocation);
            }
        }
        catch (IOException e) {
            throw new StorageException("Could not initialize storage", e);
        }
    }
}
