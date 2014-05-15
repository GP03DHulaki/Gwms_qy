<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.common.BacoCOM"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>装箱条码</title>
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
	
    function selectThis(parm1){
		if ( window.dialogArguments.document.getElementById("edit:boco") != null){
			window.dialogArguments.document.getElementById("edit:boco").value=parm1;
		}
		window.close();	
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
			ai.setSql(""); 
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
						<h:outputText value="箱码编号:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{bacoCOM.baco}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" 
								gselectsql="select baco,inco from nwba where stat=0 and bxfl='02' and baco not in (select distinct boco from pain)  #{bacoCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[baco]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = baco(headtext = 箱码,name = baco,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编号,name = whid,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>