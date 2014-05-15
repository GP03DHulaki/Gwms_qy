<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>待分拣明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="待分拣明细">
		<meta http-equiv="description" content="待分拣明细">
		<script type="text/javascript" src="secsort.js"></script>
	</head>
	<body>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton id="addDBut" value="快速分配"
								onclick="if(!quick()){return false};"
								action="#{secsortMB.quick}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,output,tableid,show"
								rendered="#{secsortMB.MOD && secsortMB.commitStatus}"
								requestDelay="50" oncomplete="endQuick();" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="show">
						<g:GTable gid="gtable1" gtype="grid" gdebug="false"
							gselectsql="SELECT a.inco,(a.qty-ISNULL(e.qty,0)) AS qty,b.inna,b.inty,d.tyna,b.inst,b.volu,b.newe,b.inpr,b.colo
									FROM (select inco,sum(qty) AS qty from pkde Where biid = '#{secsortMB.mbean.soco}' GROUP BY inco) a 
									LEFT JOIN inve b on a.inco = b.inco left join prty d on b.inty = d.inty 
									LEFT JOIN (SELECT inco,SUM(qty) AS qty FROM spde WHERE biid IN (SELECT biid FROM spma WHERE soco = '#{secsortMB.mbean.soco}') 
									GROUP BY inco ) e ON a.inco = e.inco WHERE a.qty > ISNULL(e.qty,0)"
							gpage="(pagesize = -1)" gversion="2"
							gcolumn="
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = inco(headtext = 物料编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 物料名称,name = inna,width = 240,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 花色,name = colo,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inst(headtext = 规格,name = inst,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = tyna(headtext = 物料品类,name = tyna,width = 90,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inpr(headtext = 属性,name = inpr,width = 90,align = left,type = mask,typevalue=P:成品/S:半成品,headtype = sort ,datatype = string);
								gcid = volu(headtext = 体积,name = volu,width = 90,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
								gcid = newe(headtext = 重量,name = newe,width = 90,align = right,type = hidden,headtype = sort ,datatype = number,dataformat=0.00);
								gcid = qty(headtext = 数量,name = qty,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
					" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{secsortMB.msg}" />
							<h:inputHidden id="sellist" value="#{secsortMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>