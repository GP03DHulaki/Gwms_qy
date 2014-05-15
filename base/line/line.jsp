<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.LineMB"%>
<%@page import="com.gwall.pojo.base.LineBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
	LineMB ai = (LineMB) MBUtil.getManageBean("#{lineMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new LineBean());
	}
%>
<html>
	<head>
		<title>路线档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="line.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" rendered="#{lineMB.ADD}"
							styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{lineMB.delete}" rendered="#{lineMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{lineMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{lineMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						路线编码:
						<h:inputText id="lico" value="#{lineMB.sk_obj.lico}"
							styleClass="inputtextedit" />
						路线名称:
						<h:inputText id="lina" value="#{lineMB.sk_obj.lina}"
							styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select id,lico,lina,stat,rema From liin
								Where 1=1 #{lineMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = lico(headtext = 路线编码,name = lico,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lina(headtext = 路线名称,name = lina,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{lineMB.sellist}" />
						<h:inputHidden id="msg" value="#{lineMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{lineMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{lineMB.selid}" />
						<h:inputHidden id="updateflag" value="#{lineMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									路线编码：
								</td>
								<td>
									<h:inputText id="lico" value="#{lineMB.bean.lico}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									路线名称：
								</td>
								<td>
									<h:inputText id="lina" value="#{lineMB.bean.lina}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{lineMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>	
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="rema" value="#{lineMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{lineMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{lineMB.MOD}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>

					</a4j:outputPanel>
				</h:form>

			</div>
		</body>
	</f:view>
</html>