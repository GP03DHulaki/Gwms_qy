<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>品名</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="品名">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="cefo.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<a4j:outputPanel id="pnin">
						<div id=mmain_opt>
							<a4j:commandButton id="pnSaveButton" value="新增"
								onclick="addDiv('pn',380,110);" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" 
								rendered="#{cefoMB.ADD}" styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="pnDelButton" value="删除" type="button"
								action="#{cefoMB.delete}"
								onclick="if(!deleteAll('gtable1','pn')){return false};"
								reRender="renderArea,list1" oncomplete="endDelDo();"
								requestDelay="50" onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								rendered="#{cefoMB.DEL}" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="pnSid" value="查询" type="button" action="#{cefoMB.searchPn}"
								reRender="renderArea,list1" requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData('pn');" />
						</div>
						<div id=mmain_cnd>
							品名:
							<h:inputText id="pdna" styleClass="inputtext" size="12"
								value="#{cefoMB.pdna}" onkeypress="formsubmit(event);" />
							品牌:
							<h:inputText id="brad" styleClass="inputtext" size="12"
								value="#{cefoMB.brad}" onkeypress="formsubmit(event);" />		

							<a4j:outputPanel id="list1">
								<g:GTable gid="gtable1" gtype="grid" gversion="2"
									gpage="(pagesize=20)"
									gselectsql="Select a.id,a.pdna,a.brad,a.rema,b.brde From pnin a join brin b on a.brad = b.bran
										 Where 1=1 #{cefoMB.searchSQL}"
									gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]','pn','gcolumn[2]','gcolumn[3]','gcolumn[4]','gcolumn[5]','','',380,110),datatype=string);
										gcid = id(headtext = id,name = id,width = 80,headtype = hidden);
										gcid = pdna(headtext = 品名,name = pdna,width = 100,headtype = sort,align = left,type = text);
										gcid = brde(headtext = 品牌,name = brad,width = 200,headtype = sort,align = left,type = text);
										gcid = rema(headtext = 说明,name = rema,width = 200,headtype = sort,align = left,type = text);
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
					<h:form id="editPn">
						<div id=mmain_hide>
							<h:inputHidden id="selid" value="#{cefoMB.selid}"></h:inputHidden>
							<h:inputHidden id="pnid" value="#{cefoMB.bean.pnid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{cefoMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										品名:
									</td>
									<td>
										<h:inputText id="pdna" styleClass="inputtext"
											value="#{cefoMB.bean.pdna}" />
									</td>
									<td bgcolor="#efefef">
										品牌:
									</td>
									<td>
										<h:inputText id="brde" value="#{cefoMB.bean.brde}"
											disabled="true" styleClass="inputtext" />
										<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectBran();" />
										<h:inputHidden id="bran" value="#{cefoMB.bean.brad}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										说明:
									</td>
									<td colspan="3">
										<h:inputText id="pdma" styleClass="inputtext"
											value="#{cefoMB.bean.pnma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{cefoMB.save}"
											value="保存" reRender="list1,renderArea"
											onclick="if(!formCheck('pn')){return false};"
											oncomplete="endDo('CefoPnWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{cefoMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv('CefoPnWin');" />
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