<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../frogTop.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../../../css/party/listStyle.css">
<title>PartyList</title>
</head>
<body>
<div class="titleWrap">
           식구 모집 목록<br/>
</div>
<div class="bttnWrapper">
	<button class="createButton" onclick="location.href='/party/create'">모집하기</button>
</div>
<!-- 페이징 기능 추가해봐도 좋을듯한&정렬기능 추가 -->
<table class="tb1">
	<tr><th>식구 아이디</th><th>날짜</th><th>가게명</th><th>모집자</th><th>내용</th><th></th></tr>
	<c:forEach var="party" items="${partyList}" varStatus="status">
		<tr>
			<td>${party.partyId}</td>
			<td>${party.meetDate}</td>
			<td><c:set var="placeId" value="${party.placeId}" />
	            <c:forEach var="place" items="${places}">
	                <c:if test="${place.placeId eq placeId}">
	                    ${place.name}
	                </c:if>
	            </c:forEach>
	        </td>
			<td>${party.creator}</td>
			<td>${party.content}</td>
			<td><a href='<c:url value="/party/view"><c:param name="partyId" value="${party.partyId}"/></c:url>'>보기</a>		
		</tr>
	</c:forEach>
</table>
</body>
</html>