<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<jsp:directive.page import="com.gwall.view.UserMB" />
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<%
	//获取用户id		
	if (session.getAttribute("userid") != null) {
		String userid = session.getAttribute("userid").toString();
		//设置员工编码
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = context.getApplication()
				.createValueBinding("#{user}");
		UserMB user = (UserMB) binding.getValue(context);
		user.getBean().setUsid(userid);
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>修改密码</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
		<meta http-equiv="description" content="修改密码" />
	</head>

	<script type="text/javascript">
		<!--
		 	function check(){
				var passWord=document.getElementById("edit:newpwd").value;
		 	
			    if($("edit:newpwd").value == $("edit:pwd").value)
				{
					if(passWord.indexOf("-")>=0){
						alert("密码不能包括'-'号！");
						return false;
					}
					if(passWord.indexOf(".")>=0){
						alert("密码不能包括'.'号！");
						return false;
					}
					if(passWord==""){
						alert("密码不能为空！");
						return false;
					}
					startDo();
					return true;
				}else{
					alert("输入的新密码和确认密码不一致！");
					$("edit:oldpwd").value="";
			   		$("edit:newpwd").value="";
			       	$("edit:pwd").value="";
			       	
			   		$("edit:oldpwd").focus();
			   		return false;
				}
		    }
		    
			function startDo(){
		        Gwallwin.winShowmask("TRUE");
		    }		    
		    
			function endDo(){
		       Gwallwin.winShowmask("FALSE");
		        var mes = $("edit:msg").value;
		        var reg1 = new RegExp("旧密码输入不正确!");
		        var reg2 = new RegExp("新密码和确认密码不一致");
		        var reg3 = new RegExp("密码修改成功!");		        
		        if($("edit:msg")!=null && $("edit:msg").value.length>0){
		    		alert($("edit:msg").value);		    		
		    		if(reg1.test(mes)){
			    		$("edit:oldpwd").value="";
		    			$("edit:oldpwd").focus();
		    		}
		    		if(reg2.test(mes)){
		    			$("edit:newpwd").value="";
		    			$("edit:pwd").value="";
		    			$("edit:newpwd").focus();
		    		}
		    		if(reg3.test(mes)){
		    			$("edit:oldpwd").value="";
		    			$("edit:newpwd").value="";
		    			$("edit:pwd").value="";
		    			$("edit:oldpwd").disabled="";
		    			$("edit:oldpwd").focus();
		    			$("promptDiv").style.display="none";
		    			$("edit:msg").value="";
		    		}		    		
		    	}	        	
		    }
		    var req=null;	
		    var prompt="";//提示信息
		    function getPwd(){
		    	var pwd="";			    	   	
		    	if($("edit:oldpwd")!=null){
		    		pwd=$("edit:oldpwd").value;
		    		if(pwd.length==0){
		    			alert("旧密码不能为空!");
		    			$("edit:oldpwd").focus();
		    			return false;
		    		}
		    	}	    	
		    	var uId='<%=session.getAttribute("nc_userid")%>';		    	
		    	var url="../CheckPassword.do?pwd="+pwd+"&uId="+uId+"&t="+Math.round(Math.random()*3000);
				if (window.XMLHttpRequest) { 													
					req = new XMLHttpRequest(); 			                 				
				}else if (window.ActiveXObject) { 												
					req = new ActiveXObject("Microsoft.XMLHTTP"); 
				} 
				if(req){ 
					req.open("GET",url, true); 
					req.onreadystatechange = complete; 
					req.send(null);
				} 
		    }
		    function complete(){
		    	if(req.readyState==4){
		    		if(req.status==200){
		    			var info = req.responseText;	    				    			
		    			if(info.length>0 && info.indexOf("exists")!=-1){		    				
							$("promptDiv").innerHTML="<font color='red'>密码正确!</font>";
							$("edit:oldpwd").disabled="disabled";
		    			}else{
							$("promptDiv").innerHTML="<font color='red'>密码错误!</font>";																    				
		    			}
		    			$("promptDiv").style.display="";
		    			prompt = info;	    			
		    		}
		    	}
		    }		    
		    function refresh(){
		    	if(prompt.indexOf("exists")==-1){//密码不正确时,执行以下操作 
		    		$("edit:oldpwd").value="";		    	
		    		$("promptDiv").style.display="none";
		    	}    	
		    }		    
	    //-->
	</script>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<h:panelGroup style="font-weight:bold">系统管理 >> 修改密码</h:panelGroup>
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="保存" onclick="if(!check()){return false;}"
							action="#{user.updatepassword}" oncomplete="endDo();"
							reRender="rerenderInfo" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<h:panelGrid style="text-align:center;width:650px" border="0"
						cellpadding="3" cellspacing="1">
						<h:panelGroup>
							<h:panelGrid columns="2">
								<h:panelGroup style="bgcolor:#efefef"> 旧密码:</h:panelGroup>
								<h:panelGroup>
									<h:inputSecret id="oldpwd" value="#{user.oldpass}"
										styleClass="inputtextedit" onfocus="this.select()"></h:inputSecret>
									<div id="promptDiv"></div>
								</h:panelGroup>
								<h:panelGroup style="bgcolor:#efefef"> 新密码:</h:panelGroup>
								<h:panelGroup>
									<h:inputSecret id="newpwd" value="#{user.pass}"
										styleClass="inputtextedit" onfocus="this.select()"></h:inputSecret>
								</h:panelGroup>
								<h:panelGroup style="bgcolor:#efefef">确认密码:</h:panelGroup>
								<h:panelGroup>
									<h:inputSecret id="pwd"
										styleClass="inputtextedit" onfocus="this.select()"></h:inputSecret>
								</h:panelGroup>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
					<a4j:outputPanel id="rerenderInfo">
						<h:inputHidden id="msg" value="#{user.msg}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>