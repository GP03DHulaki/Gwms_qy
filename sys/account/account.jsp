<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>帐套管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<script type="text/javascript" src="account.js"></script>
	</head>
	<body id=mmain_body>
		<f:view>
			<div id=mmain>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="新增" id="addButton"
							onmouseover="this.className='search_over'"
							onmouseout="this.className='search_buton'" styleClass="but"
							onclick="doNew();" reRender="output" />
						<a4j:commandButton id="deleteButton" value="删除"
							action="#{AccountMB.deleteAll}"
							onclick="if(deleteAll(gtable1)){}else{return false;}"
							reRender="mes,output" oncomplete="endDo();" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="sid" value="查询"
							action="#{AccountMB.search}" reRender="output"
							onmouseover="this.className='search_over'"
							onmouseout="this.className='search_buton'" styleClass="but" />
						<a4j:commandButton id="reset" value="重置"
						onclick="textClear('list','sk_accountid,sk_year');"
							onmouseover="this.className='search_over'"
							onmouseout="this.className='search_buton'" styleClass="but" />
					</div>
					<div id=mmain_cond>
						帐套号:
						<h:inputText id="sk_accountid" value="#{AccountMB.sk_accountid}"
							styleClass="datetime" onkeypress="formSubmit(event);"/>
						年份:
						<h:inputText id="sk_year" value="#{AccountMB.sk_year}"
							styleClass="datetime"  onkeypress="formSubmit(event);"/>
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable1" gtype="grid" gversion="2" gsort="vc_year" gsortmethod="desc"
							gselectsql="SELECT id_id,vc_accountname, vc_servername, vc_accountid, vc_year, vc_dbname,
								       vc_dbuser, vc_dbpw, vc_driver,
								        ch_status,case ch_status when '1' then '有效' when '0' then '无效' end as nv_status,
								        ch_isdefault,case ch_isdefault when 'Y' then '是' when 'N' then '否' end as nv_isdefault, nv_remark
								        FROM gt_accountinfo where 1=1 #{AccountMB.searchKey}
								"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id_id(headtext = selall,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,value=编辑,name = opt,width = 40,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:edit(gcolumn[1]),datatype=string);
								gcid = vc_accountname(headtext = 帐套,name = vc_accountname,width = 50,headtype = sort,align = left,type = text,datatype=string);
								gcid = vc_accountid(headtext = 帐套号,name = vc_accountid,width = 50,headtype = sort,align = left,type = text,datatype=string);
								gcid = vc_year(headtext = 年份,name = vc_year,width = 50,headtype = sort,align = center,type = text,datatype=string);
								gcid = vc_servername(headtext = 链接服务器名,name = vc_servername,width = 100,headtype = text,align = center,type = text);
								gcid = vc_dbname(headtext = 数据库名,name = vc_dbname,width = 120,headtype = text,align = left,type = text,datatype=string);
								gcid = vc_dbuser(headtext = 登录名,name = vc_dbuser,width = 60,headtype = text,align = left,type = text,datatype=string);
								gcid = vc_dbpw(headtext = 登录密码,name = vc_dbpw,width = 90,headtype = text,align = left,type = text,datatype=string);
								gcid = nv_status(headtext = 是否有效,name = nv_status,width = 60,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_isdefault(headtext = 是否为默认,name = ch_isdefault,width = 60,headtype = sort,align = left,type = text,datatype=string);
								gcid = nv_remark(headtext = 备注,name = nv_remark,width = 200,headtype = text,align = left,type = text,datatype=string);
								" />
						<h:inputHidden id="selitem" value="#{AccountMB.bean.selitem}"></h:inputHidden>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{AccountMB.msg}"></h:inputHidden>
						</a4j:outputPanel>
					</a4j:outputPanel>
				</h:form>

				<div id="edit" style="display: none">
					<h:form id="edit">
						<a4j:commandButton id="editbut" value="编辑" type="button"
							action="#{AccountMB.getVouch}" reRender="editpanel"
							style="display: none" 
							oncomplete="Gwallwin.winShow('edit','编辑帐套','550');"
							/>
						<h:inputHidden id="selitem" value="#{AccountMB.bean.selitem}"></h:inputHidden>
						<h:inputHidden id="updflag" value="#{AccountMB.bean.updflag}"></h:inputHidden>
						<a4j:outputPanel id="editpanel">
							<table>
								<tr>
									<td bgcolor="#efefef">
										帐套:
									</td>
									<td>
										<h:inputText id="vc_accountname"
											value="#{AccountMB.bean.vc_accountname}"
											styleClass="datetime" disabled="true" />
									</td>
									<td bgcolor="#efefef">
										帐套号:
									</td>
									<td>
										<h:inputText id="vc_accountid"
											value="#{AccountMB.bean.vc_accountid}" styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										年份:
									</td>
									<td>
										<h:inputText id="vc_year" value="#{AccountMB.bean.vc_year}"
											styleClass="datetime" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										链接服务器名:
									</td>
									<td>
										<h:inputText id="vc_servername"
											value="#{AccountMB.bean.vc_servername}" styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										数据库名:
									</td>
									<td>
										<h:inputText id="vc_dbname"
											value="#{AccountMB.bean.vc_dbname}" styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="ch_status"
											value="#{AccountMB.bean.ch_status}" styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="无效" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										数据库登录用户名:
									</td>
									<td>
										<h:inputText id="vc_dbuser"
											value="#{AccountMB.bean.vc_dbuser}" styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										用户密码:
									</td>
									<td>
										<h:inputText id="vc_dbpw" value="#{AccountMB.bean.vc_dbpw}"
											styleClass="datetime" />
									</td>
									<td bgcolor="#efefef">
										是否为默认数据库:
									</td>
									<td>
										<h:selectOneMenu id="ch_isdefault"
											value="#{AccountMB.bean.ch_isdefault}"
											styleClass="selectItem">
											<f:selectItem itemLabel="否" itemValue="N" />
											<f:selectItem itemLabel="是" itemValue="Y" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注:
									</td>
									<td colspan="5">
										<h:inputText id="nv_remark" size="80"
											value="#{AccountMB.bean.nv_remark}" styleClass="datetime"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<a4j:commandButton id="asId"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											action="#{AccountMB.saveVouch}" value="保存"
											reRender="renderArea,output"
											onclick="if(formcheck()){}else{return false};"
											oncomplete="endDo();" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="Gwallwin.winClose();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>

			</div>
		</f:view>
	</body>
</html>
