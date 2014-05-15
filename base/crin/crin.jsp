<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>尺寸</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="尺寸">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="crin.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body onload="clearText();">
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="新增" type="button"
							onclick="addDiv();return false;" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							rendered="#{crinMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{crinMB.delete}"
							onclick="if(!deleteAll(gtable)){return false};"
							reRender="msg,out_List" oncomplete="endDo();" requestDelay="50"
							rendered="#{crinMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />	
						<h:panelGroup id="sp" rendered="#{crinMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								action="#{crinMB.search}" reRender="out_List"
								requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						工艺编号:
						<h:inputText id="cfco" value="#{crinMB.sk_obj.cfco}"
								styleClass="inputtextedit" />
						工艺名称:
						<h:inputText id="cfna" value="#{crinMB.sk_obj.cfna}"
								styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="out_List">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select id,cfco,cfna,stat,rema From crin Where 1=1 #{crinMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = cfco(headtext = 工艺编号,name = cfco,width = 80,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = cfna(headtext = 工艺名称,name = cfna,width = 80,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort, align = center, type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						     	gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left , type = text , datatype = string);
						" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{crinMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editCrin" style="display: none">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑" 
								action="#{crinMB.getSimpleBean}"
								reRender="out_List,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
							<h:inputHidden id="selid" value="#{crinMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{crinMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
									<tr>
										<td bgcolor="#efefef">
											规格码编码:
										</td>
										<td>
											<h:inputText id="cfco" styleClass="inputtext"
												value="#{crinMB.bean.cfco}" />
										</td>
										<td bgcolor="#efefef">
											中文名称:
										</td>
										<td>
											<h:inputText id="cfna" styleClass="inputtext"
												value="#{crinMB.bean.cfna}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td colspan="3">
											<h:selectOneMenu id="stat"
												value="#{crinMB.bean.stat}"
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
											<h:inputText id="rema" styleClass="inputtext"
												value="#{crinMB.bean.rema}" size="55"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:commandButton id="s" action="#{crinMB.save}"
												value="保存" reRender="out_List,msg"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();" onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but" 
												rendered="#{crinMB.MOD}"/>
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDiv();" />
											<h:inputHidden id="msg" value="#{crinMB.msg}"></h:inputHidden>
										</td>
									</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>