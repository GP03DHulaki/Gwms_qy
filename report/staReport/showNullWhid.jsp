<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.WarehouseMB"%>
<%@ include file="../../include/include_imp.jsp" %>

<%
    WarehouseMB ai = (WarehouseMB) MBUtil
            .getManageBean("#{warehouseMB}");
    if (request.getParameter("isAll") != null) {
        ai.setSql("");
        ai.getBean().setWhty("");
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>空库位资料</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type='text/javascript' src='stockSearch.js'></script>
	</head>
	<body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<h:panelGroup id="sp" rendered="#{warehouseMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button" onclick="startDo();"
								action="#{warehouseMB.selectVoucherid}" reRender="out_List"
								oncomplete="Gwallwin.winShowmask('FALSE');" requestDelay="50" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="textClear('list','sps,ewid,whna,orid');" />							
						</h:panelGroup>
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
									onclick="reportExcel('gtable')" type="button" />
						</a4j:outputPanel>		
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
							onchange="$('list:sid').click();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="out_List">
						<g:GTable gid="gtable" gtype="grid" gversion="2"  gdebug="true"
							gpage="(pagesize=20)"
							gselectsql="Select a.id,whid,ewid,whna,pwid,whfl,whty,a.chie,a.addr,a.tele,wogr,a.orid,g.orna,cofl,volu,vole,vowi,vohe,bear,a.stat,a.rema From waho a left join orga g on g.orid = a.orid Where a.whty='4' and a.whid not in(select whid from bain)  #{warehouseMB.sql}"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);								
								gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text);
								gcid = whid(headtext = 库位编码,name = whid,width = 100,headtype = sort,align = left,type = text);
								gcid = whna(headtext = 库位名称,name = whna,width = 120,headtype = sort,align = left,type = text);
								gcid = pwid(headtext = 上级编码,name = pwid,width = 100,headtype = sort,align = left,type = text);
								gcid = whty(headtext = 库位标识,name = whty,width = 60,headtype = sort,align = center,type = mask,typevalue=0:地点/1:仓库/2:库区/3:楼层/4:拣货库位/5:备货库位/6:溢出库位/7:活动库位/8:质检库位/9:移动库位/10:系统库位/11:虚拟仓库/12:任务栏/13:残品库位/14:通道);
								gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = mask,typevalue=1:有效/0:注销);
								gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left,type = text);
								gcid = chie(headtext = 联系人,name = chie,width = 120,headtype = sort,align = left,type = text);
								gcid = tele(headtext = 联系方式,name = tele,width = 120,headtype = sort,align = left,type = text);
								gcid = addr(headtext = 地址,name = addr,width = 120,headtype = sort,align = left,type = text);								
							" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{warehouseMB.sellist}"></h:inputHidden>
				</h:form>
			</f:view>
		</div>
	</body>
</html>