<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.LogicaddrwhMB"%>
<%@page import="com.gwall.pojo.base.LogicaddrwhBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%
    LogicaddrwhMB ai = (LogicaddrwhMB) MBUtil.getManageBean("#{logicaddrwhMB}");
    LogicaddrwhBean lb  = new LogicaddrwhBean();
    lb.setLgid(request.getParameter("logicaddressid"));
	if (request.getParameter("logicaddressid") != null&&request.getParameter("logicaddressid")!="") {
	    ai.setLgid(request.getParameter("logicaddressid"));
	    ai.setBean(lb);
	}
%>

<html>
	<head>
		<title>库存逻辑地点仓库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
	
		<script type="text/javascript" src="logicaddrwh.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
	</head>
	<f:view>
	<body onload="clearData();" id=mmain_body>
		<div id=mmain>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										reRender="renderSite,out_List,msg"
										onmouseout="this.className='a4j_buton'"
										rendered="true" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{logicaddrwhMB.delete}" rendered="true"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderSite,out_List,msg" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										 />
									<a4j:commandButton onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										id="sid" value="查询" type="button" action="#{logicaddrwhMB.search}"
										reRender="out_List" requestDelay="50" />
									<a4j:commandButton type="button" value="重置" onclick="clearData();"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
								</div>
								<div id=mmain_cnd>
									<h:outputText value="SAP仓库编码:">
									</h:outputText>
									<h:inputText id="sapid" styleClass="inputtextedit" size="15"
										value="#{logicaddrwhMB.sk_obj.spid}" onkeypress="formsubmit(event);" />
									<h:outputText value="WMS仓库编码:">
									</h:outputText>
									<h:inputText id="waid" styleClass="inputtextedit" size="15"
										value="#{logicaddrwhMB.sk_obj.waid}" onkeypress="formsubmit(event);" />
								</div>
								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gdebug="false" gpage="(pagesize=15)"
										gselectsql="
											select a.id ,a.lgid,a.spid,a.waid from wala_detail a
											where a.lgid='#{logicaddrwhMB.lgid}' #{logicaddrwhMB.searchSQL } "
										gcolumn="gcid = id(headtext = selall,name = id,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
						        			gcid = -1(headtext = 操作,value=编辑, name = edit,width = 40,headtype = sort,align =center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[id]'),datatype=string);
											gcid = lgid(headtext = 库存逻辑地点编码,name = lgid,width = 70,headtype = sort,align = left,type = text);
											gcid = spid(headtext = SAP仓库编码,name = spid,width = 120,headtype = sort,align = left,type = text);
							    			gcid = waid(headtext = WMS仓库编码,name = waid,width = 70,headtype = sort,align = left,type = text, datatype = string);
									
										" />
								</a4j:outputPanel>
								 <h:inputHidden id="sellist" value="#{logicaddrwhMB.sellist}"></h:inputHidden>
								 <h:inputHidden id="msg" value="#{logicaddrwhMB.msg}"></h:inputHidden>
							</h:form>
						</div>
					</div>
		</div>
		
			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{logicaddrwhMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{logicaddrwhMB.selid}" />
						<h:inputHidden id="updateflag" value="#{logicaddrwhMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
							<td bgcolor="#efefef">
									库存逻辑地点编码：
								</td>
								<td>
									<h:inputText id="logicaddressid" value="#{logicaddrwhMB.bean.lgid}" 
										styleClass="inputtext" onfocus="this.select()" disabled="true"/>
									<span style="">*</span>
								</td>
							</tr>
							<tr>
							<td bgcolor="#efefef">
									SAP仓库编码：
								</td>
								<td>
									<h:inputText id="sapid" value="#{logicaddrwhMB.bean.spid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectintysapid();" />
									<h:inputHidden id="intysapid" value="#{logicaddrwhMB.bean.spid}" />
								</td>
								<td bgcolor="#efefef">
									WMS仓库编码：
								</td>
								<td>
									<h:inputText id="waid" value="#{logicaddrwhMB.bean.waid}" 
										styleClass="inputtext" onfocus="this.select()" />
									<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInty();" />
									<h:inputHidden id="intywaid" value="#{logicaddrwhMB.bean.waid}" />
								</td>
							</tr>
							
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{logicaddrwhMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
									    rendered="#{customerMB.MOD}"/>
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>
						<div style="display: none;">
							<a4j:commandButton id="refBut" value="隐藏按钮" reRender="editpanel"
								style="display:none;" />
						</div>

					</a4j:outputPanel>
				</h:form>
			</div>
	</body>
	</f:view>
</html>