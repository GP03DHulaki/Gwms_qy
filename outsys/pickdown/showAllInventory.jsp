<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>拣货下架任务明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="拣配下架任务明细">
		<meta http-equiv="description" content="拣配下架任务明细">
		<script type="text/javascript" src="pickdown.js"></script>
		<script type="text/javascript">
		function setSkin(){
			parent.parent.Gskin.setSkinCss(document);
		}
		//window.onload =setSkin();
	</script>
	</head>
	<body onload="setSkin();">
		<f:view>
			<h:form id="edit">
				<div id="mmain">
					<div id=mmain_opt>
						<a4j:outputPanel id="output">
							<a4j:commandButton id="addDBut" value="快捷拣货"
								onclick="if(!addDetails()){return false};"
								action="#{pickDownMB.addDetails}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,show,tableid"
								rendered="#{pickDownMB.MOD && pickDownMB.commitStatus}"
								requestDelay="50" oncomplete="endAddDetails();" />
							<a4j:commandButton id="skip" value="跳过"
								onclick="if(!skip()){return false};" action="#{pickDownMB.skip}"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,show,tableid"
								rendered="#{pickDownMB.MOD && pickDownMB.commitStatus}"
								requestDelay="50" oncomplete="endSkip();" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="showOutput('gtable1')" type="button" reRender="output" />
							<gw:GAjaxButton id="otpDBut1" value="导出" theme="b_theme"
								onclick="reportExcel('gtable1')" type="button" reRender="output" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="show">
						<g:GTable gid="gtable1" gtype="grid" gdebug="true" gsort="whid"
							gsortmethod="asc"
							gselectsql="select a.id,a.inco,(a.qty-a.fqty) as qty,a.whid,b.inna,b.inse,b.colo,c.whna,a.soid,a.baco       
						from pkln a left join inve b on a.inco = b.inco left join waho c on a.whid = c.whid   
						 Where (a.qty-a.fqty)<>0 and a.biid = '#{pickDownMB.mbean.soco}' and a.stat = '0'"
							gpage="(pagesize = -1)" gversion="2"
							gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
								gcid = id(headtext = ID,name = id,width = 30,align = center,type = hidden,headtype = string);
								gcid = whid(headtext = 货位编码,name = whid,width = 120,align = left,type = text,headtype = hidden ,datatype = string);
								gcid = whna(headtext = 应拣货位,name = whna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inco(headtext = 商品编码,name = inco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 80,align = left,type = text,headtype = sort ,datatype = string);
								gcid = qty(headtext = 应拣数量,name = qty,width = 60,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)});
								gcid = soid(headtext = 栏位,name = soid,width = 60,align = right,type = text,headtype = sort ,datatype = string);
								gcid = baco(headtext = 条码,name = baco,width = 120,align = left,type = text,headtype = sort ,datatype = string);
					" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pickDownMB.msg}" />
							<h:inputHidden id="sellist" value="#{pickDownMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>