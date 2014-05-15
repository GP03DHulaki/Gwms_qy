<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PubmMB"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>条码</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='po.js'></script>
	</head>

	<%
		PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
		if (request.getParameter("isAll") != null
				&& "0".equals(request.getParameter("isAll").toString())) {
			ai.setSelbarsql("");
			ai.setSk_baco("");
			ai.setSk_inco("");
		}
		if (request.getParameter("roid") != null) {
			ai.setRoid(request.getParameter("roid"));
		}
	%>
	<body id=mmain_body onload="initselbar();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{pubmMB.searchBar}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="clearbar();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton type="button" value="打印选定"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{pubmMB.printCode}" rendered="true"
							styleClass="a4j_but1" onclick="if(!print(gtable)){return false};"
							oncomplete="lookPrint();" reRender="renderArea,output"
							requestDelay="1000" />
						<a4j:commandButton type="button" value="打印全部"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{pubmMB.printCodeAll}" rendered="true"
							styleClass="a4j_but1" onclick="if(!printAll()){return false};"
							oncomplete="lookPrint();" reRender="renderArea,output"
							requestDelay="1000" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="商品条码:">
						</h:outputText>
						<h:inputText id="baco" styleClass="inputtextedit" size="15"
							value="#{pubmMB.sk_baco}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="inco" styleClass="inputtextedit" size="15"
							value="#{pubmMB.sk_inco}" onkeypress="formsubmit(event);" />
					</div>

					<div id=mmain_cnd style="display: none;">
						<a4j:outputPanel rendered="#{pubmMB.baraddshow}">
							<div style="vertical-align: top;"></div>
							<SPAN ID="detail_ctrl" class="ctrl_show"
								onclick="JS_ExtraFunction();"></SPAN>
							<font color="#4990dd" style="font-weight: bolder; cursor: hand"
								onclick="JS_ExtraFunction();">-----点击此处添加尾箱-----</font>
							<div id="ExtraFunction"
								style="display: none; height: 10px; margin-left: 13px;">
								<h:outputText value="尾箱条码数量:">
								</h:outputText>
								<h:inputText id="qty" styleClass="inputtextedit" size="15"
									value="#{pubmMB.qty}" />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="addBar" value="添加尾箱" type="button"
									action="#{pubmMB.addBar}" reRender="output,renderArea"
									requestDelay="50" onclick="if(!addBar()){return false};"
									oncomplete="endAddBar();" />
							</div>
						</a4j:outputPanel>
					</div>
					<div id="mmain_free">
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="baco" gsortmethod="ASC"
								gselectsql="select a.baco,a.inco,a.qty,b.inna,b.colo,b.inse,a.pnum,a.flag from nwba a LEFT JOIN inve b on a.inco=b.inco
								where a.moid = 'PO' and a.biid = '#{pubmMB.mbean.biid}' #{pubmMB.selbarroidsql} #{pubmMB.selbarsql}"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								gcolumn="gcid = baco(headtext = selall,name = id,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = baco(headtext = 商品条码,name = baco,width = 220,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 130,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 规格,name = colo,width = 60,headtype = sort,align = left,type = text,datatype=string);
									gcid = inse(headtext = 规格码,name = inse,width = 60,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 数量,name = qty,width = 30,headtype = text,align = right,type = text,datatype=number,dataformat=0);
									gcid = pnum(headtext = 打印次数,name = pnum,width = 50,headtype = text,align = right,type = text,datatype=number,dataformat=0,bgcolor=gcolumn[pnum]>0:red);
									gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:初始状态/02:已到货/03:已检验/04:已入库/05:已出库,headtype = sort,datatype = string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{pubmMB.sellist}" />
							<h:inputHidden id="filename" value="#{pubmMB.fileName}" />
							<h:inputHidden id="roid" value="#{pubmMB.roid}" />
							<h:inputHidden id="msg" value="#{pubmMB.msg}" />
							<h:inputHidden id="baraddshow" value="#{pubmMB.baraddshow}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>