<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="com.gwall.view.BillPoolConfigMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	BillPoolConfigMB ai = (BillPoolConfigMB) MBUtil
			.getManageBean("#{billpoolconfigMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	} else {
		ai.setGtableParam(request, ai);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>分单池配置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src='billpoolconfig.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<link href="billpoolconfig.css" rel="stylesheet" type="text/css" />
	</head>

	<body id=mmain id=mmain_body>
		<f:view>
			<div id=mmain>

				<h:form id="list">
					<div id=mmain_nav>
						系统管理&gt;&gt;策略配置&gt;&gt;
						<b>分单池配置</b>
					</div>
					<div id=mmain_free>

						<ul>
							<li>
								<b>固定SKU集合</b>
							</li>
							<div class="rule">
								<div class="rule">
									<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
									onclick="startDo();" oncomplete="Gwin.close('progress_id');;"
									reRender="out_List" action="#{billpoolconfigMB.search}" />
								<gw:GAjaxButton value="重置" theme="a_theme"
										onclick="textClear('list','sk_inco,sk_inna,sk_inse,sk_ortp');" />
								<a4j:commandButton id="g" value="新增"
										reRender="orderNum,goodsNum,role,msg" onclick="addDiv();"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
									<a4j:commandButton id="h" value="删除"
										reRender="out_List,msg,renderArea,msgArea" oncomplete="endDo('1');"
										action="#{billpoolconfigMB.delete}" rendered="#{billpoolconfigMB.DEL}"
										onclick="if(!deleteAll(gtable,'')){return false};"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
									<gw:GAjaxButton id="impDBut" value="导入" theme="b_theme"
										rendered="#{billpoolconfigMB.IMP}"
										onclick="showImport()" type="button" />
								</div>
							</div>
							<div class="rule">
								<div class="rule">
							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{billpoolconfigMB.inco}" />
							商品名称:
							<h:inputText id="sk_inna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{billpoolconfigMB.inna}" />
							商品条码:
							<h:inputText id="sk_inse" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{billpoolconfigMB.inse}" />
							库位类型:
							<h:selectOneMenu id="sk_ortp" value="#{billpoolconfigMB.ortp}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="分仓" itemValue="1" />
								<f:selectItem itemLabel="预包装" itemValue="0" />
							</h:selectOneMenu>
								</div>
							</div>
							<div class="rule">
								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable" gtype="grid" gversion="2"
										gdebug="false" gpage="(pagesize=20)"
										gselectsql="Select a.id,a.inco,b.inna,b.tyco,b.colo,a.stat,a.ortp from prin a join inve b on a.inco = b.inco  Where 1=1 #{billpoolconfigMB.sql} "
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     				gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
						    			 	gcid = tyco(headtext = 货号,name = tyco,width = 90,headtype = sort,align = left , type = text, datatype = string);
						   				  	gcid = colo(headtext = 规格名称,name = colo,width =100,headtype = sort,align = left , type = text , datatype = string);
						     				gcid = ortp(headtext = 配置类别 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:分仓/0:预包装} , datatype = string);
						     				gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string);
										" />
								</a4j:outputPanel>
								<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{billpoolconfigMB.sellist}" />
							<h:inputHidden id="msg" value="#{billpoolconfigMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
							</div>
						</ul>
				</h:form>
			</div>
			<!-- 弹出层 -->
			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{billpoolconfigMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();">
						</a4j:commandButton>
						<h:inputHidden id="selid" value="#{billpoolconfigMB.selid}" />
						<h:inputHidden id="updateflag" value="#{billpoolconfigMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									商品编码：
								</td>
								<td>
									<h:inputText id="inco" value="#{billpoolconfigMB.bean.inco}"
										styleClass="inputtext" onfocus="this.select()" />
									<img id="invcode_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectInve();" />
								</td>
								<td bgcolor="#efefef">
									商品名称：
								</td>
								<td>
									<h:inputText id="inna" value="#{billpoolconfigMB.bean.inna}"
										disabled="true" styleClass="inputtext" onfocus="this.select()" />
								</td>
							</tr>

							<tr>
								<td bgcolor="#efefef">
									配置类别:
								</td>
								<td>
									<h:selectOneMenu id="sex" value="#{billpoolconfigMB.bean.ortp}">
										<f:selectItem itemLabel="分  仓" itemValue="1" />
										<f:selectItem itemLabel="预包装" itemValue="0" />
									</h:selectOneMenu>
								</td>
								<td bgcolor="#efefef">
									是否有效:
								</td>
								<td>
									<h:selectOneMenu id="status" value="#{billpoolconfigMB.bean.stat}">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{billpoolconfigMB.addInve}"
										value="保存" reRender="output,msgArea,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo('1');"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{billpoolconfigMB.MOD}">
									</a4j:commandButton>
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv(1);" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
					<a4j:outputPanel id="msgArea">
							<h:inputHidden id="msg" value="#{billpoolconfigMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
				</h:form>

			</div>
		<div id="import" style="display: none" align="left">
				<h:form id="file" enctype="multipart/form-data">
					<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
						value="#{billpoolconfigMB.myFile}" required="true" size="75" />
					<div id="mes"></div>
					<div align="center">
						<gw:GAjaxButton value="上传" onclick="return doImport();"
							id="import" theme="a_theme" />
						<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
							onclick="hideDiv()" type="button" />
					</div>
					<div style="display: none;">
						<h:commandButton value="上传" id="importBut"
							action="#{billpoolconfigMB.uploadFile}" />
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
