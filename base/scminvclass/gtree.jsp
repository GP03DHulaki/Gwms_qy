<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.gwall.core.GDatabase"%>
<%@page import="java.util.Vector;"%>

<%
	out.clear();                                       	//清空当前的输出内容（空格和换行符）
    String parentId = request.getParameter("parentId"); //获取要加载的父节点值
    String childId = request.getParameter("childId"); 	//获取要加载的子节点值
	String xmlstring = "";
	Vector v = null;
	
	if (parentId == null){
		parentId = "";
	}else if(parentId.trim().toUpperCase().equals("ROOT")) {
		//parentId="0";
		//   gl  2012-07-31
		parentId="ROOT";
	}
	if (childId == null){
		childId = "";
	}
	
    //创建用于保存xmlTree信息的StringBuffer对象
	StringBuffer xmlTree= new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    xmlstring = "<tree>";		                      //xmlTree根节点为<tree>
	//xmlTree.append("<tree>"); 
	//根据请求的目标节点返回不同的结果
	//isFolder属性标识当前节点是否为目录，true表示目录，false表示普通节点
	//link属性用于设置普通节点的目标链接地址
	//String sql = "SELECT id,inty,'(' + inty + ')' + tyna As tyna,'#' as wind,upty,stat FROM prty " + 
	//	"where type='0' and ((upty =? And ? = '') Or (upty = ? And id = ? Or id = ?))";
	//   gl  2012-07-31
	String sql = "SELECT id,inty,'(' + inty + ')' + tyna As tyna,'#' as wind,upty,stat FROM prty " + 
		"where type='0' and ((upty =? And ? = '') Or (upty = ? And id = ? Or inty = ?))";
    PreparedStatement ps = null;         			//声明PreparedStatement对象
    ResultSet rs = null;  								//声明ResultSet对象
    GDatabase db=null;               
    try {
    	db = new GDatabase();
        ps = db.getPreparedStatement(sql); 			//根据sql创建PreparedStatement
        ps.setString(1,parentId);
        ps.setString(2,childId);
        ps.setString(3,parentId);
        ps.setString(4,childId);
        ps.setString(5,parentId);   
        rs = ps.executeQuery();          			//执行查询，返回结果集     
        while (rs.next()) {                 			//遍历结果集创建item节点
			xmlstring = xmlstring + "<item orid=\"";
			xmlstring = xmlstring + rs.getString("inty");   
			//xmlstring = xmlstring + "\" id = \"" + rs.getString("id") + "\" stat=\"" + rs.getString("stat");
			//   gl  2012-07-31
			xmlstring = xmlstring + "\" id = \"" + rs.getString("inty") + "\" stat=\"" + rs.getString("stat");
			xmlstring = xmlstring + "\" itemtype=\"";
			if (rs.getString("stat").toString().equals("0")){
				xmlstring = xmlstring + "S";
			}else{
				String isSpreadSql="select 1 from prty where upty =?";         
				v = new Vector();
				
				//v.add(rs.getString("id"));
				//  gl  2012-07-31
				v.add(rs.getString("inty"));
				if(db.executeExists(isSpreadSql,v))
					xmlstring = xmlstring + "F";
				else
					xmlstring = xmlstring + "M";
			}
			xmlstring = xmlstring + "\" link=\"";
			xmlstring = xmlstring + rs.getString("tyna");
            xmlstring = xmlstring + "\">";
            xmlstring = xmlstring + rs.getString("tyna");
            xmlstring = xmlstring + "</item>";
        }
    } catch (SQLException e) {
       e.printStackTrace();
    } finally {
		xmlstring = xmlstring + "</tree>";
		xmlTree.append(xmlstring);					//和下一句有什么不同???
		out.print(xmlTree.toString()); 				//输出xmlTree
		if(db!=null){
			db.close();
		}
    }
%>
