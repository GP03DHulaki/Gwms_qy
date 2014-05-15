<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="org.apache.myfaces.custom.tree.DefaultMutableTreeNode"%>
<%@ page import="org.apache.myfaces.custom.tree.model.DefaultTreeModel"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>导入结果</title>
		<base target="_parent" />
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="导入结果">
	</head>
	<%
		if (pageContext
				.getAttribute("treeModel", PageContext.SESSION_SCOPE) == null) {
			DefaultMutableTreeNode root = new DefaultMutableTreeNode("XY");
			DefaultMutableTreeNode a = new DefaultMutableTreeNode("A");
			root.insert(a);
			DefaultMutableTreeNode b = new DefaultMutableTreeNode("B");
			root.insert(b);
			DefaultMutableTreeNode c = new DefaultMutableTreeNode("C");
			root.insert(c);

			DefaultMutableTreeNode node = new DefaultMutableTreeNode("a1");
			a.insert(node);
			node = new DefaultMutableTreeNode("a2 ");
			a.insert(node);
			node = new DefaultMutableTreeNode("b ");
			b.insert(node);

			a = node;
			node = new DefaultMutableTreeNode("x1");
			a.insert(node);
			node = new DefaultMutableTreeNode("x2");
			a.insert(node);

			pageContext.setAttribute("treeModel",
					new DefaultTreeModel(root), PageContext.SESSION_SCOPE);
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form>
					<t:tree id="tree" value="#{treeModel}" styleClass="tree"
						nodeClass="treenode" selectedNodeClass="treenodeSelected"
						expandRoot="true">
					</t:tree>

					<t:inputCalendar monthYearRowClass="yearMonthHeader"
						weekRowClass="weekHeader" currentDayCellClass="currentDayCell"
						value="" renderAsPopup="true" 
						renderPopupButtonAsImage="true" />
					<h:commandButton value="test" />
					<h:inputText id="email2" value=""
						required="true">
						<t:validateEmail />
					</h:inputText>
				</h:form>
			</f:view>
		</div>


	</body>
</html>