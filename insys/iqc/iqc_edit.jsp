<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>编辑到货检验单</title>
	
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="编辑到货检验单">
	<meta http-equiv="description" content="编辑到货检验单">
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="iqc.js"></script>
</head>

<body id="mmain_body" onload="showMes();">
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>编辑到货检验单</b><br></div>
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
					id="tijiao" value="提交" type="button"
					action="" onclick="tijiao()"
					reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
					oncomplete="endTijiao();" requestDelay="50"
					rendered="false" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="huitui" value="回退" type="button"
					action="" onclick="huitui()"
					reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
					oncomplete="endHuitui();" requestDelay="50"
					rendered="false" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="approveId" value="审核单据" type="button"
					action="" onclick="shenHe()"
					reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
					oncomplete="endShenHe();" requestDelay="50"
					rendered="true" />
				<a4j:commandButton onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
					id="approveDCId" value="对冲审核" type="button"
					action="" onclick="shenHe()"
					reRender="output,renderArea,head,countPage,detailbutton,input,tableid"
					oncomplete="endShenHe();" requestDelay="50"
					rendered="false" />
				<h:commandButton type="button" value="打印单据"
					onmouseover="this.className='a4j_over1'"
					onmouseout="this.className='a4j_buton1'"
					rendered="false" styleClass="a4j_but1"
					onclick="doPrintRep();" />
			</a4j:outputPanel>
		</div>
		
		<div id=mmain_cnd>
			<a4j:outputPanel id="head">
			<table border="0" cellspacing="0" cellpadding="3">
				<tr>
					<td >
						<h:outputText value="到货检验单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="vc_voucherid" styleClass="datetime"
							value="DH20110817001" disabled="true"/>	
					</td>
					<td>
						<h:outputText value="订单号:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_fromvoucherid" styleClass="datetime"
							disabled="true" value="PO20110816001"/>
					</td>
					<td>
	
							<h:outputText value="到货检验类型:"></h:outputText>
				
					</td>
					<td>
				
						<h:selectOneMenu id="vc_operatetype" value="01" 
						  onkeypress="formsubmit(event);"  disabled="true">
							<f:selectItem itemLabel="采购" itemValue="01" />
							<f:selectItem itemLabel="ASN" itemValue="02" />
							<f:selectItem itemLabel="生产" itemValue="03" />
						</h:selectOneMenu>
					
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="供应商名称:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_suppliername" styleClass="datetime"
							disabled="true" value="GWALL"/>
					</td>
					<td>
						<h:outputText value="入库仓库:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_storehousename" styleClass="datetime"
							value="深圳仓库" disabled="true"/>
					</td>
					
				</tr>
				<tr>
					<td>
						<h:outputText value="采购人:"></h:outputText>
					</td>
					<td>
						<h:inputText id="nv_dealer" styleClass="datetime"
							value="DEW" disabled="true"/>
					</td>
					<td>
						<h:outputText value="采购类型:"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="nv_purchaseType" value="102" disabled="true" >
							<f:selectItem itemLabel="自采" itemValue="102" />
							<f:selectItem itemLabel="比例代销" itemValue="106" />
							<f:selectItem itemLabel="协议代销" itemValue="107" />
						</h:selectOneMenu>
					</td>
					<td>
						<h:outputText value="状态:"></h:outputText>
					</td>
					<td>
						<h:selectOneMenu id="sk_ch_flag" value="01"
						 onkeypress="formsubmit(event);" disabled="true">
						<f:selectItem itemLabel="检验中" itemValue="01" />
						</h:selectOneMenu>
					</td>
				</tr>
				<tr>
					<td>
						<h:outputText value="备注:"></h:outputText>
					</td>
					<td colspan="3">
						<h:inputText id="nv_remark" styleClass="datetime"
							value="" size="69" />
					</td>
				</tr>
			</table>
			</a4j:outputPanel>
		</div><!--
		
		<a4j:outputPanel id="countPage">
			<div id="mmain_cnd">
				<iframe id="view" frameborder="0" src="count.jsf" width="98%"
					height="120px;"></iframe>
			</div>
		</a4j:outputPanel>
		
		--><div id=mmain_opt>
		<a4j:outputPanel id="detailbutton" >
		<a4j:outputPanel rendered="true">
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="增加明细" type="button"
				action=""
				onclick="if(!addDetail()){return false};"
				rendered="false"
				reRender="tableid,input" oncomplete="endAddDetail();"
				requestDelay="50" />
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="修改明细" type="button"
				action=""
				onclick="if(!updateDetail()){return false};"
				rendered="true"
				reRender="tableid,renderArea" oncomplete="endUpdateDetail();"
				requestDelay="50" />
			<a4j:commandButton onmouseover="this.className='a4j_over1'"
				onmouseout="this.className='a4j_buton1'"
				styleClass="a4j_but1" value="删除明细" type="button"
				action=""
				onclick="if(!delDetail(gtable)){return false};"
				rendered="true"
				reRender="tableid,renderArea" oncomplete="endDelDetail();"
				requestDelay="50" />
		</a4j:outputPanel>
		</a4j:outputPanel>
		</div>
		<div id=mmain_cnd>
		<a4j:outputPanel id="input" >
			<a4j:outputPanel rendered="true">
				<table>
					<tr>
						<td>
							<h:outputText value="商品属性:"></h:outputText>
						</td>
						<td width = "130px;">
							<h:selectOneRadio id="ch_dflag" value="01"  
								layout="lineDirection" onclick = "tobarcode();">
								<f:selectItem itemLabel="正品" itemValue="01" />
								<f:selectItem itemLabel="残品" itemValue="02" />
							</h:selectOneRadio>
						</td>
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
			</a4j:outputPanel>
		</a4j:outputPanel>
		</div>
			
		<div>
		<a4j:outputPanel id="tableid">
		<g:GTable gid="gtable" gtype="grid" gdebug="false"
			gselectsql="select id_id,'IVEIKSK' as a,'TEST10' as b,'DSQQQQVIDEICF' as c,'4*7' as d,'件' as e,100 as f,0 as g,mtxt from temp 
						union select id_id,'WREGEQ' as a,'TEST11' as b,'IIKRIJOWKC' as c,'6*3' as d,'件' as e,80 as f,0 as g,mtxt from temp "
			gpage="(pagesize = 20)" gversion="2"
			gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
						gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
						gcid = 2(headtext = 商品编码,name = vc_invcode,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = 3(headtext = 商品名称,name = nv_invname,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = 4(headtext = 商品条码,name = vc_barcode,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = 5(headtext = 规格,name = nv_specification,width = 120,align = left,type = text,headtype = sort ,datatype = string);
						gcid = 6(headtext = 单位,name = nv_units,width = 40,align = center,type = text,headtype = hidden,datatype = string);
						gcid = 7(headtext = 正品数量,name = dc_qty,width = 80,align = right,type = input,headtype=sort,datatype =number,dataformat=0.##);
						gcid = 8(headtext = 次品数量,name = dc_fqty,width = 80,align = right,type = input,headtype=sort,datatype =number,dataformat=0.##);
						gcid = 9(headtext = 备注,name = nv_remark,width = 217,align = left,type = text,headtype = hidden,datatype = string);
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
					reRender="tableid,renderArea,input,countPage" oncomplete="endAddDetail();"
					requestDelay="50" />
			</a4j:outputPanel>
		</div>
	</div>
	</h:form>
	</f:view>
</body>
</html>