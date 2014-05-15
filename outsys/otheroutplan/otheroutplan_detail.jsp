<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="com.gwall.view.OtherOutPlanMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	String id = "";
	OtherOutPlanMB ai = (OtherOutPlanMB) MBUtil.getManageBean("#{otherOutPlanMB}");
	if (request.getParameter("pid") != null) {
	  
	    if (request.getParameter("pid") != null) {
	        id = request.getParameter("pid");
	        ai.setBiid(id);
	    }
	}
%>

<html>
	<head>
		<title>其它出库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="其它出库">
		<script type="text/javascript" src="otherout.js"></script>
	</head>

	<body id='mmain_body'>
		<div id="mmain_nav">
			<font color="#000000">出库处理&gt;&gt;</font><b>其它出库计划</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id="mmain_opt">
					
					<a4j:commandButton value="返回"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="javascript:history.go(-1);;" rendered="#{otherOutPlanMB.LST}" />
					</div>
					
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="select  b.otheroutnumber,a.skuNumber,a.itemname,c.inna,a.planquantity,a.remark from tb_otherout_item a left join tb_otherout b on a.otheroutGUID=b.otheroutGUID 
							left join inve c on a.skuNumber=c.inco where  b.otheroutnumber='#{otherOutPlanMB.biid}'"
							gpage="(pagesize = 20)" gversion="2" gdebug="true"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 31,align = center,type = text,headtype = text,datatype = string);
								gcid = otheroutnumber(headtext = 其他出库计划,name = otheroutnumber,width = 110,align = left,type = text,headtype = sort,datatype=string);
								gcid = skuNumber(headtext = 商品编码,name = skuNumber,width = 110,align = left,type = text,headtype = sort,datatype=string);
								gcid = itemname(headtext = 货号名称,name = itemname,width = 180,align = left,type = text,headtype = sort,datatype=string);
								gcid = inna(headtext = 商品名称,name = inna,width = 150,align = left,type = text,headtype = sort,datatype=string);	
								gcid = planquantity(headtext = 计划出库数量,name = planquantity,width = 110,align = center,type = text,headtype = sort,datatype =number,dataformat=0.##,update=edit,summary=this);
								gcid = remark(headtext = 备注,name = remark,width = 110,align = left,type = text,headtype = sort,datatype=string);
							
							
							" />
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{otherOutPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{otherOutPlanMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
