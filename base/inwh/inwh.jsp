<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.InwhMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	InwhMB ai = (InwhMB) MBUtil.getManageBean("#{inwhMB}");
	if (request.getParameter("isAll") != null) {
		ai.initPage();
	} else {
		ai.setGtableParam(request, ai);
	}
%>
<html>
	<head>
		<title>商品默认货位</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript" src="inwh.js"></script>
	</head>
	<body>
	<f:view>
		<div id="tabDiv">
			<div id="tabsHead">
				<a class="curtab" id="tabs1"
					href="javascript:showTab('tabs1','tabContent1')" title="库位">库位</a>
				<a class="tabs" id="tabs2"
					href="javascript:showTab('tabs2','tabContent2');" title="库区">库区</a>
			</div>
			<div id="tabsBody">
				<div id="tabContent1" class="curtab_body">
					<h:form id="list">
						<span id=mmain_opt style="width: 100%;">
							<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" rendered="#{inwhMB.ADD}"
								styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="delButton" value="删除" type="button"
								action="#{inwhMB.delete}" rendered="#{inwhMB.DEL}"
								onclick="if(!deleteAll(gtable,'')){return false};"
								reRender="outTable,msg" oncomplete="endDo('1');" requestDelay="50"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
							<h:panelGroup id="sp" rendered="#{inwhMB.LST}">
								<gw:GAjaxButton id="query" value="查询" theme="a_theme"
									reRender="outTable" action="#{inwhMB.search}">
									<a4j:actionparam name="page" value="#{inwhMB.gpage}" />
								</gw:GAjaxButton>
								<gw:GAjaxButton value="重置" theme="a_theme" onclick="clearData();" reRender="query">
									<a4j:actionparam name="page" value="1" assignTo="#{inwhMB.gpage}" />
								</gw:GAjaxButton>
							</h:panelGroup>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{inwhMB.exportProcedureProduct}"
								reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
								oncomplete="excelios_end();" requestDelay="50" />
						</span>
						<div id=mmain_cnd>
							商品编码:
							<h:inputText id="inco" value="#{inwhMB.sk_obj.inco}"
								styleClass="inputtextedit" />
							库位编码:
							<h:inputText id="whid" value="#{inwhMB.sk_obj.whid}"
								styleClass="inputtextedit" />
						</div>
						<a4j:outputPanel id="outTable">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
								gsort="#{inwhMB.gsort}" gsortmethod="#{inwhMB.gsortmethod}"
								gselectsql="
									SELECT iw.id,iw.inco,iw.whco,iw.baco,iw.whid,iw.rema,iv.inna,iv.colo,iv.inse 
									FROM inwh iw JOIN inve iv ON iw.inco=iv.inco
									Where 1=1 #{inwhMB.searchSQL}"
								gpage="(pagesize = #{inwhMB.gpagesize})"
								gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
							        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
								    gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = inna(headtext = 商品名称,name = inna,width = 150,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = whid(headtext = 默认货位编码,name = whid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{inwhMB.sellist}" />
							<h:inputHidden id="msg" value="#{inwhMB.msg}"></h:inputHidden>
							<h:inputHidden id="outPutFileName" value="#{inwhMB.outPutFileName}" />							
						</a4j:outputPanel>
					</h:form>
				</div>

				<div id="edit" style="display:none ">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button"
								action="#{inwhMB.getSimpleBean}" reRender="editpanel,outTable"
								oncomplete="edit_show();" >
								<a4j:actionparam name="page" value="#{inwhMB.gpage}"  />
							</a4j:commandButton>
							<h:inputHidden id="selid" value="#{inwhMB.selid}" />
							<h:inputHidden id="updateflag" value="#{inwhMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpanel">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										商品编码：
									</td>
									<td>
										<h:inputText id="inco" value="#{inwhMB.bean.inco}"
											styleClass="inputtext" onfocus="this.select()" />
										<img id="invcode_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInve();" />
									</td>
									<td bgcolor="#efefef">
										商品名称：
									</td>
									<td>
										<h:inputText id="inna" value="#{inwhMB.bean.inna}"
											disabled="true" styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										默认库位：
									</td>
									<td>
										<h:inputText id="whid" value="#{inwhMB.bean.whid}"
											styleClass="inputtext" onfocus="this.select()" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectDWare();" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注：
									</td>
									<td colspan="3">
										<h:inputText id="rema" value="#{inwhMB.bean.rema}"
											styleClass="inputtext" onfocus="this.select()" size="65" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid" action="#{inwhMB.save}"
											value="保存" reRender="output,outTable,msg,tree,out_List"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo('1');" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{inwhMB.MOD}">
											<a4j:actionparam name="page" value="#{inwhMB.gpage}" />
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv(1);" />
									</td>
								</tr>
							</table>	
						</a4j:outputPanel>
					</h:form>
	
				</div>
				
				<div id="tabContent2" class="hidetab_body">
					<h:form id="list2">
						<span id="mmain_opt2" style="width: 100%;">
							<a4j:commandButton id="saveButton" value="新增" onclick="addDiv2();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'"
								styleClass="a4j_but" tabindex="5" />
							<a4j:commandButton id="delButton2" value="删除" type="button"
								action="#{inwhMB.deleteItwh}"
								onclick="if(!deleteAll(gtable2,'2')){return false};"
								reRender="outTable2,msg" oncomplete="endDo('2');" requestDelay="50"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
							<h:panelGroup id="sp2" rendered="#{inwhMB.LST}">
								<gw:GAjaxButton id="query2" value="查询" theme="a_theme"
									reRender="outTable2" action="#{inwhMB.search2}">
									<a4j:actionparam name="page" value="#{inwhMB.gpage}" />
								</gw:GAjaxButton>
								<gw:GAjaxButton id="gpage2" value="重置" theme="a_theme" onclick="clearData2();" reRender="query">
									<a4j:actionparam name="page" value="1" assignTo="#{inwhMB.gpage}" />
								</gw:GAjaxButton>
							</h:panelGroup>
						</span>
						<div id=mmain_cnd>
							类别编码:
							<h:inputText id="inty2" value="#{inwhMB.itwhbean.inty}"
								styleClass="inputtextedit" />
							默认库区:
							<h:inputText id="whid2" value="#{inwhMB.itwhbean.whid}"
								styleClass="inputtextedit" />
						</div>
						<h:panelGrid id="outTable2">
							<g:GTable gid="gtable2" gtype="grid" gversion="2"
								gsort="#{inwhMB.gsort}" gsortmethod="#{inwhMB.gsortmethod}"
								gselectsql="
									SELECT id,inty,whco,whid,rema 
									FROM itwh wh
									Where 1=1 #{inwhMB.searchSQL}"
								gpage="(pagesize = #{inwhMB.gpagesize})"
								gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
							        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:EditItwh(gcolumn[id]),datatype=string);
								    gcid = inty(headtext = 类别编码,name = inty,width = 120,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = whco(headtext = 仓库编码,name = whco,width = 150,headtype = sort,align = left,type = text,datatype=string);
							     	gcid = whid(headtext = 默认库区,name = whid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</h:panelGrid>
						<a4j:outputPanel id="renderArea2">
							<h:inputHidden id="sellist2" value="#{inwhMB.sellist2}" />
							<h:inputHidden id="msg" value="#{inwhMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
				
				<div id="edit2" style="display:none">
					<h:form id="edit2">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut2" value="编辑" type="button"
								action="#{inwhMB.getSimpleItwhBean}" reRender="editpanel2,outTable2"
								oncomplete="edit_show2();" >
								<a4j:actionparam name="page" value="#{inwhMB.gpage}"  />
							</a4j:commandButton>
							<h:inputHidden id="selid2" value="#{inwhMB.selid}" />
						</div>
						<a4j:outputPanel id="editpanel2">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										类别编码：
									</td>
									<td>
										<h:inputText id="inty2" value="#{inwhMB.itwhbean.inty}"
											styleClass="inputtext" onfocus="this.select()" />
										<img id="invcode_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInty();" />
									</td>
									<td bgcolor="#efefef">
										默认库区：
									</td>
									<td>
										<h:inputText id="whid2" value="#{inwhMB.itwhbean.whid}"
											styleClass="inputtext" onfocus="this.select()" />
										<img id="whid_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectDWare2('whid2');" />
									</td>
								</tr>								
								<tr>
									<td bgcolor="#efefef">
										备注：
									</td>
									<td colspan="3">
										<h:inputText id="rema2" value="#{inwhMB.itwhbean.rema}"
											styleClass="inputtext" onfocus="this.select()" size="65" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="saveid2" action="#{inwhMB.saveItwh}"
											value="保存" reRender="outTable2,msg"
											onclick="if(!formCheck2()){return false};"
											oncomplete="endDo('2');" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{inwhMB.MOD}">
											<a4j:actionparam name="page" value="#{inwhMB.gpage}" />
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv(2);" />
									</td>
								</tr>
							</table>	
						</a4j:outputPanel>
					</h:form>
	
				</div>				
			 </div>
		</div>
	</f:view>
	</body>
</html>