<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>修改密码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="修改密码">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
	</head>
	<script type="text/javascript">
		<!--
			function showMsg(){
				$("edit:newpwd").value="";
				$("edit:pwd").value="";
				$("edit:newpwd").focus();
			}
			
		 	function check(){
		 		var passWord=document.getElementById("edit:newpwd").value;
		 	
			    if($("edit:newpwd").value == $("edit:pwd").value)
				{
					if(passWord.indexOf("-")>=0){
						Gwin.alert("系统提示","密码不能包括'-'号！","!",document);
						return false;
					}
					if(passWord.indexOf(".")>=0){
						Gwin.alert("系统提示","密码不能包括'.'号！","!",document);
						return false;
					}
					if(passWord==""){
						Gwin.alert("系统提示","密码不能为空！","!",document);
						return false;
					}
					startDo();
					return true;
				}else{
					Gwin.alert("系统提示","输入的新密码和确认密码不一致！","!",document);
			   		$("edit:newpwd").value="";
			       	$("edit:pwd").value="";
			   		$("edit:newpwd").focus();
			   		return false;
				}
		    }
		    
		   	function startDo(){
		   		Gwin.progress("正在保存...",10,document);
		 		controlEditable("disabled");
		    }
		    
			function endDo(){
		       	Gwin.close("progress_id");
		        controlEditable("");
		        var msg = $('edit:mes').value;
		        var type = "X";
		     	if(msg.indexOf("成功")!=-1){
		     		type = "Y";
				}else {
					$("edit:newpwd").value="";
					$("edit:pwd").value="";
				}
		     	Gwin.alert("系统提示",msg,type,parent.document);
		     	if(type == "Y")Gwin.close("editPWDWin");
		    }
		    
		    function controlEditable(value){
				$("edit:deleteButton").disabled=value;
		    }
		//-->		    	
	</script>

	<body id=mmain_body onload="showMsg();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<b>系统管理</b> &gt;&gt;
					<b>修改密码</b>
					<div id=mmain_free>
						<h:inputText id="userid" styleClass="inputtext"
							value="#{user.bean.usid}" readonly="true"></h:inputText>
						&nbsp;
						<font style="background-color: #efefef">用户名称:</font>
						<h:inputText id="userName" styleClass="inputtext"
							value="#{user.bean.usna}" readonly="true"></h:inputText>
					</div>
					<div id=mmain_opt>
						<a4j:commandButton id="deleteButton" value="保存" type="button"
							action="#{user.updatePwd}" onclick="if(!check()){return false;}"
							reRender="mes" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							rendered="#{user.MOD}" />
						<input type="button" value="返回"
							onmouseover="this.className='search_over'"
							onmouseout="this.className='search_buton'" class="but"
							onclick="Gwin.close('editPWDWin');"></input>
					</div>
					<div id=mmain_free>
						<br />
						<br />
						<table width="300" border="0" cellpadding="3" cellspacing="1"
							bgcolor="#FFFFFF" style="font-size: 12px" id="output"
							align="center">
							<tr>
								<td bgcolor="#efefef" align="right" width="90">
									新密码:
								</td>
								<td width="210">
									<h:inputSecret id="newpwd" value="#{user.bean.pass}"
										styleClass="inputtextedit"></h:inputSecret>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef" align="right" width="90">
									确认密码:
								</td>
								<td width="210">
									<h:inputSecret id="pwd" styleClass="inputtextedit"></h:inputSecret>
								</td>
							</tr>
						</table>
						<h:inputHidden id="mes" value="#{user.msg}" />
						<br />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>