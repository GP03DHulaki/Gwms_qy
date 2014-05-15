<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.InSaleSaveSearchMB"%>

<%
	InSaleSaveSearchMB ai = (InSaleSaveSearchMB) MBUtil
			.getManageBean("#{inSaleSaveSearchMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库存变动报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="库存变动报表">
		<script type='text/javascript' src='insalesavesearch.js'></script>
	</head>
	<body id="mmain_body" onload="load();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>库存变动报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs"
							rendered="#{inSaleSaveSearchMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{inSaleSaveSearchMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','buty,biid,soty,soco,inco,boco,sk_inse,sk_chdt_end,sk_chdt_start,fwid,fwna');" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{inSaleSaveSearchMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm"
						rendered="#{inSaleSaveSearchMB.LST}">
						<div id="mmain_cnd">
							变动日期从:
							<h:inputText id="sk_chdt_start" styleClass="datetime" size="10"
								value="#{inSaleSaveSearchMB.sk_chdt_start}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至" />
							<h:inputText id="sk_chdt_end" styleClass="datetime" size="10"
								value="#{inSaleSaveSearchMB.sk_chdt_end}"
								onfocus="#{gmanage.datePicker}" />
							单据类型:
							<h:inputText id="buty" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.buty}" />
							单据编号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.biid}" />
							来源类型:
							<h:inputText id="soty" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.soty}" />
							
							来源单号:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.soco}" />
								<br>
							商品编码:
							<h:inputText id="inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.inco}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inSaleSaveSearchMB.inse}" />
							箱码:
							<h:inputText id="boco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.boco}" />
							库位编码:
							<h:inputText id="fwid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{inSaleSaveSearchMB.fwid}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif" onclick="return selectWaho();" />
							<h:inputHidden id='fwna' value="#{inSaleSaveSearchMB.fwna}"></h:inputHidden>
							组织架构:
							<h:selectOneMenu id="orid" value="#{inSaleSaveSearchMB.orid}"
								onchange="doSearch();">
								<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
							<%--  变动仓库:
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{inSaleSaveSearchMB.whna}" />
							--%>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.id,a.buty,m.mona,v.inna,v.inse,v.colo,a.crdt,
											case when a.qty>0 then isnull(a.qty,0)  END AS rqty  ,
											CASE WHEN a.qty<0 THEN ISNULL(a.qty,0) END AS oqty ,
											isnull(a.fwid,a.owid) as whid,w.whna,
											m1.mona as mona1,a.dety,a.biid,a.soty,a.soco,a.inco,a.boco
											FROM stlo a 
											left join modu m on m.moid = a.buty 
											left join modu m1 on m1.moid = a.soty
											left join waho w on isnull(a.fwid,a.owid) = w.whid
											left join inve v on v.inco = a.inco
											where 1=1 #{inSaleSaveSearchMB.initCondition} #{inSaleSaveSearchMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inna(headtext = 商品名称,name = inna,width = 100,headtype = sort,align = left,datatype=string,type = text);
										    gcid = colo(headtext = 规格,name = colo,width = 80,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,datatype=string,type = text);
											gcid = mona(headtext = 单据类型,name = mona,width = 51,headtype = sort,align = left,type = mask,typevalue=盘点计划:盘盈盘亏,datatype=string);
											gcid = biid(headtext = 单据编号,name = biid,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = dety(headtext = 子业务类型,name = dety,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=202:盘亏出库/205:委外出库/207:销售赠品出库/209:借出出库/210:管理赠品出库/212:调拔出库/213:材料销售出库/214:短码出库/215:报废出库/216:返工出库/222:花色转换/104:盘盈入库/105:委外入库/106:还回入库/108:调拔入库/110:赠品入库/113:花色转换/000:不回写入库);
											gcid = rqty(headtext = 入库数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = oqty(headtext = 出库数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
											gcid = whna(headtext = 库位名称,name = owid,width = 120,headtype = sort,align = left,datatype=string,type = text);
											gcid = whid(headtext = 库位编码,name = owid,width = 80,headtype = sort,align = left,datatype=string,type = text);
										    gcid = crdt(headtext = 操作时间,name = bidt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										    gcid = boco(headtext = 箱码,name = boco,width = 120,headtype = sort,align = left,datatype=string,type = text);
											gcid = mona1(headtext = 来源类型,name = mona1,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,datatype=string,type = text);
											" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{inSaleSaveSearchMB.msg}" />
							<h:inputHidden id="gsql" value="#{inSaleSaveSearchMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{inSaleSaveSearchMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{inSaleSaveSearchMB.searchSQL}
						--%>

					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
