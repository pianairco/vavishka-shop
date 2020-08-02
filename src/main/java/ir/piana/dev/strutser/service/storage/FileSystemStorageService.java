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
import sun.misc.BASE64Decoder;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Map;
import java.util.stream.Stream;

@Service
public class FileSystemStorageService implements StorageService {
    private final Path rootLocation;

    StorageProperties storageProperties;

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        storageProperties = properties;
        this.rootLocation = Paths.get(properties.getLocation());
    }

    public GroupProperties getGroupProperties(String group) {
        return storageProperties.getGroups().get(group);
    }

    @Override
    public String store(MultipartFile file, String group) {
        Integer width = storageProperties.getGroups().get(group).getWidth();
        Integer height = storageProperties.getGroups().get(group).getHeight();
        return this.store(file, group, width, height);
    }

    public String store(MultipartFile file, String group, Integer width, Integer height) {
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

                return "/" + filePath;

            }
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file " + filename, e);
        }
    }

    public String store(String sourceData, String group) {
        String format = "";
        try {
            String[] parts = sourceData.split(",");
            String imageString = parts[1];

            if(parts[0].startsWith("data:")) {
                format = parts[0].substring(5).split(";")[0];
                if(format.equalsIgnoreCase("image/jpeg"))
                    format = "jpeg";
                if(format.equalsIgnoreCase("image/jpg"))
                    format = "jpg";
                else if(format.equalsIgnoreCase("image/png"))
                    format = "png";
            }
            String random = RandomStringUtils.randomAlphanumeric(64).concat(".").concat(format);
            String filePath = "".concat(storageProperties.getGroups().get(group).getFolder())
                    .concat(File.separator).concat(random);

            BufferedImage originalImage = null;
            byte[] imageByte;

            BASE64Decoder decoder = new BASE64Decoder();
            imageByte = decoder.decodeBuffer(imageString);
            ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
            originalImage = ImageIO.read(bis);
            bis.close();

            int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB
                    : originalImage.getType();

            BufferedImage scaledImg = resizeImage(originalImage, type,
                    storageProperties.getGroups().get(group).getWidth(),
                    storageProperties.getGroups().get(group).getHeight());

            ByteArrayOutputStream os = new ByteArrayOutputStream();
            ImageIO.write(scaledImg, format, os);
            // Passing: ​(RenderedImage im, String formatName, OutputStream output)
            InputStream is = new ByteArrayInputStream(os.toByteArray());

            Files.copy(is, this.rootLocation.resolve(filePath),
                    StandardCopyOption.REPLACE_EXISTING);

            return "/" + filePath;
        }
        catch (IOException e) {
            throw new StorageException("Failed to store file!", e);
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
