<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>色卡档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="ccfi.js"></script>
	</head>

	<body id=mmain_body onload="clearText();">
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id="tabDiv">
						<div id="tabsHead">
							<a class="curtab" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="系列主题">色卡</a>
							<a class="tabs" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');" title="款式定位">色号</a>
						</div>
						<div id="tabsBody">
							<div id="tabContent1" class="curtab_body">
								<a4j:outputPanel id="them">
									<div id=mmain_opt>
										<a4j:commandButton id="saveButton" value="新增"
											onclick="addDiv('sk');" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" 
											rendered="#{ccfiMB.ADD}" styleClass="a4j_but" tabindex="5" />
										<a4j:commandButton id="delButton" value="删除" type="button"
											action="#{ccfiMB.delete}"
											onclick="if(!deleteAll(gtable,'sk')){return false};"
											reRender="renderArea,out_List,list2" oncomplete="endDo();"
											requestDelay="50" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{ccfiMB.DEL}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button" action="#{ccfiMB.searchSk}"
											reRender="out_List" requestDelay="50" 
											onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearDataSk();" />
									</div>
									<div id=mmain_cnd>
											色卡编号:
										<h:inputText id="cnno" styleClass="inputtext" size="12"
												value="#{ccfiMB.cnno}" onkeypress="formsubmit(event);" />
											色卡名称:
										<h:inputText id="cnna" styleClass="inputtext" size="12"
												value="#{ccfiMB.cnna}" onkeypress="formsubmit(event);" />	
											供应商编号:
										<h:inputText id="cuid" styleClass="inputtext" size="12"
												value="#{ccfiMB.cuid}" onkeypress="formsubmit(event);" />	
									<a4j:outputPanel id="out_List">
										<g:GTable gid="gtable" gtype="grid" gversion="2"
											gpage="(pagesize=20)"
											gselectsql="Select a.id,a.cono,a.cona,a.cuid,a.stat,a.rema,b.ceve From cono a 
												join suin b on a.cuid=b.suid Where 1=1 #{ccfiMB.searchSQL} "
											gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
												gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
												gcid = -1(headtext = 色号信息,width = 50,headtype = text,align = center,type = link,value=编辑,linktype = script,typevalue = javascript:showColors(gcolumn[id]),datatype=string);
												gcid = id(headtext = ID,name = id,width = 80,headtype = hidden);
												gcid = cono(headtext = 色卡编号,name = cono,width = 80,headtype = sort,align = left,type = text);
												gcid = cona(headtext = 色卡名称,name = cona,width = 80,headtype = sort,align = left,type = text);
												gcid = cuid(headtext = 供应商编号,name = cuid,width = 80,headtype = sort,align = left,type = text);											
												gcid = ceve(headtext = 供应商,name = ceve,width = 80,headtype = sort,align = left,type = text);
												gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
												gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);
											" />
									</a4j:outputPanel>
									</div>
								</a4j:outputPanel>
							</div>
							<div id="tabContent2" class="hidetab_body">
								<a4j:outputPanel id="position">
									<div id=mmain_opt>
										<a4j:commandButton id="pSaveButton" value="新增"
											onclick="addDiv('sh');" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" 
											rendered="#{ccfiMB.ADD}" styleClass="a4j_but" tabindex="5" />
										<a4j:commandButton id="pDelButton" value="删除" type="button"
											action="#{ccfiMB.delete}"
											onclick="if(!deleteAll(gtable2,'sh')){return false};"
											reRender="renderArea,list2" oncomplete="endDo();"
											requestDelay="50" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{ccfiMB.DEL}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="pSid" value="查询" type="button" action="#{ccfiMB.searchSh}"
											reRender="list2" requestDelay="50" 
											onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
										<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearDataSh();" />
									</div>
									<div id=mmain_cnd>
											色卡编号:
										<h:inputText id="skno" styleClass="inputtext" size="12"
												value="#{ccfiMB.skno}" onkeypress="formsubmit(event);" />
											色卡名称:
										<h:inputText id="skna" styleClass="inputtext" size="12"
												value="#{ccfiMB.skna}" onkeypress="formsubmit(event);" />
											色号:
										<h:inputText id="colo" styleClass="inputtext" size="12"
												value="#{ccfiMB.colo}" onkeypress="formsubmit(event);" />
											规格:
										<h:inputText id="cona" styleClass="inputtext" size="12"
												value="#{ccfiMB.cona}" onkeypress="formsubmit(event);" />
									<a4j:outputPanel id="list2">
										<g:GTable gid="gtable2" gtype="grid" gversion="2"
											gpage="(pagesize=20)"
											gselectsql="Select a.id,a.skid,a.colo,a.cona,a.stat,a.rema,b.cono as skno,b.cona as skna From colo a
												join cono b on a.skid=b.id
												Where 1=1 #{ccfiMB.searchSQL}"
											gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
												gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
												gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1],'sh'),datatype=string);
												gcid = skno(headtext = 色卡编号,name = skno,width = 80,headtype = sort,align = left,type = text);
												gcid = skna(headtext = 色卡名称,name = skna,width = 80,headtype = sort,align = left,type = text);
												gcid = colo(headtext = 色号,name = colo,width = 80,headtype = sort,align = left,type = text);
												gcid = cona(headtext = 规格,name = cona,width = 80,headtype = sort,align = left,type = text);	
												gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
												gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);
											" />
									</a4j:outputPanel>
									</div>
								</a4j:outputPanel>
							</div>
						</div>
					</div>
		<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{ccfiMB.sellist}"></h:inputHidden>
						<h:inputHidden id="msg"	value="#{ccfiMB.msg}"></h:inputHidden>
						<h:inputHidden id="saveType" value="#{ccfiMB.bean.saveType}"></h:inputHidden>
						<a4j:commandButton id="initDetailBut" action="#{ccfiMB.clearBean}"></a4j:commandButton>
					</a4j:outputPanel>
		</div>
				</h:form>
				<div style="display: none">
					<h:form id="editsk">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button"
								action="#{ccfiMB.getSimpleBean}" reRender="editpanel"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{ccfiMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{ccfiMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										色卡编号:
									</td>
									<td>
										<h:inputText id="colo" styleClass="inputtext"
											value="#{ccfiMB.bean.skno}" />
									</td>
									<td bgcolor="#efefef">
										色卡名称:
									</td>
									<td>
										<h:inputText id="cona" styleClass="inputtext"
											value="#{ccfiMB.bean.skna}" />
								</tr>
								<tr>
									<td bgcolor="#efefef">
										供应商名称:
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{ccfiMB.bean.suna}"/>
										<h:inputHidden id="suid" value="#{ccfiMB.bean.cuid}"/>	
										<img id="suid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectSuin();" />
									</td>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="stat"
											value="#{ccfiMB.bean.skst}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										描述:
									</td>
									<td colspan="3">
										<h:inputText id="lrema" styleClass="inputtext"
											value="#{ccfiMB.bean.skma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{ccfiMB.save}"
											value="保存" reRender="out_List,renderArea,list2,list3,list4"
											onclick="if(!formCheck('sk')){return false};"
											oncomplete="endSk();"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{ccfiMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDivSk();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="saveType" value="#{ccfiMB.bean.saveType}"></h:inputHidden>
							<h:inputHidden id="msg"	value="#{ccfiMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
				<div style="display: none">
					<h:form id="editsh">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button"
								action="#{ccfiMB.getSimpleBean}" reRender="editpane2"
								oncomplete="edit_show1();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{ccfiMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{ccfiMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpane2">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										色卡:
									</td>
									<td>
										<h:inputText id="seka" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{ccfiMB.bean.eana}"/>
										<h:inputHidden id="skid" value="#{ccfiMB.bean.eaid}"/>	
										<img id="skid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectCono();" />
									</td>
									<td bgcolor="#efefef">
										色号:
									</td>
									<td>
										<h:inputText id="colo" styleClass="inputtext"
											value="#{ccfiMB.bean.colo}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										规格:
									</td>
									<td>
										<h:inputText id="cona" styleClass="inputtext"
											value="#{ccfiMB.bean.cona}" />
									</td>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="stat"
											value="#{ccfiMB.bean.coat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										描述:
									</td>
									<td colspan="3">
										<h:inputText id="nrema" styleClass="inputtext"
											value="#{ccfiMB.bean.coma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										
										<a4j:commandButton id="saveid" action="#{ccfiMB.save}"
											value="保存" reRender="list2,renderArea"
											onclick="if(!formCheck('sh')){return false};"
											oncomplete="endSh();"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{patClassMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDivSh();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>	
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg"	value="#{ccfiMB.msg}"></h:inputHidden>
							<h:inputHidden id="saveType" value="#{ccfiMB.bean.saveType}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
		</f:view>
		</div>	
	</body>
</html>