<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.InTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>入库任务列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="检验单">
		<script type="text/javascript" src="instask.js"></script>
	</head>
	
	<%
		InTaskMB ai = (InTaskMB) MBUtil.getManageBean("#{inTaskMB}");
	    if (null != request.getParameter("isAll")) {
	        ai.initSK();
	    }
	%>

	<body id="mmain_body" onload="textClear('list','biid,crna,flag','N');">
		<div id=mmain_nav>
			<font color="#000000">入库任务列表</font>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{inTaskMB.search}" type="button" reRender="output"
							requestDelay="50" rendered="#{inTaskMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" rendered="#{inTaskMB.LST}" />

						<a4j:commandButton id="btnsum" value="合并任务单"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{inTaskMB.mergerInTask}" type="button"
							reRender="output,msg" requestDelay="50"
							onclick="if(!sk_meger('gtable')){return false;}"
							oncomplete="end_meger();" />

						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<div>
							单据单号:
							<h:inputText id="biid" styleClass="inputtext" size="12"
								value="#{inTaskMB.sk_biid}" onkeypress="formsubmit(event);" />
							来源单号:
							<h:inputText id="soco" styleClass="inputtext" size="12"
								value="#{inTaskMB.soco}" onkeypress="formsubmit(event);" />
							创建人:
							<h:inputText id="crna" styleClass="inputtext" size="12"
								value="#{inTaskMB.crna}" onkeypress="formsubmit(event);" />
							单据状态:
							<h:selectOneMenu id="flag" value="#{inTaskMB.flag}">
								<f:selectItem itemLabel="---全部---" itemValue="" />
								<f:selectItems value="#{inTaskMB.flags}" />
								<a4j:support event="onchange"
									onsubmit="Gwallwin.winShowmask('TRUE');"
									action="#{inTaskMB.search}"
									oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"></a4j:support>
							</h:selectOneMenu>
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gversion="2" gtype="grid"
							gselectsql="
							Select a.id,a.biid,a.roid,a.soty,a.soco,a.inco,a.qty,a.fqty,a.crus,a.crdt,a.crna,a.orid,a.stat,a.rema,a.bity,b.inna From inpk a 
							  join inve b on a.inco = b.inco Where 1 = 1 #{inTaskMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="
							gcid = biid(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 单据单号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = soty(headtext = 来源类型,name = soty,width = 80,headtype = sort,align = left,type = mask,datatype=string,typevalue=NoticeOfArrive:到货通知单);
							gcid = soco(headtext = 来源单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inco(headtext = 商品编码,name = inna,width = 120,align = left,type = text,headtype = sort,datatype=string);
							gcid = inna(headtext = 商品名称,name = inna,width = 110,align = left,type = text,headtype = sort,datatype=string);
							gcid = qty(headtext = 数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = fqty(headtext = 完成数量,name = cqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = crdt(headtext = 创建日期,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = crna(headtext = 创建人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype=string);
							gcid = stat(headtext = 状态,name = stat,width = 60,headtype = sort,align = center,type = mask,datatype=string,typevalue=0:初始化/1:入库中/2:入库完成/6:已关闭);
							gcid = bity(headtext = 是否残品,name = bity,width = 80,headtype = sort,align = left,type = mask,typevalue=0:是/1:否,datatype=string);
							gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>

					<a4j:outputPanel id="render">
						<h:inputHidden id="msg" value="#{inTaskMB.msg}" />
						<h:inputHidden id="sellist" value="#{inTaskMB.sellist}" />
						<h:inputHidden id="hiddenBiid" value="#{inTaskMB.biid}" />
						<a4j:commandButton id="editbut"
							oncomplete="javascript:window.location.href='intask_edit.jsf'"
							style="display:none;" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
