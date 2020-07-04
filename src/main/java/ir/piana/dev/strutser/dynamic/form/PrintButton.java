package ir.piana.dev.strutser.dynamic.form;

import java.util.List;

/**
 * Created by mj.rahmati on 12/26/2019.
 */
public class PrintButton {
    String title;
    String activity;
    String imageSrc;

    public PrintButton(String title, String activity, String imageSrc) {
        this.title = title;
        this.activity = activity;
        this.imageSrc = imageSrc;
    }

    public String getTitle() {
        return title;
    }

    public String getActivity() {
        return activity;
    }

    public String getImageSrc() {
        return imageSrc;
    }
}
