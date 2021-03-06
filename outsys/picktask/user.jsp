<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.common.UserCOM"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>用户信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='picktask.js'></script>
		<script type="text/javascript">
			var retid = "", retname = "";		//返回刷新的字段，如无，则不刷新
			function selectThis(parm1, parm2) {
				retid = $("edit:retid").value;
				retname = $("edit:retname").value;
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				if(isGwin === false){
					is_IE = (navigator.appName == "Microsoft Internet Explorer");
					var callBack = null;  
					if(is_IE) {
						callBack = window.dialogArguments;
					}
					else {
						if (window.opener.callBack == undefined) {   
							window.opener.callBack = window.dialogArguments;   
						}   
						callBack = window.opener.callBack;   
					}
				}else{
					callBack = parent.document;
				}
				if (retid != "" && retid != null) {
					callBack.getElementById(retid).value = parm1;
				}
				if (retname != "" && retname != null) {
					callBack.getElementById(retname).value = parm2;
				}
			
				isGwin ? Gwin.close(document.GwinID) : window.close();	
			}
			
		</script>
	</head>

	<%
	    UserCOM ai = (UserCOM) MBUtil.getManageBean("#{userCOM}");
	    if (request.getParameter("time") != null) {
	        ai.initSK();
	        ai.setSql("");
	    }
	    if (request.getParameter("retid") != null) {
	        ai.setRetid(request.getParameter("retid"));
	    }
	    if (request.getParameter("retname") != null) {
	        ai.setRetname(request.getParameter("retname"));
	    }
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{userCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="用户编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{userCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="用户名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{userCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select usid,usna from usin where 1=1 #{userCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = usid(headtext = 用户编码,name = usid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = usna(headtext = 用户名称,name = usna,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{userCOM.retid}" />
						<h:inputHidden id="retname" value="#{userCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>