<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库计划</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库计划">
		<script type="text/javascript" src="outplan.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/frame/tree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/frame/gmdi.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_nav>
						<a id="linkid" href="outplan.jsf" class="return" title="返回">出库处理</a>&gt;&gt;<b>编辑出库计划</b><br>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="mainBut" rendered="true">
							<a4j:commandButton id="printPick" value="打印拣货清单"
								onclick="startDo();" action=""
								reRender="output,renderArea,main,mainBut,msg,outPutFileName"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="endDo();" rendered="" />
							<a4j:commandButton id="printSBut" value="打印全部订单"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="" rendered="false"
								reRender="renderArea,output" oncomplete="endDo();"
								requestDelay="65" onclick="startDo();" />

							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="addMBut" value="添加单据" type="button"
								action="#{saleOrderMB.approveVouch}" onclick="shenHe()"
								reRender="output,output1,renderArea,head,countPage,detailbutton,input,tableid,detailButton"
								oncomplete="endShenHe();" requestDelay="50"
								rendered="true" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								onclick="if(!headCheck()){return false};"
								reRender="msg,headPanel,output,outTable,detailButton"
								oncomplete="endDo();" requestDelay="50"
								rendered="true" />	
							<a4j:commandButton id="delMBut" value="删除单据"
								onclick="if(!checkDelVoucher()){return false};"
								onmouseover="this.className='a4j_over1'"
								action=""
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,output,countPage"
								oncomplete="endDo();" requestDelay="50"
								rendered="true" />
							<a4j:commandButton id="appMBut" value="自动分配任务"
								onclick="if(!checkDelVoucher()){return false};"
								onmouseover="this.className='a4j_over1'"
								action=""
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,output,countPage"
								oncomplete="endDo();" requestDelay="50"
								rendered="true" />
						</a4j:outputPanel>
						<div style="display: none;">
							<a4j:outputPanel id="renderArea">
								<h:inputHidden id="msg" value="" />
								<h:inputHidden id="outPutFileName" value="" />
								<h:inputHidden id="item" value="" />
							</a4j:outputPanel>
						</div>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="main">
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										出库计划:
									</td>
									<td>
										<h:inputText id="vc_voucherid" styleClass="inputtext"
											size="20" value="OP11080100001"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										生成时间:
									</td>
									<td>
										<h:inputText id="dt_createdate" styleClass="inputtext"
											size="18" value="2011-08-01 8:30"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										状态:
									</td>
									<td>
										<h:inputText id="nv_flagname" styleClass="inputtext" size="12"
											value="待分配"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td valign="top">
										来源出库订单:
									</td>
									<td colspan="9">
										<h:inputText size="90" id="nv_fromvoucherid" styleClass="inputtext"
											value="SO11073000001,SO11073000002,SO11073100001"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td valign="top">
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="9">
										<h:inputText size="90" id="nv_remark" styleClass="inputtext"
											value="原型演示出库计划"
											 />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="orderTable">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();"></SPAN>
						<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
							onclick="JS_ExtraFunction();">出库订单列表:</font>
						<div id="ExtraFunction" style="height: 10px;">
							<div id=mmain_cnd>
								<div id=mmain_opt>
									<a4j:outputPanel id="mainSBut" rendered="true">
										<a4j:commandButton id="printSa" value="打印订单"
											onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" type="button"
											action="" rendered="false"
											onclick="if(!doPrintVid(gtable3)){return false};"
											reRender="renderSArea,renderArea" oncomplete="endDo();" requestDelay="50" />
										
										<a4j:commandButton id="addDBut" value="增加订单"
											onclick="selectFromNo();"
											onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
											type="button" reRender="renderArea,output,countPage,orderTable"
											rendered="true" requestDelay="50" />
										
										<a4j:commandButton value="删除订单"
											onclick="if(!checkDelVid('gtable3')){return false};"
											action="" reRender="renderArea,outsput,renderArea,output"
											rendered="true"
											onmouseover="this.className='a4j_over1'"
											oncomplete="endDo();"
											onmouseout="this.className='a4j_buton1'"
											styleClass="a4j_but1" />
									</a4j:outputPanel>
								</div>
								<a4j:outputPanel id="outsput">
									<g:GTable gid="gtable3" gtype="grid" gversion="2"
										gdebug="false"
										gselectsql="
											SELECT id_id,'SO11073000001' AS vc_fromvoucherid,'2011-07-31 08:00' AS dt_orderdate,
											'全一物流' AS vc_expname,'巨软科技' AS nv_customername,'A' AS vc_row
											FROM temp
											UNION ALL 
											SELECT id_id,'SO11073000002' AS vc_fromvoucherid,'2011-07-31 10:00' AS dt_orderdate,
											'德邦物流' AS vc_expname,'Gwall' AS nv_customername,'B' AS vc_row
											FROM temp
											UNION ALL 
											SELECT id_id,'SO11073100001' AS vc_fromvoucherid,'2011-07-31 10:00' AS dt_orderdate,
											'德邦物流' AS vc_expname,'Gwall' AS nv_customername,'B' AS vc_row
											FROM temp
										"
										gpage="(pagesize = -1)" gsort="id_id" gsortmethod="asc"
										gcolumn="gcid = id_id(headtext = selall,name = id_id,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = vc_fromvoucherid(headtext = 出库订单,name = vc_fromvoucherid,width = 180,headtype = text,align = left,type = text,datatype=string);
											gcid = dt_orderdate(headtext = 下单时间,name = dt_orderdate,width = 120,headtype = text,align = left,type = text,datatype=string,dataformat=yyyy-MM-dd HH:mm);
											gcid = vc_expname(headtext = 物流商,name = vc_expname,width = 120,headtype = text,align = left,type = text,datatype=string);
											gcid = nv_customername(headtext = 客户,name = nv_customername,width = 100,headtype = text,align = left,type = text,datatype=string);
											gcid = vc_row(headtext = 对应栏号,name = vc_row,width = 100,headtype = hidden,align = left,type = text,datatype=string);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="updatedata" value="" />
								<div style="display: none;">
									<a4j:outputPanel id="renderSArea">
										<h:inputHidden id="print_expcode" value="" />
										<h:inputHidden id="deleteitemid" value="" />
										<h:inputHidden id="viditems" value="" />
										<h:inputHidden id="eiditems" value="" />	
										<h:inputHidden id="orderitems" value="" />	
									</a4j:outputPanel>
								</div>
							</div>
						</div>
					</a4j:outputPanel>

					<div>
						<b>出库计划物料明细:</b>
					</div>
					<div id=mmain_cnd>
						<div id=mmain_opt>
							<a4j:commandButton id="createTask" value="分配任务"
								onclick="startDo();" action=""
								reRender="output,renderArea,main,mainBut,msg,outPutFileName"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="endDo();" rendered="true" />
						</div>	
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
								gsort="vc_warehouseid" gsortmethod="asc"
								gselectsql="SELECT id_id,'C-001-01A11' AS vc_warehouseid,'CODETEST001' AS vc_barcode,
								'TEST0001' AS vc_invcode,'演示商品001' AS nv_invname,'演示商品规格01' AS vc_invstandard,30 AS dc_qty
								FROM temp
								UNION ALL 
								SELECT id_id,'C-005-09B17' AS vc_warehouseid,'CODETEST002' AS vc_barcode,
								'TEST0001' AS vc_invcode,'演示商品001' AS nv_invname,'演示商品规格01' AS vc_invstandard,70 AS dc_qty
								FROM temp
								UNION ALL 
								SELECT id_id,'C-010-02B12' AS vc_warehouseid,'CODETEST003' AS vc_barcode,
								'TEST0002' AS vc_invcode,'演示商品002' AS nv_invname,'演示商品规格02' AS vc_invstandard,120 AS dc_qty
								FROM temp
								UNION ALL 
								SELECT id_id,'C-022-05A14' AS vc_warehouseid,'CODETEST004' AS vc_barcode,
								'TEST0003' AS vc_invcode,'演示商品003' AS nv_invname,'演示商品规格03' AS vc_invstandard,80 AS dc_qty
								FROM temp"
								gcolumn="gcid = id_id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = vc_warehouseid(headtext = 库位,name = vc_warehouseid,width = 120,headtype = hidden,align = left,type = text,datatype=string);
							gcid = vc_invcode(headtext = 商品编码,name = vc_invcode,width = 120,headtype = text,align = left,type = text,datatype=string);
							gcid = nv_invname(headtext = 商品名称,name = nv_invname,width = 160,headtype = text,align = left,type = text,datatype=string);
							gcid = vc_invstandard(headtext = 规格,name = vc_invstandard,width = 100,headtype = text,align = left,type = text,datatype=string);
							gcid = dc_qty(headtext = 数量,name = dc_qty,width = 70,headtype = text,align = right,type = number,datatype=number,dataformat={0},summary=this);
							gcid = vc_barcode(headtext = 商品条码,name = vc_barcode,width = 160,headtype = hidden,align = left,type = text,datatype=string);
						" />
							<!-- gpage="(pagesize = 20)" -->
						</a4j:outputPanel>
					</div>
				</h:form>

				<div id="edit" style="display: none">
					<h:form id="edit">
						<a4j:outputPanel id="editpanel">
							<table align="center">
								<tr height="5">
									<td></td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										快递单号:
									</td>
									<td>
										<h:inputText id="expressvid" styleClass="inputtext" size="20"
											onkeypress="if(!doFill(event)){return false};"
											value="#{picktaskMB.expressvid}" />
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<a4j:commandButton id="fillBut" action="#{picktaskMB.fillEid}"
											value="确定" reRender="outsput,renderArea,renderSArea" oncomplete="endDo();"
											onmouseover="this.className='a4j_over'"
											onclick="if(!checkEid()){return false};" requestDelay="50"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<h:inputHidden id="item" value="#{picktaskMB.item}" />
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>