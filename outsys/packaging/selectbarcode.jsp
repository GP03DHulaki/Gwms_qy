<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.common.BacoCOM"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>物料条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
		<script type="text/javascript" src='packbox.js'></script>
		<script type="text/javascript">
	
    function selectThis(parm1,parm2){
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
		isGwin ? parent.document.getElementById("edit:inco").value = parm1 : callBack.document.getElementById("edit:inco").value=parm1;
		isGwin ? parent.document.getElementById("edit:qty").value = parseInt(parm2) : callBack.document.getElementById("edit:qty").value=parseInt(parm2);
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
		BacoCOM ai = (BacoCOM) MBUtil.getManageBean("#{bacoCOM}");
		if (request.getParameter("time") != null) {
			ai.setSql(" ");
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{bacoCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="物料编号:"></h:outputText>
						<h:inputText id="inco" styleClass="inputtextedit" size="15"
							value="#{bacoCOM.baco}" onkeypress="formsubmit(event);" />
						<h:outputText value="物料条码:"></h:outputText>
						<h:inputText id="baco" styleClass="inputtextedit" size="15"
							value="#{bacoCOM.baco}" onkeypress="formsubmit(event);" />
					</div>
					<div id="mmain_free">
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT DISTINCT inco as baco,inco,qty from pkln where  oubi in (SELECT a.soco FROM gpam a where biid='#{packagingMB.mbean.biid}') #{bacoCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" 
								growclick="selectThis('gcolumn[baco]','gcolumn[qty]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = baco(headtext = 物料条码,name = baco,width = 140,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 物料编号,name = inco,width = 140,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = left,type = text,datatype=number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>