<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<jsp:directive.page import="com.gwall.util.ReportPrintImp"/>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="gwall">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <body>
    <body>
   	<%	   	
   			 Map map = new HashMap();
   			 if(request.getParameter("nv_voucherid").equals("")){
   				map.put("voucherid","%%");
   			 }else{
   			 	map.put("voucherid",request.getParameter("nv_voucherid"));
   			 	System.out.println(request.getParameter("nv_voucherid"));
   			 }
   			
   			
   
     String fileName ="/jasper/arriveReport.jasper";
	 String pathName="arriveReport.pdf";
     ReportPrintImp.makeReport(application,request,response,map,fileName,pathName);
     response.sendRedirect("../../pdf/" + pathName);
        %>
  </body>
</html>
