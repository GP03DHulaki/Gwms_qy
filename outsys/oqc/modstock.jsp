<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReviewLibraryMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>复核异常数据界面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="复核异常数据界面">
		<script type="text/javascript" src="oqc.js"></script>
	</head>
	<%
		ReviewLibraryMB ai = (ReviewLibraryMB) MBUtil
				.getManageBean("#{reviewLibraryMB}");
		if (request.getParameter("pid") != null) {
			ai.getMbean().setBiid(request.getParameter("pid"));
		}
		ai.getVouch();
	%>
	<body id="mmain_body">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						出库处理&gt;&gt;
						<b>是否处理出库复核的异常数据</b>
						<br>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="mainBut">
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="确定调整" type="button"
								onclick="if(!modstock()){return false};"
								action="#{reviewLibraryMB.adjustStock}"
								rendered="#{reviewLibraryMB.exections && reviewLibraryMB.SPE}"
								oncomplete="endmostock();" reRender="msg,mainBut,renderArea"
								requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								onclick="closewin();" value="关闭" id="delMBut"
								reRender="output,renderArea,main,mainBut,msg,output2"
								styleClass="a4j_but1" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="output2">
						<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
							gselectsql=" #{reviewLibraryMB.sqlstr} "
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									 gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									 gcid = inna(headtext = 商品名称,name = inna,width = 130,headtype = sort,align = left,type = text,datatype=string);
									 gcid = colo(headtext = 规格,name = colo,width = 80,headtype = sort,align = left,type = text,datatype=string);
									 gcid = inse(headtext = 规格码,name = inst,width = 100,headtype = sort,align = left,type = text,datatype=string);
									 gcid = qty(headtext = 数量,name = qty,width = 70,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
									 gcid = fqty(headtext = 已复核数量,name = fqty,width = 70,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
								" />
						<!-- gpage="(pagesize = 20)" -->
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{reviewLibraryMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>