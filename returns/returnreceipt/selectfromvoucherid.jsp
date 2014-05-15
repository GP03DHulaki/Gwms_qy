<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.ReturnReceiptMB"%><%@ include file="../../include/include_imp.jsp" %>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<%
	ReturnReceiptMB ai = (ReturnReceiptMB) MBUtil.getManageBean("#{returnReceiptMB}");
	if (request.getParameter("retid") != null) {
		ai.setRetid(request.getParameter("retid"));
	}
	if (request.getParameter("retwhid") != null) {
		ai.setRetwhid(request.getParameter("retwhid"));
	}
	if (request.getParameter("retwhna") != null) {
		ai.setRetwhna(request.getParameter("retwhna"));
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择销售退货计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<script type="text/javascript" src='<%=request.getContextPath()%>/js/Gwalldate.js'></script>
		<script src="salesreturn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
var retid="",retname="";
		function formsubmit(){
			if (event.keyCode==13){
				var obj=document.getElementById("list:sid");
				obj.onclick();
				return true;
			}
		}
function selectThis(parm1,whid,whna){
retid = $('edit:retid').value;
retwhid = $('edit:retwhid').value;
retwhna = $('edit:retwhna').value;
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
	if ( retid != "" && retid != null){
 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	if ( retwhid != "" && retwhid != null){
 		isGwin ? parent.document.getElementById(retwhid).value = whid : callBack.document.getElementById(retwhid).value=whid;
	}
	if ( retwhna != "" && retwhna != null){
 		isGwin ? parent.document.getElementById(retwhna).value = whna : callBack.document.getElementById(retwhna).value=whna;
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
	<body onload="textClear('edit','select_voucherid');">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" reRender="output"
							requestDelay="50" action="#{returnReceiptMB.search}" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="cid" value="重置" type="button"
							onclick="textClear('edit','select_voucherid');" requestDelay="50" />
					</div>
<div id=mmain_cnd>
	<h:outputText value="销售退货计划: " />
	<h:inputText id="select_voucherid" styleClass="datetime" size="15"  onkeyup="$('edit:sid').click()"
		value="#{returnReceiptMB.sk_obj.soco}"
		onkeypress="formsubmit(event);" />
</div>
		<div id=mmain_cnd>
			<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="select a.biid,a.flag ,a.whid,b.whna from rpma a left join waho b on a.whid=b.whid where a.flag<>'31' and a.flag<>'01' and (ISNULL(a.aity,'')='' OR a.aity='RETURNRECEIPT' )  #{returnReceiptMB.searchSQL} "
							gpage="(pagesize=20)" gdebug="false"
							growclick="selectThis('gcolumn[biid]','gcolumn[whid]','gcolumn[whna]')"
							gcolumn="
									gcid = 0(headtext = 行号,name = rowid,align = center,width = 30,type = text,datatype = string);
									gcid=biid(name = biid,headtext =销售退货计划单号,width =240,align = left,headtype=sort,type=text,datatype=string);
									gcid=whid(name = whid,width =200,align = left,headtype=hidden,type=text,datatype=string);
									gcid=whna(name = whna,headtext =入库仓库,width =200,align = left,headtype=sort,type=text,datatype=string);
									" />
					</a4j:outputPanel>
		</div>
		<div id="hiddenDiv" style="display: none;">
			<h:inputHidden id="retid" value="#{returnReceiptMB.retid}" />
			<h:inputHidden id="retwhid" value="#{returnReceiptMB.retwhid}" />
			<h:inputHidden id="retwhna" value="#{returnReceiptMB.retwhna}" />
		</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
