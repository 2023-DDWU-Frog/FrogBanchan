<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사업자 가입</title>
	<link rel="stylesheet" type="text/css" href="../css/place/placeFormStyle.css">

	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="../js/placeJoinForm.js"></script>

    </script>
</head>
<body>
    <div class="joinFormBox1">
        <div class="titleBox">
            사업자 가입
        </div>
        <div class="joinFormBox2 text-center placeForm">
            <form:form modelAttribute="placeForm" method="post">
                <div class="row">
                    <label for="placeId" class="col col-3">아이디</label>
                    <span class="line col col-3">- - - - - - - - -</span>
                    <div class="inputBox col col-3">
                        <form:input path="place.placeId" id="placeId" class="input" autofocus="true" />
                        <form:errors path="place.placeId" class="error error2"/>
                    </div>
                    <div class="col col-2">
                        <button class="ms-4 btn btn-success" type="button" onclick="checkExistPlaceId()">중복확인</button>
                    </div>
                </div>
                <br/>
                <div class="row">
                    <label for="password" class="col col-3">비밀번호</label>
                    <span class="line col col-3">- - - - - - - - -</span>
                    <div class="inputBox col col-5">
                        <form:password path="place.password" id="password" class="input" />
                        <form:errors path="place.password" class="error" />
                    </div>
                </div>
                <br/>
                <div class="row">
                    <label for="confirmPassword" class="col col-3">비밀번호 확인</label>
                    <span class="line col col-3">- - - - - - - - -</span>
                    <div class="inputBox col col-5">
                        <form:password path="confirmPassword" id="confirmPassword" class="input" />
                        <form:errors path="confirmPassword" class="error" />
                    </div>
                </div>
                <br/>
                <div class="row">
                    <label for="name" class="col col-3">가게 상호명</label>
                    <span class="line col col-3">- - - - - - - - -</span>
                    <div class="inputBox col col-5">
                        <form:input path="place.name" id="name" class="input" />
                        <form:errors path="place.name" class="error" />
                    </div>
                </div>
                <br/>
                <div class="row">
                    <label for="address" class="col col-3">주소</label>
                    <span class="line col col-3">- - - - - - - - -</span>
                    <div class="inputBox col col-5">
                        <form:input path="place.address" id="address" class="input" />
                        <form:errors path="place.address" class="error" />
                    </div>
                </div>
                <br/>

                </br>
                <div class="btnGroup">
                    <button class="btn btn-secondary backBtn" type="button" onclick="location.href='/join'">취소하기</button>
                    <button class="btn btn-light resetBtn" type="reset">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"/>
                            <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"/>
                        </svg>
                    </button>
                    <button class="btn btn-success registBtn" type="submit" onclick="return checkExist();">등록하기</button>
                </div>
            </form:form>
        </div>

        <div class="horizonLine">
        </div>
    </div>

</body>
</html>