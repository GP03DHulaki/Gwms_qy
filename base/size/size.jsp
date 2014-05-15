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
		<script type="text/javascript" src="size.js"></script>
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
							rendered="#{sizeMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{sizeMB.delete}"
							onclick="if(!deleteAll(gtable)){return false};"
							reRender="msg,out_List" oncomplete="endDo();" requestDelay="50"
							rendered="#{sizeMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />	
						<h:panelGroup id="sp" rendered="#{sizeMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								action="#{sizeMB.search}" reRender="out_List"
								requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						尺寸编码:
						<h:inputText id="szco" value="#{sizeMB.sk_obj.szco}"
								styleClass="inputtextedit" />
						中文名称:
						<h:inputText id="szna" value="#{sizeMB.sk_obj.szna}"
								styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="out_List">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select id,szco,szna,szde,stat,rema From szin Where 1=1 #{sizeMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = szco(headtext = 规格码编码,name = szco,width = 80,headtype = sort,align = center,type = text,datatype=string);
						     	gcid = szna(headtext = 中文名称,name = szna,width = 80,headtype = sort,align = center,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort, align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						     	gcid = szde(headtext = 描述,name = szde,width = 120,headtype = sort,align = left , type = text , datatype = string);
						     	gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left , type = text , datatype = string);
						" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{sizeMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editSize" style="display: none">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑" 
								action="#{sizeMB.getSimpleBean}"
								reRender="out_List,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
							<h:inputHidden id="selid" value="#{sizeMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{sizeMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
									<tr>
										<td bgcolor="#efefef">
											规格码编码:
										</td>
										<td>
											<h:inputText id="szco" styleClass="inputtext"
												value="#{sizeMB.bean.szco}" />
										</td>
										<td bgcolor="#efefef">
											中文名称:
										</td>
										<td>
											<h:inputText id="szna" styleClass="inputtext"
												value="#{sizeMB.bean.szna}" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td colspan="3">
											<h:selectOneMenu id="stat"
												value="#{sizeMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											size描述:
										</td>
										<td colspan="3">
											<h:inputText id="szde" styleClass="inputtext"
												value="#{sizeMB.bean.szde}" size="55"></h:inputText>
										</td>
									</tr>	
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext"
												value="#{sizeMB.bean.rema}" size="55"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:commandButton id="s" action="#{sizeMB.save}"
												value="保存" reRender="out_List,msg"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();" onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but" 
												rendered="#{sizeMB.MOD}"/>
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDiv();" />
	
											<h:inputHidden id="msg" value="#{sizeMB.msg}"></h:inputHidden>
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