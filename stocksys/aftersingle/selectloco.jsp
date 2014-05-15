<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>快递单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">

		<script src="stockopt.js"></script>
		<script type="text/javascript">
		function formsubmit(){
			if (event.keyCode==13){
				var obj=document.getElementById("list:sid");
				obj.onclick();
				return true;
			}
		}
		
		function selectThis(nv_fromvoucherid){
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
			if ( nv_fromvoucherid != "" && nv_fromvoucherid != null){
		 		isGwin ? parent.document.getElementById('edit:loco').value = nv_fromvoucherid : callBack.document.getElementById('edit:loco').value = nv_fromvoucherid;
				}
			isGwin ? Gwin.close(document.GwinID) : window.close();	
	    }
	    
	    function init(){
	    	document.getElementById("list:select_voucherid").value = "";
	    }
	</script>
	</head>
	<body onload="textClear('list','select_voucherid');">
		<div id="mmain">
			<f:view>
				<h:form id="list">
					<div id="mmain_opt">
						<h:outputText value="快递单号:" />
						<h:inputText id="select_voucherid" styleClass="datetime" size="15"
							value="#{outOrderMB.mbean.loco}" onkeypress="formsubmit(event);" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" reRender="output"
							requestDelay="50" action="#{outOrderMB.searchLoco}" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="cid" value="重置" type="button"
							onclick="textClear('list','select_voucherid');" requestDelay="50" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="SELECT a.biid,b.loco from aslt a join obma b on a.biid=b.biid where a.stat=1 #{outOrderMB.searchSQL }"
							gpage="(pagesize=18)" gdebug="false"
							growclick="selectThis('gcolumn[loco]')"
							gcolumn="
									gcid = 0(headtext = 行号,name = rowid,align = center,width = 30,type = text,datatype = string);
									gcid=loco(name = loco,headtext =快递单号,width =220,align = left,type=text,datatype=string);
									gcid=biid(name = biid,headtext =出库订单,width =220,align = left,headtype=sort,type=text,datatype=string);
								" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
