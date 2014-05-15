<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.common.TranCOM"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	TranCOM ai = (TranCOM) MBUtil.getManageBean("#{tranCOM}");
	if (request.getParameter("retvid") != null) {
		ai.setRetvid(request.getParameter("retvid"));
	}
	if (request.getParameter("retpfid") != null) {
		ai.setRetpfid(request.getParameter("retpfid"));
	}

	if (request.getParameter("retpoid") != null) {
		ai.setRetpoid(request.getParameter("retpoid"));
	}

	if (request.getParameter("flag") != null) {
		ai.setFlag(request.getParameter("flag"));
	}

	if (request.getParameter("type") != null) {
		ai.setType(request.getParameter("type"));
	}
	if (request.getParameter("time") != null) {
		ai.initFrom();
	}
%>
<html>
	<head>
		<base target="search" />
		<title>选择来源单号</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='tran_sel.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{tranCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="#{tranCOM.tname}:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{tranCOM.id}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.biid,a.orid,a.pfwh,a.powh,b.whna AS fwna,c.whna AS owna 
									FROM #{tranCOM.table} a left join waho b on a.pfwh=b.whid
									Left join waho c on a.powh = c.whid
									where c.#{traninMB.gorgaSql}
									and (#{tranCOM.conSql} #{tranCOM.sql}) "
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectThis('gcolumn[biid]','gcolumn[pfwh]','gcolumn[powh]','gcolumn[fwna]','gcolumn[owna]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = #{tranCOM.tname},name = biid,width = 220,headtype = sort,align = left,type = text,datatype=string);
									gcid = fwna(headtext = 出库仓库,name = fwna,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = owna(headtext = 入库仓库,name = owna,width = 100,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retvid" value="#{tranCOM.retvid}" />
						<h:inputHidden id="retpfid" value="#{tranCOM.retpfid}" />
						<h:inputHidden id="retpoid" value="#{tranCOM.retpoid}" />
						<h:inputHidden id="flag" value="#{tranCOM.flag}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>