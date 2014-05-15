<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.base.LprdMB"%>
<%@page import="com.gwall.pojo.base.LprdBean"%>
<%@ include file="../../include/include_imp.jsp"%>


<%
	LprdMB ai = (LprdMB) MBUtil.getManageBean("#{lprdMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new LprdBean());
	}
%>
<html>
	<head>
		<title>路线档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="lprd.js"></script>
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
							onmouseout="this.className='a4j_buton'" rendered="#{lprdMB.ADD}"
							styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{lprdMB.delete}" rendered="#{lprdMB.DEL}"
							onclick="if(!deleteAll(gtable)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{lprdMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{lprdMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
							<a4j:commandButton id="inButton" value="导入excel"
								rendered="#{lprdMB.EXP}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="showImport();" requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{lprdMB.exportProcedureProduct}"
								reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
								oncomplete="excelios_end();" requestDelay="50" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						物流商编码:
						<h:inputText id="lpco" value="#{lprdMB.sk_obj.lpco}"
							styleClass="inputtextedit" />
						物流商名称:
						<h:inputText id="lpna" value="#{lprdMB.sk_obj.lpna}"
							styleClass="inputtextedit" />
						区域:
						<h:inputText id="area" value="#{lprdMB.sk_obj.area}"
							styleClass="inputtextedit" />
						打印文字:
						<h:inputText id="prrd" value="#{lprdMB.sk_obj.prrd}"
							styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="select * from (Select a.id,a.lpco,lpna,prve,city,area,(select gena from gein where geid=prve) as prna,
										(select gena from gein where geid=city) as cina,(select gena from gein where geid=area) as arna,prrd 
										from lprd a left join lpin b on a. lpco=b.lpco) x 
								Where 1=1 #{lprdMB.searchSQL}"
							gpage="(pagesize = 20)" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = lpna(headtext = 物流商,name = lpna,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = prve(headtext = 省,name = prna,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = city(headtext = 市,name = cina,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = area(headtext = 区 ,name = arna,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = prrd(headtext = 打印文字,name = prrd,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{lprdMB.sellist}" />
						<h:inputHidden id="msg" value="#{lprdMB.msg}"></h:inputHidden>
						<h:inputHidden id="gsql" value="#{lprdMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{lprdMB.outPutFileName}" />
					</a4j:outputPanel>
				</h:form>
				<div id="import" style="display: none" align="left">
								<h:form id="file" enctype="multipart/form-data">
									<t:inputFileUpload id="upFile" styleClass="upfile"
										storage="file" value="#{lprdMB.myFile}" required="true"
										size="75" />
									<div id="mes"></div>
									<div align="center">
										<gw:GAjaxButton value="上传" onclick="return doImport();"
											id="import" theme="a_theme" />
										<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
											onclick="hideDiv1()" type="button" />
									</div>
									<div style="display: none;">
										<h:commandButton value="上传" id="importBut"
											action="#{lprdMB.uploadFileWhid}" />
									</div>
								</h:form>
							</div>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{lprdMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{lprdMB.selid}" />
						<h:inputHidden id="updateflag" value="#{lprdMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									物流商：
								</td>
								<td>
									<h:inputText id="lpco" value="#{lprdMB.bean.lpna}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									省：
								</td>
								<td>
									<h:inputText id="prve" value="#{lprdMB.bean.prve}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									市：
								</td>
								<td>
									<h:inputText id="city" value="#{lprdMB.bean.city}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									区：
								</td>
								<td>
									<h:inputText id="area" value="#{lprdMB.bean.area}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr><tr>	
								<td bgcolor="#efefef">
									打印文字：
								</td>
								<td>
									<h:inputText id="prrd" value="#{lprdMB.bean.prrd}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{lprdMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{lprdMB.MOD}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>

					</a4j:outputPanel>
				</h:form>

			</div>
		</body>
	</f:view>
</html>