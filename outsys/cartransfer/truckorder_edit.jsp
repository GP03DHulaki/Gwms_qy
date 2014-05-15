<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.CarTransferMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    CarTransferMB ai = (CarTransferMB) MBUtil
            .getManageBean("#{carTransferMB}");
    ai.getVouch();
    if (request.getParameter("AJAXREQUEST") == null) {
        ai.setDbiid("%");
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑装车单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑订单明细">
		<script type="text/javascript" src="truckorder.js"></script>
		<style type="text/css">
			.gcolstyle {
				cursor: pointer;
				color: #0000ff;
			}
		</style>
	</head>
	<body id=mmain_body onload="initEdit();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="truckorder.jsf" class="return" title="返回">出库处理</a>
						&gt;&gt;配车处理&gt;&gt;
						<b>编辑装车单</b>
						<br>
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{carTransferMB.deleteHead}"
								onclick="if(!deleteHead()){return false;}"
								oncomplete="endDeleteHead();" requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{carTransferMB.DEL && carTransferMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{carTransferMB.updateHead}"
								reRender="msg,headButton,detailButton,outdetail,orderTable,headmain"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{carTransferMB.MOD && carTransferMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{carTransferMB.APP && carTransferMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{carTransferMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,orderTable,mainBut,OUTORDER,TRANPLAN,PURCHASERETURNPLAN"
								oncomplete="endApp();" requestDelay="50" />

							<a4j:commandButton type="button" value="打印单据"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'"
								action="#{carTransferMB.printReport}"
								rendered="#{carTransferMB.PRN}" styleClass="a4j_but1"
								onclick="printReport();" oncomplete="endPrintReport();"
								reRender="hidArea,msg,outTable,output" requestDelay="1000" />
						</div>
					</a4j:outputPanel>
					<div id=mmain_cnd>
						<a4j:outputPanel id="headmain">
							<table cellpadding="3" cellspacing="0" border="0">
								<tbody>
									<tr>
										<td>
											装车单号:
										</td>
										<td>
											<h:inputText id="biid" styleClass="inputtext" size="20"
												value="#{carTransferMB.mbean.biid}"
												style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
										</td>
										<td>
											来源类型:
										</td>
										<td>
											<h:selectOneMenu id="soty" value="#{carTransferMB.mbean.soty}"
												disabled="true" style="width:130px;">
												<f:selectItem itemLabel="出库订单" itemValue="OUTORDER" />
												<f:selectItem itemLabel="采购退货"
													itemValue="PURCHASERETURNPLAN" />
												<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
											</h:selectOneMenu>
										</td>
										<td>
											组织架构:
										</td>
										<td>
											<h:selectOneMenu id="orid" value="#{carTransferMB.mbean.orid}"
												disabled="true">
												<f:selectItems value="#{OrgaMB.subList}" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td>
											承&nbsp;&nbsp;运&nbsp;商:
										</td>
										<td>
											<h:selectOneMenu id="lpco" style="width:130px;"
												value="#{carTransferMB.mbean.lpco}" disabled="true">
												<f:selectItem itemLabel="" itemValue="" />
												<f:selectItems value="#{carrierMB.list}" />
											</h:selectOneMenu>
										</td>
										<h:panelGroup
											rendered="#{carTransferMB.mbean.soty=='OUTORDER' ? false : true}">
											<td>
												路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
											</td>
											<td>
												<h:selectOneMenu id="lico" style="width:130px;"
													value="#{carTransferMB.mbean.lico}" disabled="true">
													<f:selectItems value="#{lineMB.itemlist}" />
												</h:selectOneMenu>
											</td>
										</h:panelGroup>

										<h:panelGroup
											rendered="#{carTransferMB.mbean.soty=='OUTORDER' ? true : false}">
											<td>
												快递单号:
											</td>
											<td>
												<h:inputText id="loco" styleClass="inputtext" size="20"
													disabled="#{!carTransferMB.commitStatus}"
													value="#{carTransferMB.mbean.loco}" />
											</td>
										</h:panelGroup>
										<td>
											经手人:
										</td>
										<td>
											<h:inputText id="opna" styleClass="inputtext" size="20"
												disabled="#{!carTransferMB.commitStatus}"
												value="#{carTransferMB.mbean.opna}" />
										</td>
									</tr>
									<tr>
										<td>
											备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
										</td>
										<td colspan="5">
											<h:inputText id="rema" styleClass="inputtext" size="95"
												disabled="#{!carTransferMB.commitStatus}"
												value="#{carTransferMB.mbean.rema}" />
										</td>
									</tr>
								</tbody>
							</table>
						</a4j:outputPanel>
					</div>
					<div id=mmain_opt>
						<a4j:outputPanel id="mainBut" rendered="true">
							<a4j:commandButton value="添加订单"
								onclick="selOutOrder('#{carTransferMB.mbean.orid}','#{carTransferMB.mbean.soty}');"
								oncomplete="$('edit:refBut').onclick();" styleClass="a4j_but1"
								rendered="#{carTransferMB.ADD && carTransferMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" />

							<a4j:commandButton value="删除订单"
								onclick="if(!selectFromId('#{carTransferMB.mbean.soty}')){return false};"
								action="#{carTransferMB.deleteDetail}"
								reRender="hidArea,#{carTransferMB.mbean.soty},outbiid"
								rendered="#{carTransferMB.MOD && carTransferMB.commitStatus}"
								onmouseover="this.className='a4j_over1'"
								oncomplete="endDelOrder();loadFrame();"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1">
								<a4j:actionparam value="%" assignTo="#{carTransferMB.dbiid}" />
							</a4j:commandButton>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="OUTORDER"
						rendered="#{carTransferMB.mbean.soty=='OUTORDER' ? true : false }">
						<g:GTable gid="OUTORDER" gtype="grid" gversion="2" gdebug="true"
							gsort="biilstate" gsortmethod="ASC"
							gselectsql="
							SELECT b.loco,a.obid,a.flag,b.cuid,b.flag AS srcflag,
								b.chdt,b.orad,b.rema,c.cuna,b.waid,b.biid,ISNULL(b.stat,'0') AS stat,
								CASE WHEN a.flag='17' THEN '已完成' WHEN a.flag='16' AND d.biid IS NULL THEN '未完成'
								WHEN a.flag='16' AND d.biid IS NOT NULL THEN '有差异' END AS biilstate, 
								e.rena,e.rsad,e.rem2,b.lpco
								FROM lobd a LEFT JOIN obma b ON a.obid=b.biid
								LEFT JOIN cuin c ON b.cuid=c.cuid LEFT JOIN noin e on b.biid=e.biid
								LEFT JOIN (SELECT DISTINCT biid FROM slst WHERE flag='1' AND buty='#{carTransferMB.mbean.soty}') 
								d ON a.obid=d.biid WHERE a.biid= '#{carTransferMB.mbean.biid}' and b.isup='0'
							union SELECT g.loco,a.obid,a.flag,b.cuid,b.flag AS srcflag,
								b.chdt,b.orad,b.rema,c.cuna,b.waid,b.biid,ISNULL(b.stat,'0') AS stat,
								CASE WHEN a.flag='17' or a.flag='19' THEN '已完成' WHEN a.flag='16' AND d.biid IS NULL THEN '未完成'
								WHEN a.flag='16' AND d.biid IS NOT NULL THEN '有差异' END AS biilstate, 
								e.rena,e.rsad,e.rem2,b.lpco
								FROM lobd a LEFT JOIN obma b ON a.obid=b.biid
								LEFT JOIN cuin c ON b.cuid=c.cuid LEFT JOIN noin e on b.biid=e.biid
								LEFT JOIN (SELECT DISTINCT biid FROM slst WHERE flag='1' AND buty='#{carTransferMB.mbean.soty}') d ON a.obid=d.biid
								left join poma f on f.soco=b.biid
								left join pode g on a.loco=g.loco
								WHERE a.biid= '#{carTransferMB.mbean.biid}' and b.isup='1'
							
							"
							gpage="(pagesize = -1)"
							gcolumn="gcid = obid(headtext = selall,name = selall,width = 20,headtype = #{carTransferMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = loco(headtext = 快递单号,name = loco,width = 150,headtype = sort,align = left,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=onRowClick('gcolumn[loco]')});
							gcid = obid(headtext = 出库订单,name = obid,width = 150,headtype = sort,align = left,type = text,datatype=string);
							gcid = biilstate(headtext = 单据状态,name = biilstate,width = 60,headtype = sort,align = center,type = text,datatype=string,gscript={onmouseover=refBill(this.id)&&onmouseout=rerefBill(this.id)&&onclick=refBut('gcolumn[biilstate]','gcolumn[obid]')},bgcolor={gcolumn[biilstate]=未完成:#FFB6C1/gcolumn[biilstate]=有差异:#7FFFD4});
							gcid = stat(headtext = 复核状态,name=flag,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=0:未复核/10:全部复核异常/11:部分复核异常/20:复核通过/21:部分复核成功/31:已调整差异/61:已打包);
							gcid = lpco(headtext = 承运商,name = lpco,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = rena(headtext = 收件人,name = rena,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = rsad(headtext = 详细地址,name = rsad,width = 300,headtype = sort,align = left,type = text,datatype=string);
							gcid = rem2(headtext = 买家备注,name = rem2,width = 150,headtype = sort,align = left,type = text,datatype=string);
					" />
					</a4j:outputPanel>

					<a4j:outputPanel id="TRANPLAN"
						rendered="#{carTransferMB.mbean.soty=='TRANPLAN' ? true : false }">
						<g:GTable gid="TRANPLAN" gtype="grid" gversion="2" gdebug="false"
							gsort="biilstate" gsortmethod="ASC"
							gselectsql="
							SELECT a.obid,a.flag,b.flag AS srcflag,
							b.chdt,b.rema,c.whna,c.addr,b.waid,b.biid,ISNULL(b.stat,'0') AS stat,
							CASE WHEN a.flag='17' THEN '已完成' WHEN a.flag='16' AND d.biid IS NULL THEN '未完成'
							WHEN a.flag='16' AND d.biid IS NOT NULL THEN '有差异' END AS biilstate
							FROM lobd a LEFT JOIN #{carTransferMB.mtable} b ON a.obid=b.biid
							LEFT JOIN waho c ON b.powh=c.whid
							LEFT JOIN (SELECT DISTINCT biid FROM slst WHERE flag='1' AND buty='#{carTransferMB.mbean.soty}') 
							d ON a.obid=d.biid WHERE a.biid= '#{carTransferMB.mbean.biid}' "
							gpage="(pagesize = -1)"
							gcolumn="gcid = obid(headtext = selall,name = selall,width = 20,headtype = #{carTransferMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = obid(headtext = 调拨计划,name = obid,width = 120,headtype = sort,align = left,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=onRowClick('gcolumn[obid]')});
							gcid = biilstate(headtext = 单据状态,name = biilstate,width = 60,headtype = sort,align = center,type = text,datatype=string,gscript={onmouseover=refBill(this.id)&&onmouseout=rerefBill(this.id)&&onclick=refBut('gcolumn[biilstate]','gcolumn[obid]')},bgcolor={gcolumn[biilstate]=未完成:#FFB6C1/gcolumn[biilstate]=有差异:#7FFFD4});
							gcid = stat(headtext = 复核状态,name=flag,width = 80,headtype = sort,align = center,type = mask,datatype=string,typevalue=0:未复核/10:全部复核异常/11:部分复核异常/20:复核通过/21:部分复核通过/31:已调整差异/61:已打包);
							gcid = whna(headtext = 调入仓库,name = whna,width = 160,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = addr(headtext = 详细地址,name = addr,width = 200,headtype = sort,align = left,type = text,datatype=string);
							gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text,datatype=string);
					" />
					</a4j:outputPanel>

					<a4j:outputPanel id="PURCHASERETURNPLAN"
						rendered="#{carTransferMB.mbean.soty=='PURCHASERETURNPLAN' ? true : false }">
						<g:GTable gid="PURCHASERETURNPLAN" gtype="grid" gversion="2"
							gdebug="false" gsort="biilstate" gsortmethod="ASC"
							gselectsql="
							SELECT a.obid,a.flag,b.cuid,b.flag AS srcflag,b.stna,
							b.chdt,b.orad,b.rema,b.waid,b.biid,ISNULL(b.stat,'0') AS stat,
							CASE WHEN a.flag='17' THEN '已完成' WHEN a.flag='16' AND d.biid IS NULL THEN '未完成'
							WHEN a.flag='16' AND d.biid IS NOT NULL THEN '有差异' END AS biilstate
							FROM lobd a LEFT JOIN #{carTransferMB.mtable} b ON a.obid=b.biid
							LEFT JOIN (SELECT DISTINCT biid FROM slst WHERE flag='1' AND buty='#{carTransferMB.mbean.soty}') 
							d ON a.obid=d.biid WHERE a.biid= '#{carTransferMB.mbean.biid}' "
							gpage="(pagesize = -1)"
							gcolumn="gcid = obid(headtext = selall,name = selall,width = 20,headtype = #{carTransferMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = obid(headtext = 采购退货计划,name = obid,width = 120,headtype = sort,align = left,type = text,datatype=string,gstyle=gcolstyle,gscript={onclick=onRowClick('gcolumn[obid]')});
							gcid = biilstate(headtext = 单据状态,name = biilstate,width = 60,headtype = sort,align = center,type = text,datatype=string,gscript={onmouseover=refBill(this.id)&&onmouseout=rerefBill(this.id)&&onclick=refBut('gcolumn[biilstate]','gcolumn[obid]')},bgcolor={gcolumn[biilstate]=未完成:#FFB6C1/gcolumn[biilstate]=有差异:#7FFFD4});
							gcid = stat(headtext = 复核状态,name=flag,width = 80,headtype = sort,align = center,type = mask,datatype=string,typevalue=0:未复核/10:全部复核异常/11:部分复核异常/20:复核通过/21:部分复核通过/31:已调整差异/61:已打包);
							gcid = stna(headtext = 供应商名称,name = stna,width = 220,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text,datatype=string);
					" />
					</a4j:outputPanel>


					<div style="display: none;">
						<a4j:outputPanel id="hidArea">
							<h:inputHidden id="msg" value="#{carTransferMB.msg}" />
							<h:inputHidden id="sellist" value="#{carTransferMB.sellist}" />
							<h:inputHidden id="filename" value="#{carTransferMB.fileName}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								oncomplete="loadFrame();"
								reRender="#{carTransferMB.mbean.soty},headmain,hidArea,outbiid">
								<a4j:actionparam value="%" assignTo="#{carTransferMB.dbiid}" />
							</a4j:commandButton>
							<h:inputHidden value="#{carTransferMB.dbiid}" id="dbiid" />
							<h:inputHidden value="#{carTransferMB.dbean.obid}" id="obid" />
							<a4j:commandButton id="hidbut" reRender="outbiid,hidArea"
								oncomplete="loadFrame();" requestDelay="50" />
							<a4j:commandButton id="refouib"
								reRender="outbiid,hidArea,outorders" onclick="startDo();"
								oncomplete="endDo();loadFrame();" value="刷新单据" requestDelay="50"
								action="#{carTransferMB.updateDetail}" />
							<a4j:jsFunction name="refTable"
								reRender="frameDetail,#{carTransferMB.mbean.soty}" />
						</a4j:outputPanel>
					</div>
					<div>
						<p></p>
					</div>
					<div id="errmsg" style="display: none">
						<div id=mmain_cnd align="left">
							<span id="mes" style="color: red;"></span>
							<div align="center">
								<button type="button" onclick="Gwallwin.winClose();"
									onmouseover="this.className='a4j_over'"
									onmouseout="this.className='a4j_buton'" class="a4j_but">
									关闭
								</button>
							</div>
						</div>
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="frameDetail">
							<table>
								<tr>
									<td>
										<a4j:outputPanel id="outbiid">装车单明细(<h:outputText
												id="outdbiid"
												value="#{carTransferMB.dbiid=='%'?'全部':carTransferMB.dbiid}" />):
									</a4j:outputPanel>
									</td>
								</tr>
							</table>
							<iframe id="iframe_detail" name="iframe_detail" width="100%"
								align="top" scrolling="auto" frameborder="0" height="100%"
								onload="iframe_detail.endLoad();this.height=iframe_detail.document.body.scrollHeight;
									this.width=iframe_detail.document.body.scrollWidth;"
								src="<%=request.getContextPath()%>/outsys/truckorder/orderdetails.jsf"></iframe>
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>