<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>添加明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='po_list.js'></script>
	</head>
	<body id=mmain_body onload="init()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button"
							action="#{purchaseMB.searchDetail}"
							oncomplete="init();Gwallwin.winShowmask('FALSE');"
							onclick="Gwallwin.winShowmask('TRUE');" reRender="output"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							action="#{purchaseMB.clearList}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<a4j:commandButton type="button" value="添加明细"
							action="#{purchaseMB.addDetail}"
							onmouseover="this.className='a4j_over1'"
							onclick='if(!purchaseData()){return false};'
							oncomplete="closeDiag()" reRender="renderArea,output"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="suna" styleClass="inputtextedit" size="15"
							value="#{purchaseMB.mbean.suna}" disabled="true" />
						<h:inputHidden id='suid' value='#{purchaseMB.mbean.suid}'></h:inputHidden>
						<h:outputText value="采购订单号:">
						</h:outputText>
						<h:inputText id="pubdid" styleClass="inputtextedit" size="15"
							value="#{purchaseMB.pubdid}" onkeypress="formsubmit(event);" />
						<h:outputText value="物料编码:">
						</h:outputText>
						<h:inputText id="sk_inco" styleClass="inputtextedit" size="15"
							value="#{purchaseMB.sk_inco}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid"
								gselectsql="select  a.did,a.biid,a.inco,a.suid,p.pudt,a.qty as aqty,a.dqty,a.rqty ,a.rema,a.roid ,p.tale,
									(select sum(qty) from cpbd c left join cpbm d on c.biid = d.biid where c.soco =a.biid and c.inco=a.inco) as other,
									cast(a.qty as int) - 
									cast(ISNULL((select sum(qty) from cpbd c left join cpbm d on c.biid = d.biid where c.soco =a.biid and c.inco=a.inco and d.flag<'31'),'0') as int) -
									cast(ISNULL((select sum(fqty) from cpbd c left join cpbm d on c.biid = d.biid where c.soco =a.biid and c.inco=a.inco and d.flag>='31'),'0') as int) 
									as avai ,c.colo,c.inse
									FROM pubd a left join pubm p on p.biid=a.biid join inve c on a.inco = c.inco
									where p.suid ='#{purchaseMB.mbean.suid}' 
									and  a.biid+a.inco not in (select soco+inco from cpbd where biid='#{purchaseMB.mbean.biid}') 
									#{purchaseMB.searchSQL}"
								gpage="(pagesize = 20)" gversion="2" gdebug="true"
								gcolumn="gcid = did(headtext = selall,name = pk,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
									gcid = biid(headtext = 采购订单号,name = biids,width = 0,align = left,type = text,headtype = hidden,datatype = string);
									gcid = biid(headtext = 采购订单号,name = biid,width = 110,align = left,type = text,headtype = sort,datatype = string);
									gcid = tale(headtext = 是否紧急,name = tale,width = 60,align = center,type = mask,typevalue=20:普通/10:紧急,headtype = sort,datatype = string,bgcolor={gcolumn[tale]=10:#FF0000});
									gcid = inco(headtext = 商品编码,name = inco,width = 110,align = left,type = text,headtype = sort,datatype = string);
									gcid = colo(headtext = 规格,name = colo,width = 80,align = left,type = text,datatype = sort);
									gcid = inse(headtext = 规格码,name = inse,width = 60,align = left,type = text,datatype = sort);
									gcid = pudt(headtext = 采购时间,name = pudt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
									gcid = aqty(headtext =  计划数量,name = aqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = dqty(headtext =  已到货,name = dqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = rqty(headtext =  已入库,name = rqty,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = other(headtext =  已预约数,name = other,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = avai(headtext =  可预约数,name = avai,width = 70,align = right,type =text,headtype= sort, datatype =number,dataformat=0.##,summary=this);
									gcid = -1(headtext =  本次预约数,name = nowqty,width = 70,align = right,type =input,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event),selectCheckBox(this),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
										" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseMB.msg}" />
							<h:inputHidden id="dbdata" value="#{purchaseMB.dbdata}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>