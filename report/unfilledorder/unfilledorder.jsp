<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.report.UnfilledOrderMB"%>
<%@	page import="com.gwall.view.OutOrderMB"%>
<%
	UnfilledOrderMB ai = (UnfilledOrderMB) MBUtil
			.getManageBean("#{unfilledOrderMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>未完成发货订单统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="未完成发货订单统计报表">
		<script type="text/javascript" src="unfilledorder.js"></script>
	</head>
	<body id=mmain_body onload="clearData();">
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>未完成发货订单统计报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{unfilledOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="outorderreprot" action="#{unfilledOrderMB.search}" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" rendered="#{unfilledOrderMB.LST}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{unfilledOrderMB.exportXls}"
								reRender="msg,outPutFileName"
								onclick="excelios_begin('gtable');" oncomplete="excelios_end();"
								requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm" rendered="#{unfilledOrderMB.LST}">
						<div id="mmain_cnd">
							<h:outputText value="下单日期从:"></h:outputText>
							<h:inputText id="sk_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.sk_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="sk_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.sk_end_date}"
								onfocus="#{gmanage.datePicker}" />
								
							<h:outputText value="同步日期从:"></h:outputText>
							<h:inputText id="tb_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.tb_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="tb_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.tb_end_date}"
								onfocus="#{gmanage.datePicker}" />
								
							<h:outputText value="付款日期从:"></h:outputText>
							<h:inputText id="pa_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.pa_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="pa_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.pa_end_date}"
								onfocus="#{gmanage.datePicker}" />	
							单据状态:
							<h:selectOneMenu id="flag" value="#{unfilledOrderMB.flag}"
								rendered="true">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
								<f:selectItem itemLabel="已分配任务" itemValue="13" />
								<f:selectItem itemLabel="分拣中" itemValue="16" />
								<f:selectItem itemLabel="分拣完成" itemValue="17" />
								<f:selectItem itemLabel="装车中" itemValue="19" />
								<f:selectItem itemLabel="已完成" itemValue="31" />
								<f:selectItem itemLabel="已关闭" itemValue="100" />
							</h:selectOneMenu>
							<br/>
								
							<h:outputText value="快递交接日期从:"></h:outputText>
							<h:inputText id="jj_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.jj_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="jj_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.jj_end_date}"
								onfocus="#{gmanage.datePicker}" />
								
							<h:outputText value="备货任务生成日期从:"></h:outputText>
							<h:inputText id="bh_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.bh_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="bh_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.bh_end_date}"
								onfocus="#{gmanage.datePicker}" />
								
							<h:outputText value="拣货完成日期从:"></h:outputText>
							<h:inputText id="jh_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.jh_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="jh_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.jh_end_date}"
								onfocus="#{gmanage.datePicker}" />
							<br/>	
							<h:outputText value="发货单打印日期从:"></h:outputText>
							<h:inputText id="fhdy_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.fhdy_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="fhdy_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.fhdy_end_date}"
								onfocus="#{gmanage.datePicker}" />
								
							<h:outputText value="快递单打印日期从:"></h:outputText>
							<h:inputText id="kddy_start_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.kddy_start_date}"
								onfocus="#{gmanage.datePicker}" />
							<h:outputText value="至:">
							</h:outputText>
							<h:inputText id="kddy_end_date" styleClass="datetime" size="15"
								value="#{unfilledOrderMB.kddy_end_date}"
								onfocus="#{gmanage.datePicker}" />
							
							来源店铺:
							<h:selectOneMenu id="fsid" value="#{unfilledOrderMB.fsid}"
								rendered="true">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{outOrderMB.shops}" />
							</h:selectOneMenu>	
							
							承运商:
							<h:selectOneMenu id="lpco" value="#{unfilledOrderMB.lpco}"
								rendered="true">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{carrierMB.list}" />
							</h:selectOneMenu>	
							<br/>
									
							订单编号:
							<h:inputText id="biid" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{unfilledOrderMB.biid}" />
							来源单据:
							<h:inputText id="soco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);"
								value="#{unfilledOrderMB.soco}" />
							
	<%-- 						是否完成:
							<h:selectOneMenu id="stat" value="#{unfilledOrderMB.stat}"
								rendered="true">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="已完成" itemValue="0" />
								<f:selectItem itemLabel="未完成" itemValue="1" />
							</h:selectOneMenu>
	--%>						
							发货仓库:
							<h:selectOneMenu id="whid" value="#{unfilledOrderMB.whid}"
								rendered="true">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{warehouseMB.wareList}" />
							</h:selectOneMenu>
							
							是否取消:
							<h:selectOneMenu id="cancle" value="#{unfilledOrderMB.cancle}"
								rendered="true">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="已取消" itemValue="0" />
								<f:selectItem itemLabel="未取消" itemValue="1" />
							</h:selectOneMenu>
							
							
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="outorderreprot">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="biid" gsortmethod="ASC"
										gselectsql=" select  DISTINCT a.biid,a.loco,
										case when a.flag='11' then '正式单据' 
											 when a.flag='13' then '已分配任务' 
											 when a.flag='16' then '分拣中' 
											 when a.flag='17' then '分拣完成' 
											 when a.flag='19' then '装成中' 
											 when a.flag='31' then '已完成' 
											 when a.flag='100' then '已关闭'
											 end as flag,
										case when a.biid in (select biid from obbm) then '已取消'
											 when a.biid not in (select biid from obbm) then '未取消' end as cancle,
										case when (a.whfl IS NULL OR a.whfl='') then '未锁定'
											  when (a.whfl IS not NULL OR a.whfl<>'') then '已锁定' end as whfl,
											  d.whna,(SELECT SUM(qty) FROM oubd WHERE biid=a.biid) AS sqty,
											  a.fsna,a.lpco,c.cuna,c.rena,c.reca,c.reph,c.prov,a.orad,
											  CASE WHEN a.stat='0' THEN '未复核' WHEN a.stat='20' THEN '已复核' END AS fhstat,
											  a.crdt,a.eddt,a.padt,j.crdt AS bhdt,j.eddt as kddydt,j.eddt as fhdydt,k.chdt AS jhdt,m.chdt AS fhdt,n.crdt AS czdt,f.crdt AS jjdt,a.chdt,o.orna,a.soco	  
										from obma a 
										left join oubd b on a.biid=b.biid AND b.roid='0001'
										left join noin c on a.biid=c.biid 
										LEFT JOIN waho d ON a.whid=d.whid
										left join olma f on f.soco=a.biid
										LEFT JOIN ltde h ON a.biid=h.oubi
										LEFT JOIN ltma j ON h.biid=j.biid
										LEFT JOIN ptma q ON q.soco=j.biid
										LEFT JOIN pkma k ON k.soco=q.biid
										LEFT JOIN rema m ON m.soco=a.biid
										LEFT JOIN coma n ON a.loco=n.loco
										LEFT JOIN orga o ON o.orid=a.orid
										where 1=1  and a.flag<31 #{unfilledOrderMB.searchSQL}"
										gpage="(pagesize = 20)"
										gcolumn="
													gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
													gcid = biid(headtext = 订单编号,name = biid,width = 130,align = center,type = text,headtype = sort ,datatype = string);
													gcid = loco(headtext = 快递单号,name = loco,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = flag(headtext = 单据状态,name = flag,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = cancle(headtext = 是否取消,name = cancle,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = whfl(headtext = 库存状态,name = whfl,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = whna(headtext = 发货仓库,name = whna,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = sqty(headtext = 总数量,name = sqty,width = 60,align = center,type = text,headtype = sort ,datatype=number,dataformat={0});
													gcid = fsna(headtext = 来源店铺,name = fsna,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = lpco(headtext = 承运商,name = lpco,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = cuna(headtext = 客户名称,name = cuna,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = rena(headtext = 收件人,name = rena,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = reca(headtext = 手机,name = reca,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = reph(headtext = 固话,name = reph,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = prov(headtext = 省份,name = prov,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = orad(headtext = 收件地址,name = orad,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = fhstat(headtext = 是否复核,name = fhstat,width = 70,align = center,type = text,headtype = sort ,datatype = string);
													gcid = crdt(headtext = 下单时间,name = crdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = eddt(headtext = 同步时间,name = eddt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = padt(headtext = 付款时间,name = padt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = bhdt(headtext = 备货任务生成时间,name = bhdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = kddydt(headtext = 快递单打印时间,name = kddydt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = fhdydt(headtext = 发货单打印时间,name = fhdydt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = jhdt(headtext = 拣货完成时间,name = jhdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = fhdt(headtext = 出库复核时间,name = fhdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = czdt(headtext = 称重时间,name = czdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = jjdt(headtext = 快递交接时间,name = jjdt,width = 120,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = chdt(headtext = 审核时间,name = chdt,width = 140,align = center,type = text,headtype = sort ,datatype= datetime,dataformat=yyyy-MM-dd HH:mm);
													gcid = orna(headtext = 组织架构,name = orna,width = 100,align = center,type = text,headtype = sort ,datatype = string);
													gcid = soco(headtext = 来源单号,name = soco,width = 100,align = center,type = text,headtype = sort ,datatype = string);
												" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>

					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{unfilledOrderMB.msg}" />
							<h:inputHidden id="gsql" value="#{unfilledOrderMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{unfilledOrderMB.outPutFileName}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='picksche_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
