<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.report.InCollectMB"%>

<%
	InCollectMB ai = (InCollectMB) MBUtil
			.getManageBean("#{inCollectMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>入库采集统计</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="入库采集统计">
		<script type='text/javascript' src='incollect.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>入库采集查询</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{inCollectMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{inCollectMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,inco,usid,usna,start_date,end_date');" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{inCollectMB.exportXls}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{inCollectMB.LST}">
						<div id="mmain_cnd">
							最后采集时间从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{inCollectMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{inCollectMB.sk_end_date}" />
							单号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inCollectMB.biid}" />
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inCollectMB.inco}" />
							用户编码:
							<h:inputText id="usid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inCollectMB.usid}" />
							用户名称:
							<h:inputText id="usna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inCollectMB.usna}" />	
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.biid,a.inco,a.usid,a.usna,a.crdt,a.qty,a.modt 
											FROM t_in_collect a
											WHERE 1=1 #{inCollectMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width =110,headtype = sort,align = left,type = text,datatype=string);
										    gcid = qty(headtext = 数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = biid(headtext = 单号,name = biid,width =120,headtype = sort,align = left,type = text,datatype=string);
										    gcid = usid(headtext = 用户编码,name = usid,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = usna(headtext = 用户名称,name = usna,width =80,headtype = sort,align = left,type = text,datatype=string);
										    gcid = crdt(headtext = 创建时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = modt(headtext = 最后扫描时间,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{inCollectMB.msg}" />
							<h:inputHidden id="gsql" value="#{inCollectMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{inCollectMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{inCollectMB.searchSQL}
						--%>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
