<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PurchaseArriveMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>采购到货</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购到货">
		<meta http-equiv="description" content="采购到货">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwalldate.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="arrive.js"></script>

	</head>
	<%
	    PurchaseArriveMB ai = (PurchaseArriveMB) MBUtil
	            .getManageBean("#{purchaseArrvicMB}");
	    if (null != request.getParameter("isAll")) {
	        ai.initSK();
	    }
	%>

	<body id="mmain_body">
		<f:view>
			<div id="mmain_nav">
				<font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>采购到货</b>
				<br>
			</div>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="addNew();return true" rendered="#{purchaseArrvicMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							rendered="#{purchaseArrvicMB.DEL}" reRender="output,renderArea"
							action="#{purchaseArrvicMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							onclick="startDo()" oncomplete="endLoad()"
							action="#{purchaseArrvicMB.search}" requestDelay="50"
							rendered="#{purchaseArrvicMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearData();" rendered="#{purchaseArrvicMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							rendered="#{purchaseArrvicMB.EXP}"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id="mmain_cnd">
						<h:outputText value="制单日期从:"></h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_start_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_end_date}"
							onfocus="#{gmanage.datePicker}" />
						<h:outputText value="到货单号:" />
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_obj.biid}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="来源单号:" />
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_obj.soco}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="质检单号:" />
						<h:inputText id="sk_esoco" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_esoco}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="采购订单:" />
						<h:inputText id="sk_pobiid" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_pobiid}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:" />
						<h:inputText id="sk_inco" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_inco}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:" />
						<h:inputText id="sk_suna" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_obj.ceve}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:"></h:outputText>
						<h:inputText id="sk_inna" styleClass="datetime" size="15"
							value="#{purchaseArrvicMB.sk_inna}"
							onkeypress="formsubmit(event);" />
						<h:outputText value="状态:" />
						<h:selectOneMenu id="sk_flag"
							value="#{purchaseArrvicMB.sk_obj.flag}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{purchaseArrvicMB.flags}" />
						</h:selectOneMenu>
						<!--  
						<h:outputText value="类型:" />
						<h:selectOneMenu id="sk_dety"
							value="#{purchaseArrvicMB.sk_obj.dety}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{purchaseArrvicMB.detys}" />
						</h:selectOneMenu>
						-->
						<h:outputText value="质检状态:" />
						<h:selectOneMenu id="sk_check_state"
							value="#{purchaseArrvicMB.sk_check_state}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="未质检" itemValue="11" />
							<f:selectItem itemLabel="部分质检" itemValue="55" />
							<f:selectItem itemLabel="质检完成" itemValue="99" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT a.id,a.biid,a.buty,a.dety,a.flag,b.owid,
										a.crus,a.soty,a.soco,c.suna,a.crna,a.crdt,a.chus,a.chna,a.chdt,a.opna,a.stdt,a.rema,a.refl,stna,b.whna ,
										(select sum(aa.qty) from rgde aa where aa.biid=a.biid) as dqty
										FROM rgma a 
										LEFT JOIN waho b ON a.whid=b.whid 
										left join suin c on a.suid=c.suid
										LEFT JOIN ckma d ON a.biid=d.rgso
										left join pubm e on a.soco=e.biid
										where a.#{purchaseArrvicMB.gorgaSql} #{purchaseArrvicMB.searchSQL}"
							gpage="(pagesize = 25)" gversion="2" gdebug="true"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 单据编号 ,name = biids,width = 100,headtype = hidden , align = left ,datatype = string);
								gcid = biid(headtext = 采购到货单 ,name = biid,width = 120,headtype = sort , align = left ,type = link,linktype=script,typevalue=arrive_edit.jsf?pid=gcolumn[biid],datatype = string);
								gcid = soco(headtext = 来源单号 ,name = soco,width = 120,headtype = sort , align = left ,type=sort ,datatype = string);
								gcid = suna(headtext = 供应商名称,name = suna,width = 180,align = left,type = text,headtype = sort,datatype = string);
								gcid = owid(headtext = 货主,name = owid,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:已审核/12:拒收中/21:已拒收/22:拒收完成/31:已添加完入库单据,headtype = sort,datatype = string);						
								gcid = dqty(headtext = 到货数量,name = dqty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
								gcid = chna(headtext = 审核人,name = chna,width = 90,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 180,align = left,type = text,headtype = sort,datatype = string);" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseArrvicMB.msg}" />
							<h:inputHidden id="sellist" value="#{purchaseArrvicMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
<%-- 
<a4j:outputPanel id="output">
	<g:GTable gid="gtable" gtype="grid"
		gselectsql="SELECT distinct isnull(e.biid,'') as ebiid,a.id,a.biid,a.buty,a.dety,a.flag,
					a.crus,a.soty,a.soco,c.suna,a.crna,a.crdt,a.chus,a.chna,a.chdt,a.opna,a.stdt,a.rema,a.refl,stna,b.whna FROM
					rgma a 
					LEFT JOIN waho b ON a.whid=b.whid 
					left join suin c on a.suid=c.suid
					left join rgde d on d.biid=a.biid
					left join ckma e on d.soco=e.soco
					where a.#{purchaseArrvicMB.gorgaSql} #{purchaseArrvicMB.searchSQL}"
		gpage="(pagesize = 20)" gversion="2" gdebug="false"
		gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
			gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
			gcid=biid(headtext = 单据编号 ,name = biids,width = 100,headtype = hidden , align = left ,datatype = string);
			gcid=biid(headtext = 采购到货单 ,name = biid,width = 120,headtype = sort , align = left ,type = link,linktype=script,typevalue=arrive_edit.jsf?pid=gcolumn[biid],datatype = string);
			gcid=soco(headtext = 来源单号 ,name = soco,width = 120,headtype = sort , align = left ,type=sort ,datatype = string);
			gcid = ebiid(headtext = 质检单号,name = ebiid,width = 100,align = left,type = text,headtype = sort,datatype = string);
			gcid = suna(headtext = 供应商名称,name = suna,width = 180,align = left,type = text,headtype = sort,datatype = string);
			gcid = whna(headtext = 存放仓库,name = whna,width = 100,align = left,type = text,headtype = hidden,datatype = string);
			gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:已审核/12:拒收中/21:已拒收/22:拒收完成/31:已添加完入库单据,headtype = sort,datatype = string);						
			gcid = crna(headtext = 制单人,name = crna,width = 90,align = left,type = text,headtype = sort,datatype = string);
			gcid = crdt(headtext = 制单时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
			gcid = chna(headtext = 审核人,name = chna,width = 90,align = left,type = text,headtype = sort,datatype = string);
			gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
			gcid = rema(headtext = 备注,name = rema,width = 180,align = left,type = text,headtype = sort,datatype = string);
		" />
</a4j:outputPanel>
--%>