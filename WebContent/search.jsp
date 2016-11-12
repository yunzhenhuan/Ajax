<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
#mydiv {
	position: absolute;
	left: 50%;
	top: 50%;
	margin-left: -200px;
	margin-top: -50px;
}

.mouseOver {
	background: #708090;
	color: #FFFAFA;
}

.mouseOut {
	background: #FFFAFA;
	color:#000000;
}
</style>
<script type="text/javascript">
	var xmlHttp;
	//获得用户输入内容关联信息的函数
	function getMoreContents() {
		//首先要获得用户的输入
		var content = document.getElementById("keyword");
		if (content.value == "") {
			clearContent();
			return;
		}

		//要给服务器发送用户输入的内容，因为要采用的是ajax异步发送数据
		//所以要使用一个对象，叫做XmlHttp对象
		xmlHttp = createXMLHttp();

		//要给服务器发送数据
		var url = "search?keyword=" + escape(content.value);

		//true表示javascript脚本会在send()发送之后继续执行，而不会等待来自服务器的响应
		xmlHttp.open("GET", url, true);

		//xmlHttp绑定回调方法，这个回调方法会在xmlHttp状态改变的时候被调用
		//xmlHttp状态0-4，我们只关心4（complete)这个状态，所以

		xmlHttp.onreadystatechange = callback;
		xmlHttp.send(null);
	}

	function createXMLHttp() {
		//对于大多数的浏览器都适用
		var xmlHttp;
		if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		}
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			if (!xmlHttp) {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")
			}
		}
		return xmlHttp;
	}

	//回调函数
	function callback() {
		//4代表完成
		if (xmlHttp.readyState == 4) {
			//alert("4");
			//200代表服务器响应成功
			//404代表资源未找到，500代表服务器内部错误
			if (xmlHttp.status == 200) {
				//交互成功，获得响应的数据，是文本格式
				var result = xmlHttp.responseText;
				//解析获得数据
				var json = eval("(" + result + ")");
				//获得数据之后,就可以动态的显示这些数据展示到输入框下面				
				setContent(json);
			}
		}
	}

	//设置关联数据的展示，参数
	function setContent(contents) {
		clearContent();
		setLocation();
		//首先获得关联数据的长度，以此来确定生成多少<tr></td>
		var size = contents.length;
		//设置内容
		for (var i = 0; i < size; i++) {
			var nextNode = contents[i];//代表的是json的第i个元素
			var tr = document.createElement("tr");
			var td = document.createElement("td");
			td.setAttribute("border", "0");
			td.setAttribute("bgcolor", "#FFFAFA");
			td.onmouseover = function() {
				this.className = 'mouseOver';
			};
			td.onmouseout = function() {
				this.className = 'mouseOut';
				//document.getElementById("keyword").value="out";	
			};
			td.onclick = function() {
				//这个方法实现的是，当用鼠标点击一个关联的俄数据时，关联数据自动设置为输入框的输入数据
				document.getElementById("keyword").value=nextNode;					
			};
			var text = document.createTextNode(nextNode);
			td.appendChild(text);
			tr.appendChild(td);
			document.getElementById("content_table_body").append(tr);
		}
	}
	//晴空之前的数据
	function clearContent() {
		var contentTableBody = document.getElementById("content_table_body");
		var size = contentTableBody.childNodes.length;
		//alert("size="+size);
		for (var i = size - 1; i >= 0; i--) {
			contentTableBody.removeChild(contentTableBody.childNodes[i]);
		}
		document.getElementById("popDiv").style.border="none";
	}

	//设置显示关联信息的位置
	function setLocation() {
		//关联信息的显示位置要和输入框的宽度
		var content = document.getElementById("keyword");
		var width = content.offsetWidth;//输入框的宽度
		var left=content["offsetLeft"];//距离左边框的距离
		var top = content["offsetTop"] + content.offsetHeight;//到顶部的距离
		//获得显示数据的div
		var popDiv = document.getElementById("popDiv");
		popDiv.style.border = "black 1px solid";
		popDiv.style.left = left + "px";
		popDiv.style.top = top + "px";
		popDiv.style.width = width + "px";
		document.getElementById("content_table").style.width=width+"px";

	}
	//当输入框失去焦点
	function keywordBlur() {
		clearContent();
	}
</script>
</head>
<body>
	<div id="mydiv">
		<!-- 输入框 -->
		<input type="text" size="50" id="keyword" onkeyup="getMoreContents()"
			onblur="keywordBlur()" onfocus="getMoreContents()" /> <input
			type="button" value="百度一下" width="50px" />
		<!-- 下面是内容展示的区域 -->
		<div id="popDiv">
			<table id="content_table" bgcolor="#FFFAFA" border="0"
				cellspacing="0" cellpadding="0">

				<tbody id="content_table_body">
					<!-- 动态查询出来的显示在这个地方-->

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>

