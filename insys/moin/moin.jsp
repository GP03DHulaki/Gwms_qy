<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.MoinMB"%><%@ include file="../../include/include_imp.jsp" %>
<html>
	<head>
		<title>生产入库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="生产入库">
		<script type="text/javascript" src='<%=request.getContextPath()%>/js/Gwalldate.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/DatePicker/WdatePicker.js"></script>
		<script src="moin.js"></script>

	</head>
<%
		MoinMB ai = (MoinMB) MBUtil.getManageBean("#{moinMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}

	%>
	<body id='mmain_body'>
	<div id="mmain_nav"><font color="#000000">入库处理&gt;&gt;入库&gt;&gt;</font><b>生产入库</b><br></div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{moinMB.ADD}" 
							action="#{moinMB.clearMBean}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();"/>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{moinMB.DEL}" reRender="output,renderArea"
							action="#{moinMB.deleteHead}"
							oncomplete="endDeleteHeadAll();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="同步" type="button" reRender="output,renderArea"
							action="" requestDelay="50" 
							onclick="syn();" rendered="false"
							oncomplete="endSyn();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							action="#{moinMB.search}" requestDelay="50" onclick="if(!search()){return false};"
							oncomplete="Gwallwin.winShowmask('FALSE');"
							rendered="#{moinMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{moinMB.LST}" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="创建日期从:">
						</h:outputText>
						<h:inputText id="sk_start_date" styleClass="datetime" size="12"
							value="#{moinMB.sk_start_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="至:">
						</h:outputText>
						<h:inputText id="sk_end_date" styleClass="datetime" size="12"
							value="#{moinMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
						<h:outputText value="生产入库单:">
						</h:outputText>
						<h:inputText id="sk_biid" styleClass="datetime" size="15"
							value="#{moinMB.sk_obj.biid}" onkeypress="formsubmit(event);" />	
						<h:outputText value="生产计划单号:">
						</h:outputText>
						<h:inputText id="sk_soco" styleClass="datetime" size="15"
							value="#{moinMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
						<h:outputText value="入库仓库:">
						</h:outputText>
							<h:inputText id="whna" styleClass="inputtext" size="17"
								onkeypress="formsubmit(event);" value="#{moinMB.whna}" />
							<img id="owid_img" style="cursor: hand;"
											src="../../images/find.gif" 
								onclick="return selectWaho();" />
								<h:inputHidden id='whid' value="#{moinMB.whid}"></h:inputHidden>
						<br>
						<h:outputText value="制单人:">
						</h:outputText>
						<h:inputText id="crna" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{moinMB.sk_obj.crna}" />
						<h:outputText value="组织架构:" >
						</h:outputText>
						<h:selectOneMenu id="orid" value="#{moinMB.sk_obj.orid}" onchange="doSearch();">
							<f:selectItem itemLabel="" itemValue="" />
							<f:selectItems value="#{OrgaMB.subList}" />
							</h:selectOneMenu>
						<h:outputText value="单据标志:" rendered="true">
						</h:outputText>
						<h:selectOneMenu id="sk_flag" value="#{moinMB.sk_obj.flag}"rendered="true" onchange="doSearch();" >
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItems value="#{moinMB.flags}"/>
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select a.id,a.biid,a.dety,a.soty,a.soco,a.orid,a.suid,b.ceve,a.pddt,a.infl,a.flag,a.prco,a.prnu,a.deus,d.usna,a.dedt,a.stus,a.
										stna,a.stdt,a.stat,a.crus,a.crna,a.crdt,a.edus,a.edna,a.eddt,a.chus,a.chna,a.chdt,a.opna,a.whid,c.whna,a.rema,e.orna  
										From csma a LEFT JOIN suin b ON a.suid = b.suid LEFT JOIN waho c ON a.whid = c.whid 
										Left join usin d on a.deus = d.usid
										left join orga e on e.orid=a.orid 
										WHERE a.#{moinMB.gorgaSql} #{moinMB.searchSQL }"
							gpage="(pagesize = 20)" gversion="2" gdebug = "false"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = orna(headtext = 组织架构,name = orna,width = 100,align = left,type = text,headtype = sort,datatype = string);
								gcid = biid(headtext = 生产入库单,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 生产入库单,name = biid,width = 100,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = moin_edit.jsf?pid=gcolumn[biid]);
								gcid = soco(headtext = 生产包装计划,name = socos,width = 110,align = left,type = text,headtype = sort,datatype = string);
								gcid = dety(headtext = 业务类型,name = buty,width = 71,align = center,type = mask,headtype = sort,datatype = string,typevalue=102:半成品入库/103:产成品入库/105:委外入库/109:返工入库);
								gcid = ceve(headtext = 供应商,name = ceve,width = 111,align = left,type = text,headtype = hidden,datatype = string);
								gcid = usna(headtext = 送货人,name = usna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = crna(headtext = 入库人,name = crna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = crdt(headtext = 入库时间,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = whna(headtext = 入库仓库,name = whna,width = 91,align = left,type = text,headtype = sort,datatype = string);
								gcid = flag(headtext = 单据标志,name = flag,width = 61,align = center,type = mask,typevalue=01:制作之中/11:正式单据/21:关闭单据,headtype = sort,datatype = string);
								gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
								gcid = rema(headtext = 备注,name = rema,width = 131,align = left,type = text,headtype = sort,datatype = string);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{moinMB.msg}" />
						<h:inputHidden id="sellist" value="#{moinMB.sellist}" />
					</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
