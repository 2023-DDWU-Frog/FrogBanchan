package com.frog.frogbanchan.controller.reservation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.util.WebUtils;

import com.frog.frogbanchan.controller.PlaceSession;
import com.frog.frogbanchan.controller.UserSession;
import com.frog.frogbanchan.domain.Reservation;
import com.frog.frogbanchan.service.FrogBanchanFacade;

@Controller
public class ReservationForPlaceContorller {

    @Value("/reservation/timeSelectForPlace")
    private String TIME_SELECT_VIEW_FORPLACE;
    @Value("/reservation/reservationResultForPlace")
    private String RESULT_VIEW_FORPLACE;
    @Value("/reservation/calendarForPlace")
    private String CALENDAR_FORPLACE;

    private FrogBanchanFacade frogBanchan;

    @Autowired
    public void setFrogBanchan(FrogBanchanFacade frogBanchan) {
        this.frogBanchan = frogBanchan;
    }

    @RequestMapping("/reservation/time/forplace") // requestparam으로 input 태그 받기
    public String timeselectHandleForPlace(HttpServletRequest request, ModelMap modelMap,
            @SessionAttribute("placeSession") PlaceSession placeSession,
            @RequestParam Object selectedDay) {
        List<Timestamp> reservedTimeList = frogBanchan.findReservedTime(placeSession.getPlace().getPlaceId()); // placeId
                                                                                                               // 사용
        List<Timestamp> availableTimeList = frogBanchan.findCalendar(placeSession.getPlace().getPlaceId()); // placeId
                                                                                                            // 사용
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH");

        String[] availableTime = new String[100];
        int i = 0;
        for (Timestamp timestamp : availableTimeList) {
            Date date = new Date(timestamp.getTime());

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd");
            // Format the Date object to the desired date and time format
            String formattedDate = dateFormat.format(date);
            if (formattedDate.equals(selectedDay)) {
                String day = timeFormat.format(timestamp);
                availableTime[i++] = day;

                System.out.println("availableTimes: " + availableTime);
                System.out.println("---------");
            }

        }

        String[] reservedTimes = new String[100];
        i = 0;
        for (Timestamp timestamp : reservedTimeList) {
            Date date = new Date(timestamp.getTime());

            SimpleDateFormat dateFormat = new SimpleDateFormat("dd");

            // Format the Date object to the desired date and time format
            String formattedDate = dateFormat.format(date);
            if (formattedDate.equals(selectedDay)) {
                String time = timeFormat.format(timestamp);

                reservedTimes[i++] = time;
            }
        }

        modelMap.addAttribute("availableTimes", availableTime);
        modelMap.addAttribute("reservedTimes", reservedTimes);
        modelMap.addAttribute("selectedDay", selectedDay);

        return TIME_SELECT_VIEW_FORPLACE;
    }

    @RequestMapping("/reservation/result/forplace") // requestparam으로 input 태그 받기
    public String resultHandleForPlace(HttpServletRequest request, ModelMap modelMap,
            @SessionAttribute("placeSession") PlaceSession placeSession,
            @RequestParam String selectedDay,
            @RequestParam String selectedTime, @RequestParam String flag) {

        System.out.print(flag + "******************flag");
        String reservedDay = null;
        String reservedTime = null;
        String username = null;
        int seat = 0;

        if (flag.equals("reservation")) {
            List<Reservation> reservations = frogBanchan.findReservationByPlaceId(placeSession.getPlace().getPlaceId());
            for (Reservation reservation : reservations) {
                Timestamp timestamp = reservation.getReservationDate();

                Date date = new Date(timestamp.getTime());

                SimpleDateFormat dateFormat = new SimpleDateFormat("dd");
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH");

                // Format the Date object to the desired date and time format
                String formattedDate = dateFormat.format(date);
                String formattedTime = timeFormat.format(date);

                if (formattedDate.equals(selectedDay) && selectedTime.contains(formattedTime)) {
                    reservedDay = formattedDate;
                    reservedTime = formattedTime;
                    username = reservation.getUsername();
                    seat = reservation.getSeat();
                }
            }
        }

        modelMap.addAttribute("reservedDay", reservedDay);
        modelMap.addAttribute("reservedTime", reservedTime);
        modelMap.addAttribute("username", username);
        modelMap.addAttribute("seat", seat);

        if (reservedDay == null) {
            return "error_page";
        }
        return RESULT_VIEW_FORPLACE;
    }
}
