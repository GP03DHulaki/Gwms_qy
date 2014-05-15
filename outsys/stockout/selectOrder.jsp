<%@ page language="java" pageEncoding="UTF-8"%>
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
	<script type="text/javascript" src="pickdown.js"></script>
</head>
<script type="text/javascript">
	function selectThis(param1){
    	window.returnValue = param1;
		window.close();	
    }
	function showMes(){
		$('edit:searchpicktaskkey').value='';
		$('edit:sid').onclick();
	}


</script>
<body onload="showMes()">
	<f:view>
		<div id="mmain">
			<h:form id="edit">
				<div id=mmain_opt>
					<a4j:commandButton onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
						id="sid" value="查询" type="button" 
						reRender="output" requestDelay="50" />
					<a4j:commandButton type="button" value="重置" onclick="cleartext();"
						onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
				</div>
				<div id=mmain_cnd>
					<h:outputText value="出库计划:"></h:outputText>
					<h:inputText id="searchpicktaskkey" styleClass="inputtextedit" size="20"
						onkeypress="formsubmit(event);" />
				</div>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gtype="grid" gversion="2"
						gselectsql="
							SELECT 'OP11072900001' AS vc_voucherid,'2011-07-29 15:30' AS dt_createdate
							FROM temp
						"
						gwidth="550" gpage="(pagesize = 20)"
						growclick="selectThis('gcolumn[vc_voucherid]')"
						gcolumn="
							gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = vc_voucherid(headtext = 出库计划,name = vc_voucherid,width = 200,headtype = text,align = left,type = text,datatype=string);
							gcid = dt_createdate(headtext = 创建时间,name = dt_createdate,width = 200,headtype = sort,align = left,type = text,datatype=string,dataformat=yyyy-MM-dd HH:mm);
							" />
				</a4j:outputPanel>
			</h:form>
		</div>
	</f:view>
</body>
</html>