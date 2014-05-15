<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>选择出库订单</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content=出库订单>
	<meta http-equiv="description" content="出库订单">
	<script type="text/javascript" src="entruckplan.js"></script>
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
					<a4j:commandButton styleClass='a4j_but' 
						value='确定' action="#{entruckPlanMB.addDetail}" reRender="renderArea,output"
						onmouseover="this.className='a4j_over'" onmouseout="this.className='a4j_buton'"
						oncomplete="endAddOrder();" onclick="if(!selectFromId('gtable3')){return false}"
						 />	
					<a4j:commandButton type="button" value="返回" onclick="window.close();"
						onmouseover="this.className='a4j_over'"
						onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />	 
				</div>
				<div id=mmain_cnd>
					<h:outputText value="出库订单:"></h:outputText>
					<h:inputText id="searchpicktaskkey" styleClass="inputtextedit" size="15"
						onkeypress="formsubmit(event);" />
					<h:outputText value="客户:"></h:outputText>
					<h:inputText id="customer" styleClass="inputtextedit" size="15"
						onkeypress="formsubmit(event);" />	
				</div>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable3" gtype="grid" gversion="2"
						gdebug="false"
						gselectsql="
							SELECT a.id,a.biid,a.cuid,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,a.chdt,a.tavo,a.orid,a.soty,a.tanu,a.lico,
							a.tawe,a.orad,a.stat,a.rema,b.cuna FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid 
							WHERE a.flag='11' "
						gpage="(pagesize = -1)"
						gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 出库订单,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = cuna(headtext = 客户名称,name = cuna,width = 130,headtype = sort,align = left,type = text,datatype=string);
							gcid = lico(headtext = 路线,name = lico,width = 60,headtype = sort,align = left,type = text,datatype=string);
							gcid = tavo(headtext = 总体积,name = tavo,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = tawe(headtext = 总重量,name = tawe,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = tanu(headtext = 总数量,name = tanu,width = 55,headtype = sort,align = left,type = text,datatype=number,dataformat={0.##});
							gcid = rema(headtext = 备注,name = rema,width = 100,headtype = sort,align = left,type = text,datatype=string);
					" />
				</a4j:outputPanel>
				
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{entruckPlanMB.msg}" />
						<h:inputHidden id="sellist" value="#{entruckPlanMB.sellist}" />
					</a4j:outputPanel>
				</div>
			</h:form>
			
			<div id="errmsg" style="display: none">
				<div id=mmain_cnd align="left">
					<span id="mes" style="color: red;"></span>
					<div align="center">
						<button type="button" onclick="Gwallwin.winClose();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" class="a4j_but">
							关闭
						</button>
					</div>
				</div>
			</div>
			
		</div>
	</f:view>
</body>
</html>