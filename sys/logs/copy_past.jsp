<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>用户管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="用户管理">
	</head>
	<script type="text/javascript">
		function doCopy(){
			var copyText="";
			 if(window.getSelection){//是否支持该方法
			 	copyText=window.getSelection();
			 }else if(document.getSelection){//是否支持该方法
			 	copyText = document.getSelection();
			 }else if(document.selection){//是否支持该方法
				copyText = document.selection.createRange().text;//获取鼠标选定的文本      
			}
			doClipBoard(copyText);
		}
		
		function doClipBoard(copyText){
			if(window.clipboardData){        
				window.clipboardData.clearData();//清空剪贴板
				window.clipboardData.setData("Text", copyText);//放进剪贴板        
			} 
		}
		
		function doPast(){
			var itemObj=document.getElementById("txt");
			itemObj.focus();
			//item.value=window.clipboardData.getData("Text");
			itemObj.document.execCommand("paste"); //粘贴 
		}
	</script>
	<body>
		<div id="mydiv"
			style="width: 190px; height: 30px; bgcolor: #efefef; display: none;">
			<img src="<%=request.getContextPath()%>/images/indicator.gif"
				width="16" height="16" />
			<b><font color="white">正在处理，请稍等...</font> </b>
		</div>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="1">
						<tr bgcolor="#ffffff">
							<td height="20">
								<font color="#000000"> 日志管理&gt;&gt;</font>
								<b> 剪切板 </b>
								<br>
							</td>
						</tr>
						<tr>
							<td>
								<input id="copy" value="复制" type="button" onclick="doCopy();"
									onmouseover="this.className='a4j_over'"
									onmouseout="this.className='a4j_buton'" class="a4j_but" />

								<input id="past" value="粘贴" type="button" onclick="doPast();"
									onmouseover="this.className='a4j_over'"
									onmouseout="this.className='a4j_buton'" class="a4j_but" />
							</td>
						</tr>
						<tr>
							<Td>
								<textarea rows="6" cols="100" id="txt"></textarea>
							</Td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>