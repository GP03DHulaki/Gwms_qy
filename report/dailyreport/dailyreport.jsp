<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.DailyReportMB"%>

<%
	DailyReportMB ai = (DailyReportMB) MBUtil
			.getManageBean("#{dailyReportMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>收发存明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="收发存明细报表">
		<script type='text/javascript' src='dailyreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>收发存明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{dailyReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="if(!startDo()){return false;};"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{dailyReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','inna,tyna,inco,sk_inse,sk_chdt_start,sk_chdt_end,fwid,whna,colo');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{dailyReportMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{dailyReportMB.LST}">
						<div id="mmain_cnd">
							日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{dailyReportMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至当前">
							</h:outputText>
							库位编码:
							<h:inputText id="fwid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.fwid}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif"
								onclick="return selectWaho('edit:fwid','edit:whna1');" />
							<h:inputHidden id='whna1' value="#{dailyReportMB.fwna}"></h:inputHidden>
							库位名称:
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.whna}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.inco}" />
							<br>
							商品名称:
							<h:inputText id="inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.inna}" />
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.colo}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{dailyReportMB.inse}" />
							商品类别:
							<h:inputText id="tyna" value="#{dailyReportMB.tyna}"
								styleClass="inputtextedit" />
							<img id="tyna_img" style="cursor: hand"
								src="../../images/find.gif" onclick="selectSK_Inty();" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gsort="tyna" gsortmethod="desc"
										gselectsql="
								select p.tyna,a.baco,v.inna,v.colo,v.inse,v.inun,
					                   isnull(a.uqty,0) -(ISNULL([PURCHASRETURN],0)+ISNULL([otherout],0)+
										 ISNULL([STOCKOUT],0)+ISNULL([TRANOUT],0)+ISNULL(CASE WHEN [stockplan]<0 THEN [stockplan] else 0 END,0))-
										 (ISNULL([moin],0)+ISNULL([otherin],0)+ISNULL([poin],0)+ISNULL([TRANIN],0)+ISNULL([SALERETURN],0)+
										  ISNULL(CASE WHEN [stockplan]>0 THEN [stockplan] else 0 end,0)) AS jqty,
								         ISNULL([moin],0) as G_0,
                                         ISNULL([otherin],0) as G_1,  ISNULL([TRANIN],0) AS G_7,ISNULL([poin],0) AS G_3, ISNULL([SALERETURN],0) G_5, 
                                         ISNULL(CASE WHEN [stockplan]>0 THEN [stockplan] ELSE 0 end,0) AS G_9,
                                         ISNULL([moin],0)+ISNULL([otherin],0)+ISNULL([poin],0)+ISNULL([TRANIN],0)+ISNULL([SALERETURN],0)+ ISNULL(CASE WHEN [stockplan]>0 THEN [stockplan] end,0) AS rqty, 
										 ISNULL(-[otherout],0) as G_2,
									     ISNULL(-[TRANOUT],0) AS G_8,
									     ISNULL(-[STOCKOUT],0) AS G_6,
									     ISNULL(-[PURCHASRETURN],0) AS G_4,
									     ISNULL(CASE WHEN [stockplan]<0 THEN -[stockplan] else 0 END,0) AS G_10,
									     
									    ISNULL(-[PURCHASRETURN],0)+ISNULL(-[otherout],0)+ISNULL(-[STOCKOUT],0)+ISNULL(-[TRANOUT],0+ISNULL(CASE WHEN [stockplan]<0 THEN -[stockplan] END,0)) AS oqty,
									     isnull(a.uqty,0) as uqty,
									    isnull(a.uuqty,0) as uuqty 

										from (
										 select q.buty,q.qty,isnull(q.baco,s.baco) AS baco,s.uqty,s.uuqty from 
										   (select o.buty,o.baco,o.qty from stlo o  
											 WHERE 1= 1 #{dailyReportMB.initCondition}#{dailyReportMB.searchSQL} ) q  
										full JOIN (SELECT baco ,sum(qty) AS uqty,sum(uqty) as uuqty FROM stnu  WHERE 1= 1 #{dailyReportMB.extraCondition}  GROUP BY baco) s ON s.baco = q.baco		 
										) as t pivot
										(
										    sum(t.qty)
										    for t.buty in ([moin],[otherin],[otherout],[poin],[PURCHASRETURN],[SALERETURN],[STOCKOUT],[TRANIN],[TRANOUT],[stockplan])
										)as a
										left join inve v on v.inco = a.baco
										left join prty p on p.inty = v.inty
										WHERE 1= 1 #{dailyReportMB.initCondition}#{dailyReportMB.thirdCondition}#{dailyReportMB.fourthCondition}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = tyna(headtext = 商品类别,name = tyna,width = 50,headtype = sort,align = left,datatype=string,type = text);
										    gcid = baco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inna(headtext = 商品名称,name = inna,width = 130,headtype = sort,align = left,datatype=string,type = text);
										    gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inun(headtext = 单位,name = inun,width = 30,headtype = sort,align = center,datatype=string,type = text);
										    gcid = jqty(headtext = 期初结存,name = jqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#FFFFFF});
										    gcid = G_0(headtext = 生产入库,name = mqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
										    gcid = G_1(headtext = 其他入库,name = G_1,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
											gcid = G_7(headtext = 调拨入库,name = G_7,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
											gcid = G_3(headtext = 采购入库,name = G_3,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
											gcid = G_5(headtext = 销售退货,name = G_5,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
											gcid = G_9(headtext = 盘盈入库,name = G_9,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
											gcid = rqty(headtext = 入库小计,name = rqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#B4CDCD});
										   gcid = -1(headtext = ,name = fs,width = 1,headtype = sort,align = left,datatype=string,type = text,value= ,bgcolor={#D4CCCC}); 
											gcid = G_2(headtext = 其他出库,name = G_2,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = G_8(headtext = 调拨出库,name = G_8,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = G_6(headtext = 销售出库,name = G_6,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = G_4(headtext = 采购退货出库,name = G_4,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = G_10(headtext = 盘亏出库,name = G_10,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = oqty(headtext = 出库小计,name = oqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
											gcid = uqty(headtext = 期末结存,name = uqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#FFFFFF});
											gcid = uuqty(headtext = 可用库存,name = uuqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#FF0000});
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{dailyReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{dailyReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{dailyReportMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{dailyReportMB.searchSQL}
						--%>

					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
