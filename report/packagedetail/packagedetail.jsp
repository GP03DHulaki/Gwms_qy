<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.PackageDetailMB"%>

<%
	PackageDetailMB ai = (PackageDetailMB) MBUtil
			.getManageBean("#{packageDetailMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>打包明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="打包明细报表">
		<script type='text/javascript' src='packagedetail.js'></script>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>打包明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{packageDetailMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{packageDetailMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme" onclick="cleartext();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{packageDetailMB.LST}">
						<div id="mmain_cnd">
							出库订单:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packageDetailMB.soco}" />
							物流商名称:
							<h:inputText id="lpna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packageDetailMB.lpna}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
										select l.lpna,sum(m.qty) AS qty,a.soco,sum(ISNULL([1],0)) AS G_1,sum(ISNULL([2],0)) AS G_2,sum(ISNULL([3],0)) AS G_3,
										sum(ISNULL([4],0)) AS G_4,sum(ISNULL([5],0)) AS G_5,sum(ISNULL([6],0)) AS G_6,
										sum(ISNULL([7],0)) AS G_7,sum(ISNULL([8],0)) AS G_8,sum(ISNULL([9],0)) AS G_9,
										(SELECT distinct count(DISTINCT stat) FROM pvde WHERE bxid LIKE a.soco+'%') AS total
										 from (
										 	SELECT  k.soco,isnull(k.stat,0) AS stat FROM 
											  (SELECT  b.soco,m.stat FROM pvde m JOIn 
											  pvma b ON m.biid = b.biid AND m.bxid LIKE b.soco+'%' AND m.stat>0 
											  GROUP BY b.soco,m.stat) k 
										
										 ) as t
										 pivot
										(
											count(t.stat)
											for t.stat in ([1],[2],[3],[4],[5],[6],[7],[8],[9])
										)as a
									JOIN
									(SELECT g.soco,sum(h.qty) AS qty FROM pvma g JOIN pvde h ON g.biid = h.biid WHERE h.bxid LIKE g.soco +'%' GROUP BY g.soco) m 	
										ON m.soco = a.soco
									 LEFT JOIN (SELECT biid,lpco FROM obma) b ON b.biid = a.soco
									 LEFT JOIN (select lpco,lpna from lpin) l ON l.lpco = b.lpco
								where 1=1 #{packageDetailMB.initCondition}#{packageDetailMB.searchSQL}
								GROUP BY a.soco,l.lpna
										
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = soco(headtext = 出库订单,name = whid,width = 90,headtype = sort,align = left,type = string,datatype=string);
											gcid = lpna(headtext = 物流商,name = whna,width = 150,headtype = sort,align = left,type = string,datatype=string);
											gcid = G_1(headtext = 大纸箱,name = colo,width = 60,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_2(headtext = 中纸箱,name = colo,width = 60,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_3(headtext = 小纸箱,name = colo,width = 60,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_4(headtext = 大编织袋,name = cuna,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_5(headtext = 中编织袋,name = inco,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_6(headtext = 小编织袋,name = inna,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_7(headtext = 其他大袋,name = colo,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_8(headtext = 其他中袋,name = colo,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = G_9(headtext = 其他小袋,name = colo,width = 70,headtype = sort,align = right,type = string,datatype=number,dataformat={0},summary=this);
											gcid = total(headtext = 总袋数,name = inst,width = 70,headtype = sort,align = right,type = string,datatype=string);
										    gcid = qty(headtext = 打包数量,name = rqty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
