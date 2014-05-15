<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@page import="com.gwall.view.InventoryMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
    InventoryMB ai = (InventoryMB) MBUtil
            .getManageBean("#{InventoryMB}");
    if (request.getParameter("isAll") != null) {
        ai.initPage();
    } else {
        ai.setGtableParam(request, ai);
    }
    ai.setFilePath(request.getContextPath());
%>
<html>
	<head>
		<title>商品档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="inventory.js"></script>
		<script type="text/javascript" src="gtree.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/GwallJS/Gtab/Gtab.js'></script>
		<script type="text/javascript">
			Gtab.fnclick = function( obj ){
				var iframeimg = document.getElementById("iframeImg");
				var Gimg = iframeimg.contentWindow.Gimg;
				if(iframeimg.src == "about:blank"){
					iframeimg.src = "../../GwallJS/Gimg/imgManage.jsp";
				}else{
					if(Gimg.submitfn == null){
						Gimg.submitfn = function( path ){ //选择图片后的确认事件
							$('edit:imgPath').value=path;
							$('edit:saveImg').click();
						}
					}
					if(obj.id == "showImg"){//传递参数过去.告诉选中哪些图片.
						var select = $('edit:imgPath').value;
						if(Gimg.selectPathList != select) 
							Gimg.setSelect(select);
					}
				}
			}
		</script>

	</head>
	<f:view>
		<body id=mmain_body onload="Gtab.init('Gtab01');">
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							rendered="#{InventoryMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{InventoryMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							rendered="#{InventoryMB.DEL}" reRender="outTable,msg"
							oncomplete="endDo('delinventory1');" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp">
							<a4j:commandButton id="query" value="查询"
								action="#{InventoryMB.query}" onclick="startDo('正在查询...');"
								rendered="#{InventoryMB.LST}"
								oncomplete="Gwin.close('progress_id');"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable">
								<a4j:actionparam assignTo="#{InventoryMB.gpage}" name="page"
									value="1" />
							</a4j:commandButton>
							<a4j:commandButton value="重置" rendered="#{InventoryMB.LST}"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{InventoryMB.exportmstinvExcel}"
								rendered="#{InventoryMB.EXP}" reRender="msg,outPutFileName"
								onclick="excelstock_begin('gtable2');"
								oncomplete="excelstock_end();" requestDelay="50" />
					    	<a4j:commandButton id="inButton" value="导入excel"
								rendered="#{InventoryMB.EXP}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="showImport();" requestDelay="50" />		
						</h:panelGroup>
						<a4j:commandButton type="button" value="打印条码"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{InventoryMB.printCode}" rendered="#{InventoryMB.PRN}"
							styleClass="a4j_but1" onclick="if(!print()){return false};"
							oncomplete="lookPrint();" reRender="renderArea,outTable"
							requestDelay="1000" />


						<a4j:commandButton type="button" value="打印条码3"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{InventoryMB.printInvCode}"
							rendered="#{false && InventoryMB.PRN}" styleClass="a4j_but1"
							onclick="if(!print()){return false};" oncomplete="lookPrint();"
							reRender="renderArea,outTable" requestDelay="500" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel rendered="#{InventoryMB.LST}">
						商品编码:
						<h:inputText id="sk_inco" value="#{InventoryMB.sk_obj.inco}"
								styleClass="inputtextedit" />
						商品名称:
						<h:inputText id="sk_inna" value="#{InventoryMB.sk_obj.inna}"
								styleClass="inputtextedit" />
						货号:
						<h:inputText id="sk_tyco" value="#{InventoryMB.sk_tyco}"
								styleClass="inputtextedit" />
						规格:
						<h:inputText id="sk_colo" value="#{InventoryMB.sk_obj.colo}"
								styleClass="inputtextedit" />
						规格码:
						<h:inputText id="sk_inst" value="#{InventoryMB.sk_obj.inse}"
								styleClass="inputtextedit" />
							<br>
						商品类别:
						<h:inputText id="sk_tyna" value="#{InventoryMB.sk_obj.tyna}"
								styleClass="inputtextedit" />
							<img id="tyna_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSK_Inty();" />
						属性:
						<h:selectOneMenu id="sk_inpr" value="#{InventoryMB.sk_obj.inpr}"
						styleClass="inputtextedit" 		style="width:130ps;">
								<f:selectItem itemLabel="全部" itemValue="0" />
								<f:selectItem itemLabel="成品" itemValue="P" />
								<f:selectItem itemLabel="半成品" itemValue="S" />
								<f:selectItem itemLabel="原材料" itemValue="M" />
							</h:selectOneMenu>
						</a4j:outputPanel>
						默认货主:
						<h:inputText id="sk_owid" value="#{InventoryMB.sk_owid}"
								styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gsort="#{InventoryMB.gsort}"
							gsortmethod="#{InventoryMB.gsortmethod}"
							gselectsql="Select a.id,a.inco,a.inna,a.tyco,a.colo,a.inse,b.tyna,
										a.stat,a.owid,a.inpr,isnull(a.bupr,0) as bupr
										from inve a 
										left join prty b on a.inty = b.inty 
										left join brin c on a.bran = c.bran 
										Where   #{InventoryMB.searchKey}"
							gpage="(pagesize = #{InventoryMB.gpagesize})" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1],'gcolumn[inpr]'),datatype=string);
							    gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = tyco(headtext = 货号,name = tyco,width = 90,headtype = sort,align = center , type = text, datatype = string);
						     	gcid = colo(headtext = 规格名称,name = colo,width = 80,headtype = sort,align = left , type = text , datatype = string);
						     	gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
							    gcid = tyna(headtext = 商品类别,name = tyna,width = 90,headtype = sort,align = center , type = text, datatype = string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = hidden , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string);
						        gcid = owid(headtext = 默认货主,name = owid,width = 90,headtype = sort,align = center , type = text, datatype = string);
						        gcid = inpr(headtext = 商品属性 ,name = inpr,width = 60,headtype = sort , align = center , type = mask,typevalue={P:正常商品 /X:虚拟商品/G:赠品/M:辅料/C:耗材/B:包装/I:发票} , datatype = string);
						        gcid = bupr(headtext = 库存成本,name = bupr,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0.0); 
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{InventoryMB.sellist}" />
						<h:inputHidden id="outPutFileName"
							value="#{InventoryMB.outPutFileName}" />
						<h:inputHidden id="filename" value="#{InventoryMB.fileName}" />
						<h:inputHidden id="gsql" value="#{InventoryMB.gsql}" />
						<h:inputHidden id="gcoldatatype"
							value="#{InventoryMB.gcoldatatype}" />
						<h:inputHidden id="gcolheadtext"
							value="#{InventoryMB.gcolheadtext}" />
						<h:inputHidden id="msg" value="#{InventoryMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
									<t:inputFileUpload id="upFile" styleClass="upfile"
										storage="file" value="#{InventoryMB.myFile}" required="true"
										size="75" />
										
									<div id="mes"></div>
									
									<div align="center">
										<gw:GAjaxButton value="上传" onclick="doImport();"
											id="import" theme="a_theme" />
										<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
											onclick="hideDiv()" type="button" />
									</div>
									
									<div style="display: none;">
										<h:commandButton value="上传" id="importBut"
											action="#{InventoryMB.uploadFile}" />
									</div>
					</h:form>
				</div>
			</div>
			<%-- 
			<div id="tabContent2" class="hidetab_body">
				<a4j:outputPanel id="tree">
					<div id="treeInit" onselectstart="return false;"
						style="white-space: nowrap; height =100%; overflow: auto;"></div>
					<script type="text/javascript">GTree.init();</script>
				</a4j:outputPanel>
			</div>
			--%>
			<div id="Gtab01" gtype="Gtab" width="100%" height="100%"
				style="display: none">
				<div id="edit" glable="商品信息" height="95%">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button"
								action="#{InventoryMB.getInventory}" reRender="editpanel"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{InventoryMB.selid}" />
							<h:inputHidden id="selinpr" value="" />
							<h:inputHidden id="selflag" value="" />
							<h:inputHidden id="updateflag" value="#{InventoryMB.updateflag}"></h:inputHidden>
						</div>
						<div style="display: none">
							<h:commandButton id="saveImg" action="#{InventoryMB.saveImg}"></h:commandButton>
						</div>
						<a4j:outputPanel id="editpanel">
							<h:inputHidden id='imgPath' value="#{InventoryMB.bean.imid}"></h:inputHidden>
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										商品编码：
									</td>
									<td>
										<h:inputText id="inco" value="#{InventoryMB.bean.inco}"
											styleClass="inputtext" onfocus="this.select()" />
										<span style="">*</span>
									</td>
									<td bgcolor="#efefef">
										商品名称：
									</td>
									<td>
										<h:inputText id="inna" value="#{InventoryMB.bean.inna}"
											styleClass="inputtext" onfocus="this.select()" />
										<span style="">*</span>
									</td>
									<td bgcolor="#efefef">
										商品条码：
									</td>
									<td>
										<h:inputText id="inba" value="#{InventoryMB.bean.inba}"
											styleClass="inputtext" onfocus="this.select()">
										</h:inputText>
										<!--<span style="">*</span>
									-->
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										包装规格：
									</td>
									<td>
										<h:inputText id="past" value="#{InventoryMB.bean.past}"
											styleClass="inputtext" onfocus="this.select()" />

									</td>
									<td bgcolor="#efefef">
										商品单位：
									</td>
									<td>
										<h:inputText id="inun" value="#{InventoryMB.bean.inun}"
											styleClass="inputtext" onfocus="this.select()" />

									</td>
									<td bgcolor="#efefef">
										商品类别：
									</td>
									<td>
										<h:inputText id="tyna" value="#{InventoryMB.bean.tyna}"
											disabled="true" styleClass="inputtext" />
										<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectInty();" />
										<h:inputHidden id="inty" value="#{InventoryMB.bean.inty}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										货号：
									</td>
									<td>
										<h:inputText id="tyco" value="#{InventoryMB.bean.tyco}"
											styleClass="inputtext" onfocus="this.select()">
										</h:inputText>
										<span style="">*</span>
									</td>
									<td bgcolor="#efefef">
										号型：
									</td>
									<td>
										<h:inputText id="inst" value="#{InventoryMB.bean.inst}"
											styleClass="inputtext" onfocus="this.select()">
										</h:inputText>
									</td>
									<td bgcolor="#efefef">
										等级：
									</td>
									<td>
										<h:inputText id="sfle" value="#{InventoryMB.bean.sfle}"
											styleClass="inputtext" onfocus="this.select()">
										</h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										保质期控制：
									</td>
									<td>
										<h:selectOneMenu id="cpfl" value="#{InventoryMB.bean.cpfl}"
											styleClass="selectItem">
											<f:selectItem itemLabel="否" itemValue="N" />
											<f:selectItem itemLabel="是" itemValue="Y" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										保质期类型：
									</td>
									<td>
										<h:selectOneMenu id="cpty" value="#{InventoryMB.bean.cpty}"
											styleClass="selectItem">
											<f:selectItem itemLabel="月" itemValue="M" />
											<f:selectItem itemLabel="周" itemValue="W" />
											<f:selectItem itemLabel="日" itemValue="D" />
											<f:selectItem itemLabel="时" itemValue="H" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										保质期：
									</td>
									<td>
										<h:inputText id="cpri" value="#{InventoryMB.bean.cpri}"
											styleClass="selectItem" onfocus="this.select()">
										</h:inputText>
									</td>
								<tr>
									<td bgcolor="#efefef">
										品牌：
									</td>
									<td>
										<h:inputText id="brde" value="#{InventoryMB.bean.brde}"
											disabled="true" styleClass="inputtext" />
										<img id="inty_img" style="cursor: pointer"
											src="../../images/find.gif" onclick="selectBran();" />
										<h:inputHidden id="bran" value="#{InventoryMB.bean.bran}" />
									</td>
									<td bgcolor="#efefef">
										专属供应商：
									</td>
									<td>
										<h:inputText id="ceve" value="#{InventoryMB.bean.ceve}"
											styleClass="inputtext" onfocus="this.select()" />

									</td>
									<td bgcolor="#efefef">
										专属客户：
									</td>
									<td>
										<h:inputText id="cecu" value="#{InventoryMB.bean.cecu}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										规格名称：
									</td>
									<td>
										<h:inputText id="colo" value="#{InventoryMB.bean.colo}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										规格代码：
									</td>
									<td>
										<h:inputText id="inse" value="#{InventoryMB.bean.inse}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										体积：
									</td>
									<td>
										<h:inputText id="volu" value="#{InventoryMB.bean.volu}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										长(cm)：
									</td>
									<td>
										<h:inputText id="vole" value="#{InventoryMB.bean.vole}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										宽(cm)：
									</td>
									<td>
										<h:inputText id="vowi" value="#{InventoryMB.bean.vowi}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										高(cm)：
									</td>
									<td>
										<h:inputText id="vohe" value="#{InventoryMB.bean.vohe}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										毛重：
									</td>
									<td>
										<h:inputText id="grwe" value="#{InventoryMB.bean.grwe}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										净重：
									</td>
									<td>
										<h:inputText id="newe" value="#{InventoryMB.bean.newe}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										皮重：
									</td>
									<td>
										<h:inputText id="tawe" value="#{InventoryMB.bean.tawe}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										内包装数量：
									</td>
									<td>
										<h:inputText id="inpa" value="#{InventoryMB.bean.inpa}"
											styleClass="inputtext" onfocus="this.select()" size="8" />
									</td>
									<td bgcolor="#efefef">
										外包装数量：
									</td>
									<td>
										<h:inputText id="oupa" value="#{InventoryMB.bean.oupa}"
											styleClass="inputtext" onfocus="this.select()" size="8" />
									</td>
									<td bgcolor="#efefef">
										版本：
									</td>
									<td>
										<h:inputText id="vers" value="#{InventoryMB.bean.vers}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										类型：
									</td>
									<td>
										<h:selectOneMenu id="baty" value="#{InventoryMB.bean.baty}"
											styleClass="selectItem">
											<f:selectItem itemLabel="批次" itemValue="P" />
											<f:selectItem itemLabel="序列" itemValue="S" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										ABC分类：
									</td>
									<td>
										<h:selectOneMenu id="abcl" value="#{InventoryMB.bean.abcl}"
											styleClass="selectItem">
											<f:selectItem itemLabel="A类" itemValue="A" />
											<f:selectItem itemLabel="B类" itemValue="B" />
											<f:selectItem itemLabel="C类" itemValue="C" />
											<f:selectItem itemLabel="L类" itemValue="L" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										吊牌价格：
									</td>
									<td>
										<h:inputText id="sapr" value="#{InventoryMB.bean.sapr}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										商品属性：
									</td>
									<td>
										<h:selectOneMenu id="inpr" value="#{InventoryMB.bean.inpr}"
											styleClass="selectItem">
											<f:selectItem itemLabel="正常商品" itemValue="P" />
											<f:selectItem itemLabel="赠品" itemValue="G" />
											<f:selectItem itemLabel="耗材" itemValue="C" />
											<f:selectItem itemLabel="包装" itemValue="B" />
											<f:selectItem itemLabel="虚拟物品" itemValue="X" />
											<f:selectItem itemLabel="辅料" itemValue="M" />
											<f:selectItem itemLabel="发票" itemValue="I" />
											<f:selectItem itemLabel="次品" itemValue="L" />
											<%--
											<f:selectItem itemLabel="半成品" itemValue="S" />
											<f:selectItem itemLabel="原材料" itemValue="M" />
											 --%>
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										状态：
									</td>
									<td>
										<h:selectOneMenu id="stat" value="#{InventoryMB.bean.stat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										辅助国标码:
									</td>
									<td>
										<h:inputText id="gsco" value="#{InventoryMB.bean.gsco}"
											styleClass="inputtextedit" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										预包装重量：
									</td>
									<td >
										<h:inputText id="ywei" value="#{InventoryMB.bean.ywei}"
											styleClass="inputtextedit"/>
									</td>
									<td bgcolor="#efefef">
										默认货主：
									</td>
									<td colspan="3">
										<h:inputText id="owid" value="#{InventoryMB.bean.owid}"
											styleClass="inputtext" onfocus="this.select()" size="62" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										执行标准：
									</td>
									<td colspan="5">
										<h:inputText id="dosd" value="#{InventoryMB.bean.dosd}"
											styleClass="inputtext" onfocus="this.select()" size="80" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										安全要求：
									</td>
									<td colspan="5">
										<h:inputText id="sfrq" value="#{InventoryMB.bean.sfrq}"
											styleClass="inputtext" onfocus="this.select()" size="80" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注：

									</td>
									<td colspan="5">
										<h:inputText id="rema" value="#{InventoryMB.bean.rema}"
											styleClass="inputtext" onfocus="this.select()" size="80" />
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">

										<a4j:commandButton id="saveid" action="#{InventoryMB.save}"
											value="保存" reRender="output,outTable,msg,tree,out_List"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo('inventoryWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{InventoryMB.MOD || InventoryMB.ADD}">
											<a4j:actionparam name="page" value="#{InventoryMB.gpage}" />
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
				<div glable="其他" id="others">
					<h:form id="edit1">
						<a4j:outputPanel>
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										大类：
									</td>
									<td>
										<h:inputText id="gwf1" value="#{InventoryMB.bean.gwf1}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										大类描述：
									</td>
									<td>
										<h:inputText id="gwf2" value="#{InventoryMB.bean.gwf2}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										商品类别：
									</td>
									<td>
										<h:inputText id="gwf3" value="#{InventoryMB.bean.gwf3}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										商品类别描述：
									</td>
									<td>
										<h:inputText id="gwf4" value="#{InventoryMB.bean.gwf4}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										分类：
									</td>
									<td>
										<h:inputText id="gwf5" value="#{InventoryMB.bean.gwf5}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										分类描述：
									</td>
									<td>
										<h:inputText id="gwf6" value="#{InventoryMB.bean.gwf6}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										规格范围：
									</td>
									<td>
										<h:inputText id="gwf7" value="#{InventoryMB.bean.gwf7}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										规格范围描述：
									</td>
									<td>
										<h:inputText id="gwf8" value="#{InventoryMB.bean.gwf8}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										分析类别：
									</td>
									<td>
										<h:inputText id="gwf9" value="#{InventoryMB.bean.gwf9}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										分析类别描述：
									</td>
									<td>
										<h:inputText id="gwf10" value="#{InventoryMB.bean.gwf10}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										季节：
									</td>
									<td>
										<h:inputText id="gwf11" value="#{InventoryMB.bean.gwf11}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										季节描述：
									</td>
									<td>
										<h:inputText id="gwf12" value="#{InventoryMB.bean.gwf12}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										性别：
									</td>
									<td>
										<h:inputText id="gwf13" value="#{InventoryMB.bean.gwf13}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										性别描述：
									</td>
									<td>
										<h:inputText id="gwf14" value="#{InventoryMB.bean.gwf14}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										商品属性：
									</td>
									<td>
										<h:inputText id="gwf15" value="#{InventoryMB.bean.gwf15}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										商品属性描述：
									</td>
									<td>
										<h:inputText id="gwf16" value="#{InventoryMB.bean.gwf16}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										年份：
									</td>
									<td>
										<h:inputText id="gwf17" value="#{InventoryMB.bean.gwf17}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										波段：
									</td>
									<td>
										<h:inputText id="gwf18" value="#{InventoryMB.bean.gwf18}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										波段描述：
									</td>
									<td>
										<h:inputText id="gwf19" value="#{InventoryMB.bean.gwf19}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										设计风格：
									</td>
									<td>
										<h:inputText id="gwf20" value="#{InventoryMB.bean.gwf20}"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										设计风格描述：
									</td>
									<td>
										<h:inputText id="gwf21" value="#{InventoryMB.bean.gwf21}"
											styleClass="inputtext" />
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">

										<a4j:commandButton id="saveid" action="#{InventoryMB.save}"
											value="保存" reRender="output,outTable,msg,tree,out_List"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo('inventoryWin');"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{InventoryMB.MOD || InventoryMB.ADD}">
											<a4j:actionparam name="page" value="#{InventoryMB.gpage}" />
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
				<div glable="洗水唛" id="showImg">
					<iframe id="iframeImg" width="100%" height="330" padding="0"
						frameborder="0" src="about:blank"></iframe>
				</div>
			</div>
		</body>
	</f:view>
</html>