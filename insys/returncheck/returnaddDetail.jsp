<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include	file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.ReturnCheckMB"%>
<%
	ReturnCheckMB ai = (ReturnCheckMB) MBUtil.getManageBean("#{returncheckMB}");
	String biid = request.getParameter("cbiid");
	if(biid != null)
	{
		ai.setBiid(biid);
	}
	//清空查询
	ai.setSearchSQL("");
%>
<html>
	<head>
		<title>选择返修商品</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="returncheck.js"></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton id="addDBut" value="添加明細"
							onclick="if(!addDetails()){return false};"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{returncheckMB.addReturnCheckDetails}"
							reRender="renderArea,output" oncomplete="endAddDetails();"
							requestDelay="50" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
									select a.biid,a.inco,sum(a.qty) as qty,isnull(sum(b.qty),0) as rqty,sum(a.qty)-isnull(sum(b.qty),0) as wqty
									 from ckbd a left join rcde b on a.biid=b.soco 
									 where a.chre='R' #{returncheckMB.searchSQLEx}
									group by a.inco,a.biid having  sum(a.qty) > isnull(sum(b.qty),0)
								"
								gwidth="550" gpage="(pagesize = -1)" gdebug="false"
								gcolumn="gcid = biid(headtext = selall,name = biid,width = 20,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 质检单号,name = biid,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = inco(headtext = 商品编码,name = inco,width = 110,headtype = sort,align = left,type = text,datatype=string);
									gcid = qty(headtext = 待返修数量,name = dqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = rqty(headtext = 已返修数量,name = rkqty,width = 70,headtype = sort,align = right,type = text,datatype=number,dataformat={0});
									gcid = wqty(headtext = 返修数量,name = wqty,width = 70,align = right,type = input,headtype= sort, datatype =number,dataformat={0},update=edit,gscript={onkeypress=return isInteger(event),selectCheckBox(this),keyhandle(this)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{returncheckMB.msg}" />
							<h:inputHidden id="socos" value="#{returncheckMB.socos}" />
							<h:inputHidden id="incos" value="#{returncheckMB.incos}" />
							<h:inputHidden id="qtys" value="#{returncheckMB.qtys}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>