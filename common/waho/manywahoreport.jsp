<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.common.WahoCOM"%>

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
					</div>
					<div id="mmain_cnd">
						<h:outputText value="开始时间:">
						</h:outputText>
						<h:inputText id="startdate" styleClass="inputtextedit" size="15"
							onfocus="#{wahoCOM.datePicker}"
							value="#{wahoCOM.startdate}" onkeypress="formsubmit(event);" />
						<h:outputText value="结束时间:">
						</h:outputText>
						<h:inputText id="enddate" styleClass="inputtextedit" size="15"
							onfocus="#{wahoCOM.datePicker}"
							value="#{wahoCOM.enddate}" onkeypress="formsubmit(event);" />
					</div>
					<div id="mmain_free">
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2" gsort="mocount" gsortmethod="DESC"
								gselectsql="
									SELECT a.fwid AS whid,COUNT(a.fwid) AS mocount  FROM stlo a JOIN waho b ON a.fwid=b.whid
									WHERE (a.buty='move' OR a.buty='otherin' OR a.buty='PackBox' OR a.buty='PICKDOWN' OR a.buty='POIN'
									OR a.buty='SHEFT' OR a.buty='SALERETURN' OR a.buty='TRANIN' OR a.buty='otherout')
									AND a.fwid<>'' AND (b.whty='4' OR b.whty='6')
									AND b.whco='#{wahoCOM.pwid}' #{wahoCOM.sql}								
									GROUP BY a.fwid
								"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								gcolumn="
									gcid = whid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = whid(headtext = 库位编码,name = whid,width = 300,headtype = sort,align = left,type = text,datatype=string);
									gcid = mocount(headtext = 操作次数,name = mocount,width = 200,headtype = sort,align = left,type = text,datatype=string);
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