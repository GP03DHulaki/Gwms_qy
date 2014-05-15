<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>选择客户分类</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript" src='companycost.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{companycostCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="费用编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{companycostCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="费用类型:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{companycostCOM.na}" onkeypress="formsubmit(event);" />
						<h:outputText value="结算公司:">
						</h:outputText>
						<h:inputText id="company" styleClass="inputtextedit" size="15"
							value="深圳**干线运输有限公司" onkeypress="formsubmit(event);" disabled="true"/>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="soco" gsortmethod="asc" 
								gselectsql="SELECT 'PO12080300003' as soco,'干线' as soty,'1000.00' as cost,'2012-08-03 00:00:00.000' as codt,'11' as stat"
								gwidth="550" gpage="(pagesize = 40)" gdebug="false"
								growclick="selectThis('gcolumn[1]','gcolumn[2]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = soco(headtext = 结算单据,name = soco,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = soty(headtext = 单据类型,name = soty,width = 100,headtype = sort,align = center,type = text,datatype=string);
									gcid = cost(headtext = 单据费用,name = cost,width = 100,headtype = sort,align = right,type = text,datatype=number);
									gcid = codt(headtext = 单据时间,name = codt,width = 100,headtype = sort,align = left,type = mask,typevalue=20:普通/10:紧急,datatype = string,bgcolor={gcolumn[tale]=10:#FF0000});
									gcid = stat(headtext = 单据状态,name = stat,width = 100,align = center,type = mask,typevalue=01:制作中/11:已审核/21:部分预约/22:全部预约/31:到货中/32:全部到货/41:检验中/51:入库中/99:已完成/100:已关闭,headtype = sort,datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{companycostCOM.retid}" />
						<h:inputHidden id="retname" value="#{companycostCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>