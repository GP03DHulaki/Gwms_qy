<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.StorefileMB"%>
<%@page import="com.gwall.pojo.base.StorefileBean"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>


<%
    StorefileMB ai = (StorefileMB) MBUtil
            .getManageBean("#{storefileMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSearchKey(new StorefileBean());
    }
%>
<html>
	<head>
		<title>店铺档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="storefile.js"></script>
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
							rendered="#{storefileMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{storefileMB.delete}" rendered="#{storefileMB.DEL}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp" rendered="#{storefileMB.LST}">
							<a4j:commandButton id="query" value="查询"
								action="#{storefileMB.search}"
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
						店铺编码:
						<h:inputText id="dpid" value="#{storefileMB.sk_obj.dpid}"
							styleClass="inputtextedit" />
						店铺名称:
						<h:inputText id="dpmc" value="#{storefileMB.sk_obj.dpmc}"
							styleClass="inputtextedit" />
					</div>
					<h:panelGrid id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gselectsql="Select a.id,a.dpid,a.dpmc,a.dpdz,a.stat,a.rema,b.plna From strf a
								LEFT join pltf b on a.plid=b.plid
								Where 1=1 #{storefileMB.searchSQL}"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[id]),datatype=string);
							    gcid = dpid(headtext = 店铺编码,name = dpid,width = 90,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = dpmc(headtext = 店铺名称,name = dpmc,width = 150,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = plna(headtext = 所属平台,name = plna,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = dpdz(headtext = 店铺地址,name = dpdz,width = 120,headtype = sort,align = left,type = text,datatype=string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string);
						        gcid = rema(headtext = 备注,name = rema,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</h:panelGrid>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{storefileMB.sellist}" />
						<h:inputHidden id="msg" value="#{storefileMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
			</div>

			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{storefileMB.getSimpleBean}"
							reRender="editpanel,outTable" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{storefileMB.selid}" />
						<h:inputHidden id="updateflag" value="#{storefileMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									店铺编码：
								</td>
								<td>
									<h:inputText id="dpid" value="#{storefileMB.bean.dpid}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
								<td bgcolor="#efefef">
									店铺名称：
								</td>
								<td>
									<h:inputText id="dpmc" value="#{storefileMB.bean.dpmc}"
										styleClass="inputtext" onfocus="this.select()" />
									<span style="">*</span>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									店铺地址：
								</td>
								<td>
									<h:inputText id="dpdz" value="#{storefileMB.bean.dpdz}"
										styleClass="inputtext" onfocus="this.select()" />
								</td>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{storefileMB.bean.stat}"
										styleClass="inputtext">
										<f:selectItem itemLabel="有效" itemValue="1" />
										<f:selectItem itemLabel="注销" itemValue="0" />
									</h:selectOneMenu>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									所属平台：
								</td>
								<td>
									<h:selectOneMenu id="plid" value="#{storefileMB.bean.plid}"
										styleClass="inputtext">
										<f:selectItems value="#{storefileMB.pltfList}" />
									</h:selectOneMenu>
								</td>
								<td bgcolor="#efefef">
									独立拣货：
								</td>
								<td>
									<h:selectOneMenu id="alpk" value="#{storefileMB.bean.alpk}"
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
									<h:inputText id="rema" value="#{storefileMB.bean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="65" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{storefileMB.save}"
										value="保存" reRender="output,outTable,msg,tree,out_List"
										onclick="if(!formCheck()){return false};"
										oncomplete="endDo();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{storefileMB.MOD}" />
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