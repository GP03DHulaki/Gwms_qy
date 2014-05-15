<%@ page language="java" pageEncoding="UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<jsp:directive.page import="com.gwall.view.LogsMB" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    FacesContext context = FacesContext.getCurrentInstance();
    ValueBinding binding = context.getApplication().createValueBinding(
            "#{LogsMB}");
    LogsMB ai = (LogsMB) binding.getValue(context);
%>

<html>
	<head>
		<title>用户管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="用户管理">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script src="<%=request.getContextPath()%>/gwall/all.js"></script>
		<script src="logs.js"></script>
	</head>

	<body onload="doInit();" id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_nav>
					</div>
					<div id=mmain_opt>
						<h:panelGroup id="sp" rendered="#{logsMB.LST}">
							<a4j:commandButton id="searchButton" value="查询" type="button"
								action="#{logsMB.searchAll}"
								onclick="if(doSearch()==false){return false;}" reRender="output"
								oncomplete="endDo();" requestDelay="50"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
							<a4j:commandButton id="resetButton" value="重置" type="button"
								onclick="if(doClearData()==false){return false;}"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						</h:panelGroup>
						<a4j:commandButton id="deleteButton" value="删除" type="button"
							action="#{logsMB.delete}" rendered="#{logsMB.DEL}"
							onclick="if(doDel(gtable1)==false){return false;}"
							reRender="msg,output" oncomplete="endDel();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<h:panelGroup id="sps" rendered="#{logsMB.LST}">
						<div id=mmain_cnd>
							<b>事件时间:</b>
							<h:inputText id="startDate" value="#{logsMB.startDate}"
								styleClass="inputtextedit" size="10"
								onfocus="#{gmanage.datePicker};" />
							－
							<h:inputText id="endDate" value="#{logsMB.endDate}"
								styleClass="inputtextedit" size="10"
								onfocus="#{gmanage.datePicker};" />
							&nbsp;
							<b>模块名称:</b>
							<h:inputText id="module" value="#{logsMB.vc_module}"
								styleClass="inputtextedit" />
							&nbsp;
							<b>事件类型:</b>
							<h:inputText id="sk_loty" value="#{logsMB.sk_loty}"
								styleClass="inputtextedit" />
							&nbsp;
							<b>级别:</b>
							<h:selectOneMenu id="eventLevel" value="#{logsMB.in_eventRank}"
								styleClass="inputtext">
								<f:selectItem itemValue="100" itemLabel="--请选择--" />
								<f:selectItem itemValue="0" itemLabel="普通" />
								<f:selectItem itemValue="1" itemLabel="异常" />
								<f:selectItem itemValue="2" itemLabel="严重" />
								<f:selectItem itemValue="3" itemLabel="特别严重" />
							</h:selectOneMenu>
							<br />
							<b>机器:</b>
							<h:inputText id="computer"
								value="#{logsMB.vc_eventHappenComputer}"
								styleClass="inputtextedit" />
							&nbsp;
							<b>事件描述:</b>
							<h:inputText id="eventDetail" value="#{logsMB.vc_eventDetail}"
								styleClass="inputtextedit" />
							<h:panelGroup id="userpanel" rendered="#{logsMB.SCH}">
								<b>用户编码:</b>
								<h:inputText id="userId" value="#{logsMB.userId}"
									styleClass="inputtextedit" />
							</h:panelGroup>
						</div>
					</h:panelGroup>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable1" gtype="grid" gsort="loda"
							gsortmethod="Desc" gversion="2"
							gselectsql="Select a.id,a.loty,a.loda,a.moid,c.mona,
										Case lora When 0 Then '普通' When 1 Then '异常' When 2 Then '严重' When 3 Then '特别严重' End As lora,
										loev,lous,b.usna,a.comp From logs As a 
										Left Join usin As b On b.usid = a.lous And ((a.lous='#{logsMB.userId}' And upper('#{logsMB.SCH}') != 'TRUE') Or ( upper('#{logsMB.SCH}') = 'TRUE') ) 
										Left Join modu As c On c.moid = a.moid #{logsMB.sql} 
										"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
										gcid = lous(headtext = 用户编码,name = lous,width = 50,headtype = text,align = left,type = text,datatype=string);
										gcid = usna(headtext = 用户姓名,name = usna,width = 70,headtype = text,align = left,type = text,datatype=string);
										gcid = loty(headtext = 事件类型,name = loty,width = 70,headtype = text,align = left,type = text,datatype=string);
										gcid = loev(headtext = 事件描述,name = loev,width = 230,headtype = text,align = left,type = text,datatype=string);
										gcid = loda(headtext = 记录时间,name = loda,width = 125,headtype = text,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm:ss);
										gcid = mona(headtext = 模块名称,name = mona,width = 90,headtype = text,align = left,type = text,datatype=string);
										gcid = lora(headtext = 级别,name = lora,width = 30,headtype = text,align = center,type = text,datatype=string);
										gcid = comp(headtext = 触发机器,name = comp,width = 120,headtype = text,align = left,type = text,datatype=string);
										" />
						<h:inputHidden id="msg" value="#{logsMB.msg}" />
						<h:inputHidden id="sellist" value="#{logsMB.sellist}" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>