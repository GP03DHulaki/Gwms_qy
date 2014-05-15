、<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.SalesPlanMB"%>
<%@page import="com.gwall.pojo.base.SalesPlanBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    SalesPlanMB ai = (SalesPlanMB) MBUtil.getManageBean("#{salesPlanMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new SalesPlanBean());
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
		<script type="text/javascript" src="salesplan.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<f:view>
		<body id=mmain_body onload="clearData();">
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							rendered="#{salesPlanMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{salesPlanMB.delete}" rendered="#{salesPlanMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{salesPlanMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{salesPlanMB.search}"
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
						预售ID:
						<h:inputText id="prids" value="#{salesPlanMB.sk_obj.prid}"
							styleClass="inputtext" />
						店铺编码:
						<h:inputText id="dpids" value="#{salesPlanMB.sk_obj.dpid}"
							styleClass="inputtext" />
						商品编码:
						<h:inputText id="incos" value="#{salesPlanMB.sk_obj.inco}"
							styleClass="inputtext" />
					
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select a.id,a.prid,a.dpid,a.inco,a.betm,a.eddt,a.rema,a.isva,b.dpmc from sapm a 
							left join strf b on a.dpid=b.dpid
							where 1=1 #{salesPlanMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = prid(headtext = 预售ID,name = prid,width = 140,headtype = sort,align = left,type = text,datatype=string);
							    gcid = dpid(headtext = 店铺编码,name = dpid,width = 140,headtype = sort,align = left,type = text,datatype=string);
							    gcid = dpmc(headtext = 店铺名称,name = dpmc,width = 140,headtype = sort,align = left,type = text,datatype=string);
							    gcid = inco(headtext = 商品编码,name = inco,width = 140,headtype = sort,align = left,type = text,datatype=string);
							    gcid = betm(headtext = 开始时间,name = betm,width = 130,headtype = sort,align = left,type = text,datatype=datetime);
							    gcid = eddt(headtext = 结束数据,name = eddt,width = 130,headtype = sort,align = left,type = text,datatype=string);
						        gcid = rema(headtext = 备注,name = rema,width = 90,headtype = sort,align = left,type = text,datatype=string);
								gcid = isva(headtext = 是否有效,name = isva,width = 90,align = center,type = mask,headtype = sort,datatype = string,typevalue=1:有效/0:无效);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{salesPlanMB.sellist}" />
						<h:inputHidden id="msg" value="#{salesPlanMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{salesPlanMB.getSimpleBean}"
							reRender="editpanel,outPan,outTable" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{salesPlanMB.selid}" />
						<h:inputHidden id="updateflag" value="#{salesPlanMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									预售ID:
								</td>
								<td>
										<h:inputText id="prid" value="#{salesPlanMB.bean.prid}" styleClass="inputtext"></h:inputText>
										<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									店铺编码：
								</td>
								<td>
									<h:inputText id="dpid" value="#{salesPlanMB.bean.dpid}" styleClass="inputtext"></h:inputText>
									<h:inputHidden id="ids" value="#{salesPlanMB.bean.id}" ></h:inputHidden>
									<img id="dpid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectDpid();" />
									<span style="">*</span>
								</td>

								
							</tr>

							<tr>
								<td bgcolor="#efefef">
									开始时间：
								</td>
								<td>
										<h:inputText id="betm" value="#{salesPlanMB.bean.betm}" styleClass="datetime" 
										onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'});" ></h:inputText>
									
								</td>
								<td bgcolor="#efefef">
									商品编码:
								</td>
								<td>
										<h:inputText id="inco" value="#{salesPlanMB.bean.inco}"  styleClass="inputtext"></h:inputText>
										<img id="inco_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectInco();" />
								
										<span style="">*</span>
								</td>
								

							</tr>
							<tr>
								<td bgcolor="#efefef">
									备注：
								</td>
								<td>
										<h:inputText id="rema" value="#{salesPlanMB.bean.rema}" styleClass="inputtext"></h:inputText>
								</td>
								<td bgcolor="#efefef">
									结束数据：
								</td>
								<td>
										<h:inputText id="eddt" value="#{salesPlanMB.bean.eddt}" styleClass="inputtext"></h:inputText>
								</td>
								

							</tr>
							<tr>
								<td bgcolor="#efefef">
									是否有效：
								</td>
								<td>
										<h:inputText id="isva" value="#{salesPlanMB.bean.isva}" styleClass="inputtext"></h:inputText>
								</td>
							</tr>
							
							<tr>
								<td colspan="4" align="center">

									<a4j:commandButton id="saveid" action="#{salesPlanMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{salesPlanMB.MOD}" />
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