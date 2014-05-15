<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.ShelvMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>待上架明细</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="待处理条码信息">
		<script type="text/javascript">
			function clearSearchKey(){
		   		$("list:biid").value = "";
		   		$("list:whid").value = "";
		   		$("list:inco").value = "";
		   		$("list:inna").value = "";
		   		$("list:sk_ch_flag").value = "";
		   	}
		</script>
	</head>
	<%
		ShelvMB ai = (ShelvMB) MBUtil.getManageBean("#{shelvMB}");
		if (request.getParameter("isAll") != null) {
			//ai.initSK();
		}
	%>

	<body id="mmain_body" onload="clearSearchKey();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>待处理条码信息</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id="mmain_opt">
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{shelvMB.search}" type="button" reRender="output"
							requestDelay="50" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id="mmain_cnd">
						<div>
							单据号:
							<h:inputText id="biid" styleClass="inputtext" size="12"
								value="#{shelvMB.waitBiid}" />
							货位:
							<h:inputText id="whid" styleClass="inputtext" size="12"
								value="#{shelvMB.waitWhid}" />
							物料编码:
							<h:inputText id="inco" styleClass="inputtext" size="12"
								value="#{shelvMB.sk_inco}" />
							物料名称:
							<h:inputText id="inna" styleClass="inputtext" size="12"
								value="#{shelvMB.sk_inna}" />
							条码状态：
							<h:selectOneMenu id="sk_ch_flag" value="#{shelvMB.sk_flag}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="待质检" itemValue="0" />
								<f:selectItem itemLabel="带入库" itemValue="2" />
								<f:selectItem itemLabel="待拒收" itemValue="3" />
								<f:selectItem itemLabel="待入库报废区" itemValue="4" />
							</h:selectOneMenu>
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid"
							gselectsql="
								SELECT a.id,a.inco,a.whid,a.biid,a.qty,a.baco,a.soco,b.inna,b.colo,b.inse,a.stat,c.whna  
								FROM pbin a left join inve b on a.inco=b.inco 
								LEFT JOIN waho c ON a.waid=c.whid #{shelvMB.searchSQL } and c.#{shelvMB.gorgaSql }"
							gpage="(pagesize = 20)"
							gcolumn="
									gcid = id(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = whna(headtext = 仓库,name = whna,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = biid(headtext = 来源单号,name = biid,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = soco(headtext = 检验单号,name = soco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = stat(headtext = 条码状态,name = chfl,width = 80,align = left,type = mask,typevalue=0:待质检/2:待入库/3:待拒收/4:待入库报废区);
									gcid = baco(headtext = 条码,name = baco,width = 160,align = left,type = text,headtype = sort,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = whid(headtext = 库位,name = whid,width = 150,align = left,type = text,typevalue=sort,headtype = sort,datatype = string);
									gcid = qty(headtext = 数量,name = qty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
						" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
