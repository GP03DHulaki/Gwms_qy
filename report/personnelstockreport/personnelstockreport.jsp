<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.OrderCountMB"%>

<%
    OrderCountMB ai = (OrderCountMB) MBUtil
            .getManageBean("#{orderCountMB}");
    if (request.getParameter("isAll") != null) {
        ai.initSK();
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>员工绩效</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="员工绩效">
			<script type='text/javascript' src='personnelstockreport.js'></script>
		<script type="text/javascript">
			function formsubmit(){
				if (event.keyCode==13)
				{
					var obj=$("edit:sid");
					obj.onclick();
					return true;
				}
			}	
		</script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>员工出库明细报表</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
					
						
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs" rendered="#{orderCountMB.LST}">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="Gwallwin.winShowmask('TRUE');"
								oncomplete="Gwallwin.winShowmask('FALSE');" reRender="output"
								action="#{orderCountMB.searchReport}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','crus,crna,start_date,end_date,iscancel,isreturn,lpco');" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{orderCountMB.exportPersonnelStockReport}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>

					</div>
					<a4j:outputPanel id="queryForm" rendered="#{orderCountMB.LST}">
						<div id="mmain_cnd">
							开始时间:
							<h:inputText id="start_date" styleClass="datetime" size="16"
								onfocus="#{gmanage.datePicker}"
								value="#{orderCountMB.sk_start_datetime}" />
							到:
							<h:inputText id="end_date" styleClass="datetime" size="16"
								onfocus="#{gmanage.datePicker}"
								value="#{orderCountMB.sk_end_datetime}" />
							用户编码:
							<h:inputText id="crus" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{orderCountMB.crus}" />
							用户名称:
							<h:inputText id="crna" styleClass="inputtext" size="12"
								onkeypress="formsubmit(event);" value="#{orderCountMB.crna}" />
							承运商:
							<h:inputText id="lpco" styleClass="inputtext" size="10"
								onkeypress="formsubmit(event);" value="#{orderCountMB.lpco}" />
							是否包含取消包裹:
							<h:selectOneMenu id="iscancel" value="#{orderCountMB.iscancel}">
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							是否包含拒收包裹:
							<h:selectOneMenu id="isreturn" value="#{orderCountMB.isreturn}">
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT b.chus AS crus,b.chna AS crna,c.lpco,d.lpna,COUNT(DISTINCT a.obid) AS orderQty,sum(a.qty) AS qty
											,SUM(CASE WHEN c.inty ='S' THEN a.qty ELSE 0 END) AS sqty
											,SUM(CASE WHEN c.inty ='O' OR c.inty ='M' THEN a.qty ELSE 0 END) AS mqty
											,COUNT(DISTINCT CASE WHEN c.inty ='S' THEN a.obid ELSE NULL END) AS soqty 
											,COUNT(DISTINCT CASE WHEN c.inty ='O' OR c.inty ='M' THEN a.obid ELSE NULL END) AS moqty 
											FROM lode a JOIN loma b ON a.biid=b.biid JOIN obma c ON a.obid=c.biid
											LEFT JOIN lpin d ON c.lpco=d.lpco
											WHERE b.flag='11'  #{orderCountMB.searchSQL}
											GROUP BY b.chus,b.chna,c.lpco,d.lpna
										"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = crus,width = 30,headtype = text,align = center,type = text,datatype=string);											   
										    gcid = crus(headtext = 用户编码,name = crus,width =100,align = left,type = text,datatype=text,headtype = sort);
										    gcid = lpna(headtext = 承运商,name = lpna,width =100,align = left,type = text,datatype=text,headtype = sort);
										    gcid = crna(headtext = 用户名称,name = crna,width =100,align = left,type = text,datatype=text,headtype = sort);
										    gcid = orderQty(headtext = 订单数,name = orderQty,width = 80,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
										    gcid = qty(headtext = 总商品数,name = qty,width = 80,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=personnelstockreport_edit.jsf?isAll=true&type=&crus=gcolumn[crus]&lpco=gcolumn[lpco]);
										    gcid = soqty(headtext = 一单一货订单数,name = soqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
										    gcid = sqty(headtext = 一单一货商品数,name = sqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=personnelstockreport_edit.jsf?isAll=true&type=s&crus=gcolumn[crus]&lpco=gcolumn[lpco]);
										    gcid = moqty(headtext = 一单多货订单数,name = moqty,width = 120,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this,bgcolor={#E0EEEE});
										    gcid = mqty(headtext = 一单多货商品数,name = mqty,width = 120,headtype = sort,align = right,type = link,datatype=number,dataformat={0},summary=this,linktype = script,typevalue=personnelstockreport_edit.jsf?isAll=true&type=m&crus=gcolumn[crus]&lpco=gcolumn[lpco]);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{orderCountMB.msg}" />
							<h:inputHidden id="gsql" value="#{orderCountMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{orderCountMB.outPutFileName}" />
						</a4j:outputPanel>
					</div>

					<%--
						select top 30 a.crus,a.crna,
						(select count(distinct aa.biid) from olma aa join olde bb on aa.biid = bb.biid join obma cc on cc.biid=aa.soco where cc.lpna=c.lpna and aa.crus = a.crus and aa.crna = a.crna and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}') as orderQty,
						(select sum(bb.qty) from olma aa join olde bb on aa.biid = bb.biid join obma cc on cc.biid=aa.soco where cc.lpna=c.lpna and aa.crus = a.crus and aa.crna = a.crna and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}') as qty,
						(select count(*) from olma aa join obma cc on aa.soco = cc.biid where cc.lpna=c.lpna and aa.crus = a.crus and aa.crna = a.crna and cc.inty = 'S' and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}')  as soqty,
						(select isnull(sum(bb.qty),0) from olma aa join olde bb on aa.biid =bb.biid join obma cc on aa.soco = cc.biid where cc.lpna=c.lpna and  aa.crus = a.crus and aa.crna = a.crna and cc.inty = 'S'and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}')  as sqty,
						(select count(*) from olma aa join obma cc on aa.soco = cc.biid where cc.lpna=c.lpna and  aa.crus = a.crus and aa.crna = a.crna and cc.inty = 'M' and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}')  as moqty,
						(select isnull(sum(bb.qty),0) from olma aa join olde bb on aa.biid =bb.biid join obma cc on aa.soco = cc.biid where cc.lpna=c.lpna and aa.crus = a.crus and aa.crna = a.crna and cc.inty = 'M' and aa.crdt >= '#{orderCountMB.sk_start_datetime}' and aa.crdt <= '#{orderCountMB.sk_end_datetime}') as mqty,lpna
						from olma a join olde b on a.biid = b.biid join obma c on a.soco=c.biid  where 1=1  #{orderCountMB.searchSQL} group by a.crus,a.crna,c.lpna order by a.crus,c.lpna
					 --%>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
