<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@page import="com.gwall.view.base.ScmInveMB"%>

<%
ScmInveMB ai = (ScmInveMB) MBUtil
			.getManageBean("#{scmInveMB}");
	if (request.getParameter("isAll") != null) {
		ai.initPage();
	} else {
		ai.setGtableParam(request, ai);
	}
%>
<html>
	<head>
		<title>物料</title>
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
				var iframeComp = document.getElementById("iframeComp");
				var iframeRici = document.getElementById("iframeRici");
				var flag = $("edit:updateflag").value;
				if(flag!="ADD"){
					if(obj.id=="showComp"){
						Gwin.progress("请稍等...",10,document);
						var inco ="";
						if($("edit:leve").value=="0"){
							inco=$("edit:inco").value;
							}
						else{
							inco=$("edit:upco").value;
							}
						
						iframeComp.src="composition.jsf?id="+inco+"&leve="+$("edit:leve").value+"&date="+new Date().getTime();
					}
					if(obj.id=="showRici") {
						Gwin.progress("请稍等...",10,document);
						iframeRici.src="rici.jsf?id="+$("edit:inco").value+"&leve="+$("edit:leve").value+"&date="+new Date().getTime();
					}
				}
				else{
					if($("edit:inco").value==""||$("edit:inco").value=="自动生成"){
						//alert("请先保存物料信息");
						$("edit").click();
					}
					
					$("showComp").style.display="none";
					$("showRici").style.display="none";
				}
			}
		</script>

	</head>
	<f:view>
		<body id=mmain_body onload="Gtab.init('Gtab01');Gwin.close('progress_id');">
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="新增" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'"
							rendered="#{scmInveMB.ADD}" styleClass="a4j_but" tabindex="5" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{scmInveMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							rendered="#{scmInveMB.DEL}" reRender="outTable,msg"
							oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:panelGroup id="sp">
							<a4j:commandButton id="query" value="查询"
								action="#{scmInveMB.query}" onclick="startDo('正在查询...');"
								rendered="#{scmInveMB.LST}"
								oncomplete="Gwin.close('progress_id');"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								reRender="outTable">
								<a4j:actionparam assignTo="#{scmInveMB.gpage}" name="page"
									value="1" />
							</a4j:commandButton>
							<a4j:commandButton value="重置" rendered="#{scmInveMB.LST}"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" reRender="out_List" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="excel" value="导出EXCEL" type="button"
								action="#{scmInveMB.exportmstinvExcel}"
								rendered="#{scmInveMB.EXP}" reRender="msg,outPutFileName"
								onclick="excelstock_begin('gtable2');"
								oncomplete="excelstock_end();" requestDelay="50" />
						</h:panelGroup>
						<a4j:commandButton type="button" value="打印条码"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{scmInveMB.printCode}" rendered="#{scmInveMB.PRN}"
							styleClass="a4j_but1" onclick="if(!print()){return false};"
							oncomplete="lookPrint();" reRender="renderArea,outTable"
							requestDelay="1000" />
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel rendered="#{scmInveMB.LST}">
						物料编码:
						<h:inputText id="sk_inco" value="#{scmInveMB.sk_obj.inco}"
								styleClass="inputtextedit" />
						物料名称:
						<h:inputText id="sk_inna" value="#{scmInveMB.sk_obj.inna}"
								styleClass="inputtextedit" />
						规格:
						<h:inputText id="sk_colo" value="#{scmInveMB.sk_obj.colo}"
								styleClass="inputtextedit" />
						规格码:
						<h:inputText id="sk_inst" value="#{scmInveMB.sk_obj.inse}"
								styleClass="inputtextedit" />
							<br>
						物料类别:
						<h:inputText id="sk_tyna" value="#{scmInveMB.sk_obj.tyna}"
								styleClass="inputtextedit" />
							<img id="tyna_img" style="cursor: pointer"
								src="../../images/find.gif" onclick="selectSK_Inty();" />
						属性:
						<h:selectOneMenu id="sk_leve" value="#{scmInveMB.sk_obj.leve}" onchange="$('list:query').click()"
							>
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="不包含规格规格码" itemValue="0" />
							<f:selectItem itemLabel="包含规格规格码" itemValue="1" />
						</h:selectOneMenu>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gsort="#{scmInveMB.gsort}"
							gsortmethod="#{scmInveMB.gsortmethod}"
							gselectsql="Select a.id,a.inco,a.asco,a.inna,a.colo,a.inse,a.past,b.tyna,a.inpr,c.brde,a.stat,a.psco,d.cona
										from inve a left join prty b on a.inty = b.inty left join brin c on a.bran = c.bran 
										left join colo d on a.colo =d.id
										Where a.inpr='M' and b.type='0' #{scmInveMB.searchKey}"
							gpage="(pagesize = #{scmInveMB.gpagesize})" gdebug="false"
							gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						        gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							    gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),datatype=string);
							    gcid = inco(headtext = 物料编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = inna(headtext = 物料名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
						     	gcid = colo(headtext = 规格,name = colo,width = 80,headtype = hidden,align = left , type = text , datatype = string);
						     	gcid = cona(headtext = 规格,name = cona,width = 80,headtype = sort,align = left , type = text , datatype = string);
						     	gcid = inse(headtext = 规格码,name = inse,width = 80,headtype = sort,align = left,type = text,datatype=string);
							    gcid = tyna(headtext = 物料类别,name = tyna,width = 90,headtype = sort,align = center , type = text, datatype = string);
						        gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = hidden , align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						" />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="sellist" value="#{scmInveMB.sellist}" />
						<h:inputHidden id="outPutFileName"
							value="#{scmInveMB.outPutFileName}" />
						<h:inputHidden id="filename" value="#{scmInveMB.fileName}" />
						<h:inputHidden id="gsql" value="#{scmInveMB.gsql}" />
						<h:inputHidden id="gcoldatatype"
							value="#{scmInveMB.gcoldatatype}" />
						<h:inputHidden id="gcolheadtext"
							value="#{scmInveMB.gcolheadtext}" />

						<h:inputHidden id="msg" value="#{scmInveMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</h:form>
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
				<div id="edit" glable="物料信息" height="95%">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button" onclick="editDo()"
								action="#{scmInveMB.getInventory}" reRender="editpanel"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{scmInveMB.selid}" />
							<h:inputHidden id="updateflag" value="#{scmInveMB.updateflag}"></h:inputHidden>
						</div>
						<div style="display: none">
							<h:commandButton id="saveImg" action="#{scmInveMB.saveImg}"></h:commandButton>
						</div>
						<a4j:outputPanel id="editpanel">
							<h:inputHidden id='imgPath' value="#{scmInveMB.bean.imid}"></h:inputHidden>
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										物料编码：
									</td>
									<td>
										<h:inputText id="inco" value="#{scmInveMB.bean.inco}" disabled="true"
											styleClass="inputtext" />
										
									</td>
									<td bgcolor="#efefef">
										物料名称：
									</td>
									<td>
										<h:inputText id="inna" value="#{scmInveMB.bean.inna}"
											styleClass="inputtext" onfocus="this.select()" />
										<span style="">*</span>
									</td>
									<td bgcolor="#efefef">
										物料类别：
									</td>
									<td>
										<h:inputText id="tyna" value="#{scmInveMB.bean.tyna}" 
											disabled="true" styleClass="inputtext" />
										<img id="inty_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectInty();" />
										<h:inputHidden id="inty" value="#{scmInveMB.bean.inty}" />
										<h:inputHidden id="prefix" value="#{scmInveMB.bean.prefix}"/>
									</td>
									
								</tr>
								<tr>
									<td bgcolor="#efefef">
										基准单位：
									</td>
									<td>
										<h:inputText id="inun" value="#{scmInveMB.bean.inun}" 
											styleClass="inputtext" readonly="true" style="color:#A0A0A0"/>
									</td>
									<td bgcolor="#efefef">
										进货价格：
									</td>
									<td>
										<h:inputText id="bupr" value="#{scmInveMB.bean.bupr}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										原始用量:
									</td>
									<td>
										<h:inputText id="dfus" value="#{scmInveMB.bean.dfus}"
											styleClass="inputtextedit" />
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#efefef">
										默认布封:
									</td>
									<td>
										<h:inputText id="nstv" value="#{scmInveMB.bean.nstv}"
											styleClass="inputtextedit" />
									</td>
									<td bgcolor="#efefef">
										图样：
									</td>
									<td>
										
									</td>
									<td bgcolor="#efefef">
										状态：
									</td>
									<td>
										<h:selectOneMenu id="stat" value="#{scmInveMB.bean.stat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										是否配色：
									</td>
									<td >
										<h:selectOneMenu id="isco" value="#{scmInveMB.bean.isco}"
											styleClass="selectItem">
											<f:selectItem itemLabel="是" itemValue="1" />
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										是否配码：
									</td>
									<td >
										<h:selectOneMenu id="issi" value="#{scmInveMB.bean.issz}"
											styleClass="selectItem">
											<f:selectItem itemLabel="是" itemValue="1" />
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										规格列表：
									</td>
									<td >
										<h:inputText  value="点击查看" styleClass="inputtext" id="colorbtn" style="color:#A0A0A0;cursor:pointer" readonly="true" onclick="colorlist();"/>
										<h:inputHidden id="colorlist" value="#{scmInveMB.bean.colo}"></h:inputHidden>
										<img  style="cursor: pointer"
											src="../../images/find.gif" onclick="colorlist();" />
									</td>
									
								</tr>
									
									<%--<td bgcolor="#efefef" >
										规格码列表：
									</td>
									<td colspan="3">
										<h:inputText  value="点击查看" styleClass="inputtext" id="sizebtn"  style="color:#A0A0A0;cursor:pointer"  readonly="true" onclick="sizelist();"/>
										<h:inputHidden id="sizelist" value="#{scmInveMB.bean.inse}"></h:inputHidden>
										<img  style="cursor: pointer"
											src="../../images/find.gif" onclick="sizelist();" />
									</td>
								
								--%><tr>
									<td bgcolor="#efefef">
										备注：

									</td>
									<td colspan="5">
										<h:inputText id="rema" value="#{scmInveMB.bean.rema}"
											styleClass="inputtext" onfocus="this.select()" size="80" />
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden value="#{scmInveMB.bean.inpr}" id="inpr"></h:inputHidden>
										<h:inputHidden value="#{scmInveMB.bean.leve}" id="leve"></h:inputHidden>
										<h:inputHidden value="#{scmInveMB.bean.upco}" id="upco"></h:inputHidden>
										<a4j:commandButton id="saveid" action="#{scmInveMB.save}"
											value="保存" reRender="output,outTable,msg,tree,out_List"
											onclick="if(!formCheck()){return false};"
											oncomplete="endSave();"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{scmInveMB.MOD || scmInveMB.ADD}">
											<a4j:actionparam name="page" value="#{scmInveMB.gpage}" />
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<div style="display: none;">
							
						</div>
					</h:form> 
				</div>
				<div  id="showComp" glable="成分" >
					<iframe id="iframeComp" width="100%" height="380px" padding="0" onload="parent.Gskin.setSkinCss(null,this);Gwin.close('progress_id');"
					 frameborder="0" src="about:blank"></iframe>
				</div>
				<div  id="showRici" glable="供应商色号" >
					<iframe id="iframeRici" width="100%" height="430px" padding="0" onload="parent.Gskin.setSkinCss(null,this);Gwin.close('progress_id');"
					 frameborder="0" src="about:blank"></iframe>
				</div>
			</div>
		</body>
	</f:view>
</html>