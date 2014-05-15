<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.PurchaseArriveMB"%><%@ include
	file="../../include/include_imp.jsp"%>
<%
    PurchaseArriveMB ai = (PurchaseArriveMB) MBUtil
            .getManageBean("#{purchaseArrvicMB}");
    if (request.getParameter("time") != null) {
        ai.setSql("");

    }
    if (request.getParameter("retid") != null) {
        ai.setRetid(request.getParameter("retid"));
    }
%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>采购到货单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='arrive.js'></script>
		<script type="text/javascript">
			var retid="",retname="";		//返回刷新的字段，如无，则不刷新
		    function selectThis(parm1,parm2){
				retid = $("edit:retid").value;
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
				isGwin ? Gwin.close(document.GwinID) : window.close();	
			}
			function formsubmit(){
				if (event.keyCode==13){
					var obj=$("edit:sid");
					obj.onclick();
					return true;
				}
			}
			
			function cleartext(){
				var a = $("edit:id");
				if(a!=null){
					a.value="";
					a.focus();
				}
			}
		</script>
	</head>


	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button"
							action="#{purchaseArrvicMB.search}" reRender="output"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="到货通知单号:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{purchaseArrvicMB.socoid}"
							onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="Select a.biid,a.crdt,a.ceve,b.suna From nofm a LEFT join suin b on a.suid=b.suid 
								Where #{purchaseArrvicMB.searchSQL} a.flag='41'or a.flag='51'"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 到货通知单号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = crdt(headtext = 到货日期,name = crdt,width = 125,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									gcid = suna(headtext = 供应商,name = suna,width = 220,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{purchaseArrvicMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>