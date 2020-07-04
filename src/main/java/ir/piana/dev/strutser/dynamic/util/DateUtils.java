package ir.piana.dev.strutser.dynamic.util;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateUtils {
    private static int[] g_days_in_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    public static int[] j_days_in_month = {31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29};
    public static SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
    public static SimpleDateFormat timeFormatSecond = new SimpleDateFormat("HH:mm:ss");
    public static SimpleDateFormat timeFormatDetail = new SimpleDateFormat("HH:mm:ss:SSS");
    public static SimpleDateFormat dateFormatDetail = new SimpleDateFormat("yyyy/MM/dd");
    public static SimpleDateFormat dateTimeFormatFull = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private static long TICKS_AT_EPOCH = 621355968000000000L;
    private static long TICKS_PER_MILLISECOND = 10000;

    public static String getJalaliDate(String gregorianDate) {
        ///
        int g_y = Integer.parseInt(gregorianDate.substring(0, 4));
        int g_m = Integer.parseInt(gregorianDate.substring(5, 7));
        int g_d = Integer.parseInt(gregorianDate.substring(8));
        ///
        int gy, gm, gd;
        int jy, jm, jd;
        long g_day_no, j_day_no;
        int j_np;

        int i;
        gy = g_y - 1600;
        gm = g_m - 1;
        gd = g_d - 1;

        g_day_no = 365 * gy + (gy + 3) / 4 - (gy + 99) / 100 + (gy + 399) / 400;
        for (i = 0; i < gm; ++i)
            g_day_no += g_days_in_month[i];
        if (gm > 1 && ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0)))
            /* leap and after Feb */
            ++g_day_no;
        g_day_no += gd;

        j_day_no = g_day_no - 79;

        j_np = (int) j_day_no / 12053;

        j_day_no %= 12053;

        jy = (int) (979 + 33 * j_np + 4 * (j_day_no / 1461));
        j_day_no %= 1461;

        if (j_day_no >= 366) {
            jy += (j_day_no - 1) / 365;
            j_day_no = (j_day_no - 1) % 365;
        }

        for (i = 0; i < 11 && j_day_no >= j_days_in_month[i]; ++i) {
            j_day_no -= j_days_in_month[i];
        }
        jm = i + 1;
        jd = (int) j_day_no + 1;

        return jy + "/" + (jm < 10 ? "0" + jm : "" + jm) + "/" + (jd < 10 ? "0" + jd : "" + jd);
    }

    public static boolean isValidJalaliDate(String jalaiDate) {
        boolean valid = true;
        try {
            valid &= (jalaiDate.length() == 10);
            valid &= (jalaiDate.charAt(4) == '/');
            valid &= (jalaiDate.charAt(7) == '/');

            int j_y = Integer.parseInt(jalaiDate.substring(0, 4));
            int j_m = Integer.parseInt(jalaiDate.substring(5, 7));
            int j_d = Integer.parseInt(jalaiDate.substring(8));

            valid &= (j_y > 1200 && j_y < 1500);
            valid &= (j_m >= 1 && j_m <= 12);
            valid &= ((j_m >= 1 && j_m <= 6) && (j_d >= 1 && j_d <= 31)) || ((j_m >= 7) && (j_d >= 1 && j_d <= 30));
        } catch (Exception e) {
            valid = false;
        }
        return valid;
    }

    public static boolean isValidTime(String time) {
        boolean valid = true;
        try {
            valid &= (time.length() == 5);
            valid &= (time.charAt(2) == ':');

            int hh = Integer.parseInt(time.substring(0, 2));
            int mm = Integer.parseInt(time.substring(3));

            valid &= (hh >= 0 && hh < 24);
            valid &= (mm >= 0 && mm < 60);
        } catch (Exception e) {
            valid = false;
        }
        return valid;
    }

    public static String getGregorianDate(String jalaiDate) {
        ///
        int j_y = Integer.parseInt(jalaiDate.substring(0, 4));
        int j_m = Integer.parseInt(jalaiDate.substring(5, 7));
        int j_d = Integer.parseInt(jalaiDate.substring(8));
        ///
        int gy, gm, gd;
        int jy, jm, jd;
        long g_day_no, j_day_no;
        int leap;

        int i;

        jy = j_y - 979;
        jm = j_m - 1;
        jd = j_d - 1;

        j_day_no = 365 * jy + (jy / 33) * 8 + (jy % 33 + 3) / 4;
        for (i = 0; i < jm; ++i)
            j_day_no += j_days_in_month[i];

        j_day_no += jd;

        g_day_no = j_day_no + 79;

        gy = (int) (1600 + 400 * (g_day_no / 146097)); /* 146097 = 365*400 + 400/4 - 400/100 + 400/400 */
        g_day_no = g_day_no % 146097;

        leap = 1;
        if (g_day_no >= 36525) /* 36525 = 365*100 + 100/4 */ {
            g_day_no--;
            gy += 100 * (g_day_no / 36524); /* 36524 = 365*100 + 100/4 - 100/100 */
            g_day_no = g_day_no % 36524;

            if (g_day_no >= 365)
                g_day_no++;
            else
                leap = 0;
        }

        gy += 4 * (g_day_no / 1461); /* 1461 = 365*4 + 4/4 */
        g_day_no %= 1461;

        if (g_day_no >= 366) {
            leap = 0;

            g_day_no--;
            gy += g_day_no / 365;
            g_day_no = g_day_no % 365;
        }

        for (i = 0; g_day_no >= g_days_in_month[i] + ((i == 1 && leap == 1) ? 1 : 0); i++)
            g_day_no -= g_days_in_month[i] + ((i == 1 && leap == 1) ? 1 : 0);
        gm = i + 1;
        gd = (int) g_day_no + 1;

//        return gy + "-" + gm + "-" + gd;
        return gy + "-" + (gm < 10 ? "0" + gm : "" + gm) + "-" + (gd < 10 ? "0" + gd : "" + gd);
    }

    public static java.util.Date convertGregorianDate(String gregorianDate) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.parse(gregorianDate);
    }

    public static String getTodayJalali() {
        Date date = new Date(System.currentTimeMillis());
        String gregorianDate = date.toString();
        return getJalaliDate(gregorianDate);
    }
}
