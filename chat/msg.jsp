<%@ page language="java"  contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<!--[if IE 8]>         <html class="no-js lt-ie9"> </html><![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
<meta charset="utf-8" />
<title>haohao</title>
<meta name="description" content="neil-hao" />
<meta name="author" content="neil-hao" />
<meta name="robots" content="noindex, nofollow" />
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1.0" /><!--手机自动缩放-->
<link rel="shortcut icon" href="./img/favicon.ico" /><!--网页标题图标-->

<!-- 引入 PROUI 的样式表  不用更改它的设置-->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/plugins.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" type="text/css" href="css/themes.css" />

<!-- PROUI 样式结束-->

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   <!--网页编码    utf-8 国际标准    GB2312 简体中文-->
<style>
.nav.navbar-nav-custom>li.open>a,.nav.navbar-nav-custom>li>a:focus,.nav.navbar-nav-custom>li>a:hover{background:none;}
ul li {
    list-style-type: none;
}
</style>
<script src="js/jquery-1.11.0.min.js"></script>

<script src="libs/gumhelper.js" type="text/javascript"></script>
<script src="libs/Animated_GIF.js" type="text/javascript"></script>
<script src="videoShooter.js" type="text/javascript"></script>

<%
String uid=request.getParameter("uid");
String mid=request.getParameter("mid");
%>
<script type="text/javascript">
/*function getQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}*/

var ws = null;
var myname ='<%=mid%>';//'<%//=request.getSession().getAttribute("username")%>';//getQueryString("uid");// "haohao";
console.log("mid:"+myname);
var yourname = '<%=uid%>';//"zhy";//"<%=uid%>";//"zhy";
console.log("toUser:"+yourname);
function log(text) {
	console.log(text);
}
String.prototype.startWith=function(s){
	if(s==null||s==""||this.length==0||s.length>this.length)
		return false;
	if(this.substr(0,s.length)==s)
		return true;
	else
		return false;
	return true;
}
function startServer() {
	console.log("enviroment:"+navigator.userAgent);
	var url ="ws://killinux.com:8443/websocketchat/hao/msg";
    if(window.location.href.split(":")[0]=="https"){
        url="wss://killinux.com:8443/websocketchat/hao/msg";
    }else{
        url="ws://killinux.com:8080/websocketchat/hao/msg";
    }
	//if https ,websocket is wss
	//var url ="ws://killinux.com:8443/hao/msg";
	if ('WebSocket' in window) {
		ws = new WebSocket(url);
	} else if ('MozWebSocket' in window) {
		ws = new MozWebSocket(url);
	} else {
		log('浏览器不支持websocket');
		return;
	}
	ws.onopen = function() {
		log('hoho，on websocket open');
	};
	ws.onmessage = function(event) {
		var thisdata = event.data;
		//log("thisdata:"+thisdata+"   "+myname);
		if(thisdata.startWith("open")){
		//	document.getElementById("username").value=thisdata.split(" ")[1];
		}else{
			var showData=event.data.split("#");
			//log(showData[0]+" say:"+showData[2]);
			if(showData[1]==yourname){
				//console.log("right");
				if(showData[3]==undefined||""==showData[3]){
					$("#content").append("<div><ul class='ul_talk reply'><li class='tbox' ><div><span class='head' style=''><img src='img/"+myname+".jpg'></span></div><div><span ><svg class='arrow'><path d='M0 10 L20 19 L21 12 L20 14 L0 20 Z' stroke-width='1' stroke='#7EBE2A' fill='#7EBE2A'></path></svg></span></div><div><article class='content'  style='border-radius:5px;box-shadow:  -1px 4px 2px -3px #999999; '>"+showData[2]+"</article></div></li></ul></div>"); 
				}else{ 
					$("#content").append("<div><ul class='ul_talk reply'><li class='tbox' ><div><span class='head' style=''><img src='"+showData[3]+"'></span></div><div><span ><svg class='arrow'><path d='M0 10 L20 19 L21 12 L20 14 L0 20 Z' stroke-width='1' stroke='#7EBE2A' fill='#7EBE2A'></path></svg></span></div><div><article class='content'  style='border-radius:5px;box-shadow:  -1px 4px 2px -3px #999999; '>"+showData[2]+"</article></div></li></ul></div>");  
				}
			}else{
				//console.log("left");
				if(showData[3]==undefined||""==showData[3]){
				$("#content").append("<div><ul class='ul_talk' style='padding:0; margin:0'><li class='tbox' ><div><span class='head'><img src='img/"+yourname+".jpg'></span></div><div><span class='arrow'><svg><path d='M50 0 L5 19 L4 20 L5 21 L50 40 Z' stroke-width='1' stroke='#FFFFFF' fill='#FFFFFF'></path></svg></span></div><div><article class='content' style='border-radius:5px;box-shadow: -1px 4px 2px -3px #999999; margin-bottom: 0px;'>"+showData[2]+"</article></div></li></ul></div>");
				}else{ 
				$("#content").append("<div><ul class='ul_talk' style='padding:0; margin:0'><li class='tbox' ><div><span class='head'><img src='"+showData[3]+"'></span></div><div><span class='arrow'><svg><path d='M50 0 L5 19 L4 20 L5 21 L50 40 Z' stroke-width='1' stroke='#FFFFFF' fill='#FFFFFF'></path></svg></span></div><div><article class='content' style='border-radius:5px;box-shadow: -1px 4px 2px -3px #999999; margin-bottom: 0px;'>"+showData[2]+"</article></div></li></ul></div>");
				}
			}
		}
		
	};
	ws.onclose = function() {
		log('Closed! 刷新页面尝试连接.');
	}
}
function sendMessage() {
	var mytext = document.getElementById("input-pj-text").value;
	
	if (ws != null && mytext != "") {
		
		ws.send(myname+","+yourname+","+mytext);
	}
	document.getElementById("input-pj-text").value="";
}
function stopconn() {
	ws.close();
}
function send_picture() {
	var main = document.querySelector('main');
	var mosaicContainer = document.getElementById('mosaic');
	var videoWidth= 0, videoHeight = 0;
	var videoElement;
	var shooter;
	var imagesPerRow = 5;
	var maxImages = 5;
	window.addEventListener('resize', onResize);
	GumHelper.startVideoStreaming(function(error, stream, videoEl, width, height) {
		if(error) {
			console.log('error: Cannot open the camera. Sad times: ' + error.message);
			//no video send message
			var mytext = document.getElementById("input-pj-text").value;
		        if (ws != null && mytext != "") {
                        	ws.send(myname+"#"+yourname+"#"+mytext);
                	}
			document.getElementById("input-pj-text").value="";
			return;
		}
		videoElement = videoEl;
		videoElement.width = width / 4;
		videoElement.height = height / 4;
		videoElement.style.display="none";
		videoWidth = width;
		videoHeight = height;
		main.appendChild(videoElement);
		shooter = new VideoShooter(videoElement);
		onResize();
		startCapturing();

	});
	function startCapturing() {
		shooter.getShot(onFrameCaptured, 10, 0.2, function onProgress(progress) {
			// Not doing anything in the callback,
		});
	}
	function onFrameCaptured(pictureData) {
		var mytext = document.getElementById("input-pj-text").value;
	        if (ws != null && mytext != "") {
	                ws.send(myname+"#"+yourname+"#"+mytext+"#"+pictureData);
	        }
	        document.getElementById("input-pj-text").value="";
		var img = document.createElement('img');
		img.src = pictureData;
		var imageSize = getImageSize();
		img.style.width = imageSize[0] + 'px';
		img.style.height = imageSize[1] + 'px';
		mosaicContainer.insertBefore(img, mosaicContainer.firstChild);
		if(mosaicContainer.childElementCount > maxImages) {
			mosaicContainer.removeChild(mosaicContainer.lastChild);	
		}
	}
	function getImageSize() {
		var windowWidth = window.innerWidth;
		var imageWidth = Math.round(windowWidth / imagesPerRow);
		var imageHeight = (imageWidth / videoWidth) * videoHeight;

		return [ imageWidth, imageHeight ];
	}
	function onResize(e) {
		// Don't do anything until we have a video element from which to derive sizes
		if(!videoElement) {
			return;
		}
		var imageSize = getImageSize();
		var imageWidth = imageSize[0] + 'px';
		var imageHeight = imageSize[1] + 'px';
		for(var i = 0; i < mosaicContainer.childElementCount; i++) {
			var img = mosaicContainer.children[i];
			img.style.width = imageWidth;
			img.style.height = imageHeight;
		}
		videoElement.style.width = imageWidth;
		videoElement.style.height = imageHeight;
	}

}
function keydownEvent() {
    var e = window.event || arguments.callee.caller.arguments[0];
	if (e && e.keyCode == 13 ) {
		//alert("您按回车键了");
        send_picture();
	}
}
</script>
</head>
<body onload="startServer()" style=" background:#E6E6E6; margin:0; padding:0; padding-bottom:55px; ">
<div  id="page-container" style=" margin:0px; padding:0px; background:none; padding-top:0px; padding-bottom:0px">
<div id="content" class="containertop">
<main style="display:none"><!--for debug-->
	<div id="mosaic">mosaic</div>
</main>
<!-- 	<div><ul class='ul_talk' style="padding:0; margin:0"><li class='tbox' ><div><span class='head'><img src='img/1.jpg'></span></div><div><span class='arrow'><svg><path d='M50 0 L5 19 L4 20 L5 21 L50 40 Z' stroke-width='1' stroke='#FFFFFF' fill='#FFFFFF'></path></svg></span></div><div>
		<article class='content' style='border-radius:5px;box-shadow: -1px 4px 2px -3px #999999; margin-bottom: 0px;'>事情是一样的嘛</article></div></li></ul>
	</div>
	<div><ul class='ul_talk reply'><li class='tbox' ><div><span class='head' style=''><img src='img/0.jpg'></span></div><div><span class='arrow'><svg><path d='M0 10 L20 19 L21 12 L20 14 L0 20 Z' stroke-width='1' stroke='#7EBE2A' fill='#7EBE2A'></path></svg></span></div><div>
		<article class='content'  style='border-radius:5px;box-shadow:  -1px 4px 2px -3px #999999; '>我觉得还可以！当世界变的不同的时候，我们议案让你选择放弃了</article></div></li></ul>
	</div> -->
</div>
</div>

<footer class="navbar navbar-default navbar-fixed-bottom text-center slideUp" style=" line-height:40px; color:#EBEBEB; font-size:16px;border:none; opacity:1; display:block; border-top:#E6E6E6 1px solid; background:#FFFFFF" id="pjtext" >
<div  style="padding-top:4px;">
<!--form id="form_pj"-->
<div class="col-xs-1" style="padding:0px; margin:0; padding-left:5px; color:#B9B9B9"><i class="fa fa-smile-o" style=" font-size:2.1em; padding-top:5px;"></i></div>
<div class="col-xs-9" style="padding:0px; margin:0; padding-left:8px; padding-right:0px">
	<input id="input-pj-text" onkeydown="keydownEvent()" name="pj_text" class="form-control input-lg"  required="required"    style="border-radius:3px;height:40px; border:none; border-bottom:#E6E6E6 1px solid; font-size:18px" ><!-- onBlur="javascript:$('#st-footer-bar').show();$('#wyh').show();$('#pjtext').hide();"  -->
</div>


<!--div class="col-xs-2" style="padding:0; margin:0; line-height:35px">
	<a onclick="sendMessage()"  class="btn btn-lg btn-primary" style="border-color:#999999;  border-radius:2px;border-width:0px; opacity:1; height:35px; width:83%; padding:7px; background:#33CC33;" id="doPingjia">
		<span style="color:#FFFFFF; font-size:15PX;" >发送</span>
	</a>
</div-->
<div class="col-xs-2" style="padding:0; margin:0; line-height:35px">
	<a onclick="send_picture()"  class="btn btn-lg btn-primary" style="border-color:#999999;  border-radius:2px;border-width:0px; opacity:1; height:35px; width:83%; padding:7px; background:#33CC33;" id="send_message_button">
		<span style="color:#FFFFFF; font-size:15PX;" >发送</span>
	</a>
</div>

<!--/form-->
</div>
<!--<div style="height:200px"></div>fa fa-smile-o-->
</footer>
</html>
