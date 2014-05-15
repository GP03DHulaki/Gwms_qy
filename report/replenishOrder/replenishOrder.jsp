<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.ReplenishOrderMB"%>

<%
    ReplenishOrderMB ai = (ReplenishOrderMB) MBUtil
            .getManageBean("#{replenishOrderMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<script type="text/javascript">
function doSearch(){
	$("list:sid").click();
}

function creTask(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(incos.Trim().length<=0){
		alert("请选择需要补货的商品!");
		return false;
	}else{
		if(confirm("确定生成补货任务?")){
			Gwallwin.winShowmask("TRUE");
			$("list:sellist").value = incos;
			return true;
		}
	}
}

function initWhid(){
	if(confirm("刷新在架商品到默认库位,是否确定?")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

function endCreTask(){
	var msg = $("list:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}
function doSearch(){
	$("list:sid").click();
}
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>待补货订单列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="待补货订单">
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>待补货订单列表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{replenishOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{replenishOrderMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('list','sk_inco,sk_biid,sk_moid,sk_stat');" />
							<gw:GAjaxButton value="生成补货任务" theme="b_theme"
								action="#{replenishOrderMB.createTask}" id="deleteId"
								onclick="if(!creTask(gtable)){return false};"
								reRender="output,renderArea" oncomplete="endCreTask();"
								requestDelay="50" rendered="#{replenishOrderMB.ADD}" />
							<gw:GAjaxButton value="刷新默认库位" theme="b_theme"
								action="#{replenishOrderMB.initInwh}" id="initInwh"
								onclick="if(!initWhid()){return false};"
								reRender="output,renderArea" oncomplete="endCreTask();"
								requestDelay="50" rendered="#{replenishOrderMB.ADD}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
						</a4j:outputPanel>

					</div>
					<a4j:outputPanel id="queryForm" rendered="#{replenishOrderMB.LST}">
						<div id="mmain_cnd">
							商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{replenishOrderMB.sk_inco}" />
							订单号:
							<h:inputText id="sk_biid" styleClass="inputtext" size="25"
								onkeypress="formsubmit(event);"
								value="#{replenishOrderMB.sk_biid}" />
							单据类型:
							<h:selectOneMenu id="sk_moid" value="#{replenishOrderMB.sk_moid}"
								onchange="doSearch();">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="销售订单" itemValue="OUTORDER" />
								<f:selectItem itemLabel="调拨计划" itemValue="TRANPLAN" />
							</h:selectOneMenu>
							状态:
							<h:selectOneMenu id="sk_stat" value="#{replenishOrderMB.sk_stat}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="大货补货" itemValue="1" />
								<f:selectItem itemLabel="溢出补货" itemValue="2" />
								<f:selectItem itemLabel="上架" itemValue="3" />
								<f:selectItem itemLabel="缺货" itemValue="4" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="stat" gsortmethod="ASC"
										gselectsql="
											select b.inco,b.inna,b.colo,b.inse,b.qty,b.jqty,b.yqty,b.bqty,b.stat,b.cqty,b.whid,c.whid AS idwh,b.baco
											,(select top 1 c.whid from stnu c left join waho d on d.whid=c.whid where c.inco=b.inco and d.whty='5' and b.bqty>0 and c.uqty>0) as bwhid
											from f_outorderdetail('#{replenishOrderMB.sk_biid}','#{replenishOrderMB.gorid}','#{replenishOrderMB.sk_moid}') b
											LEFT JOIN inwh c on b.inco=c.inco and c.whco='D0101'
										    WHERE 1=1 and b.inco not in (select b.inco from stma a left  join stde b on a.biid=b.biid where a.flag='01')
										    #{replenishOrderMB.searchSQL}
										"
										gpage="(pagesize = -1)"
										gcolumn="
											gcid = 1(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rownu,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = inco(headtext = 商品编码,name = inco,width =120,align = left,type = text,datatype=string,headtype = sort);
										    gcid = inna(headtext = 商品名称,name = inna,width =100,align = left,type = text,datatype=string,headtype = sort);
										    gcid = colo(headtext = 规格,name = colo,width =60,align = left,type = text,datatype=string,headtype = sort);
										    gcid = inse(headtext = 规格码,name = inse,width =60,align = left,type = text,datatype=string,headtype = sort);
										    gcid = idwh(headtext = 默认库位,name = idwh,width =100,align = left,type = text,datatype=string,headtype = sort);
										    gcid = qty(headtext = 订单数量,name = qty,width =75,align = right,type = number,datatype=number,dataformat={0},summary=this,headtype = sort);
										    gcid = jqty(headtext = 拣货库位数量,name = jqty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = yqty(headtext = 溢出库位数量,name = yqty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = cqty(headtext = 移动库位数量,name = cqty,width =80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=replenishOrderMqtyDetail.jsf?inco=gcolumn[inco]);
										    gcid = bqty(headtext = 备货库位数量,name = bqty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=replenishOrderBqtyDetail.jsf?inco=gcolumn[inco]);
											gcid = stat(headtext = 状态,name = stat,width =80,headtype = sort,align = center,type = mask,datatype=string,typevalue=5:/1:大货补货/2:溢出补货/3:上架/4:缺货,bgcolor={gcolumn[stat]=1:red/gcolumn[stat]=2:#F4CA80/gcolumn[stat]=3:#7FFFD41/gcolumn[stat]=4:#FFFF00});
											gcid = bwhid(headtext = 商品所在库位,name = idwh,width =100,align = left,type = text,datatype=string,headtype = sort);
										    " />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{replenishOrderMB.msg}" />
							<h:inputHidden id="sellist" value="#{replenishOrderMB.sellist}" />
						</a4j:outputPanel>
					</div>
					<%-- 
						,linktype = script,typevalue=replenishOrderJqtyDetail.jsf?inco=gcolumn[inco]
					--%>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
