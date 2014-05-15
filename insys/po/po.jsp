<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@ page import="com.gwall.view.PubmMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>采购订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="采购订单">
		<meta http-equiv="description" content="采购订单">
		<script type="text/javascript" src="po.js"></script>
	</head>
	<%
		PubmMB ai = (PubmMB) MBUtil.getManageBean("#{pubmMB}");
		if (request.getParameter("isAll") != null) {
			ai.initSK();
		}
	%>
	<body id="mmain_body">
		<div id="mmain_nav">
			<font color="#000000">入库处理&gt;&gt;订单&gt;&gt;</font><b>采购订单</b>
			<br>
		</div>
		<f:view>
			<div id="mmain">
				<h:form id="edit">
					<div id="mmain_opt">
						<a4j:commandButton value="添加单据" type="button"
							onmouseover="this.className='a4j_over1'" rendered="#{pubmMB.ADD}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							oncomplete="addNew();" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="deleteId" value="删除单据" type="button"
							onclick="if(!deleteHeadAll()){return false};"
							rendered="#{pubmMB.DEL}" reRender="output,renderArea"
							action="#{pubmMB.deleteHead}" oncomplete="endDeleteHeadAll();"
							requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							value="查询" type="button" reRender="output" id="sid"
							onclick="search();" action="#{pubmMB.search}" requestDelay="50"
							oncomplete="endSearch()" rendered="#{pubmMB.LST}" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearData();" rendered="#{pubmMB.LST}" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
							onclick="reportExcel('gtable')" type="button"
							reRender="output,msg" />
						<!--&nbsp;&nbsp;&nbsp;&nbsp;
						 <a name="podetail" class="default_a" id="podetail"
							href="javascript:goToDetail(1)"><font size="3">预售商品汇总列表</font>
						</a> -->
					</div>
					<div id=mmain_cnd>
						<table>
							<tr>
								<td>
									<h:outputText value="创建日期从:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_start_date" styleClass="datetime" size="12"
										value="#{pubmMB.sk_start_date}"
										onfocus="#{gmanage.datePicker}" />
									<h:outputText value="至:">
									</h:outputText>
									<h:inputText id="sk_end_date" styleClass="datetime" size="12"
										value="#{pubmMB.sk_end_date}" onfocus="#{gmanage.datePicker}" />
								</td>
								<td>
									<h:outputText value="采购订单号:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_biid" styleClass="datetime" size="15"
										value="#{pubmMB.sk_obj.biid}" onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="来源单号:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_soco" styleClass="datetime" size="15"
										value="#{pubmMB.sk_obj.soco}" onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="制单号:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_outo" styleClass="datetime" size="15"
										value="#{pubmMB.sk_obj.outo}" onkeypress="formsubmit(event);" />
								</td>
							</tr>
							<tr>
								<td align="right">
									<h:outputText value="商品名称:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_inna" styleClass="datetime" size="15"
										value="#{pubmMB.sk_inna}" onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="供应商名称:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="sk_suna" styleClass="datetime" size="15"
										value="#{pubmMB.sk_obj.suna}" onkeypress="formsubmit(event);" />
								</td>
								<td>
									<h:outputText value="单据状态:">
									</h:outputText>
								</td>
								<td>
									<h:inputText id="orderFlag" styleClass="inputtext" size="20"
										value="#{pubmMB.orderFlag}"
										onclick="showsel(this,'orderFlags')" />
								</td>
							</tr>
						</table>

						<div id="orderFlags" class="checkboxsel" style="display: none;">
							<div id=mmain_opt>
								<a4j:commandButton value="全选"
									onmouseover="this.className='a4j_over'"
									onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
									onclick="selectAllItems('edit:flagList',true)" />
								<a4j:commandButton value="全清"
									onmouseover="this.className='a4j_over'"
									onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
									onclick="selectAllItems('edit:flagList',false)" />
							</div>
							<h:selectManyCheckbox id="flagList" value="#{pubmMB.orderFlags}"
								styleClass="selectItem" layout="pageDirection">
								<f:selectItems value="#{pubmMB.flags}" />
							</h:selectManyCheckbox>
						</div>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="SELECT a.id,a.biid,a.owid,a.suid,b.suna,a.indt,a.flag,a.stat,a.buty,a.chna,a.chdt,c.orna,a.soco,a.crdt,a.gddt,
								a.opna,a.pudt,a.whid,a.orid,a.rema,t.dpna,a.tale,isnull((select top 1 e.inna from pubd d join inve e on d.inco=e.inco where d.biid = a.biid ),'') as inna,a.outo,
								(select sum(aa.qty) from pubd aa where aa.biid = a.biid group by aa.biid) as qty,
								(select sum(aa.dqty) from pubd aa where aa.biid = a.biid group by aa.biid) as dqty,
								(select sum(bb.rqty) from pubd bb where bb.biid = a.biid group by bb.biid) as aqty,
								(select case when sum(cc.qty) - sum(cc.rqty)>0 then sum(cc.qty) - sum(cc.rqty) else 0 end as bqty from pubd cc where cc.biid = a.biid group by cc.biid) as bqty
								--(select sum(cc.dqty) - sum(cc.cqty) from pubd cc where cc.biid = a.biid group by cc.biid) as zqty
								FROM pubm a LEFT join suin b ON a.suid = b.suid 
								left join orga c on a.orid=c.orid left join dept t on a.dpid = t.dpid
								WHERE a.#{pubmMB.gorgaSql} AND a.flag in (#{pubmMB.flagSql}) #{pubmMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="true"
							gcolumn="gcid = 1(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
								gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = biid(headtext = 采购订单号,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
								gcid = biid(headtext = 采购订单号,name = biid,width = 120,align = left,type = link,headtype = sort,datatype = string,linktype = script,typevalue = po_edit.jsf?pid=gcolumn[biid]);
								gcid = inna(headtext = 商品名称,name = inna,width = 80,align = left,type = text,headtype = sort,datatype = string);
								gcid = outo(headtext = 制单号,name = outo,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = soco(headtext = 来源单号,name = soco,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = suna(headtext = 供应商名称,name = suna,width = 140,align = left,type = text,headtype = sort,datatype = string);
								gcid = owid(headtext = 货主,name = owid,width = 120,align = left,type = text,headtype = sort,datatype = string);
								gcid = rema(headtext = 备注,name = rema,width = 220,align = left,type = text,headtype = sort,datatype = string);
								gcid = gddt(headtext = 过帐日期,name = indt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
								gcid = indt(headtext = 预计到货日期,name = indt,width = 120,align = center,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
								gcid = qty(headtext = 订单总数,name = qty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = dqty(headtext =  实际到货数,name = dqty,width = 60,align = right,type = text,headtype=sort, datatype =number,dataformat=0.###,summary=this);
								gcid = aqty(headtext = 己入库数,name = aqty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = bqty(headtext = 待入库数,name = bqty,width = 80,align = right,type = text,headtype=sort, datatype =number,dataformat=0.##,summary=this);
								gcid = buty(headtext = 采购类型,name = buty,width = 60,align = center,type = mask,headtype = sort,datatype = string,typevalue=01:工厂采购/02:市场采购/03:耗材采购);
								gcid = flag(headtext = 状态,name = flag,width = 60,align = center,type = mask,typevalue=01:制作中/11:已审核/21:部分预约/22:全部预约/31:到货中/32:全部到货/41:检验中/51:入库中/99:已完成/100:已关闭,headtype = sort,datatype = string);
								gcid = chna(headtext = 审核人,name = chna,width = 50,align = left,type = text,headtype = sort,datatype = string);
								gcid = chdt(headtext = 审核时间,name = chdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{pubmMB.msg}" />
							<h:inputHidden id="sellist" value="#{pubmMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</div>
		</f:view>
	</body>
</html>