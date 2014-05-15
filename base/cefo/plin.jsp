<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>等级</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="等级">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="cefo.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<a4j:outputPanel id="plin">
						<div id=mmain_opt>
							<a4j:commandButton id="plSaveButton" value="新增"
								onclick="addDiv('pl',400,110);" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" 
								rendered="#{cefoMB.ADD}" styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="plDelButton" value="删除" type="button"
								action="#{cefoMB.delete}"
								onclick="if(!deleteAll('gtable6','pl')){return false};"
								reRender="renderArea,list6" oncomplete="endDelDo();"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								rendered="#{cefoMB.DEL}" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="plSid" value="查询" type="button" action="#{cefoMB.searchPl}"
								reRender="renderArea,list6" requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData('pl');" />
						</div>
						<div id=mmain_cnd>
								等级编号:
							<h:inputText id="leve" styleClass="inputtext" size="12"
									value="#{cefoMB.leve}" onkeypress="formsubmit(event);" />
								等级名称:
							<h:inputText id="lena" styleClass="inputtext" size="12"
									value="#{cefoMB.lena}" onkeypress="formsubmit(event);" />
							<a4j:outputPanel id="list6">
								<g:GTable gid="gtable6" gtype="grid" gversion="2"
									gpage="(pagesize=20)"
									gselectsql="Select id,leve,lena From plin Where 1=1 #{cefoMB.searchSQL}"
									gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]','pl','gcolumn[2]','gcolumn[3]','','','','',400,110),datatype=string);
										gcid = id(headtext = id,name = id,width = 80,headtype = hidden);
										gcid = leve(headtext = 等级编号,name = leve,width = 100,headtype = sort,align = left,type = text);
										gcid = lena(headtext = 等级名称,name = lena,width = 100,headtype = sort,align = left,type = text);
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
					<h:form id="editPl">
						<div id=mmain_hide>
							<a4j:commandButton id="editplbut" value="编辑" type="button"
								action="#{cefoMB.getSimpleBean}" reRender="list7,renderArea"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{cefoMB.selid}"></h:inputHidden>
							<h:inputHidden id="plid" value="#{cefoMB.bean.plid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{cefoMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										等级编号:
									</td>
									<td>
										<h:inputText id="leve" styleClass="inputtext"
											value="#{cefoMB.bean.leve}" />
									</td>
								</tr>	
								<tr>
									<td bgcolor="#efefef">
										等级名称:
									</td>
									<td>
										<h:inputText id="lena" styleClass="inputtext"
											value="#{cefoMB.bean.lena}" size="56"/>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{cefoMB.save}"
											value="保存" reRender="renderArea,list6"
											onclick="if(!formCheck('pl')){return false};"
											oncomplete="endDo('CefoPlWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{cefoMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv('CefoPlWin');" />
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