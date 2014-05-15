<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.gwall.util.CreateXls" %>

<%
 	//错误页面时
	String errorPage=request.getContextPath()+"/excel/error.jsp";
	
	//导出的内容SQL语句
	String sql="Select Row_number() Over (Order By inco Asc) As 'id',inco,sqty, Case stat When '1' Then '有效' When '0' Then '注销' End As 'stat',rema From insy";
	
	//列名数组
	String[] colName = {"序列号","商品编码","默认数量","状态","备注"};
	
	//要导出的路径及文件名(全)
 	String filepath=application.getRealPath("excel/insy.xls");
 	
	try{
       	if(new CreateXls().createInsyXls(sql,colName,filepath,"商品默认补货数页","详情列表")){
        	response.sendRedirect(request.getContextPath()+"/excel/insy.xls");	        
       }else{        
        	response.sendRedirect(errorPage);
       	}
    }catch(Exception ex){
    	System.out.println("导出报表时发生错误."+ex.getStackTrace());
    	response.sendRedirect(errorPage);
    }
%>