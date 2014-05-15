<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   <title>款式定位</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="patclass.js"></script>    
 </head>
  <body>
   <f:view>
	<h:form id="list">
		<a4j:outputPanel id="position">
								<div id=mmain_opt>
									<a4j:commandButton id="pSaveButton" value="新增"
										onclick="addDiv('2');" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" 
										rendered="#{patClassMB.ADD}" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{patClassMB.delete}"
										onclick="if(!deleteAll('gtable','2')){return false};"
										reRender="renderArea,list" oncomplete="endDeleteAll();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{patClassMB.DEL}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										id="sid" value="查询" type="button" action="#{patClassMB.searchPosition}"
										reRender="gtable" requestDelay="50" 
										onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
									<a4j:commandButton value="重置"	onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="clearData();" />
								</div>
								<div id=mmain_cnd>
									款式定位名称:
								<h:inputText id="name" styleClass="inputtext" size="12"
										value="#{patClassMB.position}" onkeypress="formsubmit(event);" />
								<a4j:outputPanel id="list">
									<g:GTable gid="gtable" gtype="grid" gversion="2"
										gpage="(pagesize=20)" gdebug = "true"
										gselectsql="Select id, spno,stat,rema From spin Where 1=1 #{patClassMB.positionSql}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1],'2'),datatype=string);
											gcid = spno(headtext = 款式定位名称,name = spno,width = 100,headtype = sort,align = left,type = text);
											gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
											gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								</div>
								
							</a4j:outputPanel>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{patClassMB.sellist}"></h:inputHidden>
						<h:inputHidden id="msg"	value="#{patClassMB.msg}"></h:inputHidden>
						<h:inputHidden id="saveType" value="#{patClassMB.saveType}"></h:inputHidden>
						<a4j:commandButton id="refBut" reRender="list"></a4j:commandButton>
					</a4j:outputPanel>
				</div>
	</h:form>
	<div style="display: none">
						<h:form id="edit">
							<div id=mmain_hide>
								<a4j:commandButton id="editbut" value="编辑" type="button"
									action="#{patClassMB.getSimpleBean}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{patClassMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{patClassMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef">
											名称:
										</td>
										<td>
											<h:inputText id="dname" styleClass="inputtext"
												value="#{patClassMB.bean.name}" />
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat"
												value="#{patClassMB.bean.stat}"
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
											<h:inputText id="drema" styleClass="inputtext"
												value="#{patClassMB.bean.rema}" size="56"></h:inputText>
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:commandButton id="saveid" action="#{patClassMB.save}"
												value="保存" reRender="renderArea"
												onclick="if(!formCheck()){return false};"
												oncomplete="endSave();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{patClassMB.MOD}" />
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDiv();" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
							<a4j:outputPanel id="renderArea">
								<h:inputHidden id="saveType" value="#{patClassMB.saveType}"></h:inputHidden>
								<h:inputHidden id="msg"	value="#{patClassMB.msg}"></h:inputHidden>
							</a4j:outputPanel>
						</h:form>
					</div>
	</f:view>
  </body>
</html>
