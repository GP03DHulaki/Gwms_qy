<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<jsp:directive.page import="com.gwall.view.UserMB" />
<jsp:directive.page import="com.gwall.util.MBUtil" />
<jsp:directive.page import="com.gwall.pojo.sys.UserBean" />


<%
	UserMB ai = (UserMB) MBUtil.getManageBean("#{user}");
	if (request.getParameter("isAll") != null) {
		ai.setSearchSQL(" 1=1 ");
		ai.initSearchKey(new UserBean());
	}
%>
<%--
<jsp:include page="/include/all.jsp"></jsp:include>
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>用户管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="用户管理">
		<script type='text/javascript' src='user.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
	</head>
	<body id=mmain_body>
		<f:view>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<gw:GAjaxButton id="addButton" value="新增" theme="a_theme"
							onclick="doNew();" reRender="output" rendered="#{user.ADD}" />

						<gw:GAjaxButton id="deleteButton" value="删除" theme="a_theme"
							action="#{user.delete}" rendered="#{user.DEL}"
							onclick="if(!doDelete(gtable1)){return false;}"
							reRender="mes,output" oncomplete="endDo();" requestDelay="50" />

						<h:panelGroup id="sp" rendered="#{user.LST}">
							<gw:GAjaxButton id="query" value="查询" theme="a_theme"
								reRender="output" action="#{user.query}" />
							<gw:GAjaxButton id="reset" value="重置" theme="a_theme"
								onclick="reset();" />
						</h:panelGroup>
						<a4j:commandButton type="button" value="打印条码"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.printCode}" rendered="#{user.LST}"
							styleClass="a4j_but1" onclick="if(!print()){return false};"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />
						<a4j:commandButton type="button" value="发送其它出库"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.test}" rendered="#{user.LST}"
							styleClass="a4j_but1"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />
						<a4j:commandButton type="button" value="其他调仓上传"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.test2}" rendered="#{user.LST}"
							styleClass="a4j_but1"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />
						<a4j:commandButton type="button" value="电商零售业务上传"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.test3}" rendered="#{user.LST}"
							styleClass="a4j_but1"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />	
						<a4j:commandButton type="button" value="退货采购订单退库过账上传"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.test4}" rendered="#{user.LST}"
							styleClass="a4j_but1"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />	
						<a4j:commandButton type="button" value="原采购订单退库拉式下传"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'"
							action="#{user.test5}" rendered="#{user.LST}"
							styleClass="a4j_but1"
							oncomplete="lookPrint();" reRender="renderArea,outTable,output"
							requestDelay="1000" />	
					</div>
					<h:panelGroup id="sps" rendered="#{user.LST}">
						<div id=mmain_cond>
							用户编码:
							<h:inputText id="searchuserid" value="#{user.sk_obj.usid}"
								styleClass="inputtextedit" />
							用户名称:
							<h:inputText id="searchuser" value="#{user.sk_obj.usna}"
								styleClass="inputtextedit" />
							<!--
							角色编码:
							<h:inputText id="roleid" value="#{user.sk_obj.sk_role.grid}"
								styleClass="inputtextedit" />
							-->
							所属部门:
							<h:selectOneMenu id="dpid" value="#{user.sk_obj.dpid}"
								style="width:150px;" styleClass="inputtextedit">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItems value="#{user.deptlist}" />
							</h:selectOneMenu>
						</div>
					</h:panelGroup>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable1" gtype="grid" gversion="2"
							gselectsql="select a.id,a.usid,a.usna,a.crdt,a.dpid,b.dpna,
								case When a.stat = '1' Then '有效' Else '注销' End As stat,a.rema 
								From usin a left join dept b on a.dpid = b.dpid Where #{user.searchsql}"
							gpage="(pagesize = 30)" gdebug="false" gcolumn="gcid = id(headtext = selall,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = id,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = usid(headtext = 用户编码,name = usid,width = 70,headtype = sort,align = left,type = text,datatype=string);
								gcid = usna(headtext = 用户姓名,name = usna,width = 90,headtype = sort,align = left,type = text,datatype=string);
								gcid = dpna(headtext = 所属部门,name = dpna,width = 120,headtype = sort,align = left,type = text,datatype=string);
								gcid = stat(headtext = 状态,name = stat,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = crdt(headtext = 创建时间,name = crdt,width = 120,headtype = sort,align = center,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm:ss);
								gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
								gcid = -1(headtext = 操作,value=用户资料,name = editpw,width = 55,headtype = #{user.MOD ? 'text' : 'hidden'},align = center,type = link,typevalue=javascript:edituser(gcolumn[id],'gcolumn[usid]'),datatype=string);
								gcid = -1(headtext = 操作,value=数据权限,name = editdataright,width = 55,headtype = #{user.MOD ? 'text' : 'hidden'},align = center,type = hidden,typevalue=javascript:editdatarights(gcolumn[1],'gcolumn[2]'),datatype=string);
								gcid = -1(headtext = 操作,value=岗位权限,name = edit,width = 55,headtype = #{user.MOD ? 'text' : 'hidden'},align = center,type = link,typevalue=javascript:editrole(gcolumn[id],'gcolumn[usid]'),datatype=string);
								gcid = -1(headtext = 操作,value=修改密码,name = editpw,width = 55,headtype = #{user.MOD ? 'text' : 'hidden'},align = center,type = link,typevalue=javascript:editpw(gcolumn[id],'gcolumn[usid]'),datatype=string);
						" />
						<h:inputHidden id="mes" value="#{user.msg}" />
						<h:inputHidden id="sellist" value="#{user.sellist}" />
						<h:inputHidden id="filename" value="#{user.fileName}" />
					</a4j:outputPanel>
				</h:form>

				<div id="editDetail" style="display: none" align="center">
					<h:form id="edit">
						<div id=mmain_hide>
							<h:inputHidden id="selid" value="#{user.selid}" />
							<a4j:commandButton id="roleedit" value="修改角色"
								action="#{user.getUserinfo}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								oncomplete="editrole_show();" reRender="editarea,output" />
							<a4j:commandButton id="dredit" value="修改数据权限"
								action="#{user.getUserinfo}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								oncomplete="editdatarights_show();" reRender="editarea,output" />
							<a4j:commandButton id="pwedit" value="修改密码"
								action="#{user.getUserinfo}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								oncomplete="editpw_show();" reRender="editarea,output" />
							<a4j:commandButton id="useredit" value="编辑用户"
								action="#{user.getUserinfo}"
								onmouseover="this.className='search_over'"
								onmouseout="this.className='search_buton'" styleClass="but"
								oncomplete="edituser_show();" reRender="editarea,output" />
						</div>
						<a4j:outputPanel id="editarea">
							<table border="0" cellpadding="1" cellspacing="3">
								<tr>
									<td bgcolor="#efefef">
										用户编码:
									</td>
									<td>
										<h:inputText id="userid" value="#{user.bean.usid}"
											styleClass="inputtext" size="25" />
									</td>
									<td bgcolor="#efefef" width="20%">
										用户名称:
									</td>
									<td>
										<h:inputText id="userName" value="#{user.bean.usna}"
											styleClass="inputtext" size="25" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef" bgcolor="#efefef" width="20%">
										用户密码:
									</td>
									<td>
										<h:inputSecret id="passWord" value="#{user.bean.pass}"
											styleClass="inputtext" size="25" />
									</td>
									<td bgcolor="#efefef" bgcolor="#efefef" width="20%">
										确认密码:
									</td>
									<td>
										<h:inputSecret id="passWord1" styleClass="inputtext" size="25" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										身份证号:
									</td>
									<td>
										<h:inputText id="vc_pid" value="#{user.bean.idca}"
											styleClass="inputtext" size="25" />
									</td>
									<td bgcolor="#efefef">
										电子邮件:
									</td>
									<td>
										<h:inputText id="email" value="#{user.bean.usem}"
											styleClass="inputtext" size="25" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										性别:
									</td>
									<td>
										<h:selectOneMenu id="sex" value="#{user.bean.usse}">
											<f:selectItem itemLabel="男" itemValue="1" />
											<f:selectItem itemLabel="女" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										是否有效:
									</td>
									<td>
										<h:selectOneMenu id="status" value="#{user.bean.stat}">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										联系电话:
									</td>
									<td>
										<h:inputText id="telephone" value="#{user.bean.uste}"
											styleClass="inputtext" size="25" />
									</td>
									<td bgcolor="#efefef">
										其它联系电话:
									</td>
									<td>
										<h:inputText id="othercontact" value="#{user.bean.usco}"
											styleClass="inputtext" size="25" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										所属组织:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{user.bean.orid}"
											style="width:150px;">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{user.orglist}" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										所属部门:
									</td>
									<td>
										<h:selectOneMenu id="dpid" value="#{user.bean.dpid}"
											style="width:150px;">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{user.deptlist}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										复核解锁：
									</td>
									<td>
										<h:selectOneMenu id="isdh" value="#{user.bean.isdh}"
											styleClass="selectItem">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItem itemLabel="否" itemValue="0" />
											<f:selectItem itemLabel="是" itemValue="1" />
										</h:selectOneMenu>
									</td>
									<td>
										所属设计组:
									</td>
									<td>
										<h:selectOneMenu id="dgno" value="#{user.bean.dgno}"
											style="width:150px;">
											<f:selectItem itemLabel="无" itemValue="" />
											<f:selectItems value="#{user.dglist}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注:
									</td>
									<td colspan="3">
										<h:inputTextarea id="remark" value="#{user.bean.rema}"
											cols="80" rows="3" />
										<h:inputHidden id="updateflag" value="#{user.updateflag}" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<a4j:commandButton id="aId" action="#{user.save}" value="保存"
											reRender="renderArea,output"
											onclick="if(!formCheck()){return false};"
											oncomplete="endUser();" rendered="#{user.ADD || user.MOD}"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{user.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>

			</div>
		</f:view>
	</body>
</html>