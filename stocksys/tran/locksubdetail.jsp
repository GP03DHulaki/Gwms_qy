<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>调拨锁定明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨锁定明细">
		<script type="text/javascript" src="tran.js"></script>
		<style type="text/css">
.gcolstyle {
	cursor: pointer;
	color: #0000FF;
}
</style>
		<script type="text/javascript">
			function init(){
				if(parent.Gskin){
					parent.Gskin.setSkinCss(document);
				}
			}
		</script>
	</head>
	<body id="mmain_body" onload="init();">
		<f:view>
			<h:form id="edit">
				<%-- 
				<div style="color: red">
					<b><h:outputText value="#{tranPlanMB.boxInco}" /></b>
				</div>
				--%>
				<a4j:outputPanel id="locktable">
					<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
						gsort="whid" gsortmethod="ASC"
						gselectsql="
							SELECT a.baco,a.qty,a.whid FROM slst a
							WHERE a.biid='#{tranPlanMB.mbean.biid}' AND (a.inco ='#{tranPlanMB.boxInco}' 
							OR EXISTS(SELECT 1 FROM pain where boco=a.baco and inco= '#{tranPlanMB.boxInco}'))
							AND a.ispt=0;
						"
						gpage="(pagesize = -1)"
						gcolumn="
							gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
							gcid = -1(headtext = 操作,value = 解锁,name = unlock,width = 50,headtype = text,align = center,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=startDo()&unlockBox('gcolumn[baco]')});
							gcid = baco(headtext = 箱条码,name = baco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = whid(headtext = 库位,name = whid,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = qty(headtext = 数量,name = qty,width = 65,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
						" />
				</a4j:outputPanel>
				<a4j:jsFunction name="renderTable" reRender="output2"
					oncomplete="parent.Gwallwin.winShowmask('FALSE');" />
				<a4j:jsFunction name="unlockBox"
					oncomplete="endDo();parent.startDo();parent.renderTable();"
					requestDelay="50"
					action="#{tranPlanMB.unlockBox}"
					reRender="msg,locktable">
					<a4j:actionparam name="boxCode" assignTo="#{tranPlanMB.boxCode}" />
				</a4j:jsFunction>
				<a4j:outputPanel id="renderArea">
					<h:inputHidden id="item" value="#{tranPlanMB.sellist}" />
					<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
					<h:inputHidden id="filename" value="#{tranPlanMB.fileName}" />
				</a4j:outputPanel>
			</h:form>
		</f:view>
	</body>
</html>