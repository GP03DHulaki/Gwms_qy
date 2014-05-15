<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="com.gwall.view.VouchersetMB"%>
<%@ include file="../../include/include_imp.jsp" %>

<%
	VouchersetMB ai = (VouchersetMB) MBUtil.getManageBean("#{vouchersetMB}");
	if (request.getParameter("isAll") != null) {
		ai.initPage();
	} else {
		ai.setGtableParam(request, ai);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>单据管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src='voucherset.js'></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain id=mmain_body>
		<f:view>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_nav>
						<font color="#000000">系统管理&gt;&gt;</font><b>单据规则管理</b>
					</div>
					<h:panelGroup id="sp" rendered="#{vouchersetMB.LST}">
						<div id=mmain_opt>
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								onclick="startDo('正在查询...');"
								oncomplete="Gwin.close('progress_id');"
								action="#{vouchersetMB.getSearchKey}" reRender="refreshArea"
								requestDelay="50" >
								<a4j:actionparam name="page" value="1" assignTo="#{vouchersetMB.gpage}" />
							</a4j:commandButton>	
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="doClear();" id="clear" value="重置" type="button" />
						</div>
						<div id=mmain_cnd>
							模块名称：
							<h:inputText styleClass="inputtext"
								id="nv_modulename"
								value="#{vouchersetMB.bean.mona}"
								onkeypress="if(event.keyCode==13){$('list:sid').click();}" />
						</div>
					</h:panelGroup>
					<a4j:outputPanel id="refreshArea">
						<h:inputHidden id="msg" value="#{vouchersetMB.msg}"></h:inputHidden>
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gsort="#{vouchersetMB.gsort}" gsortmethod="#{vouchersetMB.gsortmethod}"
							gselectsql="select a.id,b.mona,a.voru,a.cuid,a.idst,a.iden
								from voru a join modu b on a.moid = b.moid
								where 1=1 #{vouchersetMB.sql} "
							gpage="(pagesize = #{vouchersetMB.gpagesize})"
							gcolumn=" gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = mona(headtext = 模块名称,name = mona,width = 140,headtype = sort,align = left,type = text,datatype=string);
								gcid = voru(headtext = 单据规则,name = voru,width = 170,headtype = sort,align = left,type = text,datatype=string);
								gcid = cuid(headtext = 当前流水号,name = cuid,width = 80,headtype = sort,align = right,type = text,datatype=int);
								gcid = idst(headtext = 来源类型,name = vc_from,width = 80,headtype = sort,align = right,type = text,datatype=int);
								gcid = iden(headtext = 目标类型,name = vc_to,width = 80,headtype = sort,align = right,type = text,datatype=int);
								gcid = -1(headtext = 操作,name = edit,width = 60,headtype = text,align = center,type = link,value=编辑,typevalue = javascript:Edit(gcolumn[1]));
							" />
					</a4j:outputPanel>
				</h:form>
			</div>
			<!-- 弹出层 -->
			<div id="editdiv" style="display: none;">
				<h:form id="edit">
					<div id=mmain_hide>
						<h:inputHidden id="selid" value="#{vouchersetMB.selid}"></h:inputHidden>
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{vouchersetMB.getVoucherinfo}" reRender="editpanel"
							oncomplete="Edit_show();" requestDelay="50" />
					</div>
					<a4j:outputPanel id="editpanel">
					<table align="center">
						<tr>
							<td bgcolor="#efefef">
								模块名称
							</td>
							<td colspan="2">
								<h:inputText styleClass="inputtext" id="mona"
									value="#{vouchersetMB.bean.mona}" />
							</td>
						</tr>
						<tr>
							<td bgcolor="#efefef">
								单号规则
							</td>
							<td>
								<h:inputText styleClass="inputtext" id="vc_idrule"
									value="#{vouchersetMB.bean.voru}" />
							</td>
							<td bgcolor="#efefef">
								当前流水号
							</td>
							<td>
								<h:inputText id="in_id" value="#{vouchersetMB.bean.cuid}"
									styleClass="inputtext" />
							</td>
						</tr>
						<tr>
							<td colspan="4" align=center>
								<h:panelGroup id="au" rendered="#{vouchersetMB.MOD}">
									<a4j:commandButton id="updateBut"
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										action="#{vouchersetMB.save}" value="保存"
										reRender="refreshArea" onclick="if(!check()){return false};"
										oncomplete="endDo();" >
										<a4j:actionparam name="page" value="#{vouchersetMB.gpage}" />
									</a4j:commandButton>	
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv()" />
								</h:panelGroup>
							</td>
						</tr>

					</table>
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view>
	</body>
</html>
