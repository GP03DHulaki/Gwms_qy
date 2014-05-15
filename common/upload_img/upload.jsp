<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.scm.UploadFileMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
//传入来源id，查出所有图片
String id = request.getParameter("id");
String type = request.getParameter("type");
if(request.getParameter("time") != null) {
	UploadFileMB ai = (UploadFileMB)MBUtil.getManageBean("#{uploadFileMB}");
	if(id==null||id.equals("")) {
	out.print("参数错误");
	return;
	}
	else {
		ai.setId(id);
		ai.setType(type);
	}
	ai.setMsg("");
	
}

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加清单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="添加清单">
		<meta http-equiv="description" content="添加清单">
<style>
body{overflow: auto;}
#upload{ background-color: #FFFFFF; border: 1px solid #C0C0C0;width:515px;float: left; margin-right: 5px;margin-left:5px;margin-top:5px;}
.tool-bar{background-color: #ECF4FE;border-bottom: 1px solid #C0C0C0; border-left: 1px solid #FFFFFF;border-top: 1px solid #FFFFFF;padding: 2px; width: 100%;}
.button-border{border: #c0c0c0 1px solid;margin: 2px;}
#upload-list{width: 100%;height: 310px;overflow-x: hidden;overflow-y: auto;padding: 5px;}
.button{background-color: #d6e6fb;padding: 2px;cursor: pointer;background: url("botton.png") repeat-x left top;}
.botton-font{font-family: Arial, Verdana, sans-serif;font-size: 11px;}
.button-content{display: block;color: #000;text-decoration: none;text-align: left;padding: 2px 6px 2px 3px;}
.botton-ico{padding-left: 19px;background-repeat: no-repeat;background-position: 0 50%;vertical-align: middle;}
.botton-ico-add{background-image: url("ico_add_gif.gif");}
.fileupload-hidden{text-align: left;filter:alpha(opacity:0); opacity: 0;moz-opacity:0;position: absolute; font-size: 10em; top: 0px; cursor: pointer; right: 0px; padding: 0}
input{border:#bed6f8 1px ;color:#000;}
.button-light{background-repeat:repeat;background-position:top left;background-color:#D6E6FB;border:1px solid;cursor:pointer;padding:1px;background-image:url("button-light.png");border-color:#E79A00;}
.button-press{background-image:url("botton_press.png");border-color:#E79A00;border:1px solid;padding:2px 0 0 2px;background-repeat:repeat-x;background-position:top left;background-color:#ECF4FE;}
.delete a{color: #0078D0;width: 50px;text-decoration: underline;cursor: pointer;}
#upload-list table td{border-bottom: 1px solid;}
.botton-ico-upload{background: url("upload.gif") no-repeat;}
.imgcontainer{height: 100%;overflow: auto;}
#existfiles{ border: 1px solid #C0C0C0;background-color: #FFFFFF;width: 500px;float: left;}
.tableL{width:160px;height: 150px;overflow: hidden;}
.tableR{width:30px;}
</style>
<script type="text/javascript">
function overCSS(obj) {
	obj.className="button-light";
}
function outCSS(obj){
	obj.className="button";
}
function mouseDownCSS(obj){
	obj.className="button-press";
}
function mouseUpCSS(obj){
	obj.className="button";
}
var upcss = "button-content botton-font botton-ico botton-ico-upload"
var addcss="button-content botton-font botton-ico botton-ico-add"
function addFile(obj){
	document.getElementById('uploadValue').innerHTML="上传文件："+obj.value;
	document.getElementById('uploadValue').title=obj.value;
	var addbtn = document.getElementById('addbtn');
	var upbtn = document.getElementById('upbtn');
	document.getElementById('hideinput').style.display='none';
	addbtn.style.display='none';
	upbtn.style.display='block';
	addbtn.innerText="上传";
}

function upload(){
	document.getElementById('uploadValue').innerHTML="";
	document.getElementById('uploadValue').title="";
	var addbtn = document.getElementById('addbtn');
	var upbtn = document.getElementById('upbtn');
	document.getElementById('hideinput').style.display='block';
	addbtn.style.display='block';
	upbtn.style.display='none';
	$('edit:submit').click();
}
function init(){
if($('edit:msg').value!=''){alert($('edit:msg').value)}
}
function del(pid){
	if(confirm("确认删除吗？")) {
		$("edit:pid").value=pid;
		$("edit:delete").click();
	}
	return false;
	
}
function delStart() {
	Gwin.progress("",10,document);
}
function delEnd(){
	Gwin.close("progress_id");
	if($("edit:msg").value!=''){
		alert($("edit:msg").value);
	}
}
function openBigImg(url) {
	window.open(url);
}
</script>
	</head>

	<body id="mmain_body" onload="init()">
		<f:view>
			<div >
				<h:form id="edit" enctype="multipart/form-data">
					<div id="upload">
						<table class="tool-bar">
							<tr><td>
<span style="display: block;overflow: hidden;white-space: nowrap;line-height: 18px;width:430px;float: left;" id="uploadValue">上传文件名：空</span>
<div style="margin-left: 5px;width: 420px;display: block;float: left;padding-top: 5px;">文件说明: <h:inputText id="title" value="#{uploadFileMB.label}" styleClass="datetime" size="65"/></div>
<div class="button-border" style="float: right;">
<div style="position: relative"  class="button botton-font"  onmouseover="overCSS(this)" onmouseout="outCSS(this)" onmousedown="mouseDownCSS(this)" onmouseup="mouseUpCSS(this)">
<div style="position: relative" class="button-content botton-font botton-ico botton-ico-add " id="addbtn">添加</div>
<div style="position: relative;display: none" class="button-content botton-font botton-ico botton-ico-upload " onclick="upload()" id="upbtn">上传</div>
<div style="position: absolute;width: 58px;height: 22px; overflow: hidden; top: 0px; padding: 0; left: 0px" id="hideinput">
<t:inputFileUpload id="tupload" value="#{uploadFileMB.upFile}" storage="file" styleClass="fileupload-hidden" accept="image/*" onchange="addFile(this)"></t:inputFileUpload>
</div>
</div>
</div>
								<div></div>
							</td></tr>
							<tr></tr>
						</table>
<div id="upload-list">
<a4j:outputPanel id="list">
	<t:dataTable id="imgTab" var="image" value="#{uploadFileMB.images}" width="100%" columnClasses="tableL,tableC,tableR">
		<t:column >
			<h:graphicImage url="/upload/cut/#{image.url}" width="150px" title="点击查看大图" style="cursor:pointer" onclick="openBigImg('../../upload/#{image.url}')"></h:graphicImage>
		</t:column>
		<t:column>
			<h:outputText value="#{image.label}"></h:outputText>
		</t:column>
		<t:column>
				<h:outputLink onclick="return del(#{image.id})">删除</h:outputLink>
		</t:column>
	</t:dataTable>
</a4j:outputPanel>
</div>
					
					</div>
<div style="display:none">
	<h:commandButton id="submit" action="#{uploadFileMB.upload}" />
	<a4j:outputPanel id="renderArea">
		<h:inputHidden id="msg" value="#{uploadFileMB.msg}"></h:inputHidden>
		<h:inputHidden id="id" value="#{uploadFileMB.id}"></h:inputHidden>
	</a4j:outputPanel>
	<a4j:commandButton id="delete" action="#{uploadFileMB.delete}" reRender="list,renderArea" onclick="" oncomplete=""></a4j:commandButton>
	<h:inputHidden id="pid" value="#{uploadFileMB.pid}"></h:inputHidden>
</div>

				</h:form>
			</div>
		</f:view>
	</body>
</html>