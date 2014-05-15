<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>洗涤说明</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="洗涤说明">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="cefo.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<a4j:outputPanel id="wain">
						<div id=mmain_opt>
							<a4j:commandButton id="waSaveButton" value="新增"
								onclick="addDiv('ws',420,130);" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" 
								rendered="#{cefoMB.ADD}" styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="waDelButton" value="删除" type="button"
								action="#{cefoMB.delete}"
								onclick="if(!deleteAll('gtable7','ws')){return false};"
								reRender="renderArea,list7" oncomplete="endDelDo();"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								rendered="#{cefoMB.DEL}" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="waSid" value="查询" type="button" action="#{cefoMB.searchWs}"
								reRender="renderArea,list7" requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData('ws');" />
						</div>
						<div id=mmain_cnd>
								洗涤类型:
							<h:inputText id="wsty" styleClass="inputtext" size="12"
									value="#{cefoMB.wsty}" onkeypress="formsubmit(event);" />
							<a4j:outputPanel id="list7">
								<g:GTable gid="gtable7" gtype="grid" gversion="2"
									gpage="(pagesize=20)"
									gselectsql="Select id,wsna,wsty,stat,rema From wsin Where 1=1 #{cefoMB.searchSQL}"
									gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]','ws','gcolumn[2]','gcolumn[3]','gcolumn[4]','gcolumn[5]','','',420,130),datatype=string);
										gcid = id(headtext = id,name = id,width = 80,headtype = hidden);
										gcid = wsna(headtext = 洗涤名称,name = wsna,width = 100,headtype = sort,align = left,type = text);
										gcid = wsty(headtext = 洗涤类型,name = wsty,width = 100,headtype = sort,align = left,type = text);
										gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
										gcid = rema(headtext = 洗涤说明,name = rema,width = 200,headtype = sort,align = left,type = text);
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
					<h:form id="editWa">
						<div id=mmain_hide>
							<a4j:commandButton id="editwabut" value="编辑" type="button"
								action="#{cefoMB.getSimpleBean}" reRender="editpanel"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{cefoMB.selid}"></h:inputHidden>
							<h:inputHidden id="wsid" value="#{cefoMB.bean.wsid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{cefoMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										洗涤名称:
									</td>
									<td colspan="3">
										<h:inputText id="wsna" styleClass="inputtext"
											value="#{cefoMB.bean.wsna}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										洗涤类型:
									</td>
									<td>
										<h:inputText id="wsty" styleClass="inputtext"
											value="#{cefoMB.bean.wsty}" />
									</td>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="wsat"
											value="#{cefoMB.bean.wsat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										洗涤说明:
									</td>
									<td colspan="3">
										<h:inputText id="wsma" styleClass="inputtext"
											value="#{cefoMB.bean.wsma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{cefoMB.save}"
											value="保存" reRender="renderArea,list7"
											onclick="if(!formCheck('ws')){return false};"
											oncomplete="endDo('CefoWaWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{cefoMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv('CefoWaWin');" />
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