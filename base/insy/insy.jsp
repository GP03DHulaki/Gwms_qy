<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.InsyMB"%>
<%@page import="com.gwall.pojo.base.InsyBean"%>
<%@ include file="../../include/include_imp.jsp"%>


<%
	InsyMB ai = (InsyMB) MBUtil.getManageBean("#{insyMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new InsyBean());
	}
%>
<html>
	<head>
		<title>商品默认补货数量</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="insy.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript">
			function gotoWarehousexls(){
				window.open("<%=request.getContextPath()%>/base/insy/insyexls.jsf");												
			}	
		</script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" rendered="#{insyMB.ADD}"
							styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{insyMB.delete}" rendered="#{insyMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{insyMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{insyMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
							<a4j:commandButton id="expButton" value="导出"
										rendered="#{insyMB.EXP}"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="gotoWarehousexls();" requestDelay="50" />
							<a4j:commandButton id="inButton" value="导入"
										rendered="#{insyMB.EXP}"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										onclick="showImport();" requestDelay="50" />
					</div>
					<div id=mmain_cnd>
						商品编码:
						<h:inputText id="inco" value="#{insyMB.inco}"
							styleClass="inputtextedit" />
						商品名称:
						<h:inputText id="inna" value="#{insyMB.inna}"
							styleClass="inputtextedit" />
					</div>
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select a.id,a.inco,a.sqty,a.stat,a.rema From insy a
							left join inve b on a.inco=b.inco
								Where 1=1 #{insyMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = inco(headtext = 商品编码,name = bran,width = 100,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = sqty(headtext = 商品默认补货数量,name = brde,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{insyMB.sellist}" />
						<h:inputHidden id="msg" value="#{insyMB.msg}"></h:inputHidden>
						<h:inputHidden id="filename" value="#{insyMB.fileName}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{insyMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="hideDiv()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{insyMB.uploadFileWhid}" />
						</div>
					</h:form>
				</div>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{insyMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{insyMB.selid}" />
						<h:inputHidden id="updateflag" value="#{insyMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									商品编码：
								</td>
								<td>
									<h:inputText id="inco" value="#{insyMB.bean.inco}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									商品默认补货数量：
								</td>
								<td>
									<h:inputText id="sqty" value="#{insyMB.bean.sqty}" 
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{insyMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>	
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="rema" value="#{insyMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{insyMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{insyMB.MOD}" />
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