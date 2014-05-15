<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>组织架构</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type="text/javascript" src="organize.js"></script>
		<script type="text/javascript" src="gtree.js"></script>
		<link href="gtree.css" rel="stylesheet" type="text/css" />
	</head>
	<body onload="clearData();" id=mmain_body>
		<f:view>
			<div id=mmain>
				<div id="tabDiv">
					<div id="tabsHead">
						<a class="curtab" id="tabs1"
							href="javascript:showTab('tabs1','tabContent1')" title="列表">列表</a>
						<a class="tabs" id="tabs2"
							href="javascript:showTab('tabs2','tabContent2');" title="组织架构">组织架构</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'"
										rendered="#{OrgaMB.ADD}" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{OrgaMB.delete}"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderArea,out_List" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{OrgaMB.DEL}" />
									<h:panelGroup id="sp" rendered="#{OrgaMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button"
											onclick="Gwin.progress('正在查询...',10,document);"
											oncomplete="Gwin.close('progress_id');"
											action="#{OrgaMB.queryWhere}" reRender="out_List"
											requestDelay="50" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
									</h:panelGroup>
								</div>
								<div id=mmain_cnd>
									<h:panelGroup id="sps" rendered="#{OrgaMB.LST}">
										组织编号:
									<h:inputText id="orid" styleClass="inputtext" size="12"
											value="#{OrgaMB.bean.orid}" onkeypress="formsubmit(event);" />
										&nbsp; 组织名称:
									<h:inputText id="orna" styleClass="inputtext" size="15"
											value="#{OrgaMB.bean.orna}" onkeypress="formsubmit(event);" />
									</h:panelGroup>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gpage="(pagesize=20)"
										gselectsql="Select id,orid,orna,poid,orfl,chie,addr,tele,stat,rema From orga #{OrgaMB.sqlWhere}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
											gcid = orid(headtext = 组织编码,name = orid,width = 100,headtype = sort,align = left,type = text);
											gcid = orna(headtext = 组织名称,name = orna,width = 120,headtype = sort,align = left,type = text);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = chie(headtext = 联系人,name = chie,width = 120,headtype = sort,align = left,type = text);
											gcid = tele(headtext = 联系方式,name = tele,width = 120,headtype = sort,align = left,type = text);
											gcid = addr(headtext = 地址,name = addr,width = 120,headtype = sort,align = left,type = text);
											gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text);
											gcid = poid(headtext = 上级编码,name = poid,width = 100,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{OrgaMB.sellist}"></h:inputHidden>
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
									action="#{OrgaMB.query}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{OrgaMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{OrgaMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef" width="60px;">
											上级编码:
										</td>
										<td>
											<h:selectOneMenu id="poid" value="#{OrgaMB.bean.poid}">
												<f:selectItem itemLabel="ROOT" itemValue="ROOT" />
												<f:selectItems value="#{OrgaMB.list}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat" value="#{OrgaMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											组织架构编码:
										</td>
										<td>
											<h:inputText id="orid" styleClass="inputtext"
												value="#{OrgaMB.bean.orid}" />
										</td>
										<td bgcolor="#efefef">
											组织架构名称:
										</td>
										<td>
											<h:inputText id="orna" styleClass="inputtext"
												value="#{OrgaMB.bean.orna}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											联系人:
										</td>
										<td>
											<h:inputText id="chie" styleClass="inputtext"
												value="#{OrgaMB.bean.chie}"></h:inputText>
										</td>
										<td bgcolor="#efefef">
											联系方式:
										</td>
										<td>
											<h:inputText id="tele" styleClass="inputtext"
												value="#{OrgaMB.bean.tele}"></h:inputText>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											服务器IP:
										</td>
										<td>
											<h:inputText id="ifsv" styleClass="inputtext"
												value="#{OrgaMB.bean.ifsv}"></h:inputText>
										</td>
										<td bgcolor="#efefef">
											数据库名:
										</td>
										<td>
											<h:inputText id="ifdb" styleClass="inputtext"
												value="#{OrgaMB.bean.ifdb}"></h:inputText>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											登录名:
										</td>
										<td>
											<h:inputText id="ifus" styleClass="inputtext"
												value="#{OrgaMB.bean.ifus}"></h:inputText>
										</td>
										<td bgcolor="#efefef">
											密码:
										</td>
										<td>
											<h:inputSecret id="ifpw" styleClass="inputtext"
												value="#{OrgaMB.bean.ifpw}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											地址:
										</td>
										<td colspan="3">
											<h:inputText id="addr" styleClass="inputtext"
												value="#{OrgaMB.bean.addr}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext"
												value="#{OrgaMB.bean.rema}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="renderArea_mes" value="#{OrgaMB.msg}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{OrgaMB.save}"
												value="保存" reRender="out_List,renderArea,tree"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{OrgaMB.MOD}" />
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
			</div>
		</f:view>
	</body>
</html>