<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.common.StinCOM"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库存商品信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='stin.js'></script>

		<script type="text/javascript">
			//选择货位点击确定按钮
		
			function commitisok(obj){	
				var arr=Gtable.getselectid(obj);
				if(arr.Trim().length<0){
					alert("请选择商品!");
					return false;
				}
				var retid = $('edit:retid').value;
			   	var retname = $('edit:retname').value;
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				parent.document.getElementById(retid).value = arr;
				Gwin.close(document.GwinID);
			}
			function thisclose(){
				window.close();
			}
		</script>
	</head>

	<%
		StinCOM ai = (StinCOM) MBUtil.getManageBean("#{stinCOM}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
		if (request.getParameter("whid") != null) {
			ai.setWhid(request.getParameter("whid"));
		}
	%>
	<body id="mmain_body">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{stinCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="isok" value="确定" type="button"
							onclick="commitisok('gtable');" reRender="output"
							requestDelay="50" />
						<a4j:commandButton type="button" value="取消" onclick="thisclose();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id="mmain_cnd">
						<h:outputText value="商品编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{stinCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="商品名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{stinCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id="mmain_free">
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.inco,a.whid,a.qty,b.inna,b.inst,b.colo
								FROM stin a LEFT JOIN inve b ON a.inco=b.inco WHERE 1=1 
								And a.whid like '#{stinCOM.whid}%' #{stinCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								gcolumn="
									gcid = inco(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inna(headtext = 商品名称,name = inna,width = 170,headtype = sort,align = left,type = text,datatype=string);
									gcid = colo(headtext = 花号,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = inst(headtext = 规格,name = inst,width = 80,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{stinCOM.retid}" />
						<h:inputHidden id="retname" value="#{stinCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>