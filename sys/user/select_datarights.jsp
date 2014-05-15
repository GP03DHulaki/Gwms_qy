<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@ taglib prefix="g" uri="/WEB-INF/GWallTag"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self" />
		<title>选择库位</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	</head>
	<script type="text/javascript">
		<!--
		    function startDo(){
		    	Gwallwin.winShowmask("TRUE");
		 		controlEditable("disabled");
			}
			
			function endDo(){
				Gwallwin.winShowmask("FALSE");
		        controlEditable("");
		     	alert($("edit:msg").value);
		     	var message = $('edit:msg').value;
		     	if(message.indexOf("成功!")!=-1){
					window.close();
				}
		   	}
		    function controlEditable(value){
		    	$("edit:deleteButton").disabled=value;
		    }
		    function doSaveAll(obj){
				var arr=Gtable.getselectid(obj);
			  	$("edit:vc_keyvalueitem").value=arr;
				startDo();
		 	}	
		 	function doInit(){
		 		$("edit:searchid").value="";
		 	}
		//-->
	</script>

	<body id=mmain_body onload="doInit();">
	<div id=mmain>
	<f:view>
		<h:form id="edit">
		<div id=mmain_opt>
			<a4j:commandButton id="deleteButton" value="保存"
				type="button" action="#{user.saveDatarights}"
				onclick="doSaveAll('gtable1');" 
				reRender="msg,output_datarights"
				oncomplete="endDo();" requestDelay="50"
				onmouseover="this.className='a4j_over'"
				onmouseout="this.className='a4j_buton'"
				styleClass="a4j_but" />
			<input type="button" value="返回" class="but"
				onmouseover="this.className='search_over'"
				onmouseout="this.className='search_buton'"
				onclick="javascript:window.close();"/>
			
			<h:selectOneMenu id="ch_righttype" value="#{user.ch_righttype}" >
				<a4j:support event="onchange" action="#{user.selectchange}" reRender="output_datarights"></a4j:support> 
				<f:selectItem itemLabel="" itemValue="" />
				<f:selectItem itemLabel="仓库" itemValue="S" />
				<f:selectItem itemLabel="库位" itemValue="W" />
			</h:selectOneMenu> 
			&nbsp;&nbsp;&nbsp;&nbsp;
			<font style="background-color: #efefef">编码:</font>
			<h:inputText id="searchid" styleClass="inputtext" value="#{user.searchid}" />
			<a4j:commandButton id="seach" value="查询"
				type="button" action="#{user.querydatarights}"
				reRender="output_datarights"
				requestDelay="50"
				onmouseover="this.className='a4j_over'"
				onmouseout="this.className='a4j_buton'"
				onclick=""
				styleClass="a4j_but" />
		</div>
		<a4j:outputPanel id="output_datarights">
			<g:GTable gid="gtable1" gtype="grid" gversion="2"
				gselectsql="Select '库位' As type,vc_warehouseid As id,nv_warehousename as name
					From gt_warehouse where ch_status = '1' And vc_warehouseid Like '#{user.searchvalue}'
						And '#{user.ch_righttype}' = 'W'
					Union all
					Select '仓库' As type,vc_storehouseid As id,vc_storehousename as name
					From gt_storehouse where ch_status = '1' And vc_storehouseid Like '#{user.searchvalue}'
						And '#{user.ch_righttype}' = 'S'
					"
				gpage="(pagesize = 20)"
				gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
					gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
					gcid = type(headtext = 类型,name = type,width = 40,headtype = sort,align = center,type = text,datatype=string);
					gcid = id(headtext = 编码,name = id,width = 100,headtype = sort,align = left,type = text,datatype=string);
					gcid = name(headtext = 名称,name = name,width = 300,headtype = sort,align = left,type = text,datatype=string);
				"
			/>
		</a4j:outputPanel>
		<h:inputHidden id="msg" value="#{user.msg}" />
		<h:inputHidden id="vc_keyvalueitem" value="#{user.vc_keyvalueitem}"></h:inputHidden>
		</h:form>
	</f:view>
	</div>
	</body>
</html>