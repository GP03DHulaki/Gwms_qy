<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.SAPinventoryMB"%>
<%@page import="com.gwall.pojo.base.SAPinventoryBean"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
     SAPinventoryMB ai = (SAPinventoryMB) MBUtil.getManageBean("#{sAPinventoryMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new SAPinventoryBean());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>SAP仓库地点</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="SAPinventory.js"></script>
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
							onmouseout="this.className='a4j_buton'" rendered="#{sAPinventoryMB.ADD}"
							styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button" rendered="#{sAPinventoryMB.DEL}"
							action="#{sAPinventoryMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{sAPinventoryMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{sAPinventoryMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						
						</h:panelGroup>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="inButton" value="导入EXCEL" type="button"
							reRender="msg,outPutFileName" onclick="showImport();"
							requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						SAP库存编码:
						<h:inputText id="sapid" value="#{sAPinventoryMB.sk_obj.spid}"
							styleClass="inputtextedit" />
						公司编码:
						<h:inputText id="companyCode" value="#{sAPinventoryMB.sk_obj.cpid}"
							styleClass="inputtextedit" />
						仓库编码:
						<h:inputText id="waid" value="#{sAPinventoryMB.sk_obj.waid}"
							styleClass="inputtextedit" />
						<br/>
						仓库名称:
						<h:inputText id="whna" value="#{sAPinventoryMB.sk_obj.whna}"
							styleClass="inputtextedit" />
						<h:outputText value="状态:" />
					   <h:selectOneMenu id="flags"
							value="#{sAPinventoryMB.sk_obj.stat}" onchange="doSearch();">
							<f:selectItem itemLabel="全部" itemValue="00" />
							<f:selectItems value="#{sAPinventoryMB.flags}" />
						</h:selectOneMenu>
					
					</div>
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select id,spid,cpid,waid,whna,stat,rema From sap_waho
								Where 1=1 #{sAPinventoryMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = spid(headtext = SAP库存编码,name = spid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = cpid(headtext = 公司编码,name = cpid,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = waid(headtext = 仓库编码,name = waid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = whna(headtext = 仓库名称,name = whna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态,name = stat,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{sAPinventoryMB.sellist}" />
						<h:inputHidden id="msg" value="#{sAPinventoryMB.msg}"></h:inputHidden>
						<h:inputHidden id="outPutFileName"
								value="#{outOrderMB.outPutFileName}" />
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{sAPinventoryMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{sAPinventoryMB.selid}" />
						<h:inputHidden id="updateflag" value="#{sAPinventoryMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									SAP库存编码：
								</td>
								<td>
									<h:inputText id="sapid" value="#{sAPinventoryMB.bean.spid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<!-- <span style="">*</span> -->
								</td>
								<td bgcolor="#efefef">
									公司编码：
								</td>
								<td>
									<h:inputText id="companyCode" value="#{sAPinventoryMB.bean.cpid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									仓库编码：
								</td>
								<td>
									<h:inputText id="waid" value="#{sAPinventoryMB.bean.waid}" 
										styleClass="inputtext" onfocus="this.select()"/>
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								
								<td bgcolor="#efefef">
									仓库名称：
								</td>
								<td>
									<h:inputText id="whna" value="#{sAPinventoryMB.bean.whna}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							
							<tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{sAPinventoryMB.bean.stat}"
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
									<h:inputText id="rema" value="#{sAPinventoryMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{sAPinventoryMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{sAPinventoryMB.MOD}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>

					</a4j:outputPanel>
					
	

				</h:form>
								               <!-- ly -->
               <div id="import" style="display: none" align="left">
								<h:form id="file" enctype="multipart/form-data">
								<t:inputFileUpload id="upFile" styleClass="upfile"
										storage="file" value="#{sAPinventoryMB.upFile}" required="true"
										size="75" />
										<div id="mes"></div>
									<div align="center">
										<gw:GAjaxButton value="上传" onclick="return doImport();"
											id="import" theme="a_theme" />
										<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
											onclick="hideDi()" type="button" />
									</div>
									<div style="display: none;">
										<h:commandButton value="上传" id="importBut"
											action="#{sAPinventoryMB.uploadFile}"/>
									</div>
								</h:form>
							</div>
               <!-- ly -->
			</div>
		</body>
	</f:view>
</html>