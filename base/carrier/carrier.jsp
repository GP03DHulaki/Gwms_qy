<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.CarrierMB"%>
<%@page import="com.gwall.pojo.base.CarrierBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
	CarrierMB ai = (CarrierMB) MBUtil.getManageBean("#{carrierMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSearchKey(new CarrierBean());
	}
%>
<html>
	<head>
		<title>物流商档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="carrier.js"></script>
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
							rendered="#{carrierMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{carrierMB.delete}"
							rendered="#{carrierMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{carrierMB.LST}">
							<a4j:commandButton id="query" value="查询" 
								action="#{carrierMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						物流商编码:
						<h:inputText id="sk_lpco" value="#{carrierMB.sk_obj.lpco}"
							styleClass="inputtextedit" />
						物流商名称:
						<h:inputText id="sk_lpna" value="#{carrierMB.sk_obj.lpna}"
							styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select lpco,id,rena,reph,stat,prst,rema,lpna From lpin 
								Where 1=1 #{carrierMB.searchSQL}"
							gpage="(pagesize = 18)" 
							gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = lpco(headtext = 物流商编码,name = lpco,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lpna(headtext = 物流商名称,name = lpna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = rena(headtext = 联系人,name = rena,width = 60,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = reph(headtext = 联系电话,name = reph,width = 80,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 40,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = prst(headtext = 是否后打印 ,name = prst,width = 60,headtype = sort , align = center , type = mask,typevalue={1:是/0:否} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id='detailArea' rendered="false">
						<div style="overflow: auto">
							<iframe id="iframe_linedetail" name="iframe_linedetail"
								align="top" scrolling="auto" frameborder="0" height="300px"
								onload="this.width=iframe_linedetail.document.body.scrollWidth;
								this.height=iframe_linedetail.document.body.scrollHeight"
								src="<%=request.getContextPath()%>/base/carrier/linedetail.jsf"></iframe>
						</div>
						<%-- 
							growclick="refreshLine('gcolumn[lpco]');"
						--%>
					</a4j:outputPanel>

					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{carrierMB.sellist}" />
						<h:inputHidden id="msg" value="#{carrierMB.msg}" />
						<h:inputHidden id="lpco" value="#{carrierMB.bean.lpco}" />
						<a4j:commandButton id="hidBut" style="display:none;" oncomplete="iframe_linedetail.window.location.reload();" />
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{carrierMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{carrierMB.selid}" />
						<h:inputHidden id="updateflag" value="#{carrierMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									物流商编码：
								</td>
								<td>
									<h:inputText id="lpco" value="#{carrierMB.bean.lpco}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									物流商名称：
								</td>
								<td>
									<h:inputText id="lpna" value="#{carrierMB.bean.lpna}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									联系人：
								</td>
								<td>
									<h:inputText id="rena" value="#{carrierMB.bean.rena}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
								<td bgcolor="#efefef">
									联系电话：
								</td>
								<td>
									<h:inputText id="reph" value="#{carrierMB.bean.reph}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{carrierMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
								<td bgcolor="#efefef">
									是否后打印：
								</td>
								<td>
									<h:selectOneMenu id="prst" value="#{carrierMB.bean.prst}"
										styleClass="inputtext">
										<f:selectItem itemLabel="否" itemValue="0" />
										<f:selectItem itemLabel="是" itemValue="1" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="rema" value="#{carrierMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{carrierMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{carrierMB.MOD}" />
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