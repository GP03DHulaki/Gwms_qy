<%@ page language="java" pageEncoding="utf-8"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>生产订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="生产订单">
		<script type="text/javascript"
			src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
		<script src="mo.js"></script>
	</head>
	<body onload="initMain();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;订单&gt;&gt;</font>
			<b>生产订单</b>
		</div>
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="javascript:window.location.href='mo_add.jsf'"
							rendered="#{crbmMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="删除单据" type="button" 
							onclick="if(!dodVoucher(gtable)){return false;}"
							action="#{crbmMB.delete}"
							reRender="output" oncomplete="enddVoucher();" requestDelay="50"
							rendered="#{crbmMB.DEL}" />
						<a4j:outputPanel rendered="#{crbmMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" 
							action="#{crbmMB.search}" reRender="output"
							requestDelay="50"/>
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="initMain();" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel rendered="#{crbmMB.LST}">
							<table>
								<tr>
									<td>
										生产日期从:
									</td>
									<td>
										<h:inputText id="sk_start_date" styleClass="datetime"
											size="12" value="#{crbmMB.sk_start_date}"
											onfocus="#{gmanage.datePicker}"
											onkeypress="dosubmit(event);" />
										至:
										<h:inputText id="sk_end_date" styleClass="datetime" size="12"
											value="#{crbmMB.sk_end_date}"
											onfocus="#{gmanage.datePicker}"
											onkeypress="dosubmit(event);"/>
									</td>
									<td>
										单据编号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime" size="15"
											value="#{crbmMB.bean.biid}" onkeypress="dosubmit(event);"/>
									</td>
									<td>
										单据状态:
									</td>
									<td>
										<h:selectOneMenu id="stat" value="#{crbmMB.bean.stat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="全部" itemValue="0" />
											<f:selectItem itemLabel="制作之中" itemValue="1" />
											<f:selectItem itemLabel="正式单据" itemValue="2" />
										</h:selectOneMenu>
									</td>
									<td>
										供应商名称:
									</td>
									<td>
										<h:inputText id="ceve" styleClass="datetime" size="15"
											value="#{crbmMB.bean.ceve}" onkeypress="dosubmit(event);"/>
									</td>
									<td>
										产品编码:
									</td>
									<td>
										<h:inputText id="prco" styleClass="datetime" size="15"
											value="#{crbmMB.bean.prco}" onkeypress="dosubmit(event);"/>
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="Select biid,prco,prnu,whid,ceve,crna,pddt,Case flag When '0' Then '普通工单' When '1' Then '重工单' End As 'flag',
										Case stat When '1' Then '制作之中' When '2' Then '正式单据' End As 'stat',rema From crbm Where 1=1 #{crbmMB.searchSQL}"
							gpage="(pagesize = 20)" gdebug="false" gsortmethod="asc"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,headtype = checkbox,align = center,type = checkbox);
								gcid=0(headtext = 行号,name = rowid,width = 30,headtype = text, align = center, type = text,datatype = string);
								gcid=biid(headtext = 单据编号 ,name = biids,width = 100,headtype = hidden , align = left ,datatype = string);
								gcid=biid(headtext = 单据编号 ,name = biid,width = 100,headtype = sort , align = left ,type = link,linktype=script,typevalue=mo_edit.jsf?biid=gcolumn[biid],datatype = string);
								gcid=prco(headtext = 产品编号 ,name = prco,width = 100,headtype = text , align = left , type = text ,datatype = string);
								gcid=prnu(headtext = 数量 ,name = prnu,width = 80,headtype = text , align = left , type = text , datatype = number,dataformat=0);
								gcid=whid(headtext = 库位号,name = whid,width = 80,headtype = text , align = left , type = text , datatype = string);
								gcid=ceve(headtext = 供应商 ,name = ceve,width = 80,headtype = text , align = left , type = text , datatype = string);
								gcid=crna(headtext = 创建人,name = crna,width = 80,headtype = text , align = left , type = text , datatype = string);
								gcid=pddt(headtext = 生产日期,name = pddt,width = 100,headtype = text, align = center, type=text , datatype=datetime,dataformat=yyyy-MM-dd);
								gcid=flag(headtext = 单据类型 ,name = flag,width = 80,headtype = text , align = center , type = text , datatype = string);
								gcid=stat(headtext = 单据状态 ,name = stat,width = 60,headtype = text , align = center , type = text , datatype = string);
								gcid=rema(headtext = 备注 ,name = rema,width = 150,headtype = text , align = left , type = text , datatype = string);
								" />
						<h:inputHidden id="msg" value="#{crbmMB.msg}" />
						<h:inputHidden id="sellist" value="#{crbmMB.sellist}" />
						<h:inputHidden id="stats" value="#{crbmMB.stats}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>