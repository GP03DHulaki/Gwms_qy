<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.SupplierMB"%>
<%@page import="com.gwall.pojo.base.SupplierBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
	SupplierMB ai = (SupplierMB) MBUtil.getManageBean("#{supplierMB}");
	if(request.getParameter("isAll") != null){
		ai.initSearchKey(new SupplierBean());		
	}
%>
<html>
	<head>
		<title>供应商档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="supplier.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript">
		function showTab2(){
			iframeRici = $("iframeRici");
			iframeRici.src="suco.jsf":
			showTab('tabs2','tabContent2');
		}
		</script>
	</head>
	<f:view>
		<body id=mmain_body>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'" onmouseout="this.className='a4j_buton'" 
							rendered="#{supplierMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{supplierMB.delete}" rendered="#{supplierMB.ADD}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{supplierMB.LST}">
							<a4j:commandButton id="query" value="查询" action="#{supplierMB.search}"
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
						供应商编码:
						<h:inputText id="suid" value="#{supplierMB.sk_obj.suid}"
								styleClass="inputtextedit" />
						辅助编码:
						<h:inputText id="erpc" value="#{supplierMB.sk_obj.erpc}"
								styleClass="inputtextedit" />
						供应商名称:
						<h:inputText id="suna" value="#{supplierMB.sk_obj.suna}"
							styleClass="inputtextedit" />
					</div>
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gsort="suid" gsortmethod="DESC"
							gselectsql="Select a.id,a.orid,a.suid,g.orna,a.erpc,a.ceve,a.suna,a.adde,a.cous,a.phon,a.emai,a.stat,a.stco,b.tyna,a.rema From suin a left join suty b on a.stco = b.stco 
								left join orga g on g.orid = a.orid  
								Where 1=1 #{supplierMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							   	gcid = orna(headtext = 组织架构,name = orna,width = 90,headtype = sort,align = left,type = text,datatype=string);
								gcid = suid(headtext = 供应商编码,name = suid,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = erpc(headtext = 辅助编码,name = erpc,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = suna(headtext = 供应商名称,name = suna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = ceve(headtext = 供应商简称,name = ceve,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = phon(headtext = 联系电话,name = phon,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = adde(headtext = 地址,name = adde,width = 120,headtype = sort,align = left,type = text,datatype=string);
							    gcid = emai(headtext = 电子邮箱,name = emai,width = 90,headtype = sort,align = left,type = text,datatype=string);
							    gcid = tyna(headtext = 供应商类型,name = tyna,width = 90,headtype = sort,align = center , type =text , datatype = string);
						     	gcid = cous(headtext = 联系人,name = cous,width = 90,headtype = sort,align = center,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						        gcid = rema(headtext = 备注,name = rema,width = 90,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{supplierMB.sellist}" />
						<h:inputHidden id="msg" value="#{supplierMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<div id="tabsHead">
					<a class="curtab" id="tabs1"
						href="javascript:showTab('tabs1','tabContent1')" title="供应商详情">供应商详情</a>
				</div>
				<div id="tabsBody">
					<div id="tabContent1" class="curtab_body">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{supplierMB.getSimpleBean}" reRender="editpanel,outTable"
							oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{supplierMB.selid}" />
						<h:inputHidden id="updateflag" value="#{supplierMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									供应商编码：
								</td>
								<td>
									<h:inputText id="suid" value="#{supplierMB.bean.suid}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
										组织架构:
								</td>
								<td>
										<h:selectOneMenu id="orid" value="#{supplierMB.bean.orid}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
								</td>
								
							</tr>
							<tr>
								<td bgcolor="#efefef">
									供应商名称：
								</td>
								<td>
									<h:inputText id="suna" value="#{supplierMB.bean.suna}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									辅助编码：
								</td>
								<td>
									<h:inputText id="erpc" value="#{supplierMB.bean.erpc}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								
							</tr>
							<tr>	
								<td bgcolor="#efefef">
									供应商简称：
								</td>
								<td>
									<h:inputText id="ceve" value="#{supplierMB.bean.ceve}"
										styleClass="inputtext" onfocus="this.select()">
									</h:inputText>
								</td>
								<td bgcolor="#efefef">
									联系人：
								</td>
								<td>
									<h:inputText id="cous" value="#{supplierMB.bean.cous}"
										styleClass="inputtext" onfocus="this.select()">
									</h:inputText>
								</td>
								
							</tr>
							<tr>
								<td bgcolor="#efefef">
									联系电话：
								</td>
								<td>
									<h:inputText id="phon" value="#{supplierMB.bean.phon}"
										styleClass="inputtext" onfocus="this.select()" />

								</td>
								<td bgcolor="#efefef">
									电子邮箱：
								</td>
								<td>
									<h:inputText id="emai" value="#{supplierMB.bean.emai}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
								
							</tr>
							<tr>
								<td bgcolor="#efefef">
									供应商类型：
								</td>
								<td>
									<h:inputText id="suty" value="#{supplierMB.bean.suty}"
										styleClass="inputtext" onfocus="this.select()" />
									<h:inputHidden id="stco" value="#{supplierMB.bean.stco}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectSuty();" />
								</td>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{supplierMB.bean.stat}"
										styleClass="selectItem">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
						
							<tr>
								<td bgcolor="#efefef">
									所属地区：
								</td>
								<td>
									<h:inputText id="gena" value="#{supplierMB.bean.gena}"
										styleClass="inputtext" onfocus="this.select()" />
									<h:inputHidden id="geid" value="#{supplierMB.bean.geid}" />
									<img id="whid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectGeid();" />
								</td>
								
							</tr>
							<tr>
							  <td bgcolor="#efefef">
									地址：
								</td>
								<td colspan="3">
									<h:inputText id="adde" value="#{supplierMB.bean.adde}" 
										styleClass="inputtext" onfocus="this.select()" size="70" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									备注：
								</td>
								<td colspan="3">
									<h:inputText id="rema" value="#{supplierMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="70" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									
									<a4j:commandButton id="saveid" action="#{supplierMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{supplierMB.MOD}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>
							<div style="display: none;">
							<a4j:commandButton id="refBut" value="隐藏按钮"
								reRender="editpanel" style="display:none;" />
						</div>
					</a4j:outputPanel>
				</h:form>
				</div>
				<div id="tabContent2" >
					
				</div>
				</div>
			</div>
		</body>
	</f:view>
</html>