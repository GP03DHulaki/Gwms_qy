<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>用户管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="用户管理">
		<script type='text/javascript' src='role.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
	</head>
	<body id=mmain_body>
		<f:view>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<gw:GAjaxButton id="addButton" value="添加用户" theme="b_theme"
							onclick="selectUser();" reRender="output"
							rendered="#{RoleMB.ADD}" />

						<gw:GAjaxButton id="deleteButton" value="删除用户" theme="b_theme"
							action="#{RoleMB.deleteUser}" rendered="#{RoleMB.DEL}"
							onclick="if(!doUserDel(gtable)){return false;}"
							reRender="usgrmsg" oncomplete="endDo2();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="select a.id,a.usid,a.usna,a.crdt,a.dpid,b.dpna,
								case When a.stat = '1' Then '有效' Else '注销' End As stat
								From usin a left join dept b on a.dpid = b.dpid 
								JOIN usgr c ON a.usid=c.usid WHERE c.grid='#{RoleMB.selroleid}'	
							"
							gpage="(pagesize = -1)" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = id,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = usid(headtext = 用户编码,name = usid,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = usna(headtext = 用户姓名,name = usna,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = dpna(headtext = 所属部门,name = dpna,width = 120,headtype = sort,align = left,type = text,datatype=string);
								gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 120,headtype = sort,align = center,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm:ss);
								" />
					</a4j:outputPanel>

					<div style="display: none;">
						<a4j:commandButton id="adduser" action="#{RoleMB.addUser}"
							onclick="Gwallwin.winShowmask('TRUE');" reRender="usgrmsg"
							oncomplete="endDo2();" requestDelay="50"/>
						<h:inputText id="userids" value="#{RoleMB.userids}"/>	
						<h:inputText id="usgrmsg" value="#{RoleMB.msg}"/>	
						<h:inputHidden id="selroleid" value="#{RoleMB.selroleid}" />
					</div>
				</h:form>

			</div>
		</f:view>
	</body>
</html>