<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../frogTop.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation Form</title>
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
            background-color: white;
            border: 2px solid #69c956;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            width: 400px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group select {
            width: 100%;
            padding: 5px;
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
    </style>
</head>

<body>
    <div class="container">
        <h2>Result</h2>
        <div class="form-group">
            <label>Date:</label>
            <span><%= request.getAttribute("reservedDay") %></span>
        </div>
        <div class="form-group">
            <label>Time:</label>
            <span><%= request.getAttribute("reservedTime") %></span>
        </div>
        <div class="form-group">
            <label>Name:</label>
            <span><%= request.getAttribute("username") %></span>
        </div>
        <div class="form-group">
            <label>인원 수:</label>
            <span><%= request.getAttribute("seat") %></span>
        </div>
        <div class="button-container">
            <button class="button" type="button" onclick="location.href='/reservation/calendar/forplace'">닫기</button>
        </div>
    </div>
</body>
</html>
