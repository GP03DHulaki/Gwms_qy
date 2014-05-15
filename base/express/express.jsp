<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.ExpressMB"%>
<%@page import="com.gwall.pojo.base.ExpressBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	ExpressMB ai = (ExpressMB) MBUtil.getManageBean("#{expressMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new ExpressBean());
	}
%>
<html>
	<head>
		<title>快递单号</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="express.js"></script>
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
							onmouseout="this.className='a4j_buton'"
							rendered="#{expressMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{expressMB.delete}" rendered="#{expressMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{expressMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{expressMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" onclick="startDo();"
								oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
						<a4j:commandButton id="inButton" value="导入execl"
							rendered="#{warehouseMB.EXP}"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="showImport();" requestDelay="50" />
						<a4j:commandButton id="expressstate" value="物流单号状态"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="showRxpressResultList();"
							 requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						物流商编码:
						<h:inputText id="sk_lpco" value="#{expressMB.sk_obj.lpco}"
							styleClass="inputtextedit" />
						快递单号:
						<h:inputText id="sk_exco" value="#{expressMB.sk_obj.exco}"
							styleClass="inputtextedit" />
						快递单号:
						<h:selectOneMenu id="sk_stat" value="#{expressMB.stat}" rendered="true" >
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="有效" itemValue="1" />
								<f:selectItem itemLabel="注销" itemValue="0" />
							</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gselectsql="Select a.id,a.lpco,b.lpna,a.exco,a.stat From expr a
							join lpin b on a.lpco = b.lpco
								Where 1=1 #{expressMB.searchSQL}"
							gpage="(pagesize = 18)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = lpco(headtext = 物流商编码,name = lpco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							    gcid = lpna(headtext = 物流商名称,name = lpna,width = 100,headtype = sort,align = left,type = text,datatype=string);
							    gcid = exco(headtext = 快递单号,name = exco,width = 140,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 40,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{expressMB.sellist}" />
						<h:inputHidden id="msg" value="#{expressMB.msg}" />
						<h:inputHidden id="lpco" value="#{expressMB.bean.lpco}" />
						<a4j:commandButton id="hidBut" style="display:none;"
							oncomplete="iframe_linedetail.window.location.reload();" />
					</a4j:outputPanel>
				</h:form>
			</div>
			<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
						物流商编码:
						<h:inputText id="lpna" value="#{expressMB.bean.lpna}"
						styleClass="inputtextedit" />
					<h:inputHidden id="lpco" value="#{expressMB.bean.lpco}"></h:inputHidden>
					<img id="tyna_img" style="cursor: pointer"
						src="../../images/find.gif" onclick="selectSK_lpco();" />
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{expressMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv1()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{expressMB.uploadFileExco}" />
					</div>
				</h:form>
			</div>
			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{expressMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{expressMB.selid}" />
						<h:inputHidden id="updateflag" value="#{expressMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									物流商：
								</td>
								<td>
									<h:inputText id="lpna" value="#{expressMB.bean.lpna}"
										styleClass="inputtextedit" />
									<h:inputHidden id="lpco" value="#{expressMB.bean.lpco}"></h:inputHidden>
									<img id="tyna_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="select_lpco();" />
								</td>
								<td bgcolor="#efefef">
									起始单号：
								</td>
								<td>
									<h:inputText id="exco" value="#{expressMB.bean.exco}"
										styleClass="inputtextedit" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									生成数量：
								</td>
								<td>
									<h:inputText id="qty" value="#{expressMB.bean.qty}"
										styleClass="inputtextedit" />
								</td>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{expressMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{expressMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{expressMB.MOD}" />
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