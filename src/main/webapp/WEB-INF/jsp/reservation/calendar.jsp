<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar" %>
<%@ include file="../frogTop.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>예약 캘린더</title>
	<link rel="stylesheet" type="text/css" href="../../css/reservation/calendarStyle.css">
</head>

<body>

<form action="/reservation/time?placeId=${placeId}" method="post">
<div class="container">
    <div class="button-container">
        <!-- <button class="button" onclick="goToPreviousMonth()">&lt;&lt;</button>
        <button class="button" onclick="goToNextMonth()">&gt;&gt;</button> -->
    </div>    
    <h1 style="text-align: center">
        <%= request.getAttribute("placename")%>
    </h1>
    <h2 style="text-align: center">
        ${month}월
    </h2>
    
    <table>
        <tr>
            <th>일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th>토</th>
        </tr>
        <%
        String[] daysArray = (String[]) request.getAttribute("days"); // Get the 'days' array from the controller
        java.util.Set<String> daysSet = new java.util.HashSet<>(java.util.Arrays.asList(daysArray)); // Convert array to set for efficient lookup

        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.set(java.util.Calendar.DAY_OF_MONTH, 1); // Set the starting day to the 1st of the current month

        int currentMonth = cal.get(java.util.Calendar.MONTH); // Get the current month
        int totalDays = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); // Total number of days in the current month

        int firstDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK); // Get the first day of the week for the starting day

        while (cal.get(java.util.Calendar.MONTH) == currentMonth) {
            out.println("<tr>");

            // Print empty cells for the days before the starting day
            for (int i = 1; i < firstDayOfWeek; i++) {
                out.println("<td>&nbsp;</td>");
            }

            for (int i = firstDayOfWeek; i <= 7; i++) {
                int currentDay = cal.get(java.util.Calendar.DAY_OF_MONTH);

                if (daysSet.contains(String.valueOf(currentDay))) {
                    out.println("<td style='opacity: 1.0; background-color: lightgreen;' onclick='selectTime(this)' value='" + currentDay + "'>" + currentDay + "</td>"); // Set transparency to 100%
                } else {
                    out.println("<td style='opacity: 0.4; pointer-events: none;' value='" + currentDay + "'>" + currentDay + "</td>"); // Set transparency to 50%
                }

                cal.add(java.util.Calendar.DAY_OF_MONTH, 1); // Move to the next day

                if (currentDay == totalDays) {
                    break; // Stop if we reach the last day of the month
                }
            }

            out.println("</tr>");

            firstDayOfWeek = 1; // Reset the first day of the week for subsequent weeks
        }
        %>

    </table>
</div>


<div class="button-container">
    <input type="hidden" id="selectedDay" name="selectedDay" value="">
    <input class="button" type="submit" value="날짜 선택">
</div>

</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Function to select a time
    function selectTime(element) {
        var selected = document.getElementsByTagName('td');
        // Reset the previously selected time
        var selectedElement = document.querySelector('.selected');
        if (selectedElement) {
            selectedElement.classList.remove('selected');
        }

        // Set the new selected time
        element.classList.add('selected');

        // Update the hidden input field value
        var selectedDay = element.innerText;
        document.getElementById('selectedDay').value = selectedDay;
    }
</script>
</body>
</html>
