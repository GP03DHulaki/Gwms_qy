<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>工作流配置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="工作流配置">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="workflow.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="添加" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							tabindex="5" rendered="#{workflowMB.ADD}" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{workflowMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							rendered="#{workflowMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select a.id,a.wfid,a.moid,b.mona,a.mopa,a.toid,c.mona As tona,a.topa,a.rema 
								From wofl a 
								Join modu b On a.moid = b.moid 
								Join modu c On a.toid = c.moid "
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),value = 编辑);
								gcid = wfid(headtext = 工作流编码,name = wfid,width = 60,headtype = sort,align = left,type = text);
								gcid = mona(headtext = 来源模块,name = mona,width = 80,headtype = sort,align = left,type = text);
								gcid = tona(headtext = 目标模块,name = topa,width = 80,headtype = sort,align = left,type = text);
								gcid = rema(headtext = 备注,name = rema,width = 400,headtype = sort,align = left,type = text);							
								" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{workflowMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="edit" style="display: none">
					<h:form id="edit">
						<h:inputHidden id="selid" value="#{workflowMB.selid}" />
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑"
								action="#{workflowMB.getInfo}" reRender="outTable,msg,editarea"
								oncomplete="edit_show();" requestDelay="50" />
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
								<tr>
									<td bgcolor="#efefef">
										工作流编码:
									</td>
									<td>
										<h:inputText id="wfid" value="#{workflowMB.bean.wfid}"
											styleClass="inputtext" />
									</td>

								</tr>
								<tr>
									<td bgcolor="#efefef">
										来源模块:
									</td>
									<td>
										<h:selectOneMenu id="moid" value="#{workflowMB.bean.moid}">
											<f:selectItems value="#{workflowMB.list}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										来源参数:
									</td>
									<td>
										<h:inputText id="mopa" value="#{workflowMB.bean.mopa}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										目标模块:
									</td>
									<td>
										<h:selectOneMenu id="toid" value="#{workflowMB.bean.toid}">
											<f:selectItems value="#{workflowMB.list}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										目标参数:
									</td>
									<td>
										<h:inputText id="topa" value="#{workflowMB.bean.topa}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注:
									</td>
									<td colspan="3">
										<h:inputText id="rema" value="#{workflowMB.bean.rema}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden id="updateflag" value="#{workflowMB.updateflag}" />
										<a4j:commandButton id="s" action="#{workflowMB.save}"
											value="保存" reRender="outTable,msg"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />

										<h:inputHidden id="msg" value="#{workflowMB.msg}"></h:inputHidden>
									</td>
								</tr>
								<tr>

								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>