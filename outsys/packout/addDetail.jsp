<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PackOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	PackOutMB ai = (PackOutMB) MBUtil.getManageBean("#{packOutMB}");
	if (request.getParameter("time") != null) {
		ai.setSql("");
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>订单信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='packout.js'></script>
	</head>


	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{packOutMB.addDetail}"
							reRender="renderArea,output"
							rendered="#{packOutMB.MOD && packOutMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="search();" oncomplete="endSearch();" id="sid" value="查询"
							type="button" action="#{packOutMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
							
						<h:outputText value="快递公司:"></h:outputText>	
						<h:selectOneMenu id="lpco" value="#{packOutMB.lpco}">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{carrierMB.list}" />
						</h:selectOneMenu>
						<h:outputText value="快递单号:"></h:outputText>	
							<h:inputText id="loco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{packOutMB.loco}" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{packOutMB.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{packOutMB.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.did,a.inco,d.lpco,d.loco,(a.qty-isnull(f.qty,0)) as qty,b.grwe as weig,b.inna,c.lpna from oubd a left join obma d on a.biid = d.biid left join inve b on a.inco = b.inco left join lpin c on d.lpco = c.lpco
								 left join poma e on d.biid = e.soco left join (SELECT biid,inco,sum(qty) as qty from pode group by biid,inco) f on e.biid = f.biid and a.inco = f.inco where (a.qty-isnull(f.qty,0)) >0 and   a.biid = '#{packOutMB.mbean.soco}' #{packOutMB.sql}" 
								gwidth="320" gpage="(pagesize = 10)" gdebug="false" gsort="inco"
								gsortmethod="asc"
								gcolumn="gcid = did(headtext = selall,name = id,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 180,headtype = sort,align = left,type = text,datatype=string);
									gcid = lpna(headtext = 快递公司,name = lpna,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = loco(headtext = 快递单号,name = loco,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext =  数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
									gcid = weig(headtext =  重量,name = weig,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{packOutMB.msg}" />
							<h:inputHidden id="sellist" value="#{packOutMB.sellist}" />
							<h:inputHidden id="qtys" value="#{packOutMB.qtys}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>