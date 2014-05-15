<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>来源货位或上架车</title>
	<meta http-equiv="pragma" content="no-cache"> 
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="来源货位或上架车">
	<meta http-equiv="description" content="来源货位或上架车">
</head>
<script type="text/javascript">
	function selectThis(parm1){
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
		var fromvoucherid =callBack.document.getElementById("edit:vc_warehouseid");
		if(fromvoucherid!=null){
			fromvoucherid.value=parm1;
		}
		window.close();	
    }
	function showMes(){
		if($("edit:sk_carid")!=null){
			$("edit:sk_carid").value = "";
		}
		if($("edit:sk_operatetype")!=null){
			$("edit:sk_operatetype").value = "0";
		}
	}
	function cleartext(){
		if($("edit:sk_carid")!=null){
			$("edit:sk_carid").value = "";
			$("edit:sk_carid").focus();
		}
		if($("edit:sk_operatetype")!=null){
			$("edit:sk_operatetype").value = "0";
		}
	}
	//回车监听
	function formsubmit(){
		if (event.keyCode==13)
		{
			var obj=$("edit:sid");
			obj.onclick();
			return true;
		}
	}

</script>

<body id="mmain_body" onload="showMes()">
	<f:view>
		<div id="mmain">
			<h:form id="edit">
				<div id=mmain_opt>
					<a4j:commandButton onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						id="sid" value="查询" type="button" action="#{shelvMB.searchCar}"
						reRender="output" requestDelay="50" rendered="#{shelvMB.LST}" />
					<a4j:commandButton type="button" value="重置" onclick="cleartext();"
						onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
				</div>
				<div id=mmain_cnd>
					<h:outputText value="来源货位或上架车:">
					</h:outputText>
					<h:inputText id="sk_carid" styleClass="datetime" size="12"
						value="#{shelvMB.sk_carid}" onkeypress="formsubmit(event);" />
				</div>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gtype="grid" gversion="2"
						gselectsql="SELECT DISTINCT a.vc_warehouseid,b.nv_warehousename 
									FROM v_astock a JOIN gt_warehouse b ON a.vc_warehouseid = b.vc_warehouseid 
									WHERE b.ch_status = '1' and b.ch_flag IN ('C','Z1','Z2','Z3','Z4','C1','C2','C3','C4') 
									AND a.vc_warehouseid NOT IN (SELECT vc_carid FROM gt_carflag WHERE ch_flag = '1') #{shelvMB.sKey}"
						gwidth="550" gpage="(pagesize = 20)" gdebug = "false"
						growclick="selectThis('gcolumn[1]')"
						gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 50,headtype = text,align = center,type = text,datatype=string);
								gcid = vc_warehouseid(headtext = 来源货位或上架车,name = vc_warehouseid,width = 210,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_warehousename(headtext = 来源货位或上架车名称,name = nv_warehousename,width = 210,headtype = sort,align = left,type = text,datatype=string);
								" />
				</a4j:outputPanel>
			</h:form>
		</div>
	</f:view>
</body>
</html>