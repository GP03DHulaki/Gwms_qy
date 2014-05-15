<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>上架任务</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="上架任务">
	<meta http-equiv="description" content="上架任务">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/Gwalldate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="shelftask.js"></script>
</head>

<body id="mmain_body" >
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;上架&gt;&gt;</font><b>上架任务</b><br></div>
	<f:view>
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
				<h:outputText value="单据编号:">
				</h:outputText>
				<h:inputText id="sk_voucherid" styleClass="datetime" size="15"
					value="" onkeypress="formsubmit(event);" />
			
			
				<h:outputText value="状态:">
				</h:outputText>
				<h:selectOneMenu id="sk_ch_flag" value=""
					 onkeypress="formsubmit(event);">
					<f:selectItem itemLabel="全部" itemValue="00" />
				</h:selectOneMenu>
				<br />
				
			</div>
			<a4j:outputPanel id="output">
				<g:GTable gid="gtable" gtype="grid" 
					gselectsql="select id_id,'SF20110817001' as a,'C区' as b,'待上架' as c,'DEW' as  d,'2011-08-17' as f,mtxt   from temp" 
					gpage="(pagesize = 20)" gversion="2" gdebug = "false"
					gcolumn="gcid = id_id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
						gcid = -1(headtext = 操作,name = view_h,width = 50,align = center,headtype = hidden,type = link,linktype = script,typevalue = shelftask_edit.jsf?pid=gcolumn[2],value = 编辑);
						gcid = 2(headtext = 任务编号,name = vc_voucherid,width = 120,align = left,type = link,linktype = script,typevalue =shelftask_edit.jsf?pid=gcolumn[2],,headtype = sort,datatype = string);
						gcid = 3(headtext = 上架区域,name = nv_warehousename,width = 130,align = center,type = text,headtype = sort,datatype = string);
						gcid = 4(headtext = 状态,name = ch_flag,width = 80,align = center,type = mask,typevalue=01:分车中/05:已完成,headtype = sort,datatype = string);
						gcid = 5(headtext = 审核人,name = nv_operatorname,width = 100,align = left,type = text,headtype = sort,datatype = string);
						gcid = 6(headtext = 审核时间,name = dt_operatedate,width = 100,align = left,type = text,headtype = sort,datatype=string,dataformat=yyyy-MM-dd);
						gcid = 7(headtext = 备注,name = nv_remark,width = 200,align = left,type = text,headtype = sort,datatype = string);
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