<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickDownMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>备货任务</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='picktask.js'></script>
		<script type="text/javascript">
	
		    function selectThis(parm1,parm2){
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				if(isGwin != false){
					callBack = parent;
				}else{
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
		    	if (callBack.document.getElementById("edit:soco") != null){
					callBack.document.getElementById("edit:soco").value=parm1;
				}
				if ( callBack.document.getElementById("edit:whid") != null){
					callBack.document.getElementById("edit:whid").value=parm2;
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

	<%
		PickDownMB ai = (PickDownMB) MBUtil.getManageBean("#{pickDownMB}");
		if (request.getParameter("time") != null) {
			ai.setSeasql("");
		}
		ai.getMbean().setCrus(session.getAttribute("userid").toString());
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{pickDownMB.seasql}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="备货任务:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{pickDownMB.soco}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="tale"
								gselectsql="select biid,soco,tale,whid from ptma 
										where flag >= 11 and flag < '31' and flag !='C9' and orid like '#{sessionScope['orid']==''?'#':sessionScope['orid']}%' and 
										(sius = '' or sius is null or sius = '#{pickDownMB.mbean.crus }')  #{pickDownMB.seasql }
										"
								gwidth="550" gpage="(pagesize = -1)" gdebug="false"
								growclick="selectThis('gcolumn[biid]','gcolumn[whid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 备货任务,name = biid,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = soco(headtext = 所属备货计划,name = biid,width = 160,headtype = sort,align = left,type = text,datatype=string);
									gcid = tale(headtext = 任务优先级,name = tale,width = 120,align = center,type = mask,typevalue = 1:普通任务/5:紧急任务,headtype = sort,datatype = string,bgcolor={gcolumn[tale]=5:#ff7474});
							" />
						</a4j:outputPanel>
					</div>
				
				</h:form>
			</f:view>
		</div>
	</body>
</html>