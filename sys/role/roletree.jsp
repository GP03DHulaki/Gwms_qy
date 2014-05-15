<%@ page contentType="text/xml; charset=UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.gwall.core.GDatabase"%>

<%
	out.clear();                                        	//清空当前的输出内容（空格和换行符）

    String parentId = request.getParameter("parentId"); 	//获取要加载的节点编号
    String roleid = request.getParameter("roleid");			//角色序号编码 int

    String sXML = "<tree>";
    //创建用于保存xmlTree信息的StringBuffer对象
    StringBuffer xmlTree= new StringBuffer("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    
    if (roleid.equals("")){
    	roleid = "0";
    }
 	String sql=" select moid ,mona,moty,wind,pmid,rope,sort from f_getmodulewithrole('G','" + roleid + "','') Where pmid='"+parentId+"' order by sort,moid";

    PreparedStatement pstmt = null;        				//声明PreparedStatement对象
    ResultSet rs = null;  				   				//声明ResultSet对象
    GDatabase db=null;               
    try {
   	    db = new GDatabase();

	    pstmt = db.getPreparedStatement(sql); 			//根据sql创建PreparedStatement
        rs = pstmt.executeQuery();				        //执行查询，返回结果      
        while (rs.next()) {                 			//遍历结果集创建item节点
			sXML = sXML + "<item id=\"" + rs.getString("moid") + "\" ";     

			sXML = sXML + "moduletype=\"" + rs.getString("moty") + "\" ";        

            String link = rs.getString("wind");
            //当link字段数据存在时才加入link属性信息

            if (link != null && !"".equals(link)) {
            	sXML = sXML + "link=\"" + link + "\" ";
            }
            sXML = sXML + "flag=\"" + rs.getString("rope") + "\"";
            sXML = sXML + ">";
            sXML = sXML + rs.getString("mona");
            sXML = sXML + "</item>";
        }
    } catch (SQLException e) {
        System.out.println(e.toString());
    } finally {
	    sXML = sXML + "</tree>";
	    xmlTree.append(sXML);								//xmlTree根节点的结束标签
		out.print(xmlTree.toString()); 						//输出xmlTree
		if(db!=null){
			db.close();
		}
    }

%>