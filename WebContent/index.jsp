<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��������</title>
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
���� ����
(���ø����̼� �̸� : ����_����)
 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dcdb31e68aaaf9cfe5501704f8c003ce&libraries=services"></script>

<div class="mapWrapKakao">
	<div id="mapKakao" style="width:90%;height:450px;"></div>
	<div class="hAddr">
		<span class="title">�����߽ɱ��� ������ �ּ�����.</span>
		<span id="centerAddr"></span>
	</div>
	<input type="text" id="addrTxt" style="width:450px;">
	<input type="button" id="coordinateBtn"value="�ּ�->��ǥ��ȯ">
	<div id="transCoordTxt"></div>
</div>

<script>
var mapContainer = document.getElementById('mapKakao'), // ������ ǥ���� div 
mapOption = { 
    center: new daum.maps.LatLng(37.58067292361561, 126.9058578299751), // ������ �߽���ǥ
    level: 3 // ������ Ȯ�� ����
};

//������ ǥ���� div��  ���� �ɼ�����  ������ �����մϴ�
var map = new daum.maps.Map(mapContainer, mapOption); 
//�ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
var geocoder = new daum.maps.services.Geocoder();

$("#coordinateBtn").click(function(){
	var addrTxt = $("#addrTxt").val();
	
	// �ּҷ� ��ǥ�� �˻��մϴ�
	geocoder.addressSearch(addrTxt, function(result, status) {

	    // ���������� �˻��� �Ϸ������ 
	     if (status === daum.maps.services.Status.OK) {

	        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	        
	        //�ٸ� ��ǥ��� ��ȯ�� ���
	     	transCoord(result[0].y, result[0].x);
	     	
	        // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
	        var marker = new daum.maps.Marker({
	            map: map,
	            position: coords
	        });

	        // ����������� ��ҿ� ���� ������ ǥ���մϴ�
	        var infowindow = new daum.maps.InfoWindow({
	            content: '<div style="width:250px;text-align:center;padding:5px 5px;">X : '+result[0].x+' <br/> Y : '+result[0].y+'</div>'
	        });
	        infowindow.open(map, marker);

	        // ������ �߽��� ��������� ���� ��ġ�� �̵���ŵ�ϴ�
	        map.setCenter(coords);
	    } 
	});
	
})

/* �޾ƿ� ��ǥ�� �ٸ� ��ǥ���� ��ǥ�� ��ȯ�Ѵ�.
 * input_coord : �Է� ��ǥ ü��. �⺻���� WGS84
 * output_coord : ��� ��ǥ ü��. �⺻���� WGS84
 * * WGS84		: WGS84 ��ǥ��
 * * WCONGNAMUL	: WCONGNAMUL ��ǥ��
 * * CONGNAMUL	: CONGNAMUL ��ǥ��
 * * WTM		: WTM ��ǥ��
 * * TM			: TM ��ǥ��
 */
function transCoord(y, x){
	// WTM ��ǥ�� WGS84 ��ǥ���� ��ǥ�� ��ȯ�Ѵ�
	geocoder.transCoord(x, y, function(result, status){
		// ���������� �˻��� �Ϸ������ 
	     if (status === daum.maps.services.Status.OK) {
	    	 console.log(result);
	    	 $("#transCoordTxt").html("X : "+ result[0].x +" <br> Y : "+ result[0].y);
	     }
	}, {
	    input_coord: daum.maps.services.Coords.WGS84,
	    output_coord: daum.maps.services.Coords.TM
	});
}

var marker = new daum.maps.Marker(), // Ŭ���� ��ġ�� ǥ���� ��Ŀ�Դϴ�
    infowindow = new daum.maps.InfoWindow({zindex:1}); // Ŭ���� ��ġ�� ���� �ּҸ� ǥ���� �����������Դϴ�

// ���� ���� �߽���ǥ�� �ּҸ� �˻��ؼ� ���� ���� ��ܿ� ǥ���մϴ�
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

// ������ Ŭ������ �� Ŭ�� ��ġ ��ǥ�� ���� �ּ������� ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
daum.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === daum.maps.services.Status.OK) {
        	
        	// Ŭ���� ����, �浵 ������ �����ɴϴ� 
            var latlng = mouseEvent.latLng;
        	
            var detailAddr = !!result[0].road_address ? '<div>���θ��ּ� : ' + result[0].road_address.address_name + '</div>' : '';
            detailAddr += '<div>���� �ּ� : ' + result[0].address.address_name + '</div>';
            detailAddr += '<div>���� : ' + latlng.getLat() + '</div>';
            detailAddr += '<div>�浵 : ' + latlng.getLng() + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">������ �ּ�����</span>' + 
                            detailAddr + 
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
daum.maps.event.addListener(map, 'idle', function() {
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
// �׽�Ʈ
function displayCenterInfo(result, status) {
    if (status === daum.maps.services.Status.OK) {
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


//feature �귣ġ ����
//test
//test
//test
//4
//5
//6
</script>

</body>
</html>

