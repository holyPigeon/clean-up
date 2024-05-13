package com.kyonggi.cleanup.parkinglot.application;

import com.kyonggi.cleanup.parkinglot.dto.request.PollutionPredictRequestByCondition;
import org.springframework.stereotype.Component;

import java.text.DecimalFormat;

@Component
public class PollutionPredictor {

    /**
     * 시간에 따른 예측
     */
    public double predictNoxAfter30MinuteByDateTime(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0386;

        returnVal += request.getHour() * 4.54004565e-04;
        returnVal += request.getMinute() * 2.39450105e-06;
        returnVal += request.getExternalTemperature() * -4.91460870e-04;
        returnVal += request.getExternalHumidity() * -3.45876570e-05;
        returnVal += request.getActualExternalNox() * 7.75177174e-02;
        returnVal += request.getActualExternalSox() * 5.00873020e-03;
        returnVal += request.getTemperature() * -1.11320237e-04;
        returnVal += request.getHumidity() * 5.97798111e-05;
        returnVal += request.getCarCount() * -1.46598796e-04;

        return resultFormatter(returnVal);
    }

    public double predictSoxAfter30MinuteByDateTime(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0215;

        returnVal += request.getHour() * 2.21007533e-04;
        returnVal += request.getMinute() * 3.56129662e-06;
        returnVal += request.getExternalTemperature() * -2.28578114e-04;
        returnVal += request.getExternalHumidity() * 6.09435123e-06;
        returnVal += request.getActualExternalNox() * 2.87416174e-02;
        returnVal += request.getActualExternalSox() * 1.00606908e-03;
        returnVal += request.getTemperature() * 3.46062184e-04;
        returnVal += request.getHumidity() * 1.68096771e-05;
        returnVal += request.getCarCount() * -8.61702054e-05;

        return resultFormatter(returnVal);
    }


    /**
     * 조건에 따른 예측
     */
    public double predictNoxByCondition(PollutionPredictRequestByCondition request, int passedMinute) {
        if (passedMinute == 30) {
            return predictNoxAfter30MinuteByCondition(request);
        }
        if (passedMinute == 60) {
            return predictNoxAfter60MinuteByCondition(request);
        }
        if (passedMinute == 90) {
            return predictNoxAfter90MinuteByCondition(request);
        }
        if (passedMinute == 120) {
            return predictNoxAfter120MinuteByCondition(request);
        }

        throw new IllegalStateException("예측할 수 없는 시간입니다.");
    }

    private double predictNoxAfter30MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0386;

        returnVal += request.getHour() * 4.54004565e-04;
        returnVal += request.getMinute() * 2.39450105e-06;
        returnVal += request.getExternalTemperature() * -4.91460870e-04;
        returnVal += request.getExternalHumidity() * -3.45876570e-05;
        returnVal += request.getActualExternalNox() * 7.75177174e-02;
        returnVal += request.getActualExternalSox() * 5.00873020e-03;
        returnVal += request.getTemperature() * -1.11320237e-04;
        returnVal += request.getHumidity() * 5.97798111e-05;
        returnVal += request.getCarCount() * -1.46598796e-04;

        return resultFormatter(returnVal);
    }

    private double predictNoxAfter60MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0387;

        returnVal += request.getHour() * 3.94936939e-04;
        returnVal += request.getMinute() * -2.26023870e-06;
        returnVal += request.getExternalTemperature() * -4.90506935e-04;
        returnVal += request.getExternalHumidity() * -3.60133969e-05;
        returnVal += request.getActualExternalNox() * 9.87945735e-02;
        returnVal += request.getActualExternalSox() * 6.97771779e-03;
        returnVal += request.getTemperature() * -1.05982817e-04;
        returnVal += request.getHumidity() * 5.69593567e-05;
        returnVal += request.getCarCount() * -1.44787189e-04;

        return resultFormatter(returnVal);
    }

    private double predictNoxAfter90MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0393;

        returnVal += request.getHour() * 3.15044171e-04;
        returnVal += request.getMinute() * 2.35241946e-06;
        returnVal += request.getExternalTemperature() * -4.70966460e-04;
        returnVal += request.getExternalHumidity() * -3.72085757e-05;
        returnVal += request.getActualExternalNox() * 1.10438147e-01;
        returnVal += request.getActualExternalSox() * 6.74248364e-03;
        returnVal += request.getTemperature() * -1.11412421e-04;
        returnVal += request.getHumidity() * 5.06054440e-05;
        returnVal += request.getCarCount() * -1.42732584e-04;

        return resultFormatter(returnVal);
    }

    private double predictNoxAfter120MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0405;

        returnVal += request.getHour() * 2.21783254e-04;
        returnVal += request.getMinute() * -2.19784878e-06;
        returnVal += request.getExternalTemperature() * -4.36279113e-04;
        returnVal += request.getExternalHumidity() * -3.76665051e-05;
        returnVal += request.getActualExternalNox() * 1.11656496e-01;
        returnVal += request.getActualExternalSox() * 5.91955332e-03;
        returnVal += request.getTemperature() * -1.26343745e-04;
        returnVal += request.getHumidity() * 4.19562129e-05;
        returnVal += request.getCarCount() * -1.41030475e-04;

        return resultFormatter(returnVal);
    }

    public double predictSoxByCondition(PollutionPredictRequestByCondition request, int passedMinute) {
        if (passedMinute == 30) {
            return predictSoxAfter30MinuteByCondition(request);
        }
        if (passedMinute == 60) {
            return predictSoxAfter60MinuteByCondition(request);
        }
        if (passedMinute == 90) {
            return predictSoxAfter90MinuteByCondition(request);
        }
        if (passedMinute == 120) {
            return predictSoxAfter120MinuteByCondition(request);
        }

        throw new IllegalStateException("예측할 수 없는 시간입니다.");
    }

    private double predictSoxAfter30MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0215;

        returnVal += request.getHour() * 2.21007533e-04;
        returnVal += request.getMinute() * 3.56129662e-06;
        returnVal += request.getExternalTemperature() * -2.28578114e-04;
        returnVal += request.getExternalHumidity() * 6.09435123e-06;
        returnVal += request.getActualExternalNox() * 2.87416174e-02;
        returnVal += request.getActualExternalSox() * 1.00606908e-03;
        returnVal += request.getTemperature() * 3.46062184e-04;
        returnVal += request.getHumidity() * 1.68096771e-05;
        returnVal += request.getCarCount() * -8.61702054e-05;

        return resultFormatter(returnVal);
    }

    private double predictSoxAfter60MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.02196;

        returnVal += request.getHour() * 1.87313275e-04;
        returnVal += request.getMinute() * -3.50387657e-06;
        returnVal += request.getExternalTemperature() * -2.31273970e-04;
        returnVal += request.getExternalHumidity() * 3.24862323e-06;
        returnVal += request.getActualExternalNox() * 4.05581623e-02;
        returnVal += request.getActualExternalSox() * 8.97667363e-04;
        returnVal += request.getTemperature() * 3.52472339e-04;
        returnVal += request.getHumidity() * 1.53644312e-05;
        returnVal += request.getCarCount() * -8.79007114e-05;

        return resultFormatter(returnVal);
    }

    private double predictSoxAfter90MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.0223;

        returnVal += request.getHour() * 1.44431555e-04;
        returnVal += request.getMinute() * 3.53188618e-06;
        returnVal += request.getExternalTemperature() * -2.21520071e-04;
        returnVal += request.getExternalHumidity() * 2.80675876e-08;
        returnVal += request.getActualExternalNox() * 4.70903992e-02;
        returnVal += request.getActualExternalSox() * 1.79838302e-04;
        returnVal += request.getTemperature() * 3.50144483e-04;
        returnVal += request.getHumidity() * 1.32344819e-05;
        returnVal += request.getCarCount() * -8.70666800e-05;

        return resultFormatter(returnVal);
    }

    private double predictSoxAfter120MinuteByCondition(PollutionPredictRequestByCondition request) {
        double returnVal = 0.023;

        returnVal += request.getHour() * 9.84189643e-05;
        returnVal += request.getMinute() * -3.48175865e-06;
        returnVal += request.getExternalTemperature() * -2.01821854e-04;
        returnVal += request.getExternalHumidity() * -3.31204706e-06;
        returnVal += request.getActualExternalNox() * 4.79097692e-02;
        returnVal += request.getActualExternalSox() * -3.49572892e-04;
        returnVal += request.getTemperature() * 3.40152880e-04;
        returnVal += request.getHumidity() * 1.08198382e-05;
        returnVal += request.getCarCount() * -8.43944780e-05;

        return resultFormatter(returnVal);
    }

    private double resultFormatter(double returnVal) {
        DecimalFormat decimalFormat = new DecimalFormat("#.###");
        String formattedString = decimalFormat.format(returnVal);

        return Double.parseDouble(formattedString);
    }
}
