<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.stockin.NoticeOfArriveMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>到货通知单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="到货通知单">
		<meta http-equiv="description" content="到货通知单">
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwalldate.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="noticeofarrive.js"></script>

	</head>
	<%
	    NoticeOfArriveMB ai = (NoticeOfArriveMB) MBUtil
	            .getManageBean("#{noticeOfArriveMB}");
	    if (null != request.getParameter("isAll")) {
	        ai.initSK();
	    }
	%>

	<body id="mmain_body" onload="clearData();">
		<f:view>
			<div id="mmain_nav">
				<font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>到货通知单</b>
				<br>
			</div>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="addNew();return true" rendered="#{noticeOfArriveMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll(gtable)){return false};"
							rendered="#{noticeOfArriveMB.DEL}" reRender="output,renderArea"
							action="#{noticeOfArriveMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							value="查询" type="button" reRender="output" id="sid"
							onclick="startDo()" oncomplete="endLoad()"
							action="#{noticeOfArriveMB.search}" requestDelay="50"
							rendered="#{noticeOfArriveMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="clearData();" rendered="#{noticeOfArriveMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							rendered="#{noticeOfArriveMB.EXP}"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id="mmain_cnd">
						<table>
							<tr>
								<td>
									<h:outputText value="制单日期从:"></h:outputText>
									<h:inputText id="sk_start_date" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_start_date}"
										onfocus="#{gmanage.datePicker}" />
									<h:outputText value="至:">
									</h:outputText>
									<h:inputText id="sk_end_date" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_end_date}"
										onfocus="#{gmanage.datePicker}" />
								</td>
								<td>
									<h:outputText value="通知单号:" />
									<h:inputText id="sk_biid" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_obj.biid}"
										onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="来源单号:" />
									<h:inputText id="sk_soco" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_poid}"
										onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="商品编码:" />
									<h:inputText id="sk_inco" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_inco}"
										onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="单据状态:" />
									<h:selectOneMenu id="sk_flag"
										value="#{noticeOfArriveMB.sk_obj.flag}" onchange="doSearch();">
										<f:selectItem itemLabel="全部" itemValue="00" />
										<f:selectItems value="#{noticeOfArriveMB.flags}" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="质检状态:" />
									<h:selectOneMenu id="sk_flag2"
										value="#{noticeOfArriveMB.sk_obj.flag2}"
										onchange="doSearch();">
										<f:selectItem itemLabel="全部" itemValue="00" />
										<f:selectItems value="#{noticeOfArriveMB.flag2}" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="入库状态:" />
									<h:selectOneMenu id="sk_flag3"
										value="#{noticeOfArriveMB.sk_obj.flag3}"
										onchange="doSearch();">
										<f:selectItem itemLabel="全部" itemValue="00" />
										<f:selectItems value="#{noticeOfArriveMB.flag3}" />
									</h:selectOneMenu>
									<h:outputText value="商品名称:"></h:outputText>
									<h:inputText id="sk_inna" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_inna}"
										onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="供应商名:" />
									<h:inputText id="sk_suna" styleClass="datetime" size="15"
										value="#{noticeOfArriveMB.sk_obj.ceve}"
										onkeypress="formsubmit(event);" />
								</td>
							</tr>
						</table>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT distinct a.id,a.biid,a.buty,a.dety,a.flag,a.flag2,a.flag3,a.owid,
										a.crus,a.soty,a.soco,b.suna,a.crna,a.crdt,a.chus,a.chna,a.chdt,a.opna,a.stdt,a.rema,a.refl,a.isch,a.ispa,a.indt,
										case when DATEDIFF(day,a.indt,isnull(a.stdt,GETDATE()))>0 then DATEDIFF(day,a.indt,isnull(a.stdt,GETDATE())) else 0 end as exdt,a.whid
										FROM nofm a LEFT join suin b on a.suid=b.suid left join nofd c on a.biid=c.biid
										left JOIN inve d ON c.inco=d.inco where 1=1 #{noticeOfArriveMB.searchSQL }				
										 "
							gpage="(pagesize = 25)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 单据编号 ,name = biids,width = 100,headtype = hidden , align = left ,datatype = string);
								gcid = biid(headtext = 到货通知单 ,name = biid,width = 110,headtype = sort , align = left ,type = link,linktype=script,typevalue=noticeofarrive_edit.jsf?pid=gcolumn[biid],datatype = string);
								gcid = suna(headtext = 供应商,name = suna,width = 200,align = left,type = text,headtype = sort,datatype = string);
								gcid = owid(headtext = 货主,name = owid,width = 200,align = left,type = text,headtype = sort,datatype = string);
								gcid = indt(headtext = 预计到货日期,name = indt,width = 80,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
								gcid = exdt(headtext = 逾期天数,name = exdt,width =60,align = center,type = text,headtype = sort,datatype = string,bgcolor={gcolumn[exdt]=1:#00ff00/gcolumn[exdt]=2:#00ffff/gcolumn[exdt]=3:#0000ff/gcolumn[exdt]=4:#ffff00/gcolumn[exdt]=5:#ffooff/gcolumn[exdt]=6:#ff8800/gcolumn[exdt]=7:#ff0000});
								gcid = isch(headtext = 是否质检,name = isch,width = 60,align = center,type = mask,typevalue=0:否/1:是,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作之中/11:确认通知/21:已拒收/41:确认到货/51:清点中/61:清点完成/99:已关闭,headtype = sort,datatype = string);						
								gcid = flag2(headtext = 质检状态,name = flag,width = 60,align = center,type = mask,typevalue=00:初始值/01:待质检/02:质检中/31:质检完成,headtype = sort,datatype = string);						
								gcid = flag3(headtext = 入库状态,name = flag,width = 60,align = center,type = mask,typevalue=00:初始值/01:待入库/02:入库中/21:入库完成,headtype = sort,datatype = string);						
								gcid = whid(headtext = 仓库,name = whid,width = 90,headtype = hidden , align = left ,datatype = string);
								gcid = crna(headtext = 制单人,name = chna,width = 90,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 制单时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = chna(headtext = 审核人,name = chna,width = 90,align = left,type = text,headtype = hidden,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = hidden,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 180,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{noticeOfArriveMB.msg}" />
							<h:inputHidden id="sellist" value="#{noticeOfArriveMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>