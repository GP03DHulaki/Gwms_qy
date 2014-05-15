<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%@page import="com.gwall.view.SfCountMB"%>

<%
	SfCountMB ai = (SfCountMB) MBUtil.getManageBean("#{sfcountMB}");
	if (request.getParameter("pid") != null) {
		ai.setSk_soco(request.getParameter("pid"));
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货人员</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货装车人员报表">
		<script type='text/javascript' src='sfcount.js'></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>备货人员</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="select a.biid,a.soco,a.crus,a.crna,b.inco,b.qty from spma a 
													join spde b on a.biid = b.biid where b.obid = '#{sfcountMB.sk_soco }' 
										"gpage="(pagesize = -1)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 分拣单号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = soco(headtext = 计划单号,name = soco,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = crus(headtext = 备货员编码,name = crna,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = crna(headtext = 备货员,name = crna,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = inco(headtext = 商品编码,name = inco,width = 120,headtype = sort,align = left,type = text,datatype=string);
										   	gcid = qty(headtext = 数量,name = qty,width= 60,headtype = sort,align = right, datatype =number,dataformat=0.##,summary=this);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
