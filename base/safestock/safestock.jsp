<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.WarehouseMB"%>

<%
	WarehouseMB ai = (WarehouseMB) MBUtil.getManageBean("#{warehouseMB}");
	if (request.getParameter("isAll") != null) {
		ai.setSearchSQL("");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>安全库存</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="safestock.js"></script>
		<script type="text/javascript" src="gtree.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
	</head>
	<body onload="clearData();" id=mmain_body>
		<div id=mmain>
			<f:view>
				<div id="tabDiv">
					<div id="tabsHead">
						<a class="curtab" id="tabs1"
							href="javascript:showTab('tabs1','tabContent1')" title="列表">列表</a>
						<a class="tabs" id="tabs2"
							href="javascript:showTab('tabs2','tabContent2');" title="库位资料">库位资料</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<h:panelGroup id="sp" rendered="#{warehouseMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button"
											onclick="startDo();"
											action="#{warehouseMB.selectVoucherid}" reRender="out_List"
											oncomplete="Gwin.close('progress_id');"
											requestDelay="50" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
										<a4j:commandButton value="导入execl"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="showDivReport('导入安全库存execl');" />
									</h:panelGroup>
									</div>
								<div id=mmain_cnd>
									<h:panelGroup id="sps" rendered="#{warehouseMB.LST}">
										库位编号:
									<h:inputText id="whid" styleClass="inputtext" size="12"
											value="#{warehouseMB.bean.whid}"
											onkeypress="formsubmit(event);" />
									辅助编码:
									<h:inputText id="ewid" styleClass="inputtext" size="12"
											value="#{warehouseMB.bean.ewid}"
											onkeypress="formsubmit(event);" />
										&nbsp; 库位名称:
									<h:inputText id="whna" styleClass="inputtext" size="15"
											value="#{warehouseMB.bean.whna}"
											onkeypress="formsubmit(event);" />
									</h:panelGroup>
									<h:outputText value="组织架构:" >
									</h:outputText>
									<h:selectOneMenu id="orid" value="#{warehouseMB.bean.orid}" onchange="doSearch();">
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{OrgaMB.subList}" />
									</h:selectOneMenu>	
									<h:outputText value="库位标识:">
									</h:outputText>
									<h:selectOneMenu id="whtys" value="#{warehouseMB.bean.whty}"
										styleClass="selectItem" onchange="doSearch();">
										<f:selectItem itemValue=""/>
										<f:selectItems value="#{warehouseMB.typeItem}"/>
									</h:selectOneMenu>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gpage="(pagesize=20)" gdebug="false"
										gselectsql="Select waho.id,whid,ewid,whna,pwid,whfl,whty,wogr,waho.orid,g.orna,cofl,volu,vole,vowi,vohe,bear,waho.stat,waho.lonu,waho.hinu
										From waho left join orga g on g.orid = waho.orid Where waho.whty in ('4','5') #{warehouseMB.sql}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text);
											gcid = whid(headtext = 库位编码,name = whid,width = 100,headtype = sort,align = left,type = text);
											gcid = whna(headtext = 库位名称,name = whna,width = 120,headtype = sort,align = left,type = text);
											gcid = pwid(headtext = 上级编码,name = pwid,width = 100,headtype = sort,align = left,type = text);
											gcid = whty(headtext = 库位标识,name = whty,width = 60,headtype = sort,align = center,type = mask,typevalue=0:地点/1:仓库/2:库区/3:楼层/4:拣货库位/5:备货库位/6:溢出库位/7:预售库位/8:质检库位/9:上架车/10:系统库位);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = lonu(headtext = 最小库存数量,name = lonu,width = 80,headtype = sort,align = right,type = text,datatype =number,dataformat=0.##);
											gcid = hinu(headtext = 最大库存数量,name = hinu,width = 80,headtype = sort,align = right,type = text,datatype =number,dataformat=0.##);
						
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{warehouseMB.sellist}"></h:inputHidden>
							</h:form>
							<div id="importFile" style="display: none" align="left">
								<h:form id="file" enctype="multipart/form-data">
									<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
										value="#{warehouseMB.uploadFile}" required="true" size="75" />								
									<div id="mes"></div>
									<div align="center">
										<gw:GAjaxButton value="上传" onclick="return doImport();"
											id="import" theme="a_theme" />
										<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
											onclick="hideDivReport()" type="button" />
									</div>
									<div style="display: none;">
										<a4j:commandButton id="importBut" action="#{warehouseMB.reportFile}"
												value="上传" reRender="out_List,msg,tree"
												oncomplete="showMsg();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
									</div>
								</h:form>
							</div>
						</div>
						<div id="tabContent2" class="hidetab_body">
							<a4j:outputPanel id="tree">
								<div id="treeInit" onselectstart="return false;"
									style="white-space: nowrap; height =100%; overflow: auto;"></div>
								<script type="text/javascript">GTree.init();</script>
							</a4j:outputPanel>
						</div>						
					</div>
					<div id="edit" style="display: none">
						<h:form id="edit">
							<div id=mmain_hide>
								<a4j:commandButton id="editbut" value="编辑" type="button"
									action="#{warehouseMB.getWarehouseinfo}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{warehouseMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{warehouseMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef">
											上级编码:
										</td>
										<td>
											<h:selectOneMenu id="pwid" value="#{warehouseMB.bean.pwid}"
												onchange="setCode();">
												<f:selectItem itemLabel="ROOT" itemValue="ROOT" />
												<f:selectItems value="#{warehouseMB.list}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											辅助编码:
										</td>
										<td>
											<h:inputText id="ewid" styleClass="inputtext"
												value="#{warehouseMB.bean.ewid}" disabled="true"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											库位编码:
										</td>
										<td>
											<h:inputText id="whid" styleClass="inputtext"
												value="#{warehouseMB.bean.whid}" />
										</td>
										<td bgcolor="#efefef">
											库位名称:
										</td>
										<td>
											<h:inputText id="whna" styleClass="inputtext"
												value="#{warehouseMB.bean.whna}" disabled="true" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											最小库存数量:
										</td>
										<td>
											<h:inputText id="vole" styleClass="inputtext"
												value="#{warehouseMB.bean.lonu}"  onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											最大库存数量:
										</td>
										<td>
											<h:inputText id="vowi" styleClass="inputtext"
												value="#{warehouseMB.bean.hinu}" onfocus="this.select()" />
										</td>
									</tr>
								
									<tr>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat" value="#{warehouseMB.bean.stat}"
												styleClass="selectItem" disabled="true">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td>
											<h:inputText id="rema" styleClass="inputtext"
												value="#{warehouseMB.bean.rema}" disabled="true"
											/>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="msg" value="#{warehouseMB.msg}"></h:inputHidden>
												<h:inputHidden id="filename" value="#{warehouseMB.fileName}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{warehouseMB.updateSafeStock}"
												value="保存" reRender="out_List,msg,tree"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{warehouseMB.MOD}" />
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDiv();" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</h:form>
					</div>
				</div>
			</f:view>
		</div>
	</body>
</html>