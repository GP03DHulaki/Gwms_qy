<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.StockSearchTotalMB"%>

<%
	StockSearchTotalMB ai = (StockSearchTotalMB) MBUtil
            .getManageBean("#{stockSearchTotalMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库存查询汇总报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="库存查询汇总报表">
		<script type='text/javascript' src='summarytotal.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>库存查询汇总报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{stockSearchTotalMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{stockSearchTotalMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','whid1,sk_inco,sk_inse,sk_inna,sk_whid,asco,psco,colo,baru');" />
						</a4j:outputPanel>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{stockSearchTotalMB.exportTotal}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{stockSearchTotalMB.LST}">
						<div id="mmain_cnd">
							仓库/库位编码:
							<h:inputText id="whid1" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockSearchTotalMB.whid1}" />
							<img id="owid_img" style="cursor: hand;"
								src="../../images/find.gif"
								onclick="return selectWaho1('edit:whid1','edit:fwna');" />
							<h:inputHidden id="fwna" value="#{stockSearchTotalMB.whna1}"></h:inputHidden>

							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockSearchTotalMB.inco}" />
							商品名称:
							<h:inputText id="sk_inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockSearchTotalMB.inna}" />
								<br/>
							规格:
							<h:inputText id="colo" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockSearchTotalMB.colo}" />
							规格码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{stockSearchTotalMB.inse}" />
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.inco,v.inna,v.colo,v.inse,sum(a.qty) as qty,sum(a.uqty) as uqty
											FROM stqu a
											left join inve v on a.inco = v.inco
											left join waho w on a.whco = w.whid
											WHERE 1=1 #{stockSearchTotalMB.initCondition} #{stockSearchTotalMB.searchSQL}
											group by a.inco,v.inse,v.colo,v.inna,a.whco,w.whna
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width =100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext = 规格,name = colo,width = 120,headtype = sort,align = left,datatype=string,type = text);
										    gcid = inse(headtext = 规格码,name = inse,width = 75,headtype = sort,align = left,datatype=string,type = text);
										    gcid = qty(headtext = 汇总数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = uqty(headtext = 可用数量,name = uqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{stockSearchTotalMB.msg}" />
							<h:inputHidden id="gsql" value="#{stockSearchTotalMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{stockSearchTotalMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
