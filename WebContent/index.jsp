<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>다음지도</title>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style>
	.mapWrapKakao {position:relative;width:100%;height:600px;}
	.title {font-weight:bold;display:block;}
	.hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
	#centerAddr {display:block;margin-top:2px;font-weight: normal;}
	.bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<body>

<!-- 
다음 지도
(애플리케이션 이름 : 로컬_지도)
 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dcdb31e68aaaf9cfe5501704f8c003ce&libraries=services"></script>

<div class="mapWrapKakao">
	<div id="mapKakao" style="width:90%;height:450px;"></div>
	<div class="hAddr">
		<span class="title">지도중심기준 행정동 주소정보.</span>
		<span id="centerAddr"></span>
	</div>
	<input type="text" id="addrTxt" style="width:450px;">
	<input type="button" id="coordinateBtn"value="주소->좌표변환">
	<div id="transCoordTxt"></div>
</div>

<script>
var mapContainer = document.getElementById('mapKakao'), // 지도를 표시할 div 
mapOption = { 
    center: new daum.maps.LatLng(37.58067292361561, 126.9058578299751), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption); 
//주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

$("#coordinateBtn").click(function(){
	var addrTxt = $("#addrTxt").val();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(addrTxt, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {

	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	        
	        //다른 좌표계로 변환할 경우
	     	transCoord(result[0].y, result[0].x);
	     	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:250px;text-align:center;padding:5px 5px;">X : '+result[0].x+' <br/> Y : '+result[0].y+'</div>'
	        });
	        infowindow.open(map, marker);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});
	
})

/* 받아온 좌표를 다른 좌표계의 좌표로 변환한다.
 * input_coord : 입력 좌표 체계. 기본값은 WGS84
 * output_coord : 출력 좌표 체계. 기본값은 WGS84
 * * WGS84		: WGS84 좌표계
 * * WCONGNAMUL	: WCONGNAMUL 좌표계
 * * CONGNAMUL	: CONGNAMUL 좌표계
 * * WTM		: WTM 좌표계
 * * TM			: TM 좌표계
 */
function transCoord(y, x){
	// WTM 좌표를 WGS84 좌표계의 좌표로 변환한다
	geocoder.transCoord(x, y, function(result, status){
		// 정상적으로 검색이 완료됐으면 
	     if (status === daum.maps.services.Status.OK) {
	    	 console.log(result);
	    	 $("#transCoordTxt").html("X : "+ result[0].x +" <br> Y : "+ result[0].y);
	     }
	}, {
	    input_coord: daum.maps.services.Coords.WGS84,
	    output_coord: daum.maps.services.Coords.TM
	});
}

var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new daum.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === daum.maps.services.Status.OK) {
        	
        	// 클릭한 위도, 경도 정보를 가져옵니다 
            var latlng = mouseEvent.latLng;
        	
            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
            detailAddr += '<div>위도 : ' + latlng.getLat() + '</div>';
            detailAddr += '<div>경도 : ' + latlng.getLng() + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">법정동 주소정보</span>' + 
                            detailAddr + 
                        '</div>';

            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(mouseEvent.latLng);
            marker.setMap(map);

            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);
        }   
    });
});

// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
daum.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
// 테스트
function displayCenterInfo(result, status) {
    if (status === daum.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}

//test
//test
//test
//4
//5
</script>

</body>
</html>

