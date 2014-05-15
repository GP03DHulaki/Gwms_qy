<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PoinMB"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>到货通知单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='poin.js'></script>
		<script type="text/javascript">
			var retid="",retname="";		//返回刷新的字段，如无，则不刷新
		    function selectThis(parm1){
retid = $("edit:retid").value;
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
}
if ( retid != "" && retid != null){
	isGwin ? parent.document.getElementById("edit:soco").value = parm1 : callBack.document.getElementById("edit:soco").value=parm1;
}
isGwin ? Gwin.close(document.GwinID) : window.close();	
		    }
		    
			function formsubmit(){
				if (event.keyCode==13){
					var obj=$("edit:sid");
					obj.onclick();
					return true;
				}
			}
			
			function cleartext(){
				var a = $("edit:id");
				if(a!=null){
					a.value="";
					a.focus();
				}
			}
		</script>
	</head>

	<%
		PoinMB ai = (PoinMB) MBUtil.getManageBean("#{poinMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");

		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{poinMB.seasql}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="到货通知:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{poinMB.socoid}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商:">
						</h:outputText>
						<h:inputText id="usna" styleClass="inputtextedit" size="15"
							value="#{poinMB.suna}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT c.biid,b.suna from nofm c 
											LEFT join suin b ON c.suid = b.suid 
										where c.flag2='01' or c.flag2='02' #{poinMB.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[biid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 到货通知,name = biid,width = 210,headtype = sort,align = left,type = text,datatype=string);
									gcid = suna(headtext = 供应商,name = suna,width = 210,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{poinMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>