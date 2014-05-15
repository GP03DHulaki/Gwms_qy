<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>到货检验</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="到货检验">
	<meta http-equiv="description" content="到货检验">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gwalldate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="iqc.js"></script>

</head>

<body id="mmain_body" onload="showMesList(1);">
	<f:view>
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>到货检验</b><br></div>
	<div id="mmain">
		<h:form id="edit">
			<div id="mmain_opt">
				<a4j:commandButton value="添加单据"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					onclick="addNew();" rendered="true"/> 
					
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="deleteId" value="删除单据" type="button"
					onclick="if(!doDeleteAll(gtable)){return false};"
					rendered="true" reRender="output,renderArea"
					action=""
					oncomplete="endDoDeleteAll();" requestDelay="50" />
					
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					value="查询" type="button" reRender="output" id="sid"
					oncomplete="Gwallwin.winShowmask('FALSE');"
					action="" requestDelay="50" rendered="true"
					 />
					
				<a4j:commandButton value="重置"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					onclick="clearData();" />
			</div>
			<div id=mmain_cnd>
				<h:outputText value="审核日期从:">
				</h:outputText>
				<h:inputText id="sk_start_date" styleClass="datetime" size="15"
					value="" onfocus="#{gmanage.datePicker}" />
				<h:outputText value="至:">
				</h:outputText>
				<h:inputText id="sk_end_date" styleClass="datetime" size="15"
					value="" onfocus="#{gmanage.datePicker}" />
				<h:outputText value="到货检验单号:">
				</h:outputText>
				<h:inputText id="sk_voucherid" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />	
				<h:outputText value="供应商编码:">
				</h:outputText>
				<h:inputText id="sk_supplierid" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />
				<h:outputText value="供应商名称:">
				</h:outputText>
				<h:inputText id="sk_suppliername" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />
				<br>
				<h:outputText value="商品条码:">
				</h:outputText>
				<h:inputText id="vc_barcode" styleClass="datetime" size="18"
					value="" onkeypress="formsubmit(event);" />
				<h:outputText value="状态:">
				</h:outputText>
				<h:selectOneMenu id="sk_ch_flag" value="" onchange="doSearch();">
					<f:selectItem itemLabel="全部" itemValue="" />
					<f:selectItem itemLabel="检验中" itemValue="01" />
					<f:selectItem itemLabel="已完成" itemValue="03" />		
				</h:selectOneMenu>&nbsp&nbsp&nbsp&nbsp&nbsp
				
				<h:outputText value="订单号:">
				</h:outputText>
				<h:inputText id="sk_frompovoucherid" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />
				
			</div>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid"
					gselectsql="select id_id,'DH20110817001' as a,'采购' as b,'PO20110816001' as c,'GWALL' as d,'DEW' as e,'自采' as f,'2011-08-16' as g,'深圳仓库' as h,'DEW' as i,'确认中' as j,'2011-08-18' as l,mtxt from temp"
					gpage="(pagesize = 20)" gversion="2" gdebug = "false"
					gcolumn="gcid = id_id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
						gcid = -1(headtext = 操作,name = view_h,width = 50,align = center,headtype = hidden,type = link,linktype = script,typevalue = iqc_edit.jsf?pid=gcolumn[2],value = 查看);
						gcid = 2(headtext = 到货检验单号,name = vc_voucherid,width = 120,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = iqc_edit.jsf?pid=gcolumn[2]);
						gcid = 3(headtext = 到货检验类型,name = vc_operatetype,width = 80,align = center,type = mask,typevalue=01:正常入库/02:对冲入库,headtype = sort,datatype = string);
						gcid = 4(headtext = 订单号,name = voucherid,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = 5(headtext = 供应商名称,name = nv_proname,width = 80,align = left,type = text,headtype = sort,datatype = string);
						gcid = 6(headtext = 采购人,name = nv_dealer,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = 7(headtext = 采购类型,name = nv_purchasetype,width = 80,align = center,type = mask,headtype = sort,datatype = string,typevalue=102:自采/106:比例代销/107:协议代销);
						gcid = 8(headtext = 采购时间,name = dt_purchasedate,width = 100,align = left,type = text,headtype = hidden,datatype=string,dataformat=yyyy-MM-dd);
						gcid = 9(headtext = 入库仓库,name = nv_storehousename,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = 10(headtext = 审核人,name = nv_operatorname,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = 11(headtext = 状态,name = ch_flag,width = 80,align = center,type = mask,typevalue=01:入库中/03:已提交/05:已完成,headtype = sort,datatype = string);
						gcid = 12(headtext = 到货检验时间,name = dt_operatedate,width = 100,align = left,type = text,headtype = sort,datatype=string,dataformat=yyyy-MM-dd);
						gcid = 13(headtext = 备注,name = nv_remark,width = 200,align = left,type = text,headtype = sort,datatype = string);
					" />
			</a4j:outputPanel>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="" />
				<h:inputHidden id="deleteItem" value="" />
			</a4j:outputPanel>
		</div>
		</h:form>
	</div>
	</f:view>
</body>
</html>