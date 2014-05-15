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
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					type="button" onmouseout="this.className='a4j_buton1'"
					onclick="if(!createTask(gtable2)){return false};" value="分配任务"
					id="delMBut" reRender="output,renderArea,main,mainBut,msg,output2"
					oncomplete="endDo();" action="#{tranPlanMB.createTask}"
					styleClass="a4j_but1" rendered="#{!tranPlanMB.commitStatus}" />

				<a4j:outputPanel id="output2">
					<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
						gsort="ispt" gsortmethod="ASC"
						gselectsql="
							SELECT a.baco,a.inco,SUM(a.qty) AS qty,a.whid,b.colo,b.inse,b.inna,a.bxfl,a.ispt FROM slst a
							LEFT JOIN inve b ON a.inco=b.inco 
							WHERE a.biid='#{tranPlanMB.mbean.biid}' and a.ispt=0
							GROUP BY a.baco,a.inco,a.whid,b.colo,b.inse,b.inna,a.bxfl,a.ispt
						"
						gcolumn="
							gcid = baco(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
							gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
							gcid = bxfl(headtext = 类型,name = bxfl,width = 50,align = center,type = mask,headtype = sort ,datatype = string,typevalue=02:箱码/04:SKU);
							gcid = baco(headtext = 条码,name = baco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
							gcid = whid(headtext = 库位,name = whid,width = 100,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inco(headtext = 商品编码,name = inco,width = 130,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inna(headtext = 商品名称,name = inna,width = 100,align = left,type = text,headtype = sort ,datatype = string);
							gcid = colo(headtext = 规格,name = colo,width = 65,align = left,type = text,headtype = sort ,datatype = string);
							gcid = inse(headtext = 规格码,name = inse,width = 65,align = left,type = text,headtype = sort ,datatype = string);
							gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
						" />
					<!-- gpage="(pagesize = 20)" -->
				</a4j:outputPanel>
				<a4j:jsFunction name="renderTable" reRender="output2"
					oncomplete="parent.Gwallwin.winShowmask('FALSE');Gwallwin.winShowmask('FALSE');" />
				<a4j:jsFunction name="print2PDF" oncomplete="endPrintReport();"
					requestDelay="50" action="#{tranPlanMB.printBox}"
					reRender="msg,filename">
					<a4j:actionparam name="boid" assignTo="#{tranPlanMB.boid}" />
				</a4j:jsFunction>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="item" value="#{tranPlanMB.sellist}" />
						<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
						<h:inputHidden id="filename" value="#{tranPlanMB.fileName}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>