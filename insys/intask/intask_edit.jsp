<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.InTaskMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="javax.faces.el.ValueBinding"%>
<%
	String path = request.getContextPath();	
	FacesContext context = FacesContext.getCurrentInstance();
	ValueBinding binding = context.getApplication().createValueBinding(
			"#{inTaskMB}");
	InTaskMB ai = (InTaskMB) binding.getValue(context);
	ai.getVouch();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>检验单</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_nav>
						<a href="intask.jsf" class="return">入库明细列表</a>>>
						入库明细
					</div>
					<div id=mmain_cnd>
						<a4j:outputPanel id="main">
							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />
							<table cellpadding="0" cellspacing="0" border="0">
								<tr>
									<td>
										入库任务单号:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext"
											size="20" value="#{inTaskMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										来源类型:
									</td>
									<td>
										<h:inputText id="soty"
											value="#{inTaskMB.mbean.soty}" styleClass="datetime"
											size="20"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"  />
									</td>									
									<td>
										组织架构:
									</td>
									<td>
										<h:inputText id="orid" styleClass="inputtext"
											size="20" value="#{inTaskMB.mbean.orid}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td>
										所属采购订单:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext"
											size="20" value="#{inTaskMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										创建时间:
									</td>
									<td>
										<h:inputText id="crdt"
											value="#{inTaskMB.mbean.crdt}" styleClass="datetime"
											size="20"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;"  />
									</td>
									<td>								
										单据状态:
									</td>
									<td>
										<h:selectOneMenu id="flag" value="#{inTaskMB.mbean.flag}">
											<f:selectItem itemLabel="---全部---" itemValue="" />
											<f:selectItems value="#{inTaskMB.flags}"/>										
										</h:selectOneMenu>
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
							gselectsql="Select a.inco,sum(a.qty) as qty,sum(a.fqty) as fqty,a.whid,b.inna,b.colo,b.inse From itde a JOIN inve b ON a.inco = b.inco where 1=1 #{inTaskMB.searchSQL} group by a.inco,a.whid,b.inna,b.colo,b.inse"
							gpage="(pagesize = 20)"
							gcolumn="gcid = inco(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = whid(headtext = 库位编码,name = whid,width = 100,headtype = sort,align = left,type = link,linktype = script,datatype=string,typevalue = javascript:Edit('gcolumn[2]'));
							gcid = inco(headtext = 商品编码,name = inco,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = fqty(headtext = 名称,name = fqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
							gcid = colo(headtext = 规格,name = colo,width = 100,headtype = sort,align = left,type = text,datatype=string);														
							gcid = inse(headtext = 规格码,name = inse,width = 80,align = center,type = mask,typevalue=11:正式单据/21:入库中/31:入库完成,headtype = sort,datatype = string);
							gcid = qty(headtext = 检验数量,name = whid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = fqty(headtext = 入库数量,name = fqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat=0,summary=this);
						" />
					</a4j:outputPanel>
				</h:form>
			</f:view>
		</div>

	</body>
</html>