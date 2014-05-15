<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.gwall.util.CreateXls" %>

<%
 	//错误页面时
	String errorPage=request.getContextPath()+"/excel/error.jsp";
	
	//导出的内容SQL语句
	String sql="Select Row_number() Over (Order By whna Asc) As 'id',whid,whna,"+
	"Case stat When '1' Then '有效' When '0' Then '注销' End As 'stat',"+
	"chie,tele,addr,rema,pwid From waho";
	
	//列名数组
	String[] colName = {"序列号","库位编码","库位名称","状态","联系人","联系方式","地址","备注","上级编码"};
	
	//要导出的路径及文件名(全)
 	String filepath=application.getRealPath("excel/warehouse.xls");
 	
	try{
       	if(new CreateXls().createWarehouseXls(sql,colName,filepath,"库位页","库位列表")){
        	response.sendRedirect(request.getContextPath()+"/excel/warehouse.xls");	        
       }else{        
        	response.sendRedirect(errorPage);
       	}
    }catch(Exception ex){
    	System.out.println("导出报表时发生错误."+ex.getStackTrace());
    	response.sendRedirect(errorPage);
    }
%>