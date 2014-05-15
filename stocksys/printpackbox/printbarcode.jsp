<%@ page contentType="text/html; charset=UTF-8"%><%@ include
	file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>初始化商品条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<link href="<%=request.getContextPath()%>/css/gtab.css"
			rel="stylesheet" type="text/css" />
		<link href="gtree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="gtree.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gtab.js'></script>
		<script type="text/javascript" src="printpackbox.js"></script>
	</head>
	<f:view>
		<body id="mmain_body" onload="listBarLoad();">
			<h:form id="list">
				<div id=mmain>
					<div>
						<a4j:commandButton type="button" value="打印商品条码"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{printPackboxMB.printbarcode1}" rendered="true"
							id="printcode" styleClass="a4j_but1"
							onclick="if(!print(gtable2)){return false};"
							oncomplete="lookPrint();" reRender="renderArea,outTable,msg"
							requestDelay="1000" />

						<a4j:outputPanel id="queryButs" rendered="#{printPackboxMB.LST}">
							<a4j:commandButton id="barSearch" value="查询"
								oncomplete="search();" reRender="output"
								action="#{printPackboxMB.search}" styleClass="a4j_but1"
								rendered="#{printPackboxMB.LST}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" />
							<a4j:commandButton value="重置" size="5"
								rendered="#{printPackboxMB.LST}" onclick="clearBarData()"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						</a4j:outputPanel>

						&nbsp;&nbsp;&nbsp; 商品编码:
						<h:inputText id="sk_inco" value="#{printPackboxMB.mbean.inco}"
							size="25" styleClass="inputtextedit" />
						<img id="whid_img" style="cursor: hand"
							src="../../images/find.gif" onclick="selectInve();" />
						生成条码个数:
						<h:inputText id="sk_qty" value="#{printPackboxMB.mbean.qty}"
							size="8" onkeyup="this.value=this.value.replace(/\D|^0/g,'')"
							styleClass="inputtextedit" />
						<a4j:commandButton type="button" value="生成商品条码"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{printPackboxMB.Generatebarcode}" rendered="true"
							id="gencode" styleClass="a4j_but1"
							onclick="if(!generate()){return false;}"
							oncomplete="Endgenerate();" reRender="renderArea,outTable,msg"
							requestDelay="1000" />
					</div>
					<div id="query">
						商品条码:
						<h:inputText id="query_baco" value="#{printPackboxMB.sk_obj.baco}"
							size="25" styleClass="inputtextedit" />
						商品编码:
						<h:inputText id="query_inco" value="#{printPackboxMB.sk_obj.inco}"
							size="25" styleClass="inputtextedit" />
						商品名称:
						<h:inputText id="query_inna" value="#{printPackboxMB.sk_obj.inna}"
							size="25" styleClass="inputtextedit" />
						打印状态:
						<h:selectOneMenu id="sk_flag"
							value="#{printPackboxMB.sk_obj.flag}">
							<f:selectItem itemLabel="全部" itemValue="" />
							<f:selectItem itemLabel="未打印" itemValue="0" />
							<f:selectItem itemLabel="已打印" itemValue="1" />
							<a4j:support event="onchange" action="#{printPackboxMB.search}"
								reRender="output"></a4j:support>
						</h:selectOneMenu>
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select a.baco,a.inco,case when a.pnum>0 then '已打印' else '未打印' end as pnum,b.iftl,b.inna,b.inse,b.colo from nwba a 
								left join inve b on a.inco=b.inco Where moid='printPackbox' #{printPackboxMB.searchSQL} "
							gpage="(pagesize = 20)"
							gcolumn="gcid = baco(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
						         gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							 	 gcid = baco(headtext = 商品条码,name = baco,width = 180,headtype = sort,align = left,type = text,datatype=string);
							  	 gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
						     	 gcid = inna(headtext = 商品名称,name = inna,width = 380,headtype = sort,align = left,type = text,datatype=string);
						     	 gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = text,datatype=string);
						     	 gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = text,datatype=string);
						 		 gcid = pnum(headtext = 是否打印,name = prnu,width = 100,headtype = sort,align = center,type = text,datatype=string);
						     " />
					</a4j:outputPanel>
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="item" value="#{printPackboxMB.item}" />
						<h:inputHidden id="outPutFileName"
							value="#{printPackboxMB.outPutFileName}" />
						<h:inputHidden id="msg" value="#{printPackboxMB.msg}"></h:inputHidden>
					</a4j:outputPanel>
				</div>
			</h:form>
		</body>
	</f:view>
</html>