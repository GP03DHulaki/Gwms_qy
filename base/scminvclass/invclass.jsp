<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.InvClassMB"%>
<%@ page import="com.gwall.pojo.base.InvClassBean"%>
<%
	InvClassMB ai = (InvClassMB) MBUtil.getManageBean("#{invClassMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new InvClassBean());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>物料类别</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css" rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="invclass.js"></script>
		<script type="text/javascript" src="gtree.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/js/Gtab.js'></script>
		<style type="text/css">
		*{margin: 0;padding: 0;}
		body{height: 0;}
		</style>
	</head>
	<body onload="clearData();" id=mmain_body>
		<div id=mmain>
			<f:view>
				<div id="tabDiv">
					<div id="tabsHead">
						<a class="curtab" id="tabs1"
							href="javascript:showTab('tabs1','tabContent1')" title="列表">列表</a>
						<a class="tabs" id="tabs2"
							href="javascript:showTab('tabs2','tabContent2');" title="物料类别">物料类别</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'"
										rendered="#{invClassMB.ADD}" styleClass="a4j_but"
										tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{invClassMB.delete}"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderArea,out_List" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{invClassMB.DEL}" />
									<h:panelGroup id="sp" rendered="#{invClassMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button"
											action="#{invClassMB.search}" reRender="out_List"
											requestDelay="50" 
											onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
									</h:panelGroup>
								</div>
								<div id=mmain_cnd>
									<h:panelGroup id="sps" rendered="#{invClassMB.LST}">
										物料类别编码:
									<h:inputText id="inty" styleClass="inputtext"
										size="12" value="#{invClassMB.sk_obj.inty}"
										onkeypress="formsubmit(event);" />
										物料类别名称:
									<h:inputText id="tyna" styleClass="inputtext"
										size="15"
										value="#{invClassMB.sk_obj.tyna}"
										onkeypress="formsubmit(event);" />
									</h:panelGroup>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false" 
										gpage="(pagesize=20)"
										gselectsql="Select a.id,a.inty,a.tyna,a.upty,b.tyna as upna,a.leve,a.stat,a.rema,a.bsul From prty a left join prty b on a.upty=b.inty Where a.type='0' #{invClassMB.searchSQL}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
											gcid = id(headtext = ID,name = id,width = 50,headtype = sort,align = left,type = hidden);
											gcid = inty(headtext = 类别编码,name = inty,width = 100,headtype = sort,align = left,type = text);
											gcid = tyna(headtext = 类别名称,name = tyna,width = 120,headtype = sort,align = left,type = text);
											gcid = bsul(headtext = 基准单位,name = bsul,width = 120,headtype = sort,align = left,type = text);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text);
											gcid = upty(headtext = 上级编码,name = upty,width = 100,headtype = sort,align = left,type = text);
											gcid = upna(headtext = 上级名称,name = upna,width = 100,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{invClassMB.sellist}"></h:inputHidden>
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
									action="#{invClassMB.getSimpleBean}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{invClassMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{invClassMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef" width="60px;">
											上级类别:
										</td>
										<td>
											<h:selectOneMenu id="upty"  onchange="showupty();"
												value="#{invClassMB.bean.upty}"
												styleClass="selectItem">
												<f:selectItem itemLabel="" itemValue="" />
												<f:selectItems value="#{invClassMB.scmList}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat"
												value="#{invClassMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef" width="80px;">
											物料类别编码:
										</td>
										<td>
											<span id="intyid" style="color:#A0A0A0;"></span>
											<h:inputText id="inty" styleClass="inputtext"
												value="#{invClassMB.bean.inty}" />
										</td>
										<td bgcolor="#efefef">基准单位</td>
										<td>
											<h:inputText id="bsul" styleClass="inputtext"
												value="#{invClassMB.bean.bsul}" ></h:inputText>
										</td>
									</tr>
									<tr>
										
										<td bgcolor="#efefef">
											物料类别名称:
										</td>
										
										<td colspan="3">
											<h:inputText id="tyna" styleClass="inputtext"
												value="#{invClassMB.bean.tyna}" size="56"/>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext"
												value="#{invClassMB.bean.rema}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="renderArea_mes"
													value="#{invClassMB.msg}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{invClassMB.saveScm}"
												value="保存" reRender="out_List,renderArea,tree,upty"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{invClassMB.MOD}" />
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