<%@ page language="java" pageEncoding="GBK" contentType="application/msexcel" %>

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
		border:5px solid;
		}
</style>
  
<body>
	<table border="1">
			<tr>
				<td>a</td>
				<td>b</td>
				<td>c</td>
			</tr>
			<tr>
				<td>哈哈</td>
				<td>哦哦</td>
				<td>恩恩</td>
			</tr>
			<tr>
				<td>刚刚</td>
				<td>亲亲</td>
				<td>vv</td>
			</tr>
		</table>
</body>
</html>