<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.StockOptMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
	StockOptMB ai = (StockOptMB) MBUtil.getManageBean("#{stockOptMB}");
	if (null != request.getParameter("fromvoucherid")) {
		ai.setNvfromvoucherid(request.getParameter("fromvoucherid"));
	}
	ai.setWhid("");
	ai.setWhna("");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择盘点计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<script src="stockopt.js"></script>
		<script type="text/javascript">
		function showMes()
	  {
	  	if(document.getElementById('list:select_warehouseid')!=null)
			{
	 			document.getElementById('list:select_warehouseid').value="";	
				document.getElementById('list:select_warehouseid').focus();	
			}	
	 		if(document.getElementById('list:select_warehousename')!=null)
	 			document.getElementById('list:select_warehousename').value="";
	  }
		function formsubmit(){
			if (event.keyCode==13){
				var obj=document.getElementById("list:sid");
				obj.onclick();
				return true;
			}
		}
		
		 function selectThis(parm1){	
			var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
			if(isGwin === false){
				is_IE = (navigator.appName == "Microsoft Internet Explorer");
				var callBack = null;  
				if(is_IE) {
					callBack = window.dialogArguments;
				}
				else {
					if (window.opener.callBack == undefined) {   
						window.opener.callBack = window.dialogArguments;   
					}   
					callBack = window.opener.callBack;   
				}
			}
			if ( parm1 != "" && parm1 != null){
		 		isGwin ? parent.document.getElementById("edit:vc_warehouseid").value = parm1 : callBack.document.getElementById("edit:vc_warehouseid").value = parm1;
				}
			isGwin ? Gwin.close(document.GwinID) : window.close();	
	  } 
	    
	    function init(){
	    	document.getElementById("list:select_code").value = "";
	    	document.getElementById("list:select_name").value = "";
	    	document.getElementById("list:select_arg").value = "";
	    }
	</script>
	</head>
	<body
		onload="showMes();">
		<div id="mmain">
			<f:view>
				<h:form id="list">
					<div id="mmain_opt">
						<h:outputText value="库位编码:" />
							<h:inputText id="select_warehouseid" styleClass="datetime"
								size="15" onkeypress="formsubmit(event);" value="#{stockOptMB.whid}"/>
							<h:outputText value="库位名称:" />
							<h:inputText id="select_warehousename" styleClass="datetime"
								size="15" onkeypress="formsubmit(event);" value="#{stockOptMB.whna}"/>
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button" reRender="output" action="#{stockOptMB.search}"
								requestDelay="50" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="cid" value="重置" type="button" onclick="showMes();"
								requestDelay="50" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
									gselectsql="select a.whid,b.whna from pwci a LEFT JOIN waho b ON a.whid=b.whid 
									WHERE a.flag<'11' and a.biid='#{stockOptMB.nvfromvoucherid}' #{stockOptMB.searchSQL}"
									gpage="(pagesize = 20)" gdebug="false"
									growclick="selectThis('gcolumn[whid]')"
									gcolumn="
										gcid = 0(headtext = 行号,name = rowid,width = 50,headtype = text,align = center,type = text,datatype=string);
										gcid = whid(headtext = 库位编码,name = whid,width = 200,headtype = sort,align = left,type = text,datatype=string);
										gcid = whna(headtext = 库位名称,name = whna,width = 200,headtype = sort,align = left,type = text,datatype=string);
										" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
