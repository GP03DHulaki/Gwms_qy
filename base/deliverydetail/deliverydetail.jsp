<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.DeliveryDetailMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.pojo.base.DeliveryDetailBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    DeliveryDetailMB ai = (DeliveryDetailMB) MBUtil.getManageBean("#{deliveryDetailMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new DeliveryDetailBean());
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
		<script type="text/javascript" src="deliverydetail.js"></script>
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
							rendered="#{deliveryDetailMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{deliveryDetailMB.delete}" rendered="#{deliveryDetailMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{deliveryDetailMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{deliveryDetailMB.search}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable1,outTable2" onclick="startDo();"
								oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
						</h:panelGroup>
						<a4j:commandButton id="getLC" value="获取LC号" onclick=""
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							action="#{deliveryDetailMB.LC}"
							reRender="outTable1,outTable2"
							rendered="#{deliveryDetailMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
					</div>
					<div id=mmain_cnd>
						快递公司:
						<h:inputText id="s_lpco" value="#{deliveryDetailMB.sk_obj.lpco}"
							styleClass="inputtext" />
						快单号:
						<h:inputText id="s_deid" value="#{deliveryDetailMB.sk_obj.deid}"
							styleClass="inputtext" />
						收件人:
						<h:inputText id="s_rena" value="#{deliveryDetailMB.sk_obj.rena}"
							styleClass="inputtext" />
					</div>
					<a4j:outputPanel id="outTable1" rendered="#{deliveryDetailMB.getLC}=='false'">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="select a.id,b.lpna,a.deid,a.rena,a.reas,a.detm from lddm a left join lpin b on a.lpco=b.lpco 
							 where 1=1 #{deliveryDetailMB.searchSQL} #{deliveryDetailMB.deliverySQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = lpna(headtext = 快递公司,name = lpna,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = deid(headtext = 快单号,name = deid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = rena(headtext = 收件人,name = rena,width = 90,headtype = sort,align = left,type = text,datatype=datetime);
							    gcid = reas(headtext = 收件地址,name = reas,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = detm(headtext = 发货时间,name = detm,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = lcid(headtext = LC单号,name = lcid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="outTable2" rendered="#{deliveryDetailMB.getLC}=='true'">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="select a.id,b.lpna,a.deid,a.rena,a.reas,a.detm,lcid='123' from lddm a left join lpin b on a.lpco=b.lpco 
								where 1=1 #{deliveryDetailMB.searchSQL} #{deliveryDetailMB.deliverySQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = lpna(headtext = 快递公司,name = lpna,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = deid(headtext = 快单号,name = deid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = rena(headtext = 收件人,name = rena,width = 90,headtype = sort,align = left,type = text,datatype=datetime);
							    gcid = reas(headtext = 收件地址,name = reas,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = detm(headtext = 发货时间,name = detm,width = 90,headtype = sort,align = left,type = text,datatype=string);
						        gcid = lcid(headtext = LC单号,name = lcid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{deliveryDetailMB.sellist}" />
						<h:inputHidden id="msg" value="#{deliveryDetailMB.msg}"></h:inputHidden>
								</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{deliveryDetailMB.getSimpleBean}"
							reRender="editpanel,outPan,outTable" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{deliveryDetailMB.selid}" />
						<h:inputHidden id="updateflag" value="#{deliveryDetailMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									快递公司：
								</td>
								<td>
									<h:inputText id="lpco" value="#{deliveryDetailMB.bean.lpco}" styleClass="inputtext"></h:inputText>
									<h:inputHidden id="ids" value="#{deliveryDetailMB.bean.id}"></h:inputHidden>
									<img id="lpco_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectLpco();" />
								
									<span style="">*</span>
								</td>

								<td bgcolor="#efefef">
									快单号:
								</td>
								<td>
										<h:inputText id="deid" value="#{deliveryDetailMB.bean.deid}" styleClass="inputtext"></h:inputText>
										<span style="">*</span>
								</td>
							</tr>

							<tr>
								<td bgcolor="#efefef">
									收件人：
								</td>
								<td>
										<h:inputText id="rena" value="#{deliveryDetailMB.bean.rena}" styleClass="inputtext"></h:inputText>
									
								</td>
								<td bgcolor="#efefef">
								        发货时间：
								</td>
								<td>
										<h:inputText id="detm" value="#{deliveryDetailMB.bean.detm}" styleClass="datetime" 
										onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});"></h:inputText>
								</td>
								

							</tr>
							<tr>
								
								<td bgcolor="#efefef">
									收件地址：
								</td>
								<td>
										<h:inputText id="reas" value="#{deliveryDetailMB.bean.reas}" styleClass="inputtext"></h:inputText>
								</td>
								

							</tr>
							
							
							<tr>
								<td colspan="4" align="center">

									<a4j:commandButton id="saveid" action="#{deliveryDetailMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{deliveryDetailMB.MOD}" />
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