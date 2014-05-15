<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ShelvMB"%>
<%@page import="com.gwall.pojo.stock.SldeDBean"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>编辑理货上架单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="编辑理货上架单">
		<meta http-equiv="description" content="编辑理货上架单">
		<script type="text/javascript" src="shelf.js"></script>
	</head>
	<%
	    String id = "";
	    ShelvMB ai = (ShelvMB) MBUtil.getManageBean("#{shelvMB}");
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.getMbean().setBiid(id);
	    }
	    ai.getVouch();
	    //默认选中
	    //if (((SldeDBean) ai.getDbean()).getChfl() == null)
	        //((SldeDBean) ai.getDbean()).setChfl("03");
	%><body id="mmain_body" onload="showMes();">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;<a href='shelf.jsf'>理货上架</a>&gt;&gt;</font><b>编辑理货上架</b>
			<br>
		</div>
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="showHeadButton">
							<a4j:commandButton value="添加单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="addNew();" rendered="#{shelvMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								action="#{shelvMB.updateHead}"
								onclick="if(!headCheck()){return false};"
								reRender="head,renderArea" requestDelay="50"
								rendered="#{shelvMB.MOD && shelvMB.commitStatus}"
								oncomplete="endHeadCheck();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="delId" value="删除单据" type="button"
								action="#{shelvMB.deleteHead}"
								onclick="if(!doDel()){return false;}"
								reRender="output,renderArea" oncomplete="endDoDel();"
								requestDelay="50"
								rendered="#{shelvMB.DEL && shelvMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="approveId" value="审核单据" type="button"
								action="#{shelvMB.approveVouch}" onclick="shenHe()"
								reRender="output,renderArea,showHeadButton,detailButton,input,countPage,codePanel"
								oncomplete="endShenHe();" requestDelay="50"
								rendered="#{shelvMB.APP&&shelvMB.commitStatus}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="head">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td>
										<h:outputText value="上架单号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="biid" styleClass="datetime"
											value="#{shelvMB.mbean.biid}" disabled="true" />
									</td>
									<td>
										<h:outputText value="来源库位:"></h:outputText>
									</td>
									<td>
										<h:inputText id="whna" styleClass="datetime" disabled="true"
											value="#{shelvMB.mbean.fwid}" />
										<h:inputHidden id="whid" value="#{shelvMB.mbean.fwid}" />
									</td>
									<td>
										<h:outputText value="状态:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{shelvMB.mbean.flag}"
											onkeypress="formsubmit(event);" disabled="true">
											<f:selectItem itemLabel="上架中" itemValue="01" />
											<f:selectItem itemLabel="正式单据" itemValue="11" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="nv_remark" styleClass="datetime"
											value="#{shelvMB.mbean.rema}" size="65" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<div style="vertical-align: top;"></div>
					<SPAN ID="detail_ctrl" class="ctrl_show"
						onclick="JS_ExtraFunction();"></SPAN>
					<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
						onclick="JS_ExtraFunction();">上架任务中商品：</font>
					<div id="ExtraFunction" style="display: none; height: 10px;">
						<a4j:outputPanel id="countPage">
							<iframe frameborder="0" src="count.jsf"
								onload="parent.Gskin.setSkinCss(null,this);" width="100%"
								height="200px">
							</iframe>
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id='detailButton'>
						<div id=mmain_opt>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								id="addDBut" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="添加明细" type="button"
								onclick="if(!addDetail()){return false};"
								action="#{shelvMB.addDetail}"
								rendered="#{shelvMB.ADD && shelvMB.commitStatus}"
								reRender="output,renderArea,countPage"
								oncomplete="endAddDetail();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="修改明细" type="button"
								onclick="if(!updateDetail()){return false};"
								action="#{shelvMB.updateDetail}"
								rendered="#{false && shelvMB.MOD && shelvMB.commitStatus}"
								reRender="output,renderArea,countPage"
								oncomplete="endUpdateDetail();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								value="删除明细" type="button" action="#{shelvMB.deleteDetail}"
								onclick="if(!delDetail(gtable)){return false};"
								rendered="#{shelvMB.DEL && shelvMB.commitStatus}"
								reRender="output,renderArea,countPage"
								oncomplete="endDelDetail();" requestDelay="50" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="input"
						rendered="#{shelvMB.MOD && shelvMB.commitStatus}">
						<div id=mmain_cnd>
							<div style="display: none;">
								<a4j:commandButton id="setCode4DBean" requestDelay="50"
									action="#{shelvMB.setCode4DBean}" onclick="startDo();"
									oncomplete="endCode4DBean();" reRender="codePanel,renderArea" />
							</div>
							<table border="0" cellpadding="1" cellspacing="0">
								<tr>
									<td>
										<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="autoItem" value="#{shelvMB.autoItem}"
											onchange="t.setIsAutoAdd(this.value);">
											<f:selectItem itemValue="0" itemLabel="否" />
											<f:selectItem itemValue="1" itemLabel="是" />
										</h:selectOneMenu>
									</td>
									<td>
										<h:outputText value="条码类型:" title="F9键切换条码类型" />
									</td>
									<td>
										<h:selectOneRadio id="batp" value="#{shelvMB.dbean.codetype}"
											layout="lineDirection"
											onclick="initEdit();t.batyClick(this);">
											<f:selectItem itemLabel="商品编码" itemValue="04" />
											<f:selectItem itemLabel="商品条码" itemValue="03" />	
											<f:selectItem itemLabel="箱码" itemValue="02" />
										</h:selectOneRadio>
									</td>
								</tr>
							</table>
							<a4j:outputPanel id='codePanel'>
								<table>
									<tr>
										<td>
											<h:outputText value="条码:"></h:outputText>
										</td>
										<td>
											<h:inputText id="baco" styleClass="datetime"
												style="width:250px" value="#{shelvMB.dbean.baco}"
												onchange="t.setCode4DBean();" onfocus="this.select();"
												onkeypress="onkeybacode();" />
											<img id="invcode_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectCode();" />
										</td>
										<td colspan="2">
											<span id='db_num'> <h:outputText value="数量: "></h:outputText>
												<h:inputText id="qty" value="#{shelvMB.dbean.qty}"
													onfocus="t.elementFocus();t.canFocus(this);"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime"
													size="10" /> </span>
										</td>
										<td>
											<h:outputText value="库位:"></h:outputText>
										</td>
										<td>
											<h:inputText id="dwhid" styleClass="datetime"
												onkeydown="t.keyPressDeal(this);"
												onfocus="this.select();t.elementFocus();"
												value="#{shelvMB.dbean.owid}" />
											<img id="whid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectWaho();" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</div>
					</a4j:outputPanel>

					<div>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="SELECT a.did,a.roid,a.biid,a.chfl,a.paco,a.baco,a.boco,a.inco,a.qty,a.owid,b.inna,b.inse,b.colo,b.inun 
								FROM slde a LEFT JOIN inve b ON a.inco=b.inco where a.biid='#{shelvMB.mbean.biid}' "
								gpage="(pagesize = 20)" gversion="2"
								gupdate="(table = {slde},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = roid(headtext = 行,name = roid,type = text,headtype = hidden,datatype = string);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = chfl(headtext = 条码类型,name = chfl,width = 80,align = center,type = mask,typevalue=02:箱码/03:商品条码/04:商品编码,headtype = sort,datatype = string,update=edit);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = chfl(headtext = 条码类型,name = chfl,width = 40,align = center,type = text,headtype = hidden,datatype = string,update=edit);
								gcid = owid(headtext = 上架货位,name = whid,width = 100,align = right,type = sort,headtype=sort,datatype =string);
								gcid = qty(headtext  = 上架数量,name = qty,width = 60,align = right,type =text,headtype=sort,datatype =number,dataformat=0.##,update=edit,gscript={onkeypress=return isInteger(event),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)},summary=this);
								gcid = baco(headtext = 条码,name = boco,width = 240,align = right,type = text,headtype = sort ,datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{shelvMB.msg}" />
							<h:inputHidden id="sellist" value="#{shelvMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{shelvMB.updatedata}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>