<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%!
public boolean isInArray(String value, String[] array) {
    for (String i : array) {
        if (i.equals(value)) {
            return true;
        }
    }
    return false;
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Calendar</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: #69c956;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            width: 800px; /* 달력의 가로 크기 조정 */
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid white;
            color: white;
        }

        th {
            background-color: #49a03e;
        }

        td:hover {
            background-color: #52c34d;
            cursor: pointer;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .button {
            background-color: #49a03e;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            margin: 0 10px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #52c34d;
        }

        .transparent {
            opacity: 0.5; /* 투명도 설정 */
        }

        .transparent-day {
            opacity: 1; /* 투명도 설정 */
        }
    </style>
</head>

<body>
<div class="container">
    <h1>
        <% 
          // DB에서 name 가져오기
          String placeName = "토리돈까스";
          try {
            // Place 테이블에서 name 필드 값 가져오기
            // ...
          } catch (Exception e) {
            e.printStackTrace();
          }
          out.println(placeName);
        %>
    </h1>
    
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

        // Assume 'daysArray' contains the dates as string values (e.g., ["1", "10", "15"])

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
                    out.println("<td style='opacity: 1.0;'>" + currentDay + "</td>"); // Set transparency to 100%
                } else {
                    out.println("<td style='opacity: 0.5;'>" + currentDay + "</td>"); // Set transparency to 50%
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
    <button class="button">예악 가능 날짜 선택</button>
    <button class="button">신청된 예약 확인</button>
</div>
<script>
    // days 배열에 값이 있는지 확인하는 함수
    function isInArray(value, array) {
        return array.indexOf(value) > -1;
    }
</script>
</body>
</html>