<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.common.WahoCOM"%>

<%
    WahoCOM ai = (WahoCOM) MBUtil.getManageBean("#{wahoCOM}");
    if (request.getParameter("time") != null) {
        ai.setId("");
        ai.setNa("");
    }
    if (request.getParameter("type") != null) {
        ai.setType(request.getParameter("type"));
    }
    if (request.getParameter("retid") != null) {
        ai.setRetid(request.getParameter("retid"));
    }
    if (request.getParameter("retname") != null) {
        ai.setRetname(request.getParameter("retname"));
    }

    if (request.getParameter("orid") != null) {
        ai.setOrid(request.getParameter("orid"));
    }
    if (request.getParameter("pwid") != null) {
        ai.setPwid(request.getParameter("pwid"));
    }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>库位信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='waho.js'></script>
		<script type="text/javascript">
			//选择货位点击确定按钮
			function commitisok(obj){	
				var arr=Gtable.getselectid(obj);
				if(arr.Trim().length<0){
					alert("请选择货位!");
					return false;
				}
				if(arr != '')
				{
					selectThis(arr,null);
				}
			}
			
			function thisclose(){
				window.close();
			}
		</script>
	</head>
	<body id="mmain_body">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="sid" value="查询" type="button" action="#{wahoCOM.search}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							id="isok" value="确定" type="button"
							onclick="commitisok('gtable');" reRender="output"
							requestDelay="50" />
						<a href="manywahoreport.jsf">-->库位操作频率</a>
					</div>
					<div id="mmain_cnd">
						<h:outputText value="库位编码:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{wahoCOM.id}" onkeypress="formsubmit(event);" />
						<h:outputText value="库位名称:">
						</h:outputText>
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{wahoCOM.na}" onkeypress="formsubmit(event);" />
					</div>
					<div id="mmain_free">
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT whid,whna FROM waho WHERE 1=1 AND 
									whfl='P' AND orid like '#{wahoCOM.orid}' 
									AND  whco = '#{wahoCOM.pwid}' #{wahoCOM.typesql}
									#{wahoCOM.sql} "
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								gcolumn="
									gcid = whid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = whid(headtext = 库位编码,name = whid,width = 250,headtype = sort,align = left,type = text,datatype=string);
									gcid = whna(headtext = 库位名称,name = whna,width = 250,headtype = sort,align = left,type = text,datatype=string);
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{wahoCOM.retid}" />
						<h:inputHidden id="retname" value="#{wahoCOM.retname}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>