<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.AbnormalStockMB"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="http://www.gwall.cn" prefix="gw"%>
<%
	AbnormalStockMB ai = (AbnormalStockMB) MBUtil
			.getManageBean("#{abnormalstockMB}");
	if (null != request.getParameter("isAll")) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>异常库存</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="异常库存">
		<meta http-equiv="description" content="异常库存">
		<link href="../../css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gwallwin.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/Gbase.js"></script>
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
			<script type="text/javascript" src="abnormalstock.js"></script>
		<script type="text/javascript">
			function clearSearchKey(){
				$("edit:start_date").value="";
				$("edit:end_date").value="";
				$("edit:inco").value="";
				$("edit:biid").value="";
			}
		</script>
	</head>
	<body id="mmain_body">
		<div id="mmain_nav">
			<FONT color="#000000">库内处理</FONT>&gt;&gt;
			<B>异常库存</B>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{abnormalstockMB.search}" rendered="#{abnormalstockMB.LST}"/>
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey();" rendered="#{abnormalstockMB.LST}"/> 
							
							<a4j:commandButton value="清除异常" id="clearError"
								onmouseover="this.className='a4j_over1'"
								action="#{abnormalstockMB.clearError}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!clearError(gtable)){return false};" rendered="#{abnormalstockMB.SPE}"
								oncomplete="endClearError();" reRender="renderArea,output" />
							<gw:GAjaxButton id="otpDBut" value="导出明细" theme="b_theme"
								onclick="showOutput('gtable','selall')" type="button" 
								reRender="output"/>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm">
						<div id="mmain_cnd">
							单据日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{abnormalstockMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="#{gmanage.datePicker};"
								value="#{abnormalstockMB.sk_end_date}" />
							单号:
							<h:inputText id="biid" styleClass='inputtext' value="#{abnormalstockMB.sk_biid}" ></h:inputText>
						
							商品编码:
							<h:inputText id="inco" styleClass='inputtext' value="#{abnormalstockMB.sk_inco}" ></h:inputText>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="SELECT DISTINCT a.id,b.mona,a.biid,v.inna,v.inse,v.colo,c.mona as formnona,
													a.soco,a.inco,a.whid,a.qty,a.crus,a.crna,a.crdt,d.orna,a.rema  FROM slst a 
													LEFT JOIN modu b ON a.buty=b.moid
													LEFT JOIN modu c ON a.soty=c.moid
													LEFT JOIN orga d ON a.orid=d.orid
													left join inve v on v.inco = a.inco
													WHERE a.stat IN (4,5) and a.#{tranPlanMB.gorgaSql} #{abnormalstockMB.searchSQL}"
										gpage="(pagesize = 27)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = mona(headtext = 单据类型,name = mona,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 单号,name = biid,width = 150,headtype = sort,align = left,type = text,linktype=script,typevalue=move_edit.jsf?pid=gcolumn[biid], datatype=string);
											gcid = formnona(headtext = 来源类型,name = formnona,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext =来源单号,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = whid(headtext =库位,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext =商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = inna(headtext =商品名称,name = inna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = colo(headtext =商品规格,name = colo,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = inse(headtext =商品规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = qty(headtext =数量,name = qty,width = 60,headtype = sort,align = right,type = text,datatype=number,dataformat=0);
											gcid = crna(headtext = 操作人,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 操作时间,name = crdt,width = 120,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = rema(headtext = 授权信息,name = rema,width = 100,headtype = sort,align = left,type = text,datatype=string);
										" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{abnormalstockMB.msg}" />
							<h:inputHidden id="id" value="#{abnormalstockMB.id}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>