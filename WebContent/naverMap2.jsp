<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>네이버지도 TM128</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
	.mapWrapNaver {position:relative;width:100%;}
	
</style>
</head>
<body>

<!-- 네이버지도 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=reqdf5rkqw&submodules=geocoder"></script>
<div class="mapWrapNaver">
Geocoder 서브 모듈의 TM128Coord 투영 객체를 사용하여, 기본 좌표계가 TM128인 지도 유형을 사용

	<div id="mapNaver" style="width:90%; height:450px;"></div>
	<br>
	<input type="text" id="pointX" style="width:220px;">
	<input type="text" id="pointY" style="width:220px;">
	<input type="button" id="coordinateBtn2"value="좌표->주소변환 (TM128 좌표입력)">
</div>
<div id="transCoord">

</div>

<script>
var map = null,
infoWindow = null;

/*
 * 참고 URL : https://navermaps.github.io/maps.js.ncp/docs/naver.maps.TM128Coord.html
 * 참고 URL : https://navermaps.github.io/maps.js.ncp/docs/tutorial-2-geocoder-tm128coord.example.html
 */
function initMap() {
map = new naver.maps.Map("mapNaver", {
    center: new naver.maps.Point(303557, 553719),
    zoom: 12,
    mapTypes: new naver.maps.MapTypeRegistry({
        'normal': naver.maps.NaverMapTypeOption.getNormalMap({
            projection: naver.maps.TM128Coord
        }),
        'terrain': naver.maps.NaverMapTypeOption.getTerrainMap({
            projection: naver.maps.TM128Coord
        }),
        'satellite': naver.maps.NaverMapTypeOption.getSatelliteMap({
            projection: naver.maps.TM128Coord
        }),
        'hybrid': naver.maps.NaverMapTypeOption.getHybridMap({
            projection: naver.maps.TM128Coord
        })
    }),
    mapTypeControl: true
});

infoWindow = new naver.maps.InfoWindow({
    content: getInfoWindowContent(map.getCenter())
});

function updateInfoWindow(coord) {
    infoWindow.setContent(getInfoWindowContent(coord));
    //map.setCenter(coord);
    infoWindow.open(map, coord);
}

function getInfoWindowContent(coord) {
    console.log('Coord:', coord);
    
    var latlng = naver.maps.TM128Coord.fromCoordToLatLng(coord);
    console.log(latlng);
    $("#transCoord").html('[위/경도] X : '+ latlng.x + '  Y : '+latlng.y + ' || [TM128] X : '+ coord.x + '  Y : '+coord.y);
    
    return [
        '<div style="padding:10px;width:200px;font-size:14px;line-height:20px;text-align:center;">',
        '<p>',
        '<strong>Coord</strong> : '+ 'TM128 좌표' +'<br />',
        '</p>',
        '</div>'
    ].join('');
}

updateInfoWindow(map.getCenter());

map.addListener('click', function(e) {
	console.log(e.coord);
    updateInfoWindow(e.coord);
});

//좌표->주소변환 클릭시
$('#coordinateBtn2').on('click', function(e) {
    e.preventDefault();
    
    var pointXY = new Object();
    pointXY.x = $('#pointX').val();
    pointXY.y = $('#pointY').val();
    console.log(pointXY);
    updateInfoWindow(pointXY);
});

}

naver.maps.onJSContentLoaded = initMap;
</script>



</body>
</html>