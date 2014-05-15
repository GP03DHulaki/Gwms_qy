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
	if (request.getParameter("cuid") != null&&request.getParameter("cuid")!="") {
	    ai.setCuid(request.getParameter("cuid"));
	}
%>

<html>
	<head>
		<title>客户仓库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
	
		<script type="text/javascript" src="cuwh.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
	</head>
	<f:view>
	<body onload="clearData();" id=mmain_body>
		<div id=mmain>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										reRender="renderSite,out_List,msg"
										onmouseout="this.className='a4j_buton'"
										rendered="true" styleClass="a4j_but" tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{customerMB.deletecuwh}" rendered="true"
										onclick="if(!deleteAll(gtable2)){return false};"
										reRender="renderSite,out_List,msg" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										 />
									<a4j:commandButton onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										id="sid" value="查询" type="button" action="#{customerMB.searchwaho}"
										reRender="out_List" requestDelay="50" />
									<a4j:commandButton type="button" value="重置" onclick="clearlpbl();"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
								</div>
								<div id=mmain_cnd>
									<h:outputText value="仓库:">
									</h:outputText>
									<h:inputText id="name" styleClass="inputtextedit" size="15"
										value="#{customerMB.sk_waho}" onkeypress="formsubmit(event);" />
								</div>
								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable2" gtype="grid" gversion="2"
										gdebug="false" gpage="(pagesize=15)"
										gselectsql="
											select a.id as id,a.stat, a.waid,a.wana,a.chie,a.rema,a.addr,
											a.cute,a.reco,a.cuad,a.saar,a.ards,a.sadp,a.dpds,a.acgr,a.grds from cuwh a 
											where a.cuid='#{customerMB.cuid}' #{customerMB.searchwahosql } "
										gcolumn="gcid = id(headtext = selall,name = id,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
						        			gcid = -1(headtext = 操作,value=编辑, name = edit,width = 40,headtype = sort,align =center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[id]'),datatype=string);
						        			gcid = cute(headtext = 客户电话,name = cute,width = 120,headtype = sort,align = left,type = text, datatype = string);
						        			gcid = reco(headtext = 收货联系人,name = reco,width = 70,headtype = sort,align = left,type = text, datatype = string);
						        			gcid = cuad(headtext = 客户地址,name = cuar,width = 140,headtype = sort,align = left,type = text);
											gcid = waid(headtext = 仓库编码,name = waid,width = 70,headtype = sort,align = left,type = text);
											gcid = wana(headtext = 仓库名称,name = wana,width = 120,headtype = sort,align = left,type = text);
							    			gcid = chie(headtext = 联系人,name = chie,width = 70,headtype = sort,align = left,type = text, datatype = string);
											gcid = addr(headtext = 地址,name = addr,width = 80,headtype = sort,align = left,type = text);
											gcid = saar(headtext = 销售地区,name = saar,width = 80,headtype = sort,align = left,type = text, datatype = string);
						        			gcid = ards(headtext = 销售地区描述,name = ards,width = 100,headtype = sort,align = left,type = text, datatype = string);
						        			gcid = sadp(headtext = 销售部门,name = sadp,width = 80,headtype = sort,align = left,type = text);
											gcid = dpds(headtext = 销售地区描述,name = dpds,width = 100,headtype = sort,align = left,type = text, datatype = string);
											gcid = acgr(headtext = 账户组,name = acgr,width = 80,headtype = sort,align = left,type = text);
											gcid = grds(headtext = 账户组描述,name = grds,width = 100,headtype = sort,align = left,type = text, datatype = string);
											gcid =stat(headtext = 状态,name = stat,width = 50,headtype = sort,align = left,type = mask,typevalue=1:有效/0:无效,datatype=string);
											gcid = rema(headtext = 客户仓库描述,name = rema,width = 140,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								 <h:inputHidden id="sellist" value="#{customerMB.sellist}"></h:inputHidden>
								 <h:inputHidden id="msg" value="#{customerMB.msg}"></h:inputHidden>
							</h:form>
						</div>
					</div>
		</div>
		
			<div id="edit" style="display: none">
				<h:form id="edit">
					<div id=mmain_hide>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{customerMB.getCuwhBeanById}"
							reRender="editpanel,outPan,out_List" oncomplete="edit_show();" />
						<h:inputHidden id="selid" value="#{customerMB.selid}" />
						<h:inputHidden id="gorid" value="#{customerMB.gorid}" />
						<h:inputHidden id="updateflag" value="#{customerMB.updateflag}"></h:inputHidden>
					</div>
					<a4j:outputPanel id="editpanel">
						<table align=center>
							<tr>
								<td bgcolor="#efefef">
									仓库编码：
								</td>
								<td>
									<h:inputText id="wana" value="#{customerMB.cuwhBean.wana}"
										styleClass="inputtext" onfocus="this.select()" />
									<h:inputHidden id="waid" value="#{customerMB.cuwhBean.waid}" />
									<img id="waid_img" style="cursor: pointer"
										src="../../images/find.gif" onclick="selectwaid();" />
								</td>
								 <td bgcolor="#efefef">
									联系人：
								</td>
								<td>
									<h:inputText id="chie" value="#{customerMB.cuwhBean.chie}"
										styleClass="inputtext" onfocus="this.select()">
									</h:inputText>
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									地址：
								</td>
								<td colspan="3">
									<h:inputText id="addr" value="#{customerMB.cuwhBean.addr}"
										styleClass="inputtext" onfocus="this.select()" size="80" />
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									状态：
								</td>
								<td>
									<h:selectOneMenu id="stat" value="#{customerMB.cuwhBean.stat}"
										styleClass="selectItem">
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
									<h:inputText id="rema" value="#{customerMB.cuwhBean.rema}"
										styleClass="inputtext" onfocus="this.select()" size="80" />
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">

									<a4j:commandButton id="saveid" action="#{customerMB.savecuwh}"
										value="保存" reRender="output,out_List,msg,tree"
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