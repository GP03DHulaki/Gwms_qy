<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.inventoryLogicAddressMB"%>
<%@page import="com.gwall.pojo.base.inventoryLogicAddressBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    inventoryLogicAddressMB ai = (inventoryLogicAddressMB) MBUtil.getManageBean("#{inventoryLogicAddressMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new inventoryLogicAddressBean());
	}
%>
<html>
	<head>
		<title>库存逻辑地点设置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="inventoryLogicAddress.js"></script>
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
							onmouseout="this.className='a4j_buton'" rendered="#{inventoryLogicAddressMB.ADD}"
							styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button" rendered="#{inventoryLogicAddressMB.DEL}"
							action="#{inventoryLogicAddressMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{inventoryLogicAddressMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{inventoryLogicAddressMB.search}"
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
						库存逻辑地点编码:
						<h:inputText id="logicaddressid" value="#{inventoryLogicAddressMB.sk_obj.lgid}"
							styleClass="inputtextedit" />
						库存逻辑地点名称:
						<h:inputText id="logicname" value="#{inventoryLogicAddressMB.sk_obj.lgnm}"
							styleClass="inputtextedit" />
						<%--
						SAP仓库编码:
						<h:inputText id="sapid" value="#{
						
						
						
						inventoryLogicAddressMB.sk_obj.sapid}"
							styleClass="inputtextedit" />
						<br/>
						WMS仓库编码:
						<h:inputText id="waid" value="#{inventoryLogicAddressMB.sk_obj.waid}"
							styleClass="inputtextedit" />
						--%><h:outputText value="状态:" />
					   <h:selectOneMenu id="flags"
							value="#{inventoryLogicAddressMB.sk_obj.stat}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{inventoryLogicAddressMB.flags}" />
						</h:selectOneMenu>
					</div>
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select id,lgid,lgnm,stat,rema From wala
								Where 1=1 #{inventoryLogicAddressMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = lgid(headtext = 库存逻辑地点编码,name = lgid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lgnm(headtext = 库存逻辑地点名称,name = lgnm,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = -1(headtext = 操作,value=仓库维护,name = opt,width = 90,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:EditLogicaddress('gcolumn[lgid]'),datatype=string);
						        gcid = stat(headtext = 状态,name = stat,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{inventoryLogicAddressMB.sellist}" />
						<h:inputHidden id="msg" value="#{inventoryLogicAddressMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{inventoryLogicAddressMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{inventoryLogicAddressMB.selid}" />
						<h:inputHidden id="updateflag" value="#{inventoryLogicAddressMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									库存逻辑地点编码：
								</td>
								<td>
									<h:inputText id="logicaddressid" value="#{inventoryLogicAddressMB.bean.lgid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									库存逻辑地点名称：
								</td>
								<td>
									<h:inputText id="logicname" value="#{inventoryLogicAddressMB.bean.lgnm}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<%--<tr>
								<td bgcolor="#efefef">
									SAP仓库编码：
								</td>
								<td>
									<h:inputText id="sapid" value="#{inventoryLogicAddressMB.bean.sapid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectintysapid();" />
									<h:inputHidden id="intysapid" value="#{inventoryLogicAddressMB.bean.sapid}" />
								</td>
								<td bgcolor="#efefef">
									WMS仓库编码：
								</td>
								<td>
									<h:inputText id="waid" value="#{inventoryLogicAddressMB.bean.waid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInty();" />
									<h:inputHidden id="intywaid" value="#{inventoryLogicAddressMB.bean.waid}" />
								</td>
							</tr>
							--%><tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="state" value="#{inventoryLogicAddressMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="是" itemValue="是" />
										<f:selectItem itemLabel="否" itemValue="否" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>	
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="remark" value="#{inventoryLogicAddressMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{inventoryLogicAddressMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{inventoryLogicAddressMB.MOD}" />
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