<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.AreaMB"%>
<%@ page import="com.gwall.pojo.base.AreaBean"%>


<%
    AreaMB ai = (AreaMB) MBUtil.getManageBean("#{areaMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new AreaBean());
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>地区分类</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="area.js"></script>
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
							href="javascript:showTab('tabs2','tabContent2');" title="地区分类">地区分类</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'"
										rendered="#{areaMB.ADD}" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{areaMB.delete}"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderArea,out_List,upid" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{areaMB.DEL}" />
									<h:panelGroup id="sp" rendered="#{areaMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button" action="#{areaMB.search}"
											reRender="out_List" requestDelay="50" onclick="startDo();"
											oncomplete="Gwin.close('progress_id');" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
									</h:panelGroup>
								</div>
								<div id=mmain_cnd>
									<a4j:outputPanel id="sps" rendered="#{areaMB.LST}">
										地区编码:
										<h:inputText id="geid" styleClass="inputtext" size="12"
											value="#{areaMB.sk_obj.geid}" onkeypress="formsubmit(event);" />
										地区名称:
										<h:inputText id="gena" styleClass="inputtext" size="15"
											value="#{areaMB.sk_obj.gena}" onkeypress="formsubmit(event);" />
										父级编码:
										<h:inputText id="upid" styleClass="inputtext" size="12"
											value="#{areaMB.sk_obj.upid}" onkeypress="formsubmit(event);" />
									</a4j:outputPanel>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gdebug="false" gpage="(pagesize=20)"
										gselectsql="Select a.id,a.geid,a.gena,a.upid,a.leve,a.geco,a.stat,a.rema,b.gena AS upge,c.lico,d.lina
											From gein a left join gein b on a.upid=b.geid Left join liif c on a.geid=c.geid
											LEFT join liin d on c.lico=d.lico
										Where 1=1 #{areaMB.searchSQL}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
											gcid = geid(headtext = 地区编码,name = geid,width = 100,headtype = sort,align = left,type = text);
											gcid = gena(headtext = 地区名称,name = gena,width = 120,headtype = sort,align = left,type = text);
											gcid = geco(headtext = 邮政编码,name = geco,width = 80,headtype = sort,align = left,type = text);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text);
											gcid = upid(headtext = 上级地区编码,name = upid,width = 100,headtype = sort,align = left,type = text);
											gcid = upge(headtext = 上级地区名称,name = upge,width = 100,headtype = sort,align = left,type = text);
											gcid = lina(headtext = 所属线路,name = lina,width = 100,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{areaMB.sellist}"></h:inputHidden>
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
									action="#{areaMB.getSimpleBean}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{areaMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{areaMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef" width="60px;">
											上级地区:
										</td>
										<td>
											<h:selectOneMenu id="upid" onchange="setCode();"
												value="#{areaMB.bean.upid}" styleClass="selectItem">
												<f:selectItems value="#{areaMB.list}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat" value="#{areaMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											地区编码:
										</td>
										<td>
											<h:inputText id="geid" styleClass="inputtext"
												value="#{areaMB.bean.geid}" />
										</td>
										<td bgcolor="#efefef">
											地区名称:
										</td>
										<td>
											<h:inputText id="gena" styleClass="inputtext"
												value="#{areaMB.bean.gena}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											邮政编码:
										</td>
										<td>
											<h:inputText id="geco" styleClass="inputtext"
												value="#{areaMB.bean.geco}" />
										</td>
										<td bgcolor="#efefef">
											所属线路:
										</td>
										<td>
											<h:selectOneMenu id="lico" value="#{areaMB.bean.lico}" styleClass="selectItem">
												<f:selectItem itemLabel="" itemValue="" />
												<f:selectItems value="#{lineMB.itemlist}" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext"
												value="#{areaMB.bean.rema}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="renderArea_mes" value="#{areaMB.msg}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{areaMB.save}"
												value="保存" reRender="out_List,renderArea,tree,upid"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{areaMB.MOD}" />
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