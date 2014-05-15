<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@	page import="com.gwall.view.OwinBainSearchMB"%>

<%
	OwinBainSearchMB ai = (OwinBainSearchMB) MBUtil
			.getManageBean("#{owinBainSearchMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>货主库存查询</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="库存查询">
		<script type='text/javascript' src='stockSearch.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>库存查询</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{owinBainSearchMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{owinBainSearchMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','sk_warehouseID,sk_inco,sk_inna,sk_whid,asco,psco,colo,sk_inse,sk_boco,sk_whna,sk_colo,sk_whidType');" />
							<gw:GAjaxButton id="otpDBut" value="空库位查询" theme="b_theme"
								onclick="showNullWhid()" type="button" reRender="output" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{owinBainSearchMB.exportProcedureProduct}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{owinBainSearchMB.LST}">
						<div id="mmain_cnd">
							仓库编码:
							<h:inputText id="sk_warehouseID" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{owinBainSearchMB.whid1}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif"
								onclick="return selectWaho1('edit:sk_warehouseID','edit:fwna');" />
							<h:inputHidden id="fwna" value="#{owinBainSearchMB.whna1}"></h:inputHidden>
							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.inco}" />
							商品名称:
							<h:inputText id="sk_inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.inna}" />
							库位编码:
							<h:inputText id="sk_whid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.whid}" />
							库位名:
							<h:inputText id="sk_whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.whna}" />	
							规格:
							<h:inputText id="sk_colo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.colo}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.inse}" />
							库位类型:
							<h:selectOneMenu id="sk_whidType" value="#{owinBainSearchMB.whidType}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{owinBainSearchMB.typeItem}" />
							</h:selectOneMenu>
							箱条码:
							<h:inputText id="sk_boco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.boco}" />
							货主:
							<h:inputText id="owid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{owinBainSearchMB.owid}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.inco,v.asco,v.psco,v.inna,v.colo,
											v.inse,v.baru,v.inpr,a.qty,a.uqty,a.lqty,a.aqty,a.oqty,a.whid,b.whna,a.owid
											FROM stqu_owin a LEFT JOIN waho b ON a.whid=b.whid
											left join inve v on a.inco = v.inco
											WHERE 1=1 #{owinBainSearchMB.initCondition} and b.#{owinBainSearchMB.gorgaSql} #{owinBainSearchMB.searchSQL}
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width =110,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = owid(headtext = 货主,name = owid,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inse(headtext = 规格码,name = inse,width = 75,headtype = sort,align = left,datatype=string,type = text);
										    gcid = qty(headtext = 账面数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
											gcid = uqty(headtext = 可用数量,name = uqty,width = 60,headtype = sort,align = right,datatype=number,dataformat={0},summary=this,type = link,linktype = script,typevalue = javascript:ShowIncoDetail('gcolumn[inco]','gcolumn[whid]'));
											gcid = aqty(headtext = 实际数量,name = aqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
										    gcid = whid(headtext = 库位编码,name = whid,width = 100,align = left,type = text,headtype = sort,datatype = string);		
											gcid = whna(headtext = 库位名称,name = whna,width = 90,align = left,type = text,headtype = sort,datatype = string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{owinBainSearchMB.msg}" />
							<h:inputHidden id="gsql" value="#{owinBainSearchMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{owinBainSearchMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
						<%-- 
						Select  INVE.inco , INVE.inna , INVE.colo ,INVE.inst , a.whid ,a.whna as awhna ,STNU.aqty ,STNU.qty,
                        STNU.uqty ,STNU.lqty, GRAND.pwid ,b.whna as bwhna from INVE,WAHO as a,STNU,f_stockSearch_selectGrandpa() as GRAND,WAHO as b
                        where INVE.inco=STNU.baco and a.whid=STNU.whid and CONVERT(VARCHAR(50),GRAND.whid)=a.whid 
                        and CONVERT(VARCHAR(50),GRAND.pwid)=b.whid  #{owinBainSearchMB.searchSQL}
						--%>

					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
