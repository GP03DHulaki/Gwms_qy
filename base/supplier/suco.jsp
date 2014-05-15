<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.SupplierMB"%>
<%@page import="com.gwall.pojo.base.SupplierBean"%>


<%
	SupplierMB ai = (SupplierMB) MBUtil.getManageBean("#{supplierMB}");
	if(request.getParameter("isAll") != null){
		ai.initSearchKey(new SupplierBean());		
	}
%>
<html>
	<head>
		<title>供应商色卡信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gsort="suid" gsortmethod="DESC"
							gselectsql="
								select a.inco,a.coid,a.sipr,a.swit,a.puni,a.rate,a.swei,b.colo,c.cono from rici a 
left join colo b on a.coid = b.id
left join cono c on b.skid = c.id
where c.cuid=''
"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							   	gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
								gcid = suid(headtext = 供应商编码,name = suid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = erpc(headtext = 辅助编码,name = erpc,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = suna(headtext = 供应商名称,name = suna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = ceve(headtext = 供应商简称,name = ceve,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = phon(headtext = 联系电话,name = phon,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = adde(headtext = 地址,name = adde,width = 120,headtype = sort,align = left,type = text,datatype=string);
							    gcid = emai(headtext = 电子邮箱,name = emai,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = tyna(headtext = 供应商类型,name = tyna,width = 90,headtype = sort,align = center , type =text , datatype = string);
						     	gcid = cous(headtext = 联系人,name = cous,width = 90,headtype = sort,align = center,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
				</h:form>
			</div>
		</body>
	</f:view>
</html>