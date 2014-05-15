<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.InitreplenishOrderMB"%>

<%
    InitreplenishOrderMB ai = (InitreplenishOrderMB) MBUtil
            .getManageBean("#{InitreplenishOrderMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<script type="text/javascript">
var post=[];
var x=1;
var y=1;
function add(){
	var pot={"X":x,"Y":y}
	post.push(pot);
	x++;
	y++;
	for(var i=0;i<post.length;i++){
		alert(post[i].X);
	}
}


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
		<title>主动补货任务列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="主动补货任务列表">
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>主动补货任务列表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{InitreplenishOrderMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{InitreplenishOrderMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('list','sk_inco,sk_biid,sk_moid,sk_stat');" />
							<gw:GAjaxButton value="生成补货任务" theme="b_theme"
								action="#{InitreplenishOrderMB.createTask}" id="deleteId"
								onclick="if(!creTask(gtable)){return false};"
								reRender="output,renderArea" oncomplete="endCreTask();"
								requestDelay="50" rendered="#{InitreplenishOrderMB.ADD}" />
							<gw:GAjaxButton value="刷新默认库位" theme="b_theme"
								action="#{InitreplenishOrderMB.initInwh}" id="initInwh"
								onclick="if(!initWhid()){return false};"
								reRender="output,renderArea" oncomplete="endCreTask();"
								requestDelay="50" rendered="#{InitreplenishOrderMB.ADD}" />
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" reRender="output" />
							<gw:GAjaxButton id="otpDBut1" value="测试"
								onclick="add()" type="button"/>
						</a4j:outputPanel>

					</div>
					<a4j:outputPanel id="queryForm" rendered="#{InitreplenishOrderMB.LST}">
						<div id="mmain_cnd">
						 	商品编码:
							<h:inputText id="sk_inco" styleClass="inputtext" size="15"
								onkeypress="formsubmit(event);"
								value="#{InitreplenishOrderMB.sk_inco}" />
								补货类型:
							<h:selectOneMenu id="sk_moid" value="#{InitreplenishOrderMB.sk_moid}">
								<f:selectItem itemLabel=" " itemValue=" " />
								<f:selectItem itemLabel="大箱补货" itemValue="TRUNK" />
								<f:selectItem itemLabel="溢出补货" itemValue="SPILL" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true" 
									
										gselectsql="
											select b.* from (										
						                        SELECT  a.inco,c.inna,c.colo,sum(a.qty) AS jqty,ISNULL(d.qty,0) AS yqty,ISNULL(e.qty,0) AS bqty FROM bain a JOIN waho b ON a.whid=b.whid
												JOIN inve c ON a.inco=c.inco 
												left JOIN (SELECT a.inco,sum(a.qty) as qty FROM bain a JOIN waho b ON a.whid=b.whid WHERE b.whty=6 GROUP BY a.inco) d
												ON a.inco=d.inco
												left JOIN (SELECT a.inco,sum(a.qty) as qty FROM bain a JOIN waho b ON a.whid=b.whid WHERE b.whty=5 GROUP BY a.inco) e
												ON a.inco=e.inco
												WHERE b.whty=4 and a.qty<=5 GROUP BY a.inco,c.inna,c.colo,d.qty,e.qty  ) b where b.jqty < 5 #{InitreplenishOrderMB.searchSQL} 
										"
										gpage="(pagesize = 20)" 
										gcolumn="
											gcid = 1(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rownu,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = inco(headtext = 商品编码,name = inco,width =120,align = left,type = text,datatype=string,headtype = sort);
										    gcid = inna(headtext = 商品名称,name = inna,width =100,align = left,type = text,datatype=string,headtype = sort);
										    gcid = colo(headtext = 规格,name = colo,width =60,align = left,type = text,datatype=string,headtype = sort);
										    gcid = jqty(headtext = 拣货库位数量,name = jqty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
										    gcid = yqty(headtext = 溢出库位数量,name = yqty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=initreplenishOrderJqtyDetail.jsf?inco=gcolumn[inco]);
										    gcid = bqty(headtext = 备货库位数量,name = bqty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=initreplenishOrderBqtyDetail.jsf?inco=gcolumn[inco]);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{InitreplenishOrderMB.msg}" />
							<h:inputHidden id="sellist" value="#{InitreplenishOrderMB.sellist}" />
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
