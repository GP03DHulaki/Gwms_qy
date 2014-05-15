<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>工厂</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="工厂">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="cefo.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<a4j:outputPanel id="fcin">
						<div id=mmain_opt>
							<a4j:commandButton id="fcSaveButton" value="新增"
								onclick="addDiv('fc',440,160);" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" 
								rendered="#{cefoMB.ADD}" styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="fcDelButton" value="删除" type="button"
								action="#{cefoMB.delete}"
								onclick="if(!deleteAll('gtable5','fc')){return false};"
								reRender="renderArea,list5" oncomplete="endDelDo();"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								rendered="#{cefoMB.DEL}" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="fcSid" value="查询" type="button" action="#{cefoMB.searchFc}"
								reRender="renderArea,list5" requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData('fc');" />
						</div>
						<div id=mmain_cnd>
								工厂编号:
							<h:inputText id="fcno" styleClass="inputtext" size="12"
									value="#{cefoMB.fcno}" onkeypress="formsubmit(event);" />
								工厂名称:
							<h:inputText id="fcna" styleClass="inputtext" size="12"
									value="#{cefoMB.fcna}" onkeypress="formsubmit(event);" />
							<a4j:outputPanel id="list5">
								<g:GTable gid="gtable5" gtype="grid" gversion="2"
									gpage="(pagesize=20)"
									gselectsql="Select id,fcno,fcna,comy,iflc,stat,rema From fcin Where 1=1 #{cefoMB.searchSQL}"
									gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]','fc','gcolumn[2]','gcolumn[3]','gcolumn[4]','gcolumn[5]','gcolumn[6]','gcolumn[7]',440,160),datatype=string);
										gcid = id(headtext = id,name = id,width = 80,headtype = hidden);
										gcid = fcno(headtext = 工厂编号,name = fcno,width = 100,headtype = sort,align = left,type = text);
										gcid = fcna(headtext = 工厂名称,name = fcna,width = 100,headtype = sort,align = left,type = text);
										gcid = comy(headtext = 所属公司,name = comy,width = 100,headtype = sort,align = left,type = text);
										gcid = iflc(headtext = 是否是本公司,name = iflc,width = 80,headtype = sort,align = left,type = mask,typevalue=0:否/1:是);
										gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
										gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);
									" />
							</a4j:outputPanel>
						</div>	
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{cefoMB.sellist}"></h:inputHidden>
						<h:inputHidden id="msg"	value="#{cefoMB.msg}"></h:inputHidden>
						<h:inputHidden id="saveType" value="#{cefoMB.bean.saveType}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
				
				<div style="display: none">
					<h:form id="editFc">
						<div id=mmain_hide>
							<h:inputHidden id="selid" value="#{cefoMB.selid}"></h:inputHidden>
							<h:inputHidden id="fcid" value="#{cefoMB.bean.fcid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{cefoMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										工厂编号:
									</td>
									<td>
										<h:inputText id="fcno" styleClass="inputtext"
											value="#{cefoMB.bean.fcno}" />
									</td>
									<td bgcolor="#efefef">
										工厂名称:
									</td>
									<td>
										<h:inputText id="fcna" styleClass="inputtext"
											value="#{cefoMB.bean.fcna}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										所属公司:
									</td>
									<td>
										<h:inputText id="comy" styleClass="inputtext"
											value="#{cefoMB.bean.comy}" />
									</td>
									<td bgcolor="#efefef">
										是否是本公司:
									</td>
									<td>
										<h:selectOneMenu id="iflc"
											value="#{cefoMB.bean.iflc}"
											styleClass="selectItem">
											<f:selectItem itemLabel="是" itemValue="1" />
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="stat"
											value="#{cefoMB.bean.fcat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注:
									</td>
									<td colspan="3">
										<h:inputText id="fcma" styleClass="inputtext"
											value="#{cefoMB.bean.fcma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{cefoMB.save}"
											value="保存" reRender="list5,renderArea"
											onclick="if(!formCheck('fc')){return false};"
											oncomplete="endDo('CefoFcWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{cefoMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv('CefoFcWin');" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="saveType" value="#{cefoMB.bean.saveType}"></h:inputHidden>
							<h:inputHidden id="msg"	value="#{cefoMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>	
	</body>
</html>