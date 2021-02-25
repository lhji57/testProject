<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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

<script>
/* Javascript 샘플 코드 */


var xhr = new XMLHttpRequest();
var url = 'http://openapi.epost.go.kr/postal/retrieveLotNumberAdressAreaCdService/retrieveLotNumberAdressAreaCdService/getDetailListAreaCd'; /*URL*/
var queryParams = '?' + encodeURIComponent('ServiceKey') + '='+encodeURIComponent('QVoFetRhuUF%2BAHjiaCD8Mw5DVsua2XXDBtxT5VN8G6sY2IpQW2hWblcSPqmSFNZSfMuE43AzguU8Vut8bYKaeQ%3D%3D'); /*Service Key*/
queryParams += '&' + encodeURIComponent('searchSe') + '=' + encodeURIComponent('dong'); /**/
queryParams += '&' + encodeURIComponent('srchwrd') + '=' + encodeURIComponent('공평동'); /**/
queryParams += '&' + encodeURIComponent('countPerPage') + '=' + encodeURIComponent('10'); /**/
queryParams += '&' + encodeURIComponent('currentPage') + '=' + encodeURIComponent('1'); /**/
xhr.open('POST', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
    }
};

//xhr.send('');

$.ajax({
	type: 'GET',
	url : url + queryParams,
	dataType : 'jsonp',
	async : false,
	contentType:'application/json; charset=utf-8',
	error:function(jqXHR, textStatus, errorThrown){
		console.log(jqXHR);
		console.log(textStatus);
		console.log(errorThrown);
	},
	success: function(data){
		console.log(data);
		
	}
});


</script>

</body>
</html>