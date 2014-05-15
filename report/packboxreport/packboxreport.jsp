<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.report.PackBoxReportMB"%>

<%
    PackBoxReportMB ai = (PackBoxReportMB) MBUtil
            .getManageBean("#{packBoxReportMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>装箱明细报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="装箱明细报表">
		<script type='text/javascript' src='packboxreport.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>装箱明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{packBoxReportMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{packBoxReportMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,sk_inse,inco,usid,usna,start_date,end_date,boco,isin,inco,fqty,oqty,ismore');" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{packBoxReportMB.exportXls}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{packBoxReportMB.LST}">
						<div id="mmain_cnd">
							装箱时间从:
							<h:inputText id="start_date" styleClass="datetime" size="20"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{packBoxReportMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="20"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{packBoxReportMB.sk_end_date}" />
							是否在库:
							<h:selectOneMenu id="isin" value="#{packBoxReportMB.isin}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							装箱单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.biid}" />
							装箱码:
							<h:inputText id="boco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.boco}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.inco}" />
								<br/>
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.inse}" />
							库位编码:
							<h:inputText id="whid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.whid}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.usna}" />
							是否多明细:
							<h:selectOneMenu id="ismore" value="#{packBoxReportMB.ismore}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							数量从:
							<h:inputText id="fqty" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.fqty}" />
							至:
							<h:inputText id="oqty" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{packBoxReportMB.oqty}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.biid,a.dety,a.chus,a.chna,a.chdt,b.inco,SUM(b.qty) AS qty,c.inna,c.colo,c.inse,a.crdt,a.boco,
											CASE WHEN ISNULL(d.baco,'')='' THEN '' ELSE '在库' END AS isin,d.whid
											FROM pvma a 
											JOIN pvde b ON a.biid=b.biid 
											LEFT JOIN inve c ON b.inco=c.inco
											LEFT JOIN stnu d ON a.boco=d.baco AND d.bxfl='02'
											WHERE a.flag='11' #{packBoxReportMB.searchSQL}
											GROUP BY a.biid,a.dety,a.chus,a.chna,a.chdt,b.inco,c.inna,c.colo,c.inse,a.crdt,a.boco,d.baco,d.whid
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 装箱单号,name = biid,width =120,headtype = sort,align = left,type = text,datatype=string);
											gcid = boco(headtext = 装箱码,name = boco,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = isin(headtext = 是否在库,name = isin,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[isin]=在库:red});
											gcid = inco(headtext = 商品编码,name = inco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width =60,headtype = sort,align = left,type = text,datatype=string);
											gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = dety(headtext = 业务类型,name = dety,width = 80,align = center,type = mask,typevalue=01:质检装箱/02:库内装箱/03:库外装箱,headtype = sort,datatype = string);
										    gcid = whid(headtext = 所在库位,name = whid,width = 80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = chus(headtext = 用户编码,name = chus,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = chna(headtext = 用户名称,name = chna,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = crdt(headtext = 创建时间,name = crdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = chdt(headtext = 装箱时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{packBoxReportMB.msg}" />
							<h:inputHidden id="gsql" value="#{packBoxReportMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{packBoxReportMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{packBoxReportMB.searchSQL}
						--%>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
