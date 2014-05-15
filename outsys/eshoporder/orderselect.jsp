<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.common.OrderSelectCOM"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库订单信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='eshoporder.js'></script>
	</head>

	<%
		OrderSelectCOM ai = (OrderSelectCOM) MBUtil.getManageBean("#{orderSelectCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}if(ai.getBiid()!=null){
			ai.setBiid("");
		}
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{orderSelectCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="出库订单:">
						</h:outputText>
						<h:inputText id="biid" styleClass="inputtextedit" size="15"
							value="#{orderSelectCOM.biid}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.waid,a.biid,b.whna from obma a left join waho b on a.waid = b.whid
									where 1=1 #{orderSelectCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 50,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 订单号,name = inco,width = 400,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{orderSelectCOM.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>