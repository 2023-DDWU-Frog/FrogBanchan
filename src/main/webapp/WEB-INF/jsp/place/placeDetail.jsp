<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../frogTop.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>가게정보</title>
</head>
<body>
    <br/><br/><br/><br/>
    <div>
        가게 아이디 : ${place.placeId}
        <br/>
        가게명 : ${place.name}
        <br/>
        가게 점수 : ${place.totalScore}
        <br/>
        가게 주소 : ${place.address}
        <br/>
        <button type="button" onClick="location.href=''">이 가게 예약하러 가기</button>
    </div>
    <br/>
    <button type="button" onClick="history.go(-1)">뒤로가기</button>
</body>
</html>