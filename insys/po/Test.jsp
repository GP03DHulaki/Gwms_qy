<%@ page language="java" pageEncoding="UTF-8" contentType="application/msexcel" %>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%    
	//独立打开excel软件    
	response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");    
	//嵌套在ie里打开excel    
	//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");    
	//Word只需要把contentType="application/msexcel"改为contentType="application/msword"   
%>  
<html>
<head>
	<title>采购订单EXCEL</title>
</head>
<style>
	table{
		border:1px solid;
		}
</style>

<body>
	<f:view>
		<g:GTable gid="gtable" gtype="grid"
			gselectsql="SELECT a.id,a.biid,a.suid,b.ceve,a.indt,a.flag,a.stat,a.buty,a.chna,a.chdt,
						a.opna,a.pudt,a.whid,a.orid,a.rema FROM pubm a join suin b ON a.suid = b.suid 
						WHERE 1 = 1 "
			gpage="(pagesize = -1)" gversion="2" gdebug = "false"
			gcolumn="
				gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
				gcid = orid(headtext = 组织架构,name = orid,width = 121,align = left,type = text,headtype = text,datatype = string);
				gcid = biid(headtext = 采购订单号,name = biids,width = 121,align = left,type = text,headtype = text,datatype = string);
				gcid = ceve(headtext = 供应商名称,name = ceve,width = 121,align = left,type = text,headtype = text,datatype = string);
				gcid = opna(headtext = 采购人,name = opna,width = 111,align = left,type = text,headtype = text,datatype = string);
				gcid = buty(headtext = 采购类型,name = buty,width = 81,align = center,type = mask,headtype = text,datatype = string,typevalue=01:自采/02:代采);
				gcid = pudt(headtext = 采购时间,name = pudt,width = 111,align = left,type = text,headtype = text,datatype=datetime,dataformat=yyyy-MM-dd);
				gcid = chna(headtext = 审核人,name = chna,width = 111,align = left,type = text,headtype = text,datatype = string);
				gcid = flag(headtext = 状态,name = flag,width = 81,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = text,datatype = string);
				gcid = chdt(headtext = 审核时间,name = chdt,width = 111,align = left,type = text,headtype = text,datatype=datetime,dataformat=yyyy-MM-dd);
				gcid = rema(headtext = 备注,name = rema,width = 131,align = left,type = text,headtype = text,datatype = string);
			" />
	</f:view>
</body>
</html>