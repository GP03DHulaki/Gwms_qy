<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.MoinMB"%>
<jsp:directive.page import="javax.faces.context.FacesContext" />
<jsp:directive.page import="javax.faces.el.ValueBinding" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='moin.js'></script>
		<script type="text/javascript">
	
    function selectThis(parm1,parm2,parm3,parm4){
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
    	if ( callBack.document.getElementById("edit:soco") != null){
			callBack.document.getElementById("edit:soco").value=parm1;
		}
		if ( callBack.document.getElementById("edit:whid") != null){
			callBack.document.getElementById("edit:whid").value=parm2;
		}
		if ( callBack.document.getElementById("edit:whna") != null){
			callBack.document.getElementById("edit:whna").value=parm3;
		}
		if ( callBack.document.getElementById("edit:dety") != null){
			callBack.document.getElementById("edit:dety").value=parm4;
		}
		window.close();	
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

	<%
		MoinMB ai = (MoinMB) MBUtil.getManageBean("#{moinMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");
			
		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{moinMB.seasql}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="生产包装计划:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{moinMB.socoid}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.biid,a.whid,b.whna,a.dety from ctma a left join waho b on a.whid = b.whid 
											where flag>=11 and flag <51 and a.#{moinMB.gorgaSql}  #{moinMB.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]','gcolumn[whid]','gcolumn[whna]','gcolumn[dety]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 生产包装计划单,name = biid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = whna(headtext = 入库仓库,name = whna,width = 200,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{moinMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>