<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>recommendMap</title>
    <link rel="stylesheet" type="text/css" href="../../../css/topStyle.css">
    <style>
        .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '����', sans-serif;line-height: 1.5;}
        .wrap * {padding: 0;margin: 0;}
        .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
        .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
        .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
        .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
        .info .close:hover {cursor: pointer;}
        .info .body {position: relative;overflow: hidden;}
        .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
        .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
        .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
        .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
        .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
        .info .link {color: #5085BB;}
    </style>
</head>
<body>
<div style="width:80%;margin: 0 auto;padding:30px;">
    <span style="font-size: 50px;margin: 2% 0;"><b>${menuName}</b> ���� �˻�</span>
    <br>
    <span style="font-size: 20px;float:right;">��ġ : <span style="text-decoration: underline;">�������ڴ��б�</span></span>
</div>
<div id="map" style="width:80%;height:670px;border: 1px solid #000000;border-radius:30px;margin: 0 auto;"></div>
<br>
<div style="text-align: center;">
    <button style="height: 50px;width: 15%;border: 1px solid #000000;border-radius: 15px;font-size: 30px;background-color: white"
            type="button" onClick="">�ٸ� �޴� ��õ����!</button></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1edbbc68addc788e67cef306ea562f13"></script>
<script>
    const { kakao } = window;
    function initMap() {
        var places = [
            <c:forEach var="place" items="${placeList}">
            {
                name: '${place.name}',
                address: '${place.address}'
            },
            </c:forEach>
        ];

        var mapContainer = document.getElementById('map');
        var mapOptions = {
            center: new kakao.maps.LatLng(37.4959097, 127.0289791), // ������ �߽���ǥ (����)
            level: 3 // ������ Ȯ�� ����
        };

        var map = new kakao.maps.Map(mapContainer, mapOptions);

        var geocoder = new kakao.maps.services.Geocoder();

        places.forEach(function(place) {
            geocoder.addressSearch(place.address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var markerPosition = new kakao.maps.LatLng(result[0].y, result[0].x);

                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });

                    marker.setMap(map);

                    var overlayContent = '<div style="padding:5px;"><h4>' + place.name + '</h4>' +
                        '<p>' + place.address + '</p></div>';

                    var overlay = new kakao.maps.CustomOverlay({
                        content: overlayContent,
                        position: markerPosition,
                        yAnchor: 1
                    });

                    overlay.setMap(map);
                }
            });
        });
    }

    // ���� �ʱ�ȭ �Լ� ȣ��
    initMap();

    <%--var mapContainer = document.getElementById('map'), // ������ �߽���ǥ--%>
    <%--    mapOption = {--%>
    <%--        center: new kakao.maps.LatLng(37.4959097, 127.0289791), // ������ �߽���ǥ--%>
    <%--        level: 3 // ������ Ȯ�� ����--%>
    <%--    };--%>

    <%--//37.6068163, 127.0423832--%>
    <%--var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�--%>


    <%--let positions = [];--%>
    <%--<c:forEach var="place" items="${placeList}" varStatus="status">--%>
    <%--positions.push("${place}");--%>
    <%--</c:forEach>--%>
    <%--var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";--%>

    <%--for (var i = 0; i < positions.length; i ++) {--%>
    <%--    // ��Ŀ �̹����� �̹��� ũ�� �Դϴ�--%>
    <%--    var imageSize = new kakao.maps.Size(24, 35);--%>

    <%--    var geocoder = new kakao.maps.services.Geocoder();--%>
    <%--        var coords;--%>
    <%--        // �ּҷ� ��ǥ�� �˻��մϴ�--%>
    <%--        geocoder.addressSearch(positions[i].address, function(result, status) {--%>
    <%--            coords = new kakao.maps.LatLng(result[0].y, result[0].x);--%>
    <%--        });--%>

    <%--    // ��Ŀ �̹����� �����մϴ�--%>
    <%--    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);--%>

    <%--    // ��Ŀ�� �����մϴ�--%>
    <%--    var marker = new kakao.maps.Marker({--%>
    <%--        map: map, // ��Ŀ�� ǥ���� ����--%>
    <%--        position: coords, // ��Ŀ�� ǥ���� ��ġ--%>
    <%--        title: positions[i].name, // ��Ŀ�� Ÿ��Ʋ, ��Ŀ�� ���콺�� �ø��� Ÿ��Ʋ�� ǥ�õ˴ϴ�--%>
    <%--        image: markerImage // ��Ŀ �̹���--%>
    <%--    });--%>
    <%--}--%>
    <%--// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�--%>
    <%--var geocoder = new kakao.maps.services.Geocoder();--%>

    <%--var positions = new Array();--%>
    <%--<c:forEach items="${placeList}" var="place">--%>
    <%--    positions.push({placeId: "${place.placeId}",--%>
    <%--                    title: "${place.name}",--%>
    <%--                    address: "${place.address}",--%>
    <%--                    score: "${place.totalScore}"});--%>
    <%--</c:forEach>--%>

    <%--positions.forEach(function (position) {--%>
    <%--    // �ּҷ� ��ǥ�� �˻��մϴ�--%>
    <%--    geocoder.addressSearch(position.address, function(result, status) {--%>

    <%--        // ���������� �˻��� �Ϸ������--%>
    <%--        if (status === kakao.maps.services.Status.OK) {--%>

    <%--            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);--%>

    <%--            // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�--%>
    <%--            var marker = new kakao.maps.Marker({--%>
    <%--                map: map,--%>
    <%--                position: coords--%>
    <%--            });--%>
    <%--            marker.setMap(map); //�߰��� �ڵ�--%>

    <%--            // ����������� ��ҿ� ���� ������ ǥ���մϴ�--%>
    <%--            var infowindow = new kakao.maps.InfoWindow({--%>
    <%--                content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'--%>
    <%--            });--%>
    <%--            infowindow.open(map, marker);--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>

    // ��Ŀ�� ǥ���� ��ġ�� title ��ü �迭�Դϴ�
    <%--var positions = new Array();--%>
    <%--<c:forEach items="${placeList}" var="place">--%>
    <%--    var geocoder = new kakao.maps.services.Geocoder();--%>
    <%--    var coords;--%>
    <%--    // �ּҷ� ��ǥ�� �˻��մϴ�--%>
    <%--    geocoder.addressSearch("${place.address}", function(result, status) {--%>
    <%--        coords = new kakao.maps.LatLng(result[0].y, result[0].x);--%>
    <%--    });--%>
    <%--    positions.push({placeId: "${place.placeId}",--%>
    <%--                    name: "${place.name}",--%>
    <%--                    address: "${place.address}",--%>
    <%--                    geocode: coords,--%>
    <%--                    score: "${place.totalScore}"});--%>
    <%--</c:forEach>--%>
    // var positions = [
    //     {
    //         title: '�丮 ���',
    //         latlng: new kakao.maps.LatLng(37.6044911, 127.042321)
    //     },
    //     {
    //         title: '�ۼ۽�Ź',
    //         latlng: new kakao.maps.LatLng(37.6038873, 127.042740)
    //     }
    // ];
    // �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�


    // for(let i=0; i < positions.length; i++){
    //     var data = positions[i];
    //     displayMarker(data);
    // }
    //
    // // ������ ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
    // function displayMarker(data) {
    //
    //     // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
    //     var marker = new kakao.maps.Marker({
    //         map: map,
    //         position: data.geocode
    //     });
    //     var infowindow = new kakao.maps.InfoWindow({
    //         content: '<div style="width:150px;text-align:center;padding:6px 0;">' + data.name + '</div>'
    //     });
    //     infowindow.open(map, marker);
    // }
    // var overlay = new kakao.maps.CustomOverlay({
    //     content: content,
    //     map: map,
    //     position: marker.getPosition()
    // });

    // var content = '<div style="width:150px;text-align:center;padding:6px 0;">' + data.name + '</div>';
    // var detail = document.createElement('button');
    // detail.innerHTML = '�ڼ��� ����';
    // detail.onclick = function () {
    //     location.href = "#"
    // }
    // content.appendChild(detail);
    //
    // var closeBtn = document.createElement('button');
    // closeBtn.innerHTML = '�ݱ�';
    // closeBtn.onclick = function () {
    //     overlay.setMap(null);
    // };
    // content.appendChild(closeBtn);
    //
    // overlay.setContent(content);
    //
    // kakao.maps.event.addListener(marker, 'click', function () {
    //     overlay.setMap(map);
    // });
    // }

    <%--        // // ����������� ��ҿ� ���� ������ ǥ���մϴ�--%>
    <%--        // var infowindow = new kakao.maps.InfoWindow({--%>
    <%--        //     content: content--%>
    <%--        // });--%>
    <%--        // infowindow.open(map, marker);--%>
    <%--    }--%>
    <%--});--%>

    <%--    // var marker = new kakao.maps.Marker({--%>
    <%--    //     map: map,--%>
    <%--    //     position: coords--%>
    <%--    // });--%>
    <%--    // var overlay = new kakao.maps.CustomOverlay({--%>
    <%--    //     content: content,--%>
    <%--    //     map: map,--%>
    <%--    //     position: marker.getPosition()--%>
    <%--    // });--%>
    <%--    //--%>
    <%--    // var content = document.createElement('div');--%>
    <%--    // content.innerHTML = data.name + '<br>' + data.address + '<br>'+ data.score + '<br>';--%>
    <%--    // content.style.cssText = 'background: white; border: 1px solid black';--%>
    <%--    //--%>
    <%--    // var detail = document.createElement('button');--%>
    <%--    // detail.innerHTML = '�ڼ��� ����';--%>
    <%--    // detail.onclick = function () {--%>
    <%--    //     location.href=""--%>
    <%--    // }--%>
    <%--    // content.appendChild(detail);--%>
    <%--    //--%>
    <%--    // var closeBtn = document.createElement('button');--%>
    <%--    // closeBtn.innerHTML = '�ݱ�';--%>
    <%--    // closeBtn.onclick = function () {--%>
    <%--    //     overlay.setMap(null);--%>
    <%--    // };--%>
    <%--    // content.appendChild(closeBtn);--%>
    <%--    // overlay.setContent(content);--%>
    <%--    //--%>
    <%--    // kakao.maps.event.addListener(marker, 'click', function() {--%>
    <%--    //     overlay.setMap(map);--%>
    <%--    // });--%>
    <%--}--%>


    // for (var i = 0; i < positions.length; i ++) {
    //     // ��Ŀ�� �����մϴ�
    //     var marker = new kakao.maps.Marker({
    //         map: map, // ��Ŀ�� ǥ���� ����
    //         position: positions[i].latlng, // ��Ŀ�� ǥ���� ��ġ
    //         title : positions[i].title, // ��Ŀ�� Ÿ��Ʋ, ��Ŀ�� ���콺�� �ø��� Ÿ��Ʋ�� ǥ�õ˴ϴ�
    //     });
    //     var content = '<div class="wrap">' +
    //         '    <div class="info">' +
    //         '        <div class="title">' +
    //                     positions[i].title +
    //         '            <div class="close" onclick="closeOverlay()" title="�ݱ�"></div>' +
    //         '        </div>' +
    //         '        <div class="body">' +
    //         '            <div class="ellipsis">' +
    //                         positions[i].latlng +
    //         '               </div>' +
    //         '            <div><a href="" target="_blank" class="link">���� ��</a></div>' +
    //         '        </div>' +
    //         '    </div>' +
    //         '</div>';
    //     var overlay = new kakao.maps.CustomOverlay({
    //             content: content,
    //             map: map,
    //             position: marker.getPosition()
    //         });
    //     kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, overlay));
    //     kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(overlay));
    // }
    // kakao.maps.event.addListener(marker, 'click', function() {
    //     overlay.setMap(map);
    // });
    // function closeOverlay() {
    //     overlay.setMap(null);
    // }

    // // ������ ��Ŀ�� ǥ���մϴ�
    // var marker = new kakao.maps.Marker({
    //     map: map,
    //     position: new kakao.maps.LatLng(37.6044911, 127.042321)
    // });
    // var marker2 = new kakao.maps.Marker({
    //     map: map,
    //     position: new kakao.maps.LatLng(37.6038873, 127.042740)
    // });
    //
    // // Ŀ���� �������̿� ǥ���� ������ �Դϴ�
    // // Ŀ���� �������̴� �Ʒ��� ���� ����ڰ� �����Ӱ� �������� �����ϰ� �̺�Ʈ�� ������ �� �ֱ� ������
    // // ������ �̺�Ʈ �޼ҵ带 �������� �ʽ��ϴ�
    // var content = '<div class="wrap">' +
    //     '    <div class="info">' +
    //     '        <div class="title">' +
    //     '            �丮 ���' +
    //     '            <div class="close" onclick="closeOverlay()" title="�ݱ�"></div>' +
    //     '        </div>' +
    //     '        <div class="body">' +
    // '                <div class="ellipsis">���� ���ϱ� ȭ����13�� 24 2�� �丮���</div>' +
    // '                <div class="jibun ellipsis">(��) 02748 (����) �Ͽ�� 21-77</div>' +
    // '                <div><a href="" target="_blank" class="link">���� ��</a></div>' +
    //     '        </div>' +
    //     '    </div>' +
    //     '</div>';
    // var content2 = '<div class="wrap">' +
    //     '    <div class="info">' +
    //     '        <div class="title">' +
    //     '            �ۼ۽�Ź' +
    //     '            <div class="close" onclick="closeOverlay2()" title="�ݱ�"></div>' +
    //     '        </div>' +
    //     '        <div class="body">' +
    //     '            <div class="desc">' +
    //     '                <div class="ellipsis">���� ���ϱ� ȭ����13�� 10</div>' +
    //     '                <div class="jibun ellipsis">(��) 02752 (����) �Ͽ�� 17-10</div>' +
    //     '                <div><a href="" target="_blank" class="link">���� ��</a></div>' +
    //     '            </div>' +
    //     '        </div>' +
    //     '    </div>' +
    //     '</div>';
    //
    // // ��Ŀ ���� Ŀ���ҿ������̸� ǥ���մϴ�
    // // ��Ŀ�� �߽����� Ŀ���� �������̸� ǥ���ϱ����� CSS�� �̿��� ��ġ�� �����߽��ϴ�
    // var overlay = new kakao.maps.CustomOverlay({
    //     content: content,
    //     map: map,
    //     position: marker.getPosition()
    // });
    // var overlay2 = new kakao.maps.CustomOverlay({
    //     content: content2,
    //     map: map,
    //     position: marker2.getPosition()
    // });
    //
    // // ��Ŀ�� Ŭ������ �� Ŀ���� �������̸� ǥ���մϴ�
    // kakao.maps.event.addListener(marker, 'click', function() {
    //     overlay.setMap(map);
    // });
    // kakao.maps.event.addListener(marker2, 'click', function() {
    //     overlay2.setMap(map);
    // });
    //
    // // Ŀ���� �������̸� �ݱ� ���� ȣ��Ǵ� �Լ��Դϴ�
    // function closeOverlay() {
    //     overlay.setMap(null);
    // }
    // function closeOverlay2() {
    //     overlay2.setMap(null);
    // }
</script>
<table style="width:70%">
    <tr><th>�����̸�</th><th>��ġ</th></tr>
    <c:forEach var="place" items="${placeList}" varStatus="status">
        <tr>
            <td>${place.name}</td>
            <td>${place.address}</td>
            <td><a href='<c:url value="/place/view"><c:param name="placeId" value="${place.placeId}"/></c:url>'>���� ����</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>