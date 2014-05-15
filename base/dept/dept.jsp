<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.DeptMB"%>
<%@ page import="com.gwall.pojo.base.DeptBean"%>


<%
    DeptMB ai = (DeptMB) MBUtil.getManageBean("#{deptMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new DeptBean());
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>部门档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="dept.js"></script>
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
							href="javascript:showTab('tabs2','tabContent2');" title="部门档案">部门档案</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'"
										rendered="#{deptMB.ADD}" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{deptMB.delete}"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderArea,out_List,upid" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{deptMB.DEL}" />
									<h:panelGroup id="sp" rendered="#{deptMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button" action="#{deptMB.search}"
											reRender="out_List" requestDelay="50" onclick="startDo();"
											oncomplete="Gwin.close('progress_id');" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
									</h:panelGroup>
								</div>
								<div id=mmain_cnd>
									<h:panelGroup id="sps" rendered="#{deptMB.LST}">
										部门编码:
									<h:inputText id="dpid" styleClass="inputtext" size="12"
											value="#{deptMB.sk_obj.dpid}" onkeypress="formsubmit(event);" />
										部门名称:
									<h:inputText id="dpna" styleClass="inputtext" size="15"
											value="#{deptMB.sk_obj.dpna}" onkeypress="formsubmit(event);" />
									</h:panelGroup>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gdebug="false" gpage="(pagesize=20)"
										gselectsql="Select id,dpid,dpna,upid,crdt,leve,stat,rema,udid From dept Where 1=1 #{deptMB.searchSQL}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
											gcid = dpid(headtext = 部门编码,name = dpid,width = 100,headtype = sort,align = left,type = text);
											gcid = dpna(headtext = 部门名称,name = dpna,width = 120,headtype = sort,align = left,type = text);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text);
											gcid = upid(headtext = 上级部门编码,name = upid,width = 100,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{deptMB.sellist}"></h:inputHidden>
							</h:form>
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
									action="#{deptMB.getSimpleBean}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{deptMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{deptMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef" width="60px;">
											上级部门:
										</td>
										<td>
											<h:selectOneMenu id="upid" onchange="setCode();"
												value="#{deptMB.bean.upid}" styleClass="selectItem">
												<f:selectItems value="#{deptMB.list}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat" value="#{deptMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											部门编码:
										</td>
										<td>
											<h:inputText id="dpid" styleClass="inputtext"
												value="#{deptMB.bean.dpid}" />
										</td>
										<td bgcolor="#efefef">
											部门名称:
										</td>
										<td>
											<h:inputText id="dpna" styleClass="inputtext"
												value="#{deptMB.bean.dpna}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext"
												value="#{deptMB.bean.rema}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="renderArea_mes" value="#{deptMB.msg}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{deptMB.save}"
												value="保存" reRender="out_List,renderArea,tree,upid"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{deptMB.MOD}" />
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