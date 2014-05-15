<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReviewLibraryMB"%>
<%@page import="com.gwall.util.MBUtil"%>
<%@page import="com.gwall.view.OutOrderMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content=出库计划>
		<meta http-equiv="description" content="出库计划">
	
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
		    
		    function cleartext(){
		    	$("edit:sk_biid").value="";
		    }
		    function formsubmit(){
		    	if(event.keyCode==13){
		    		var obj = $("edit:sid");
		    		obj.onclick();
		    	}
		    }
		</script>
	</head>
	<%
		OutOrderMB ai = (OutOrderMB) MBUtil.getManageBean("#{outOrderMB}");
		ai.getMbean().setFlag("");
		ai.search();
	%>
	
	<body>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" reRender="output"
							action="#{outOrderMB.search}" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id="mmain_cnd">
						<h:outputText value="出库订单:"></h:outputText>
						<h:inputText id="sk_biid" styleClass="inputtextedit" size="20"
							onkeypress="formsubmit(event);" value="#{outOrderMB.sk_obj.biid}" />
					</div>
					<!-- 
					<a4j:outputPanel id="output2">
						<g:GTable gid="gtable" gtype="grid" gversion="2" 
							gselectsql=" SELECT biid,crdt FROM slst where flag='11' "
							gwidth="550" gpage="(pagesize = 20)"
							growclick="selectThis('gcolumn[biid]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 复核来源单号,name = biid,width = 200,headtype = text,align = left,type = text,datatype=string);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 200,headtype = sort,align = left,type = text,datatype=string,dataformat=yyyy-MM-dd HH:mm);
							" />
					</a4j:outputPanel>
				 -->

					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
							gselectsql=" select a.id,a.biid from obma a where a.flag in ('17','19') #{outOrderMB.searchSQL} "
							gwidth="550" gpage="(pagesize = 20)"
							growclick="selectThis('gcolumn[biid]')"
							gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 复核出库订单号,name = biid,width = 400,headtype = text,align = left,type = text,datatype=string);
							" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view>
	</body>
</html>