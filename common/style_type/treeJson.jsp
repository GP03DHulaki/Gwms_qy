<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.core.GDatabase"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="com.gwall.dao.impl.base.PrtyTreeImpl"%>
<%
String id = request.getParameter("id"); 
String value = request.getParameter("value");
StringBuffer sb = new StringBuffer();
if(id==null||id.length()<=0||id.equals("ROOT")) {
	id="0";
	sb.append("[{data:");
}
response.setContentType("application/json");
//json object ：id,label,value,open,select,show,link,url,children
out.clear();
PrtyTreeImpl tree = new PrtyTreeImpl();

List<PrtyTreeImpl.TreeObj> ls = tree.getList(id,value);

sb.append("[");
for(int i=0,j=ls.size();i<j;i++) {
	sb.append("{");
	sb.append("id:'"+ls.get(i).getId()+"',");
	sb.append("lable:'"+ls.get(i).getLabel()+"',");
	sb.append("url:'"+ls.get(i).getUrl()+"',");
	sb.append("value:'"+ls.get(i).getView()+"',");
	if(ls.get(i).isFolder()){
	sb.append("children:'[]'");
	}else {
		if(sb.length()>0)
		    sb.setLength(sb.length()-1);
	}
	sb.append("},");
}
if(sb.length()>0)
    sb.setLength(sb.length()-1);
sb.append("]");

if(id.equals("0")) {
	sb.append("}]");
}
	
System.out.println(sb.toString());
out.print(sb.toString());


%>