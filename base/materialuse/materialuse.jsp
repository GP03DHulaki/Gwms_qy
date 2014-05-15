<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.MaterialUseMB"%>
<%@page import="com.gwall.pojo.base.MaterialUseBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    MaterialUseMB ai = (MaterialUseMB) MBUtil.getManageBean("#{materialUseMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new MaterialUseBean());
    }
%>
<html>
	<head>
		<title>客户档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="materialuse.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							rendered="#{materialUseMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{materialUseMB.delete}" rendered="#{materialUseMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{materialUseMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{materialUseMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" onclick="startDo();"
								oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						材料编码:
						<h:inputText id="macos" value="#{materialUseMB.sk_obj.maco}"
							styleClass="inputtext" />
					
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select a.id,a.maco,a.mana,a.rema,a.isva,a.wanu from matm a where 1=1 #{materialUseMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = maco(headtext = 材料编码,name = maco,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = mana(headtext = 材料名称,name = mana,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = rema(headtext = 备注,name = rema,width = 90,headtype = sort,align = left,type = text,datatype=datetime);
							    gcid = isva(headtext = 是否有效,name = isva,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = wanu(headtext = 警戒库存数量,name = wanu,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{materialUseMB.sellist}" />
						<h:inputHidden id="msg" value="#{materialUseMB.msg}"></h:inputHidden>
								</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{materialUseMB.getSimpleBean}"
							reRender="editpanel,outPan,outTable" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{materialUseMB.selid}" />
						<h:inputHidden id="updateflag" value="#{materialUseMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									材料编码：
								</td>
								<td>
									<h:inputText id="maco" value="#{materialUseMB.bean.maco}" styleClass="inputtext"></h:inputText>
									
									<h:inputHidden id="ids" value="#{materialUseMB.bean.id}"></h:inputHidden>
									<img id="maco_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectMaco();" />
								
									<span style="">*</span>
								</td>

								<td bgcolor="#efefef">
									材料名称:
								</td>
								<td>
										<h:inputText id="mana" value="#{materialUseMB.bean.mana}" styleClass="inputtext"></h:inputText>
										<span style="">*</span>
								</td>
							</tr>

							<tr>
								<td bgcolor="#efefef">
									备注：
								</td>
								<td>
										<h:inputText id="rema" value="#{materialUseMB.bean.rema}" styleClass="inputtext"></h:inputText>
									
								</td>
								<td bgcolor="#efefef">
									是否有效：
								</td>
								<td>
										<h:inputText id="isva" value="#{materialUseMB.bean.isva}" styleClass="inputtext"></h:inputText>
								</td>

							</tr>
							<tr>
								<td bgcolor="#efefef">
								        警戒库存数量：
								</td>
								<td>
										<h:inputText id="wanu" value="#{materialUseMB.bean.wanu}" styleClass="inputtext"></h:inputText>
								</td>

								

							</tr>
							
							
							<tr>
								<td colspan="4" align="center">

									<a4j:commandButton id="saveid" action="#{materialUseMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{materialUseMB.MOD}" />
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