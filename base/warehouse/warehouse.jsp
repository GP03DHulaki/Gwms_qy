<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.WarehouseMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
    WarehouseMB ai = (WarehouseMB) MBUtil
            .getManageBean("#{warehouseMB}");
    if (request.getParameter("isAll") != null) {
        ai.setSearchSQL("");
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库位资料</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="warehouse.js"></script>
		<script type="text/javascript" src="gtree.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
		<script type="text/javascript">
			function gotoWarehousexls(){
				window.open("<%=request.getContextPath()%>/base/warehouse/warehousexls.jsf");												
			}	
		</script>
	</head>
	<body onload="clearData();" id=mmain_body>
		<div id=mmain>
			<f:view>
				<div id="tabDiv">
					<div id="tabsHead">
						<a class="curtab" id="tabs1"
							href="javascript:showTab('tabs1','tabContent1')" title="列表">列表</a>
						<a class="tabs" id="tabs2"
							href="javascript:showTab('tabs2','tabContent2');" title="库位资料">库位资料</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<h:form id="list">
								<div id=mmain_opt>
									<a4j:commandButton id="saveButton" value="新增"
										onclick="addDiv();" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'"
										rendered="#{warehouseMB.ADD}" styleClass="a4j_but"
										tabindex="5" />
									<a4j:commandButton id="delButton" value="删除" type="button"
										action="#{warehouseMB.delete}"
										onclick="if(!deleteAll(gtable)){return false};"
										reRender="renderArea,msg,out_List" oncomplete="endDo();"
										requestDelay="50" onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{warehouseMB.DEL}" />
									<h:panelGroup id="sp" rendered="#{warehouseMB.LST}">
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											id="sid" value="查询" type="button" onclick="startDo();"
											action="#{warehouseMB.selectVoucherid}" reRender="out_List"
											oncomplete="Gwin.close('progress_id');" requestDelay="50" />
										<a4j:commandButton value="重置"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											onclick="clearData();" />
									</h:panelGroup>
									<a4j:commandButton onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										id="excel" value="导出EXCEL" type="button"
										action="#{warehouseMB.exportProcedureProduct}"
										reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
										oncomplete="excelios_end();" requestDelay="50" />
									<a4j:commandButton id="inButton" value="导入excel"
										rendered="#{warehouseMB.EXP}"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										onclick="showImport();" requestDelay="50" />
									<a4j:commandButton id="chieButton" value="批量修改货主"
										rendered="#{warehouseMB.EXP&&false}"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
										onclick="gotoWarehousexls();" requestDelay="50" />
									<a4j:commandButton type="button" value="打印条码"
										onmouseover="this.className='a4j_over1'"
										onmouseout="this.className='a4j_buton1'"
										action="#{warehouseMB.printCode}"
										rendered="#{warehouseMB.LST}" styleClass="a4j_but1"
										onclick="if(!print()){return false};"
										oncomplete="lookPrint();"
										reRender="renderArea,outTable,output" requestDelay="1000" />

									<div>
										<a4j:outputPanel id="out" rendered="#{(warehouseMB.SPE)}">
											<table height="8px">
												<tr>
													<td>
														<a4j:commandButton id="unlock" value="解锁/锁定"
															rendered="#{warehouseMB.SPE}" reRender="renderArea,msg"
															action="#{warehouseMB.unlock}" styleClass="a4j_but1"
															onclick="if(!chooselock(gtable)){return false};"
															oncomplete="endchooselock();" requestDelay="50" />
													</td>
													<td>
														<h:selectOneRadio id="radio"
															value="#{warehouseMB.bean.isar}"
															rendered="#{warehouseMB.SPE}">
															<f:selectItem itemLabel="锁定" itemValue="0" />
															<f:selectItem itemLabel="解锁" itemValue="1" />
														</h:selectOneRadio>
													</td>
												</tr>
											</table>
										</a4j:outputPanel>
									</div>
								</div>
								<div id=mmain_cnd>
									<h:panelGroup id="sps" rendered="#{warehouseMB.LST}">
										库位编号:
									<h:inputText id="whid" styleClass="inputtext" size="12"
											value="#{warehouseMB.bean.whid}"
											onkeypress="formsubmit(event);" />
									辅助编码:
									<h:inputText id="ewid" styleClass="inputtext" size="12"
											value="#{warehouseMB.bean.ewid}"
											onkeypress="formsubmit(event);" />
										&nbsp; 库位名称:
									<h:inputText id="whna" styleClass="inputtext" size="15"
											value="#{warehouseMB.bean.whna}"
											onkeypress="formsubmit(event);" />
									</h:panelGroup>
									<h:outputText value="组织架构:">
									</h:outputText>
									<h:selectOneMenu id="orid" value="#{warehouseMB.bean.orid}"
										onchange="doSearch();">
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{OrgaMB.subList}" />
									</h:selectOneMenu>
									<h:outputText value="库位标识:">
									</h:outputText>
									<h:selectOneMenu id="whtys" value="#{warehouseMB.bean.whty}"
										styleClass="selectItem" onchange="doSearch();">
										<f:selectItem itemLabel="" itemValue="" />
										<f:selectItems value="#{warehouseMB.typeItem}" />
									</h:selectOneMenu>
								</div>

								<a4j:outputPanel id="out_List">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gpage="(pagesize=20)"
										gselectsql="Select waho.id,g.orna,whid,whna,pwid,whty,waho.stat,waho.lonu,waho.chie,owid,waho.addr,waho.rema From waho left join orga g on g.orid = waho.orid Where 1=1 #{warehouseMB.sql}"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value=编辑,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text);
											gcid = whid(headtext = 库位编码,name = whid,width = 100,headtype = sort,align = left,type = text);
											gcid = whna(headtext = 库位名称,name = whna,width = 120,headtype = sort,align = left,type = text);
											gcid = pwid(headtext = 上级编码,name = pwid,width = 100,headtype = sort,align = left,type = text);
											gcid = whty(headtext = 库位标识,name = whty,width = 60,headtype = sort,align = center,type = mask,typevalue=0:地点/1:仓库/2:库区/3:楼层/4:拣货库位/5:备货库位/6:溢出库位/7:活动库位/8:质检库位/9:移动库位/10:系统库位/11:虚拟仓库/12:任务栏/13:残品库位/14:通道/99:返修库位);
											gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
											gcid = lonu(headtext = 安全库存数,name = lonu,width = 90,headtype = sort,align = center , type = text, datatype=number,dataformat=0); 
											gcid = chie(headtext = 货主,name = chie,width = 120,headtype = sort,align = left,type = text);
											gcid = owid(headtext = 默认货主,name = owid,width = 90,headtype = sort,align = center , type = text, datatype = string);
											gcid = addr(headtext = 地址,name = addr,width = 180,headtype = sort,align = left,type = text);
											gcid = rema(headtext = 备注,name = rema,width = 180,headtype = sort,align = left,type = text);
										" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{warehouseMB.sellist}"></h:inputHidden>
								<h:inputHidden id="gsql" value="#{warehouseMB.gsql}" />
								<h:inputHidden id="outPutFileName" value="#{warehouseMB.outPutFileName}" />
								<h:inputHidden id="msg" value="#{warehouseMB.msg}"></h:inputHidden>
							</h:form>
							<div id="import" style="display: none" align="left">
								<h:form id="file" enctype="multipart/form-data">
									<t:inputFileUpload id="upFile" styleClass="upfile"
										storage="file" value="#{warehouseMB.myFile}" required="true"
										size="75" />
									<div id="mes"></div>
									<div align="center">
										<gw:GAjaxButton value="上传" onclick="return doImport();"
											id="import" theme="a_theme" />
										<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
											onclick="hideDiv()" type="button" />
									</div>
									<div style="display: none;">
										<h:commandButton value="上传" id="importBut"
											action="#{warehouseMB.uploadFileWhid}" />
									</div>
								</h:form>
							</div>
						</div>
						<div id="tabContent2" class="hidetab_body">
							<a4j:outputPanel id="tree">
								<div id="treeInit" onselectstart="return false;"
									style="white-space: nowrap; height =100%; overflow: auto;"></div>
								<script type="text/javascript">GTree.init();</script>
							</a4j:outputPanel>
						</div>
					</div>
					<div id="edit" style="display: none">
						<h:form id="edit">
							<div id=mmain_hide>
								<a4j:commandButton id="editbut" value="编辑" type="button"
									action="#{warehouseMB.getWarehouseinfo}" reRender="editpanel"
									oncomplete="edit_show();" requestDelay="50" />
								<h:inputHidden id="selid" value="#{warehouseMB.selid}"></h:inputHidden>
								<h:inputHidden id="updateflag" value="#{warehouseMB.updateflag}"></h:inputHidden>
							</div>
							<a4j:outputPanel id="editpanel">
								<table align=center>
									<tr>
										<td bgcolor="#efefef">
											上级编码:
										</td>
										<td>
											<h:selectOneMenu id="pwid" value="#{warehouseMB.bean.pwid}"
												onchange="setCode();">
												<f:selectItem itemLabel="ROOT" itemValue="ROOT" />
												<f:selectItems value="#{warehouseMB.list}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											辅助编码:
										</td>
										<td>
											<h:inputText id="ewid" styleClass="inputtext"
												value="#{warehouseMB.bean.ewid}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											库位编码:
										</td>
										<td>
											<h:inputText id="prefix" styleClass="inputtext" size="10"
												style="display:none;" value="#{warehouseMB.prefix}" />
											<h:inputText id="whid" styleClass="inputtext"
												value="#{warehouseMB.bean.whid}" />
										</td>
										<td bgcolor="#efefef">
											库位名称:
										</td>
										<td>
											<h:inputText id="whna" styleClass="inputtext"
												value="#{warehouseMB.bean.whna}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											库位属性:
										</td>
										<td>
											<h:selectOneMenu id="whfl" value="#{warehouseMB.bean.whfl}"
												styleClass="selectItem">
												<f:selectItem itemLabel="可存放区" itemValue="P" />
												<f:selectItem itemLabel="非存放区" itemValue="T" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											库位标识:
										</td>
										<td>
											<h:selectOneMenu id="whty" value="#{warehouseMB.bean.whty}"
												styleClass="selectItem">
												<f:selectItems value="#{warehouseMB.typeItem}" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											所属组织:
										</td>
										<td>
											<h:selectOneMenu id="orid" value="#{warehouseMB.bean.orid}">
												<f:selectItem itemLabel="" itemValue="" />
												<f:selectItems value="#{OrgaMB.subList}" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											所属工作组:
										</td>
										<td>
											<h:inputText id="wogr" styleClass="inputtext"
												value="#{warehouseMB.bean.wogr}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											控制属性:
										</td>
										<td>
											<h:selectOneMenu id="cofl" value="#{warehouseMB.bean.cofl}"
												styleClass="selectItem">
												<f:selectItem itemLabel="不控制" itemValue="N" />
												<f:selectItem itemLabel="体积控制" itemValue="V" />
												<f:selectItem itemLabel="重量控制" itemValue="W" />
												<f:selectItem itemLabel="体积+重量控制" itemValue="A" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											是否允许拣货:
										</td>
										<td>
											<h:selectOneMenu id="isar" value="#{warehouseMB.bean.isar}"
												styleClass="selectItem">
												<f:selectItem itemLabel="不允许" itemValue="0" />
												<f:selectItem itemLabel="允许" itemValue="1" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											最大体积:
										</td>
										<td>
											<h:inputText id="volu" styleClass="inputtext"
												value="#{warehouseMB.bean.volu}" onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											最大重量:
										</td>
										<td>
											<h:inputText id="bear" styleClass="inputtext"
												value="#{warehouseMB.bean.bear}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											长:
										</td>
										<td>
											<h:inputText id="vole" styleClass="inputtext"
												value="#{warehouseMB.bean.vole}" onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											宽:
										</td>
										<td>
											<h:inputText id="vowi" styleClass="inputtext"
												value="#{warehouseMB.bean.vowi}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											高:
										</td>
										<td>
											<h:inputText id="vohe" styleClass="inputtext"
												value="#{warehouseMB.bean.vohe}" onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											层级:
										</td>
										<td>
											<h:inputText id="leve" styleClass="inputtext"
												value="#{warehouseMB.bean.leve}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											货主:
										</td>
										<td>
											<h:inputText id="chie" styleClass="inputtext"
												value="#{warehouseMB.bean.chie}" onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											联系方式:
										</td>
										<td>
											<h:inputText id="tele" styleClass="inputtext"
												value="#{warehouseMB.bean.tele}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											地址:
										</td>
										<td>
											<h:inputText id="addr" styleClass="inputtext"
												value="#{warehouseMB.bean.addr}" size="17"
												onfocus="this.select()" />
										</td>
										<td bgcolor="#efefef">
											状态:
										</td>
										<td>
											<h:selectOneMenu id="stat" value="#{warehouseMB.bean.stat}"
												styleClass="selectItem">
												<f:selectItem itemLabel="有效" itemValue="1" />
												<f:selectItem itemLabel="注销" itemValue="0" />
											</h:selectOneMenu>
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											仓库类型:
										</td>
										<td>
											<h:selectOneMenu id="ifib" value="#{warehouseMB.bean.ifib}"
												style="width:130px;" title="设置为托管仓,则系统自动增加托管仓出入库库存">
												<f:selectItem itemLabel="" itemValue="" />
												<f:selectItem itemLabel="自有仓" itemValue="0" />
												<f:selectItem itemLabel="托管仓" itemValue="1" />
											</h:selectOneMenu>
										</td>
										<td bgcolor="#efefef">
											允许调拨锁定:
										</td>
										<td>
											<h:selectOneMenu id="islk" value="#{warehouseMB.bean.islk}"
												style="width:130px;">
												<f:selectItem itemLabel="否" itemValue="0" />
												<f:selectItem itemLabel="是" itemValue="1" />
											</h:selectOneMenu>
										</td>
									<tr>
									<tr>
										<td bgcolor="#efefef">
											仓库默认库位：
										</td>
										<td>
											<h:inputText id="dewh" value="#{warehouseMB.bean.dewh}"
												styleClass="inputtext" onfocus="this.select()" size="17" />
										</td>
										<td bgcolor="#efefef">
											默认货主：
										</td>
										<td>
											<h:inputText id="owid" value="#{warehouseMB.bean.owid}"
												styleClass="inputtext" onfocus="this.select()" size="17" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											安全库存：
										</td>
										<td>
											<h:inputText id="lonu" value="#{warehouseMB.bean.lonu}"
												styleClass="inputtext" onfocus="this.select()" size="17" />
										</td>
									</tr>
									<tr>
										<td bgcolor="#efefef">
											备注:
										</td>
										<td colspan="3">
											<h:inputText id="rema" styleClass="inputtext" size="60"
												value="#{warehouseMB.bean.rema}" onfocus="this.select()" />
										</td>
									</tr>
									<tr>
										<td colspan="4" align="center">
											<a4j:outputPanel id="renderArea">
												<h:inputHidden id="msg" value="#{warehouseMB.msg}"></h:inputHidden>
												<h:inputHidden id="filename" value="#{warehouseMB.fileName}"></h:inputHidden>
											</a4j:outputPanel>
											<a4j:commandButton id="saveid" action="#{warehouseMB.save}"
												value="保存" reRender="out_List,msg,tree"
												onclick="if(!formCheck()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												rendered="#{warehouseMB.MOD}" />
											<a4j:commandButton onmouseover="this.className='a4j_over'"
												onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
												value="返回" onclick="hideDivs();" />
										</td>
									</tr>
								</table>
							</a4j:outputPanel>
						</h:form>
					</div>
				</div>
			</f:view>
		</div>
	</body>
</html>