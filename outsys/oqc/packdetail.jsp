<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>已封箱明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="已封箱明细">
		<script type="text/javascript" src="oqc.js"></script>
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
		<button onmouseover="this.className='a4j_over1'" id="printAllBut"
			onmouseout="this.className='a4j_buton1'" class="a4j_but1"
			onclick="startDo();print2PDF('%');">
			打印全部
		</button>
		<f:view>
			<h:form id="edit">
				<a4j:outputPanel id="output2">
					<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
						gsort="crdt" gsortmethod="DESC"
						gselectsql="
							SELECT a.boid,SUM(qty) AS qty,a.crdt,COUNT(inco) AS inqt FROM sobx a
							WHERE a.biid='#{reviewLibraryMB.mbean.biid}'
							GROUP BY a.boid,a.crdt
						"
						gcolumn="
								gcid = boid(headtext = 箱号,name = boid,width = 100,align = center,type = text,headtype = sort ,datatype = string);
								gcid = crdt(headtext = 封箱时间,name = crdt,width = 160,headtype = sort,align = center,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = inqt(headtext = SKU个数,name = inqt,width = 80,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
								gcid = qty(headtext = 总数量,name = qty,width = 80,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
								gcid = -1(headtext = 查看,value=查看明细,name = detail,width = 90,headtype = text,align = center,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=showPkDetail('gcolumn[boid]','gcolumn[crdt]')});
								gcid = -1(headtext = 操作,value=打印箱码,name = pirint,width = 90,headtype = text,align = center,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=startDo()&print2PDF('gcolumn[boid]')});
								" />
					<!-- gpage="(pagesize = 20)" -->
				</a4j:outputPanel>
				<a4j:jsFunction name="renderTable" reRender="output2" oncomplete="parent.Gwallwin.winShowmask('FALSE');" />
				<a4j:jsFunction name="print2PDF" oncomplete="endPrintReport();" requestDelay="50" 
					action="#{reviewLibraryMB.printBox}" reRender="msg,filename">
					<a4j:actionparam name="boid" assignTo="#{reviewLibraryMB.boid}" />
				</a4j:jsFunction>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="item" value="#{reviewLibraryMB.sellist}" />
						<h:inputHidden id="msg" value="#{reviewLibraryMB.msg}" />
						<h:inputHidden id="filename" value="#{reviewLibraryMB.fileName}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>