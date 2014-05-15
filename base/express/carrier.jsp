<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.CarrierMB"%>
<%@page import="com.gwall.pojo.base.CarrierBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
	CarrierMB ai = (CarrierMB) MBUtil.getManageBean("#{carrierMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new CarrierBean());
	}
	if (request.getParameter("retid") != null) {
		ai.setRetid(request.getParameter("retid"));
	}
	if (request.getParameter("retname") != null) {
		ai.setRetname(request.getParameter("retname"));
	}
%>
<html>
	<head>
		<title>物流商档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="express.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<h:panelGroup id="sp" rendered="#{carrierMB.LST}">
							<a4j:commandButton id="query" value="查询" 
								action="#{carrierMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData1();" reRender="out_List" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						物流商编码:
						<h:inputText id="sk_lpco" value="#{carrierMB.sk_obj.lpco}"
							styleClass="inputtextedit" />
						物流商名称:
						<h:inputText id="sk_lpna" value="#{carrierMB.sk_obj.lpna}"
							styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select lpco,id,rena,reph,stat,prst,rema,lpna From lpin 
								Where 1=1 and prst='1' #{carrierMB.searchSQL}"
							gpage="(pagesize = 18)" 
							growclick="selectThis('gcolumn[lpco]','gcolumn[lpna]')"
							gcolumn=" gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = lpco(headtext = 物流商编码,name = lpco,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lpna(headtext = 物流商名称,name = lpna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = rena(headtext = 联系人,name = rena,width = 60,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = reph(headtext = 联系电话,name = reph,width = 80,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 40,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{carrierMB.retid}" />
						<h:inputHidden id="retname" value="#{carrierMB.retname}" />
					</div>
				</h:form>
				
			</div>
			
		</body>
	</f:view>
</html>