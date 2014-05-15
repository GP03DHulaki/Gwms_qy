<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@ page import="com.gwall.view.StockPlanMB"%>

<%
	StockPlanMB ai = (StockPlanMB) MBUtil
			.getManageBean("#{stockPlanMB}");
	if (request.getParameter("time") != null) {
		ai.setSelKey(" 1=1 ");
	}
	if (request.getParameter("retid") != null) {
		ai.setRetid(request.getParameter("retid").toString().trim());
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />

		<title>选择人员</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type="text/javascript">
			function selectUser(obj){
				var arr=Gtable.getselectid(obj);
				if(arr.length>0){
					var retid = $('list:retid').value;
			    	if ( retid != "" && retid != null){
			    		parent.document.getElementById(retid).value = arr;
					}
					Gwin.close(document.GwinID);	
					alert("添加成功!");
				}else{
				   	alert("请选择记录!");
				}
			}
			
			function formsubmit(){
				if (event.keyCode==13){
					var obj=document.getElementById("list:sid");
					obj.onclick();
					return true;
				}
			}
		</script>
	</head>
	<body id="mmain_body">		
		<f:view>
			<h:form id="list">
				<div id="mmain_opt">				
					<h:outputText value="用户编码:" />
					<h:inputText id="selectCode" styleClass="datetime" size="15"
						value="#{stockPlanMB.selectCode}" />
					<h:outputText value="用户名称:" />
					<h:inputText id="selectName" styleClass="datetime" size="15"
						value="#{stockPlanMB.selectName}"/>
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="sid" value="查询" type="button"
						action="#{stockPlanMB.selectUser}" reRender="output"
						requestDelay="50" >
					</a4j:commandButton>
					<a4j:commandButton styleClass='a4j_but' value='确定'
						onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'"
						onclick="selectUser('gtable')" />
				</div>
				<div id="mmain_cnd">
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gpage="(pagesize = -1)"
							gversion="2" gdebug="false"
							gselectsql="select usid,usna 
						,CASE WHEN usid IN (SELECT col FROM f_splitSTR('#{stockPlanMB.selElement}',',')) THEN 1 ELSE 0 END AS isSelect
						from usin where stat='1' AND #{stockPlanMB.selKey}"
							gcolumn="
							gcid = usid(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string,typevalue=gcolumn[isSelect]);
							gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
							gcid = usid(headtext = 用户编码,name = usid,width = 200,headtype = sort,align = left,type = text,datatype=string);
							gcid = usna(headtext = 用户名称,name =  usna,width = 200,headtype = sort,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
				</div>
				<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{stockPlanMB.retid}" />
						<h:inputHidden id="retname" value="#{stockPlanMB.retname}" />
				</div>
			</h:form>
		</f:view>
	</body>
</html>