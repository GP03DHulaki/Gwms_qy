<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include	file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.CheckMB"%>
<%
	CheckMB ai = (CheckMB) MBUtil.getManageBean("#{checkMB}");
	ai.getVouch();
	//清空查询
	ai.setSearchSQL("");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>选择商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='check.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addCheckDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{checkMB.addCheckDetails}"
							reRender="renderArea,output" oncomplete="endAddCheckDetails();"
							requestDelay="50" />
					</div>
					<div id=mmain_free>
						<!-- 采购到货 -->
						<a4j:outputPanel id="outputArrvic" >
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.biid,a.inco,sum(b.qty) as aqty,sum(b.fqty) as fqty, sum(b.qty-b.fqty) as qty from nofd a
											JOIN ckpk b ON a.biid = b.soco AND a.inco = b.inco 
											WHERE aqty>fqty and a.biid='#{checkMB.mbean.soco}'
											GROUP BY a.biid,a.inco"
								gwidth="550" gpage="(pagesize = -1)" gdebug="true"
								gcolumn="gcid = biid(headtext = selall,name = biid,width = 20,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 到货订单,name = biid,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = aqty(headtext = 到货数量,name = aqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = fqty(headtext = 己检验数量,name = ckqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = qty(headtext = 待检验数量,name = dqty,width = 70,headtype = sort,align = right,type = input,datatype=number,dataformat={0});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{checkMB.msg}" />
							<h:inputHidden id="socos" value="#{checkMB.socos}" />
							<h:inputHidden id="incos" value="#{checkMB.incos}" />
							<h:inputHidden id="qtys" value="#{checkMB.qtys}" />

						</a4j:outputPanel>
					</div>
					<%-- 
						select a.biid,a.inco,a.dqty,ISNULL(b.ckqty,0) AS ckqty from pubd a 
						left join (
						select SUM(qty) AS ckqty,inco from ckde a join ckma b on a.biid=b.biid 
						where b.soco='#{checkMB.mbean.soco}'
						group by inco ) b
						on a.inco=b.inco
						where a.biid='#{checkMB.mbean.soco}' and a.dqty-ISNULL(b.ckqty,0)>0
					--%>
				</h:form>
			</f:view>
		</div>
	</body>
</html>