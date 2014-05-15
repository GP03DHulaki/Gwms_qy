<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.CustomerMB"%>
<%@page import="com.gwall.pojo.base.CustomerBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    CustomerMB ai = (CustomerMB) MBUtil.getManageBean("#{customerMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new CustomerBean());
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
		<script type="text/javascript" src="customer.js"></script>
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
							rendered="#{customerMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{customerMB.delete}" rendered="#{customerMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{customerMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{customerMB.search}"
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
						客户编码:
						<h:inputText id="cuid" value="#{customerMB.sk_obj.cuid}"
							styleClass="inputtextedit" />
						ERP客户编码:
						<h:inputText id="erpc" value="#{customerMB.sk_obj.erpc}"
							styleClass="inputtextedit" />
						客户名称:
						<h:inputText id="cuna" value="#{customerMB.sk_obj.cuna}"
							styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select a.id,a.geid,g.gena,a.cuid,a.cuna,a.lpco,a.cecu,a.phon,a.adde,a.erpc,
								a.emai,a.rema,a.ctco,b.tyna,a.stat,a.cous,c.lina 
								From cuin a left join cuty b on a.ctco = b.ctco 
								left join liin c on a.lico=c.lico left join gein g on a.geid = g.geid
								Where 1=1 #{customerMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = cuid(headtext = 客户编码,name = erpc,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = erpc(headtext = ERP客户编码,name = cuid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = gena(headtext = 地区名称,name = geid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = cuna(headtext = 客户名称,name = cuna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = cecu(headtext = 客户简称,name = cecu,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = -1(headtext = 操作,value=客户仓库维护 , name = cuwh,width = 100,headtype = sort,align =center,type = link,linktype = script,typevalue = javascript:EditCustomer('gcolumn[cuid]'),datatype=string);
						     	gcid = lpco(headtext = 所属快递公司,name = lpco,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = phon(headtext = 联系电话,name = phon,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = lina(headtext = 默认路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
							    gcid = adde(headtext = 地址,name = adde,width = 120,headtype = sort,align = left,type = text,datatype=string);
							    gcid = emai(headtext = 电子邮箱,name = emai,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = tyna(headtext = 客户类型,name = tyna,width = 90,headtype = sort,align = center , type =text , datatype = string);
						     	gcid = cous(headtext = 联系人,name = cous,width = 90,headtype = sort,align = center,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{customerMB.sellist}" />
						<h:inputHidden id="msg" value="#{customerMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{customerMB.getSimpleBean}"
							reRender="editpanel,outPan,outTable" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{customerMB.selid}" />
						<h:inputHidden id="updateflag" value="#{customerMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									客户编码：
								</td>
								<td>
									<h:inputText id="cuid" value="#{customerMB.bean.cuid}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>

								<td bgcolor="#efefef">
									组织架构:
								</td>
								<td>
									<h:selectOneMenu id="orid" value="#{customerMB.bean.orid}">
										<f:selectItems value="#{OrgaMB.subList}" />
									</h:selectOneMenu>
								</td>
							</tr>

							<tr>
								<td bgcolor="#efefef">
									客户名称：
								</td>
								<td>
									<h:inputText id="cuna" value="#{customerMB.bean.cuna}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									客户简称：
								</td>
								<td>
									<h:inputText id="cecu" value="#{customerMB.bean.cecu}"
										styleClass="inputtext" onfocus="this.select()">
									</h:inputText>
								</td>

							</tr>
							<tr>
								<td bgcolor="#efefef">
									联系人：
								</td>
								<td>
									<h:inputText id="cous" value="#{customerMB.bean.cous}"
										styleClass="inputtext" onfocus="this.select()">
									</h:inputText>
								</td>

								<td bgcolor="#efefef">
									联系电话：
								</td>
								<td>
									<h:inputText id="phon" value="#{customerMB.bean.phon}"
										styleClass="inputtext" onfocus="this.select()" />

								</td>

							</tr>
							<tr>
								<td bgcolor="#efefef">
									电子邮箱：
								</td>
								<td>
									<h:inputText id="emai" value="#{customerMB.bean.emai}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
								<td bgcolor="#efefef">
									客户类型：
								</td>
								<td>
									<h:inputText id="tyna" value="#{customerMB.bean.tyna}"
										styleClass="inputtext" onfocus="this.select()" />
									<h:inputHidden id="ctco" value="#{customerMB.bean.ctco}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectCategory();" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									所属地区：
								</td>
								<td>
									<h:inputText id="gena" value="#{customerMB.bean.gena}"
										styleClass="inputtext" onfocus="this.select()" />
									<h:inputHidden id="geid" value="#{customerMB.bean.geid}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectGeid();" />
								</td>
								<td bgcolor="#efefef">
									所属供应商：
								</td>
								<td>
									<h:inputText id="lpco" value="#{customerMB.bean.lpco}"
										styleClass="inputtext" onfocus="this.select()" />
									
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectLpco();" />
								</td>

							</tr>
							<tr>
								<td bgcolor="#efefef">
									默认路线：
								</td>
								<td>
									<h:selectOneMenu id="lico" value="#{customerMB.bean.lico}"
										styleClass="selectItem">
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{lineMB.itemlist}" />
									</h:selectOneMenu>
								</td>
								<td bgcolor="#efefef">
									辅助编码：
								</td>
								<td>
									<h:inputText id="erpc" value="#{customerMB.bean.erpc}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
							
							</tr>
							<tr>
									<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{customerMB.bean.stat}"
										styleClass="selectItem">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<%-- 
							<tr>
								<td bgcolor="#efefef">
									远梦集团：
								</td>
								<td>
									<h:selectOneMenu id="isym" value="#{customerMB.bean.isym}"
										styleClass="selectItem" onchange="changeIsym();">
										<f:selectItem itemLabel="否" itemValue="0" />
										<f:selectItem itemLabel="是" itemValue="1" />
									</h:selectOneMenu>
								</td>
								<td id="conatd">
									<h:outputText value="目标仓库:" style="BACKGROUND:#efefef;height:22px;"
										rendered="#{customerMB.bean.isym=='1'?true:false}" />
								</td>
								<td id="coritd">
									<h:selectOneMenu id="cori" value="#{customerMB.bean.cori}"
										rendered="#{customerMB.bean.isym=='1'?true:false}" >
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{OrgaMB.list}" />
									</h:selectOneMenu>
								</td>
							</tr>
							--%>
							<tr>
								<td bgcolor="#efefef">
									地址：
								</td>
								<td colspan="3">
									<h:inputText id="adde" value="#{customerMB.bean.adde}"
										styleClass="inputtext" onfocus="this.select()" size="80" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="rema" value="#{customerMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="80" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">

									<a4j:commandButton id="saveid" action="#{customerMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{customerMB.MOD}" />
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