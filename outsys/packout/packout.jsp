<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PackOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	PackOutMB ai = (PackOutMB) MBUtil
			.getManageBean("#{packOutMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>拆包</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="拆包">
		<script type="text/javascript" src="packout.js"></script>
	</head>



	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">出库处理&gt;&gt;</font><b>拆包</b>
			<br>
		</div>
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" rendered="#{packOutMB.ADD}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据"
							onclick="if(!doDeleteAll(gtable)){return false};"
							action="#{packOutMB.deleteHead}"
							reRender="output,renderArea,msg" oncomplete="endDeleteHeadAll();"
							requestDelay="50" rendered="#{packOutMB.DEL}" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" onclick="startDo();"
							action="#{packOutMB.search}"
							oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
							rendered="#{packOutMB.LST}" />
						<a4j:commandButton value="重置" onclick="clearSearchKey('0');"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<a4j:outputPanel id="queryForm">
						<div id=mmain_cnd>
							创建日期从:
							<h:inputText id="start_date" styleClass="datetime" size="12"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{packOutMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="12"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{packOutMB.sk_end_date}" />
							拆包单号:
							<h:inputText id="sk_voucherid" styleClass="inputtext" size="16"
								onkeypress="formsubmit(event);"
								value="#{packOutMB.sk_obj.biid}" />
							来源单号:
							<h:inputText id="sk_fomvoucherid" styleClass="inputtext"
								size="16" onkeypress="formsubmit(event);"
								value="#{packOutMB.sk_obj.soco}" />
							状态:
							<h:selectOneMenu id="sk_flag"
								value="#{packOutMB.sk_obj.flag}" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="制作之中" itemValue="01" />
								<f:selectItem itemLabel="正式单据" itemValue="11" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="SELECT a.id,a.biid,a.soty,a.soco,a.orid,a.crna,a.crdt,a.chna,a.chdt,a.flag,a.stat,a.rema,c.orna
										FROM poma a LEFT JOIN orga c ON a.orid=c.orid  where 1=1  
										#{packOutMB.searchSQL}"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 隐藏单号,name = biids,width = 60,headtype = hidden,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 拆单单号 ,name = biid,width = 120,headtype = sort,align = left,type = link,datatype=string,linktype = script,typevalue =packout_edit.jsf?pid=gcolumn[biid]);
											gcid = soty(headtext = 来源类型 ,name = soty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=OUTORDER:销售订单);
											gcid = soco(headtext = 来源单号 ,name = soco,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 创建人,name = nv_creatorname,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 创建时间,name = dt_createdate,width = 120,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = chna(headtext = 审核人,name = chna,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核时间,name = chdt,width = 100,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = flag(headtext = 状态,name=flag,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=01:制作之中/11:正式单据/100:已关闭);
											gcid = rema(headtext = 备注,name=nv_remark,width = 155,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{packOutMB.msg}" />
							<h:inputHidden id="item" value="#{packOutMB.sellist}" />
						</a4j:outputPanel>
						<a4j:commandButton id="editbut" value="隐藏的编辑按钮"
							onclick="startDo();"
							oncomplete="javascript:window.location.href='packout_edit.jsf'"
							style="display:none;" />
					</div>
				</h:form>

			</f:view>
		</div>
	</body>
</html>