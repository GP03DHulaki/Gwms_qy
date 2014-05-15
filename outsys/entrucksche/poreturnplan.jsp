<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.view.EntrSchePbPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<%
	EntrSchePbPlanMB ai = (EntrSchePbPlanMB) MBUtil.getManageBean("#{entrSchePbPlanMB}");
	if (request.getParameter("isAll") != null) {
		ai.initSK();
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货调度</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货调度">
		<script type="text/javascript" src="entrucksche.js"></script>
		<script type="text/javascript">
			function load(){
				parent.iframe_poreturnplan.height = document.body.scrollHeight+100;
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>

	<body id='mmain_body' onload="load()">
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<a4j:outputPanel id="queryButs" rendered="#{entrSchePbPlanMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{entrSchePbPlanMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="clearSearchKey('2');" />
							<gw:GAjaxButton theme="b_theme" id="creBut" value="生成备货计划"
								type="button" onclick="if(!checkSel()){return false};"
								oncomplete="endCrePlan();" reRender="output,renderArea"
								action="#{entrSchePbPlanMB.createPlan}" />
						</a4j:outputPanel>
					</div>

					<a4j:outputPanel id="queryForm" rendered="#{entrSchePbPlanMB.LST}">
						<div id="mmain_cnd">
							订单日期从:
							<h:inputText id="start_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{entrSchePbPlanMB.sk_start_date}" />
							至:
							<h:inputText id="end_date" styleClass="datetime" size="10"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'});"
								value="#{entrSchePbPlanMB.sk_end_date}" />
							采购退货计划:
							<h:inputText id="sk_biid" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{entrSchePbPlanMB.sk_biid}" />
							供应商:
							<h:inputText id="sk_stus" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{entrSchePbPlanMB.sk_stus}" />	
							<%-- 
							商品编码:
							<h:inputText id="sk_inco" value="#{entrSchePbPlanMB.sk_inco}"
								styleClass="datetime" size="22" />
							<img id="invcode_img" style="cursor: pointer;display:none;"
								src="../../images/find.gif" onclick="selectInve();" />
							线路:
							<h:selectOneMenu id="sk_lnco" value="#{entrSchePbPlanMB.sk_lnco}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{entrSchePbPlanMB.lineList}" />
							</h:selectOneMenu>
							地区:
							<h:selectOneMenu id="sk_gead" value="#{entrSchePbPlanMB.sk_gead}"
								rendered="true" onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItems value="#{entrSchePbPlanMB.areaList}" />
							</h:selectOneMenu>
							--%>
						</div>
					</a4j:outputPanel>

					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.id,a.biid,a.chdt,a.orid,a.stus,a.stna,liin.lina,d.orna,
											SUM(b.qty) AS tanu,SUM(ISNULL(c.volu,0)*b.qty) AS tavo,SUM(ISNULL(c.newe,0)*b.qty) AS tawe
											FROM prbm a JOIN prde b ON a.biid=b.biid
											LEFT JOIN inve c ON b.inco=c.inco
											LEFT JOIN liin on a.lico=liin.lico
											join orga d on d.orid=a.orid
											WHERE a.#{entrSchePbPlanMB.gorgaSql} AND a.flag in ('11','21') 
											AND (a.aity = 'ENTRUCKPLAN' OR a.aity IS NULL OR aity='')
											#{entrSchePbPlanMB.searchSQL}
											GROUP BY a.id,a.biid,a.chdt,a.orid,a.stus,a.stna,liin.lina,d.orna
										"
										gpage="(pagesize = 20)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = -1(headtext = 操作,value= 查看,name = opt,width = 30,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:showBill_pobo('gcolumn[biid]'),datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 采购退货计划,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = lina(headtext = 路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = stus(headtext = 供应商编码,name = stus,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = stna(headtext = 供应商名称,name = stna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = chdt(headtext = 审核日期,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = tavo(headtext = 总体积(m³),name = tavo,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tawe(headtext = 总重量(㎏),name = tawe,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##});
											gcid = tanu(headtext = 总数量,name = tanu,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
											
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">  
							<h:inputHidden id="sellist" value="#{entrSchePbPlanMB.sellist}" />
							<h:inputHidden id="msg" value="#{entrSchePbPlanMB.msg}" />
						</a4j:outputPanel>
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="output" />
					</div>
				</h:form>

				<div id="errmsg" style="display: none">
					<div id=mmain_cnd align="left">
						<span id="mes" style="color: red;"></span>
						<div align="center">
							<button type="button" onclick="Gwallwin.winClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>

				<div id="editPanel" style="display: none">
					<h:form id="condition">
						<div id=mmain_cnd align="center">
							<h:selectManyCheckbox id="checkbox" layout="lineDirection"
								value="#{entrSchePbPlanMB.boxvalues}">
								<f:selectItems value="#{entrSchePbPlanMB.sitem}" />
							</h:selectManyCheckbox>
							<gw:GAjaxButton id="setBut" action="#{entrSchePbPlanMB.setGtable}"
								value="确定" onclick="startDo();" theme="a_theme"
								oncomplete="endSift();" rendered="#{entrSchePbPlanMB.MOD}" />
							<gw:GAjaxButton theme="a_theme" value="返回"
								onclick="Gwallwin.winClose();" />
						</div>
					</h:form>
				</div>


			</f:view>
		</div>
	</body>
</html>