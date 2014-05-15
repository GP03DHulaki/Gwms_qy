<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PackOutMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>销售订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content=销售订单>
		<meta http-equiv="description" content="销售订单">
		<script type="text/javascript" src="packout.js"></script>
	</head>

	<script type="text/javascript">
		function selectThis(param1){
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
			}else{
				callBack = parent;
			}
			if(callBack && callBack.document.getElementById('edit:soco')){
				callBack.document.getElementById('edit:soco').value=param1;
			}
			isGwin ? Gwin.close(document.GwinID) : window.close();	
	    }
		
	</script>
	<body>
		<f:view>
			<div id="mmain">
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" reRender="output" 
							requestDelay="50" 
							action="#{packOutMB.searchSoco}"/>
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="销售单号:"></h:outputText>
						<h:inputText id="searchpicktaskkey" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);" value="#{packOutMB.frombiid}" />
					</div>
				 
				 <a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql="
								select biid,lpna,loco from obma
								where flag>=17 and biid not in(select soco from poma) #{packOutMB.socoSql}
							"
							gwidth="550" gpage="(pagesize = 10)"
							growclick="selectThis('gcolumn[biid]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 销售订单号,name = biid,width = 140,headtype = text,align = left,type = text,datatype=string);
							gcid = lpna(headtext = 快递公司,name=lpna,width = 140,headtype = sort,align = center,type = mask,datatype=string);
							gcid = loco(headtext = 快递单号,name=loco,width = 140,headtype = sort,align = center,type = mask,datatype=string);
							
							" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view> 
	</body>
</html>