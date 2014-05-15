<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@ page import="com.gwall.view.ChangeOwidMB"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>库位信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='changeowid.js'></script>
		<script>
			var retid="",retname="";		//返回刷新的字段，如无，则不刷新
		    function callback(parm1){
		    	alert(parm1);
				retid = $("edit:retid").value;
				alert(retid);
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				alert("isGwin="+isGwin);
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
			 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
				}
				isGwin ? Gwin.close(document.GwinID) : window.close();
			}
		</script>
	</head>
	<%
		ChangeOwidMB ai = (ChangeOwidMB) MBUtil.getManageBean("#{changeOwidMB}");
		if (request.getParameter("owid") != null) {
			ai.setFrow(request.getParameter("owid"));
		}
	%>
	<body id=mmain_body onload="clearMaterials1();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{changeOwidMB.searchinco}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="clearMaterials1();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="materials" styleClass="inputtextedit" size="15"
							value="#{changeOwidMB.materials}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="whid" gsortmethod="ASC"
								gselectsql="select id,inco,qty,whid from bain_owin where 1=1 #{changeOwidMB.searchSQL} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="callback('gcolumn[inco]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品条码,name = inco,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = whid(headtext = 库位编码,name = whid,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 可用数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype =number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{changeOwidMB.retid}" />
						<h:inputHidden id="retname" value="" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>