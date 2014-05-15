<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.OtherinMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='otherin.js'></script>
	</head>

	<%
		OtherinMB ai = (OtherinMB) MBUtil.getManageBean("#{otherinMB}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		//将箱码数量自动返回
		if (request.getParameter("retqty") != null) {
			ai.setRetqty(request.getParameter("retqty"));
		}
		else {
			ai.setRetqty("");
		}
	%>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{otherinMB.searchBaco}"
							reRender="C01,C02,C03" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="箱码:" />
						<h:inputText id="id" styleClass="inputtextedit" size="42" 
							value="#{otherinMB.sk_boco}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:" />
						<h:inputText id="sk_inco" styleClass="inputtextedit" size="15" 
							value="#{otherinMB.sk_inco}" onkeypress="formsubmit(event);" />	
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id='C01' >
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select b.boco,a.inco,c.inna,a.qty from pvde a left join pvma b on a.biid = b.biid
 								left join inve c on a.inco = c.inco  where b.dety='03' and b.flag = '11' #{otherinMB.bacosql}
								"
								gwidth="550" gpage="(pagesize = 20)" gdebug="true"
								growclick="selectBaco('gcolumn[boco]','gcolumn[qty]');"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = boco(headtext = 箱码,name = boco,width = 220,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{otherinMB.retid}" />
						<h:inputHidden id="retqty" value="#{otherinMB.retqty}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>