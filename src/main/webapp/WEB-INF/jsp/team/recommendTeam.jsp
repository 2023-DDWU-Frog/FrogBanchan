<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../frogTop.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>추천 | TEAM</title>
	<link rel="stylesheet" type="text/css" href="../../css/team/rcmdTeamStyle.css">
    <script type="text/javascript" src="../../js/rcmdTeam.js"></script>
</head>
<body>
    <div class="memberSelectBox memberScroll2">
        <c:forEach var="member" items="${memberList}" varStatus="status">
            <div class="memberCircle" id="${member.username}">
                <div class="addBadge">
                    <button class="badge rounded-pill text-bg-primary selectBtn"
                            id="${member.username}" name="${member.nickname}" type="button">+</button>
                </div>
                <p class="memberCircleText">${member.nickname}</p>
            </div>
        </c:forEach>

    </div>

    <div class="memberSelectTextBox">
        <p class="memberSelectText1">팀원 선택</p>
    </div>
    <div class="memberSelectedBox1">
        <div class="memberSelectedBox2">
            <c:forEach var="member" items="${selectedMembers}" varStatus="status">
                <c:if test="${not empty member}">
                    <div class="memberCircle" id="${member.username}">
                        <div class="removeBadge">
                            <button class="badge rounded-pill text-bg-danger unselectBtn"
                                    id="${member.username}" name="${member.nickname}" type="button">X</button>
                        </div>
                        <p class="memberCircleText">${member.nickname}</p>
                    </div>
                    </c:if>
            </c:forEach>
        </div>
    </div>

    <div class="horizonLine"></div>

    <div class="hateListText1">
        싫어요 리스트
    </div>
    <div class="hateListBox1">
        <div class="hateListBox2">
            <div class="hateListBox3">
                <c:forEach var="tag" items="${selectedTags}" varStatus="status">
                    <c:if test="${not empty tag}">
                        <span class="hateTag addedHate" id="${tag}">${tag}</span>
                    </c:if>
                </c:forEach>
            </div>
        </div>
        <p class="hateListText2">
            현재 선택된 멤버들의 불호 음식 목록은 추천 메뉴에서 제외된다구리
        </p>
    </div>

    <div class="recommendBox">
        <form id="recommendForm" action="<c:url value='/recommend/team/recommendMenu' />" method="POST">
            <button class="btn btn-warning recommendBtn" type="submit" >추천 go !!</button>
        </form>
    </div>
</body>
</html>