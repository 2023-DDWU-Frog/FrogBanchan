<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>recommendMap</title>
    <link rel="stylesheet" type="text/css" href="../../../css/topStyle.css">
</head>
<body>

<form id="search-form">
    <input type="text" id="address-input" placeholder="�ּҸ� �Է��ϼ���" />
    <button type="submit">�˻�</button>
</form>
<div id="map" style="width:80%;height:670px;border: 1px solid #000000;border-radius:30px;margin: 0 auto;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1edbbc68addc788e67cef306ea562f13&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // ������ ǥ���� div
        mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567), // ������ �߽���ǥ
            level: 1 // ������ Ȯ�� ����
        };

    // ������ �����մϴ�
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
    var geocoder = new kakao.maps.services.Geocoder();

    var loca;

    var marker = new kakao.maps.Marker(), // Ŭ���� ��ġ�� ǥ���� ��Ŀ�Դϴ�
        infowindow = new kakao.maps.InfoWindow({zindex:1}); // Ŭ���� ��ġ�� ���� �ּҸ� ǥ���� �����������Դϴ�

    // ���� ���� �߽���ǥ�� �ּҸ� �˻��ؼ� ���� ���� ��ܿ� ǥ���մϴ�
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);

    // ������ Ŭ������ �� Ŭ�� ��ġ ��ǥ�� ���� �ּ������� ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
        searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var detailAddr = !!result[0].road_address ? '<div>���θ��ּ� : ' + result[0].road_address.address_name + '</div>' : '';
                detailAddr += '<div>���� �ּ� : ' + result[0].address.address_name + '</div>';

                var content = '<div class="bAddr">' +
                    detailAddr +
                    '<a href="/place/view?placeId=${place.placeId}" style="color:blue">���� �� ����</a>'
                    '</div>';

                // ��Ŀ�� Ŭ���� ��ġ�� ǥ���մϴ�
                marker.setPosition(mouseEvent.latLng);
                marker.setMap(map);

                // ���������쿡 Ŭ���� ��ġ�� ���� ������ �� �ּ������� ǥ���մϴ�
                infowindow.setContent(content);
                infowindow.open(map, marker);
            }
        });
    });

    // �߽� ��ǥ�� Ȯ�� ������ ������� �� ���� �߽� ��ǥ�� ���� �ּ� ������ ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
    kakao.maps.event.addListener(map, 'idle', function() {
        searchAddrFromCoords(map.getCenter(), displayCenterInfo);
    });

    function searchAddrFromCoords(coords, callback) {
        // ��ǥ�� ������ �ּ� ������ ��û�մϴ�
        geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
    }

    function searchDetailAddrFromCoords(coords, callback) {
        // ��ǥ�� ������ �� �ּ� ������ ��û�մϴ�
        geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
    }

    // ���� ������ܿ� ���� �߽���ǥ�� ���� �ּ������� ǥ���ϴ� �Լ��Դϴ�
    function displayCenterInfo(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var infoDiv = document.getElementById('centerAddr');

            for(var i = 0; i < result.length; i++) {
                // �������� region_type ���� 'H' �̹Ƿ�
                if (result[i].region_type === 'H') {
                    infoDiv.innerHTML = result[i].address_name;
                    break;
                }
            }
        }
    }
</script>
<button type="button" id = "location" onclick="">�ּ� ����!</button>
</body>
</html>