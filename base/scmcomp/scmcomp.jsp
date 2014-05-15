<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="scmcomp.js"></script>
	</head>

	<body id=mmain_body onload="clearText();">
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="新增" type="button"
							onclick="addDiv();return false;" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							rendered="#{compMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="delButton" value="删除" type="button" 
							action="#{compMB.delete}"
							onclick="if(!deleteAll(gtable)){return false};"
							reRender="msg,out_List" oncomplete="endDo();" requestDelay="50"
							rendered="#{compMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />	
						<h:panelGroup id="sp" rendered="#{compMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								action="#{compMB.search}" reRender="out_List"
								requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						名称:
						<h:inputText id="name" value="#{compMB.sk_obj.name}"
								styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="out_List">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select id,name,eame,stat,rema From comp Where 1=1 #{compMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = name(headtext = 名称,name = szco,width = 80,headtype = sort,align = center,type = text,datatype=string);
							    gcid = eame(headtext = 英文名称,eame = szco,width = 80,headtype = sort,align = center,type = text,datatype=string);
						     	gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort, align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						     	gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left , type = text , datatype = string);
						" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{compMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editSize" style="display: none">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑" 
								action="#{compMB.getSimpleBean}"
								reRender="out_List,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
							<h:inputHidden id="selid" value="#{compMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{compMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
									<tr>
										<td bgcolor="#efefef">
											成分:
										</td>
										<td colspan="3">
											<h:inputText id="name" styleClass="inputtext" value="#{compMB.bean.name}" />
										</td>
									</tr>
									<tr>
									<td bgcolor="#efefef">
											英文名称:
										</td>
										<td>
											<h:inputText id="eame" styleClass="inputtext" value="#{compMB.bean.eame}" />
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat"
												value="#{compMB.bean.stat}"
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
												value="#{compMB.bean.rema}" size="55"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:commandButton id="s" action="#{compMB.save}"
												value="保存" reRender="out_List,msg"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();" onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but" 
												rendered="#{compMB.MOD}"/>
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDiv();" />
											<h:inputHidden id="msg" value="#{compMB.msg}"></h:inputHidden>
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