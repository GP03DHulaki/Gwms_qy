<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>执行标准</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="执行标准">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="cefo.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<a4j:outputPanel id="esin">
						<div id=mmain_opt>
							<a4j:commandButton id="esSaveButton" value="新增"
								onclick="addDiv('es',420,110);" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" 
								rendered="#{cefoMB.ADD}" styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="esDelButton" value="删除" type="button"
								action="#{cefoMB.delete}"
								onclick="if(!deleteAll('gtable3','es')){return false};"
								reRender="renderArea,list3" oncomplete="endDelDo();"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								rendered="#{cefoMB.DEL}" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="esSid" value="查询" type="button" action="#{cefoMB.searchEs}"
								reRender="renderArea,list3" requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData('es');" />
						</div>
						<div id=mmain_cnd>
								执行标准编号:
							<h:inputText id="esno" styleClass="inputtext" size="12"
									value="#{cefoMB.esno}" onkeypress="formsubmit(event);" />
							<a4j:outputPanel id="list3">
								<g:GTable gid="gtable3" gtype="grid" gversion="2"
									gpage="(pagesize=20)"
									gselectsql="Select id,esno,rema From esin Where 1=1 #{cefoMB.searchSQL}"
									gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]','es','gcolumn[2]','gcolumn[3]','','','','',420,110),datatype=string);
										gcid = id(headtext = id,name = id,width = 80,headtype = hidden);
										gcid = esno(headtext = 执行标准编号,name = esno,width = 100,headtype = sort,align = left,type = text);
										gcid = rema(headtext = 执行标准描述,name = rema,width = 200,headtype = sort,align = left,type = text);
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
					<h:form id="editEs">
						<div id=mmain_hide>
							<h:inputHidden id="selid" value="#{cefoMB.selid}"></h:inputHidden>
							<h:inputHidden id="esid" value="#{cefoMB.bean.esid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{cefoMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										执行标准编号:
									</td>
									<td>
										<h:inputText id="esno" styleClass="inputtext"
											value="#{cefoMB.bean.esno}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										执行标准描述:
									</td>
									<td>
										<h:inputText id="esma" styleClass="inputtext"
											value="#{cefoMB.bean.esma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{cefoMB.save}"
											value="保存" reRender="list3,renderArea"
											onclick="if(!formCheck('es')){return false};"
											oncomplete="endDo('CefoEsWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{cefoMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv('CefoEsWin');" />
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