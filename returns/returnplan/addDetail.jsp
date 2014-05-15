<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='returnplan.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{returnPlanMB.addDetails}"
							reRender="renderArea,output" rendered="#{returnPlanMB.MOD && returnPlanMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" 
							onclick="search();" oncomplete="endSearch();"
							id="sid" value="查询" type="button" action="#{returnPlanMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>					
						<h:outputText value="出库单号:"/>
						<h:inputText id="outBiid" size="20" styleClass="inputtext"
							value="#{returnPlanMB.outBiid}" />
						<h:outputText value="商品编码:"/>
						<h:inputText id="outInco" styleClass="inputtextedit" size="15"
							value="#{returnPlanMB.outInco}"/>
						<h:outputText value="商品条码:"/>
						<h:inputText id="outBaco" styleClass="inputtextedit" size="15"
							value="#{returnPlanMB.outBaco}"/>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT top 50 a.id,a.biid,b.inco,sum(b.qty) as qty,c.inna, c.colo,c.inse
											  FROM olma a JOIN olde b ON a.biid = b.biid JOIN inve c ON b.inco = c.inco
											  WHERE 1=1 #{returnPlanMB.sql}  group by a.id,a.biid,b.inco,c.inna,c.colo,c.inse  order by a.id"
								gwidth="550" gpage="(pagesize = 50)" gdebug="true" gsort="inco" gsortmethod="asc"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 出库单号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat=0);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returnPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{returnPlanMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>