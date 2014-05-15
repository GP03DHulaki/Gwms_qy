<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.ReviewLibraryMB"%>
<%@ page import="com.gwall.pojo.stockout.ReviewLibraryMBean"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	String main = (String)request.getParameter("main");
	String moid = (String)request.getParameter("moid");
	ReviewLibraryMB ai = (ReviewLibraryMB) MBUtil.getManageBean("#{reviewLibraryMB}");
	((ReviewLibraryMBean)ai.getMbean()).setMaintable(main);
	((ReviewLibraryMBean)ai.getMbean()).setFormmoid(moid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content=出库计划>
		<meta http-equiv="description" content="出库计划">
		<script type="text/javascript" src="oqc.js"></script>
	</head>

	<script type="text/javascript">
		function selectThis(param1){
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
				callBack = parent;
			}
			if(callBack && callBack.document.getElementById('edit:soco')){
				callBack.document.getElementById('edit:soco').value=param1;
			}
			isGwin ? Gwin.close(document.GwinID) : window.close();	
	    }
		
	</script>
	<body>
		<f:view>
			<div id="mmain">
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" reRender="output" 
							requestDelay="50" 
							action="#{reviewLibraryMB.searchSoco}"/>
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="来源单号:"></h:outputText>
						<h:inputText id="searchpicktaskkey" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{reviewLibraryMB.frombiid}" />
					</div>
					<%-- 
					<a4j:outputPanel id="output2">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql=" SELECT biid,crdt FROM slst where flag='11' "
							gwidth="550" gpage="(pagesize = 20)"
							growclick="selectThis('gcolumn[biid]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 复核来源单号,name = biid,width = 200,headtype = text,align = left,type = text,datatype=string);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 200,headtype = sort,align = left,type = text,datatype=string,dataformat=yyyy-MM-dd HH:mm);
							" />
					</a4j:outputPanel>
					gselectsql=" SELECT DISTINCT biid,buty FROM slst where flag='1' #{reviewLibraryMB.searchSQL}"
					SELECT DISTINCT biid,buty FROM obma a where (flag='17' OR flag='16' AND dety='1') AND stat<>'20' #{reviewLibraryMB.searchSQL}
				 --%>
				 
				 <a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql="
								select biid,buty from (
									SELECT DISTINCT biid,buty FROM slst where (buty='OUTORDER' OR buty='TRANPLAN') AND flag='1' 
									UNION ALL 
									SELECT DISTINCT soco as biid,soty as buty FROM slst WHERE soty='pickdown' AND flag='1' 
								)a where 1=1 #{reviewLibraryMB.socoSql}
							"
							gwidth="550" gpage="(pagesize = 50)"
							growclick="selectThis('gcolumn[biid]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 复核来源单号,name = biid,width = 400,headtype = text,align = left,type = text,datatype=string);
							gcid = buty(headtext = 来源类型,name=buty,width = 90,headtype = sort,align = center,type = mask,datatype=string,typevalue=OUTORDER:销售订单/TRANPLAN:调拨计划/pickdown:拣货下架);
							" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view> 
	</body>
</html>