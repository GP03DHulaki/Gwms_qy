<%@ page language="java" pageEncoding="GBK" contentType="application/msexcel" %>

<%    
	//������excel���    
	response.setHeader("Content-disposition","attachment; filename=MyExcel.xls");    
	//Ƕ����ie���excel    
	//response.setHeader("Content-disposition","inline; filename=MyExcel.xls");    
	//Wordֻ��Ҫ��contentType="application/msexcel"��ΪcontentType="application/msword"   
%>  
<html>
<head>

	<title>�ɹ�����EXCEL</title>

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
				<td>����</td>
				<td>ŶŶ</td>
				<td>����</td>
			</tr>
			<tr>
				<td>�ո�</td>
				<td>����</td>
				<td>vv</td>
			</tr>
		</table>
</body>
</html>