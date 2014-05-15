<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.PubmMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>采购订单商品明细列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购订单">
		<meta http-equiv="description" content="采购订单">
		<script type="text/javascript" src="po.js"></script>
	</head>
	<%
	    PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
	    if (request.getParameter("isAll") != null) {
	        ai.initSK();
	    }
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;订单&gt;&gt;</font><b>采购订单商品明细</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{pubmMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{pubmMB.DEL}" reRender="output,renderArea"
							action="#{pubmMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{pubmMB.search}" requestDelay="50"
							oncomplete="endSearch()" rendered="#{pubmMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{pubmMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button"
							reRender="output,msg" />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a name="podetail" class="default_a" id="podetail"
							href="javascript:goToDetail(0)"><font size="3">返回</font>
						</a>
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{pubmMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{pubmMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="采购订单号:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{pubmMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
						<h:outputText value="来源单号:">
						</h:outputText>
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{pubmMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
						<h:outputText value="制单号:">
						</h:outputText>
						<h:inputText id="sk_outo" styleClass="datetime" size="15"
							value="#{pubmMB.sk_obj.outo}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="sk_inna" styleClass="datetime" size="15"
							value="#{pubmMB.sk_inna}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="sk_suna" styleClass="datetime" size="15"
							value="#{pubmMB.sk_obj.suna}" onkeypress="formsubmit(event);" />
						<h:outputText value="单据状态:">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{pubmMB.sk_obj.flag}"
							onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{pubmMB.flags}" />
						</h:selectOneMenu>
						组织架构:
						<h:selectOneMenu id="orid" value="#{pubmMB.orid}"
							onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" 
							gselectsql="SELECT a.buty,a.biid,b.inco,c.inna,c.colo,c.inse,b.qty,b.rqty,b.qty-b.rqty AS paqty,indt,psdt,
								cast(cast((b.psqt/b.qty)*100 as decimal(15,2)) as varchar)+'%' AS psrt,b.psqt 
								,b.bpqt,cast(cast((b.bpqt/b.psqt)*100 as decimal(15,2)) as varchar)+'%' AS bd
								,cast(cast(((b.psqt-b.bpqt)/b.psqt)*100 as decimal(15,2)) as varchar)+'%' AS fbd
								FROM pubm a 
								JOIN pubd b ON a.biid=b.biid LEFT JOIN inve c ON b.inco=c.inco
								WHERE a.flag>'11' AND b.rqty<b.cqty AND psqt>0 AND a.#{pubmMB.gorgaSql} #{pubmMB.searchSQL}
							"
							gpage="(pagesize = 20)"
							gversion="2" gdebug="true"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = buty(headtext = 采购类型,name = buty,width = 60,align = center,type = mask,headtype = sort,datatype = string,typevalue=01:ODM/02:FOB/03:代卖/04:外调/05:整件外发);
								gcid = biid(headtext = 采购订单,name = biid,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = qty(headtext = 订单数量,name = qty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = rqty(headtext = 已入库数量,name = rqty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = paqty(headtext = 在途数量,name = paqty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = indt(headtext = 预计到货日期,name = indt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
								gcid = psdt(headtext = 预售发货日期,name = psdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = psqt(headtext =  预售发货数量,name = psqt,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
								gcid = psrt(headtext = 预售比例,name = psrt,width = 70,align = right,type = text,headtype = sort ,datatype = string);
								gcid = bpqt(headtext = B店预售数量,name = bpqt,width = 85,align = right,type = text,headtype = sort , datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
								gcid = bd(headtext = B店商城比例,name = bd,width = 100,align = right,type = text,headtype = sort ,datatype = string);
								gcid = fbd(headtext = 非B店商城比例,name = fbd,width = 100,align = right,type = text,headtype = sort ,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pubmMB.msg}" />
							<h:inputHidden id="sellist" value="#{pubmMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>