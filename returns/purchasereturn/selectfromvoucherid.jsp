<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择采购退货计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="gwall">
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwalldate.js'></script>
		<script src="salesreturn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/js/DatePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		function formsubmit(){
			if (event.keyCode==13){
				var obj=document.getElementById("list:sid");
				obj.onclick();
				return true;
			}
		}
		function selectThis(parm1,parm2,parm3){
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
			isGwin ? parent.document.getElementById("edit:soco").value = parm1 : callBack.document.getElementById("edit:soco").value=parm1;
			isGwin ? parent.document.getElementById("edit:whid").value = parm2 : callBack.document.getElementById("edit:whid").value=parm2;
			isGwin ? parent.document.getElementById("edit:whna").value = parm3 : callBack.document.getElementById("edit:whna").value=parm3;
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
						<h:outputText value="采购退货计划单号:" />
						<h:inputText id="select_voucherid" styleClass="datetime" size="15"
							value="#{purchaseReturnMB.sk_obj.soco}"
							onkeypress="formsubmit(event);" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" reRender="output"
							requestDelay="50" action="#{purchaseReturnMB.search}" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="cid" value="重置" type="button"
							onclick="textClear('edit','select_voucherid');" requestDelay="50" />
					</div>

					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2"
							gselectsql="
select a.biid,a.flag,a.crna ,a.whid,b.whna from prbm a
left join waho b on a.whid=b.whid
where 1=1 and flag<>'31' and flag<>'01' and a.#{purchaseReturnMB.gorgaSql}
 #{purchaseReturnMB.searchSQL} "
							gpage="(pagesize=25)" gdebug="true"
							growclick="selectThis('gcolumn[biid]','gcolumn[whid]','gcolumn[whna]')"
							gcolumn="
									gcid = 0(headtext = 行号,name = rowid,align = center,width = 30,type = text,datatype = string);
									gcid=biid(name = biid,headtext =采购退货计划单号,width =400,align = left,headtype=sort,type=text,datatype=string);
									gcid=whna(name = whna,headtext =出库仓库,width =100,align = left,headtype=sort,type=text,datatype=string);
									gcid=whid(name = whid,headtype=hidden,type=text,datatype=string);
									gcid=crna(name = crna,headtext =制单人,width =100,align = left,headtype=sort,type=text,datatype=string);
									" />
					</a4j:outputPanel>

				</h:form>
			</f:view>
		</div>
	</body>
</html>
