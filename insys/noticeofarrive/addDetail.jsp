<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.stockin.NoticeOfArriveMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>选择商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='noticeofarrive.js'></script>
	</head>

	<%
		NoticeOfArriveMB ai = (NoticeOfArriveMB) MBUtil
				.getManageBean("#{noticeOfArriveMB}");
		if (request.getParameter("time") != null) {

		}
	%>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{noticeOfArriveMB.addDetails}"
							reRender="renderArea,output"
							rendered="#{noticeOfArriveMB.MOD && noticeOfArriveMB.commitStatus}"
							oncomplete="endAddDetails();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="startDo()" oncomplete="endLoad()" id="sid" value="查询"
							type="button" action="#{noticeOfArriveMB.addDetailSearch}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置"
							onclick="clearDetailText();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						采购订单:
						<h:inputText id="poid" styleClass="inputtextedit" size="15"
							value="#{noticeOfArriveMB.sk_poid}"
							onkeypress="formsubmit(event);" />
						商品编码:
						<h:inputText id="id" styleClass="inputtextedit" size="12"
							value="#{noticeOfArriveMB.sk_inco}"
							onkeypress="formsubmit(event);" />
						商品名称:
						<h:inputText id="name" styleClass="inputtextedit" size="15"
							value="#{noticeOfArriveMB.sk_inna}"
							onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql=" select a.biid,a.inco,b.inna,b.colo,b.inse,a.qty,a.tqty,(a.qty-isnull(d.qty,0))as dqty from pubd a join inve b on a.inco=b.inco
								left join pubm c on a.biid = c.biid left join (select soco,inco,isnull(sum(qty),0) as qty from nofd group by soco,inco) d on a.biid = d.soco and a.inco = d.inco
								WHERE (a.qty-isnull(d.qty,0))>0 and c.suid ='#{noticeOfArriveMB.mbean.suid}' #{noticeOfArriveMB.sql}"								
								gwidth="550" gpage="(pagesize = 18)" gdebug="true"
								gcolumn="gcid = biid(headtext = selall,name = biids,width = 20,align = center,type = checkbox ,headtype = checkbox);
										gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
										gcid = biid(headtext = 采购订单,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
										gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
										gcid = inna(headtext = 商品名称,name = inna,width = 170,headtype = sort,align = left,type = text,datatype=string);
										gcid = colo(headtext = 规格,name = colo,width = 70,headtype = sort,align = left,type = text,datatype=string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,headtype = sort,align = left,type = text,datatype=string);
										gcid = qty(headtext = 采购数量,name = qty,width = 70,headtype = sort,align = left,type = text,datatype=number,dataformat={0});
										gcid = tqty(headtext = 已通知数量,name = tqty,width = 70,headtype = sort,align = left,type = text,datatype=number,dataformat={0});
										gcid = dqty(headtext = 待通知数量,name = dqty,width = 70,headtype = sort,align = left,type = input,datatype=number,dataformat={0});
									" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{noticeOfArriveMB.msg}" />
							<h:inputHidden id="sellist" value="#{noticeOfArriveMB.sellist}" />
							<h:inputHidden id="qtys" value="#{noticeOfArriveMB.qtys}" />
							<h:inputHidden id="socos" value="#{noticeOfArriveMB.socos}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>