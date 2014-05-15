<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.core.GDatabase"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="com.gwall.dao.impl.base.PrtyTreeImpl"%>
<%
String id = request.getParameter("id"); 
String value = request.getParameter("value");
String names = request.getParameter("names");
if(names!=null){
	names = new String(names.getBytes("iso-8859-1"),"gbk");
}
StringBuffer sb = new StringBuffer();
if(id==null||id.length()<=0||id.equals("ROOT")) {
	id="ROOT";
	sb.append("[{data:");
}
response.setContentType("application/json");
//json object ：id,label,value,open,select,show,link,url,children
out.clear();
PrtyTreeImpl tree = new PrtyTreeImpl();

List<PrtyTreeImpl.TreeObj> ls = tree.getScmList(id,value,names);

sb.append("[");
for(int i=0,j=ls.size();i<j;i++) {
	sb.append("{");
	sb.append("id:'"+ls.get(i).getId()+"',");
	sb.append("lable:'"+ls.get(i).getLabel()+"',");
	sb.append("url:'"+ls.get(i).getUrl()+"',");
	sb.append("value:'"+ls.get(i).getView()+"',");
	sb.append("names:'"+ls.get(i).getNames()+"',");
	sb.append("bsul:'"+ls.get(i).getBsul()+"',");
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

if(id.equals("ROOT")) {
	sb.append("}]");
}
System.out.println(sb.toString());
out.print(sb.toString());


%>