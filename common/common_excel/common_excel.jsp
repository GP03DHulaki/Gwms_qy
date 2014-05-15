<%@ page language="java" pageEncoding="utf-8" contentType="application/vnd.ms-excel"%>
<%response.setHeader("Content-disposition","filename=excel.xls"); %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>导出excel</title>
<style type="text/css">
/* 透明表格 */
table.transparent,table.transparent td
{
	border:none;
}
table ,table td,table th
{
	border:solid .5pt #000000;
}
table thead tr
{
	text-align:center;
}
</style>
</head>
<%=request.getParameter("excelContent")%>
</html>