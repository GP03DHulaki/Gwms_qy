<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.CarTransferMB"%>
<%@ page import="com.gwall.pojo.stockout.TruckOrderMBean"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	String main = (String)request.getParameter("main");
	String moid = (String)request.getParameter("moid");
	CarTransferMB ai = (CarTransferMB) MBUtil.getManageBean("#{carTransferMB}");
//	((TruckOrderMBean)ai.getMbean()).setMaintable(main);
//	((TruckOrderMBean)ai.getMbean()).setFormmoid(moid);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>物流商</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content=物流商>
		<meta http-equiv="description" content="物流商">
		<script type="text/javascript" src="truckorder.js"></script>
	</head>

	<script type="text/javascript">
		function selectThis(param1,param2){
	    	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
			if(isGwin == false){
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
			if(callBack && callBack.document.getElementById('list:lpco')){
				callBack.document.getElementById('list:lpco').value=param1;
			}
			if(callBack && callBack.document.getElementById('list:lpna')){
				callBack.document.getElementById('list:lpna').value=param2;
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
							action="#{carTransferMB.searchLpco}"/>
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="物流商编码:"></h:outputText>
						<h:inputText id="searchpicktaskkey" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{carTransferMB.mbean.lpco}" />
					</div>
				 <a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql="
								select lpco,lpna from lpin
							"
							gwidth="550" gpage="(pagesize = 50)"
							growclick="selectThis('gcolumn[lpco]','gcolumn[lpna]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = lpco(headtext = 物流商编号,name=lpco,width = 400,headtype = text,align = left,type = text,datatype=string);
							gcid = lpna(headtext = 物流商名称,name=lpna,width = 90,headtype = sort,align = center,type = mask,datatype=string,typevalue=OUTORDER:销售订单/TRANPLAN:调拨计划/pickdown:拣货下架);
							" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view> 
	</body>
</html>