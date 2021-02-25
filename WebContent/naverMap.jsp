<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>네이버지도</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
	.mapWrapNaver {position:relative;width:100%;}
	
</style>
</head>
<body>

<!-- 네이버지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=reqdf5rkqw&submodules=geocoder"></script>
<div class="mapWrapNaver">
	<div id="mapNaver" style="width:90%; height:450px;"></div>
	<br>
	<input type="text" id="addrTxt" style="width:450px;">
	<input type="button" id="coordinateBtn"value="주소->좌표변환">
	<br><br>
	<input type="text" id="pointX" style="width:220px;">
	<input type="text" id="pointY" style="width:220px;">
	<input type="button" id="coordinateBtn2"value="좌표->주소변환 (위/경도좌표입력)">
</div>
<div id="transCoord">
</div>

<script>
var map = new naver.maps.Map("mapNaver", {
    center: new naver.maps.LatLng(37.3595316, 127.1052133),
    zoom: 12,
    mapTypeControl: true
});

var infoWindow = new naver.maps.InfoWindow({
    anchorSkew: true
});

map.setCursor('pointer');


/*
 * 좌표로 주소찾기
 * lat (y), lng (x)
 */
function searchCoordinateToAddress(latlng) {

    infoWindow.close();

    naver.maps.Service.reverseGeocode({
        location: new naver.maps.LatLng(latlng.y, latlng.x),
    }, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }

        var items = response.result.items,
        htmlAddresses = [];
        htmlCoordinate = [];
		console.log(items);
		
	    for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	        item = items[i];
	        addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]';
	
	        htmlAddresses.push((i+1) +'. '+ addrType +' '+ item.address);
	        
	        var tm128 = naver.maps.TransCoord.fromLatLngToTM128(item.point);
	        htmlCoordinate.push('[위/경도] X : '+ item.point.x + '  Y : '+item.point.y + ' || [TM128] X : '+ tm128.x + '  Y : '+tm128.y);
	    }
	
	    infoWindow.setContent([
	            '<div style="padding:10px;min-width:200px;line-height:150%;">',
	            '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	            htmlAddresses.join('<br />'),
	            '</div>'
	        ].join('\n'));
		$("#transCoord").html(htmlCoordinate.join('<br />'));
	    infoWindow.open(map, latlng);
    });
}

/*
 * 주소입력시 기본 위경도값 리턴
 * 좌표변환 참고 url :  https://navermaps.github.io/maps.js.ncp/docs/naver.maps.TransCoord.html#fromLatLngToTM128__anchor
 */
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        address: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }

        var item = response.result.items[0],
            addrType = item.isRoadAddress ? '[도로명 주소]' : '[지번 주소]',
            point = new naver.maps.Point(item.point.x, item.point.y);

        infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 주소 : '+ response.result.userquery +'</h4><br />',
                addrType +' '+ item.address +'<br />',
                '</div>'
            ].join('\n'));

		console.log(response.result);
		var tm128 = naver.maps.TransCoord.fromLatLngToTM128(item.point);
		console.log(tm128);
		
		var coordContents = "";
		coordContents = coordContents + "[위/경도]<br/>"+"X : "+item.point.x+"<br/>Y : "+item.point.y;
		coordContents = coordContents + "<br/><br/>[위/경도 -> TM128]<br/>"+"X : "+tm128.x+"<br/>Y : "+tm128.y;
		$("#transCoord").html(coordContents);
		
        map.setCenter(point);
        infoWindow.open(map, point);
    });
}

function initGeocoder() {
    map.addListener('click', function(e) {
        searchCoordinateToAddress(e.coord);
    });

    //주소->좌표변환 클릭시
    $('#coordinateBtn').on('click', function(e) {
        e.preventDefault();

        searchAddressToCoordinate($('#addrTxt').val());
    });
    
    //좌표->주소변환 클릭시
    $('#coordinateBtn2').on('click', function(e) {
        e.preventDefault();
        
        var pointXY = new Object();
        pointXY.x = $('#pointX').val();
        pointXY.y = $('#pointY').val();
        console.log(pointXY);
        searchCoordinateToAddress(pointXY);
    });

    searchAddressToCoordinate('증산로 251');
}

naver.maps.onJSContentLoaded = initGeocoder;

</script>



</body>
</html>