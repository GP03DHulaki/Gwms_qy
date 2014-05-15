<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>岗位管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="description" content="岗位管理">
		<meta HTTP-EQUIV='Pragma' CONTENT='no-cache'>
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<link href="roletree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="roletree.js"></script>
		<script type="text/javascript" src="role.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>
	<body id=mmain_bidy onload="onPageload();">
		<div id=mmain>
			<f:view>
				<a4j:outputPanel id='out_hidden'>
					<h:inputHidden id="outMessage" value="#{RoleMB.outMessage}" />
					<a4j:form id="subform" ajaxSubmit="true">
						<h:inputHidden id="selid" value="#{RoleMB.selid}" />
						<h:inputHidden id="roleid" value="#{RoleMB.selroleid}" />
						<h:inputHidden id="grid" value="#{RoleMB.bean.grid}" />
						<h:inputHidden id="roleoperate" value="#{RoleMB.roleoperate}" />
					</a4j:form>
				</a4j:outputPanel>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="新增" type="button"
							onclick="addDiv();return false;" requestDelay="50"
							onmouseover="this.className='a4j_over'" rendered="#{RoleMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton value="编辑" type="button"
							reRender="out_role,mesid" onclick="editrole_click();"
							requestDelay="50" rendered="#{RoleMB.MOD}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton value="删除" type="button"
							action="#{RoleMB.delete}" reRender="out_role,mesid"
							onclick="if(!deleteAll(gtable2)){return false};"
							oncomplete="roleEndDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'" rendered="#{RoleMB.DEL}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<h:inputHidden id="sellist" value="#{RoleMB.sellist}" />
					</div>
					<a4j:outputPanel id="out_role">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select id, grid ,grna,
								stat=case when stat ='1' then '有效' else '注销' end 
								From grin"
							gpage="(pagesize = 10)"
							growclick="RoleClick('gcolumn[id]','gcolumn[grid]','gcolumn[grna]')"
							gcolumn="gcid = id(headtext = selall,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = grid(headtext = 岗位编码,name = grid,width = 180,headtype = text,align = left,type = text,datatype=string);
								gcid = grna(headtext = 岗位名称,name = grna,width = 300,headtype = text,align = left,type = text,datatype=string);
								gcid = stat(headtext = 状态,name = stat,width = 40,headtype = text,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,value=岗位用户,name = editpw,width = 55,headtype = #{RoleMB.MOD ? 'text' : 'hidden'},align = center,type = link,typevalue=javascript:showUser('gcolumn[id]','gcolumn[grid]','gcolumn[grna]'),datatype=string);
							" />
					</a4j:outputPanel>
					<%-- 
					<a4j:outputPanel id="ShowUser" rendered="#{RoleMB.LST}">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();"></SPAN>
						<font color="#4990dd" style="font-weight:bolder;cursor:hand"
							onclick="JS_ExtraFunction();">用户列表(
							<h:outputText id='selroleid' value="#{RoleMB.selroleid}" 
							style="color:red;"
							/>):
						</font>
						<div id="ExtraFunction" style="height: 10px;">
							<a4j:outputPanel id="userPage">
								<iframe frameborder="0" src="user.jsf" width="100%" 
									id="iframe_users" name="iframe_users"
									onload="this.height=iframe_users.document.body.scrollHeight;
									this.width=iframe_users.document.body.scrollWidth;"
								 	>
								</iframe>
							</a4j:outputPanel>
						</div>	
					</a4j:outputPanel>
					--%>
				</h:form>

				<div tyle="height: 300px; vertical-align: top; border: 1; border-color: #4990CD; border-style: solid;">
					<!--权限代码-->
					<h:form id="ajaxbutton">
						<a4j:commandButton id="refreshoperate" value="刷新权限" type="button"
							action="#{RoleMB.refreshoperate}"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="startDo('正在加载...');" oncomplete="endrefresh();showUserModal();"
							reRender="out_module,out_hidden,ShowUser,selroleid,userPage"
							requestDelay="50" />
						<a4j:commandButton id="saveoperate" value="保存权限" type="button"
							action="#{RoleMB.saveRole}" rendered="#{RoleMB.MOD}"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							reRender="out_module,out_hidden"
							onclick="if ($('subform:roleoperate').value != ''){
								startDo('正在保存...');subform.submit();} else {return false;}"
							oncomplete="endDo();clearRoles();" requestDelay="50" />
						<span id="helptext"> <font
							style='color: #FF0000; font-weight: bold'>请选择岗位...</font> </span>
					</h:form>
					<div id=mmain_free>
						<a4j:outputPanel id="out_module">
							<div id="treeInit"
								style="height: 300px; white-space: nowrapstyle; overflow: auto;"></div>
							<script type="text/javascript">
							var roleid = $('subform:roleid').value;
							//alert('roleid:'+roleid);
							Tree.init();
							</script>
						</a4j:outputPanel>
					</div>
				</div>

				<!--添加弹出层-->
				<div id="editRoleset" style="display: none">
					<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton value="编辑" type="button" id="editrole"
								reRender="out_role,mesid,outedit" action="#{RoleMB.getRoleinfo}"
								onclick="if(!editrole(gtable2)){return false;}"
								oncomplete="editrole_show();" requestDelay="50" />
						</div>
						<a4j:outputPanel id="outedit">
							<table align="center">
								<tr>
									<td bgcolor="#efefef" style="width: 50px;">
										岗位编码
									</td>
									<td>
										<h:inputText styleClass="inputtext" id="groupid"
											value="#{RoleMB.bean.grid}"></h:inputText>
									</td>
									<td bgcolor="#efefef">
										岗位名称
									</td>
									<td>
										<h:inputText id="groupname" styleClass="inputtext"
											value="#{RoleMB.bean.grna}"></h:inputText>
									</td>
									<td bgcolor="#efefef">
										状态
									</td>
									<td>
										<h:selectOneMenu id="status" value="#{RoleMB.bean.stat}">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<br />
										<h:inputHidden id="updateflag" value="#{RoleMB.updateflag}" />
										<a4j:commandButton id="s"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											action="#{RoleMB.save}" value="保存" reRender="out_role,mesid"
											onclick="if(!roleFormcheck()){return false};"
											oncomplete="roleEndDo();" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<a4j:outputPanel id="mesid">
							<h:inputHidden id="msg" value="#{RoleMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>