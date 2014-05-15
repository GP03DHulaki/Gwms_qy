<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>编辑上架任务单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="编辑上架任务单">
	<meta http-equiv="description" content="编辑上架任务单">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="shelftask.js"></script>
</head>

<body id="mmain_body" onload="showMes();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;上架&gt;&gt;</font><b>编辑上架任务</b><br></div>
	<f:view>
	<h:form id="edit">
	<div id="mmain">
		<div id=mmain_opt>
			<a4j:outputPanel id="output">
				<a4j:commandButton value="添加单据"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					onclick="addNew();" rendered="true" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="updateId" value="保存单据" type="button"
					action=""
					onclick="if(!headCheck()){return false};"
					reRender="output,renderArea,head" 
					requestDelay="50" rendered="true"
					oncomplete="endHeadCheck();" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="delId" value="删除单据" type="button"
					action=""
					onclick="if(!doDel()){return false;}"
					reRender="output,renderArea"
					oncomplete="endDoDel();" requestDelay="50"
					rendered="true" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="approveId" value="审核单据" type="button"
					action="" onclick="shenHe()"
					reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
					oncomplete="endShenHe();" requestDelay="50"
					rendered="true" />
				<h:commandButton type="button" value="打印单据"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'"
					rendered="false" styleClass="a4j_but1"
					onclick="doPrintRep();" />
			</a4j:outputPanel>
		</div>
		<a4j:outputPanel id="head">
		<div id=mmain_cnd>
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="单据单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="vc_voucherid" styleClass="datetime"
							value="SF20110817001" disabled="true"/>	
					</td>
					<td>
						<h:outputText value="上架任务区域:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_warehousename" styleClass="datetime"
							value="C区" disabled="true"/>
					</td>
					<td>
						<h:outputText value="状态:"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="sk_ch_flag" value="01"
						styleClass="selectItem" onkeypress="formsubmit(event);" disabled="true">
						<f:selectItem itemLabel="待上架" itemValue="01" />
						</h:selectOneMenu>
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="nv_remark" styleClass="datetime"
							value="" size="65" />
					</td>
				</tr>
			</table>
		</div>
		</a4j:outputPanel>
		<div style="vertical-align: top;"></div>
		<SPAN ID="detail_ctrl" class="ctrl_show"
			onclick="JS_ExtraFunction();"></SPAN>
		<font color="#4990dd" style="font-weight:bolder;cursor:pointer"
			onclick="JS_ExtraFunction();">未上架区域中存在的商品：</font>
		<div id="ExtraFunction" style="display: none;height: 10px;">
			<a4j:outputPanel id="countPage">
				<iframe frameborder="0" src="count.jsf" width="100%" height="200px" >
				</iframe>
			</a4j:outputPanel>
		</div>	
		<a4j:outputPanel id="detailbutton" >
		<a4j:outputPanel rendered="true">
		<div id=mmain_opt>
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="增加明细" type="button"
				action=""
				onclick="if(!addDetail()){return false};"
				rendered="true"
				reRender="tableid,input" oncomplete="endAddDetail();"
				requestDelay="50" />
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="修改明细" type="button"
				action=""
				onclick="if(!updateDetail()){return false};"
				rendered="true"
				reRender="tableid,renderArea,countPage" oncomplete="endUpdateDetail();"
				requestDelay="50" />
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="删除明细" type="button"
				action=""
				onclick="if(!delDetail(gtable)){return false};"
				rendered="true"
				reRender="tableid,renderArea,countPage" oncomplete="endDelDetail();"
				requestDelay="50" />
		</div>
		</a4j:outputPanel>
		</a4j:outputPanel>
		<a4j:outputPanel id="input" >
			<a4j:outputPanel rendered="true">
				<div id=mmain_cnd>
				<table>
					<tr>
						
						<td>
							<h:outputText value="商品条码:"></h:outputText>
						</td>
						<td>
							<h:inputText id="vc_barcode" styleClass="datetime"
								value="" onkeypress="onkeybarcode();"/>
						</td>
						<td>
							<h:outputText value="数量:"></h:outputText>
						</td>
						<td>
							<h:inputText id="dc_qty" styleClass="datetime"
								value="" onkeypress="addbarcode();"/>
						</td>
						
					</tr>
				</table>
				 提示信息 : <span id="tsqydiv" style="color:red;"></span>
				</div>
			</a4j:outputPanel>
		</a4j:outputPanel>
		<div>
		<a4j:outputPanel id="tableid">
		<g:GTable gid="gtable" gtype="grid" gdebug="false"
			gselectsql="select id_id,'IVEIKSK' as a,'TEST10' as b,'DSQQQQVIDEICF' as c,'4*7' as d,'件' as e,100 as f,mtxt from temp 
						union select id_id,'WREGEQ' as a,'TEST11' as b,'IIKRIJOWKC' as c,'6*3' as d,'件' as e,80 as f,mtxt from temp  "
			gpage="(pagesize = 20)" gversion="2"
			gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = 2(headtext = 商品编码,name = vc_invcode,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 3(headtext = 商品名称,name = nv_invname,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 4(headtext = 商品条码,name = vc_barcode,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 5(headtext = 规格,name = nv_specification,width = 120,align = left,type = text,headtype = sort,datatype = string);
						gcid = 6(headtext = 单位,name = nv_units,width = 40,align = center,type = text,headtype = hidden,datatype = string);
						gcid = 7(headtext = 正品数量,name = dc_qty,width = 80,align = right,type = #{sepcarMB.canUpdate},headtype=sort,datatype =number,dataformat=0.##);
						gcid = 8(headtext = 备注,name = nv_remark,width = 217,align = left,type = text,headtype = hidden,datatype = string);
						" />
		</a4j:outputPanel>
		</div>
		<div style="display: none;">
			<a4j:outputPanel id="renderArea">
				<h:inputHidden id="msg" value="" />
				
				
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="增加明细" type="button"
				action="" id="addbarcode"
				onclick="if(!addDetail()){return false};"
				rendered="true"
				reRender="tableid,renderArea,countPage" oncomplete="endAddDetail();"
				requestDelay="50" />
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="提示信息" type="button"
				action="" id="selectQy"
				onclick="selectQy();"
				rendered="true"
				reRender="tableid,renderArea,countPage" oncomplete="endSelectQy();"
				requestDelay="50" />
			</a4j:outputPanel>
		</div>
	</div>
	</h:form>
	</f:view>
</body>
</html>