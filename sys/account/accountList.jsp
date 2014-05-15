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
		<meta http-equiv="description" content="帐套管理">
		<script src="../javascript/date1.js"></script>
	</head>
	<body id="mmain_body">
		<f:view>
			<h:form id="list">
				<div id=mmain_opt>
					<font color="#000000">帐套管理>></font>
					<b>帐套查询</b>
					<a4j:commandButton value="新增帐套"
						onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						onclick="addDiv();" tabindex="5" />
				</div>
				<a4j:outputPanel id="output">
					<g:GTable gid="gtable" gversion="2" gtype="grid"
						gselectsql="SELECT vc_accountname, vc_servername, vc_accountid, vc_year, vc_dbname,
							       vc_dbuser, vc_dbpw, vc_driver, ch_status, ch_isdefault, nv_remark
								 	 FROM gt_accountinfo
									where 1=1 "
						gpage="(pagesize = 20)"
						gcolumn="
								gcid = vc_voucherid(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 行号,name = rowid,width = 40,headtype = text,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = view_h,width = 50,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[1]'),value = 编辑);							
								gcid = vc_voucherid(headtext = 帐套,name = vc_voucherid,width = 100,headtype = sort,align = center,type = text,datatype=string);
								gcid = poplaninno(headtext = 采购预入库单号,name = poplaninno,width = 100,headtype = sort,align = center,type = text,datatype=string);
								gcid = nv_vendorname(headtext = 供应商,name = nv_vendorname,width = 130,headtype = sort,align = center,type = text,datatype=string);
								gcid = nv_creatorname(headtext = 制单人,name = nv_creatorname,width = 60,headtype = sort,align = center,type = text,datatype=string);
								gcid = dt_createdate(headtext = 入库日期,name = dt_createdate,width = 70,headtype = sort,align = center,type = text,datatype=datetime,dataformat=yyyy-mm-dd);
								gcid = nv_flagname(headtext = 单据状态,name = nv_flagname,width = 60,headtype = sort,align = center,type = text,datatype=string);
								gcid = nv_remark(headtext = 备注,name = nv_remark,width = 150,headtype = sort,align = center,type = text,datatype=string);
							" />
				</a4j:outputPanel>
				<h:inputHidden id="item" value="#{AccountMB.item}"></h:inputHidden>
			</h:form>
			<!--添加弹出层-->
			<h:form id="add">
				<table>
					<tr>
						<td bgcolor="#efefef">
							帐套名:
						</td>
						<td>
							<h:inputText id="nv_accountname"
								value="#{AccountMB.nv_accountname}" styleClass="datetime" />
						</td>
						<td bgcolor="#efefef">
							服务器:
						</td>
						<td>
							<h:inputText id="nv_accountserver"
								value="#{AccountMB.nv_accountserver}" styleClass="datetime" />
						</td>
						<td bgcolor="#efefef">
							数据库:
						</td>
						<td>
							<h:inputText id="nv_accountdatabase"
								value="#{AccountMB.nv_accountdatabase}" styleClass="datetime" />
						</td>
					</tr>
					<tr>
						<td bgcolor="#efefef">
							登录用户:
						</td>
						<td>
							<h:inputText id="vc_accountlogin"
								value="#{AccountMB.vc_accountlogin}" styleClass="datetime" />
						</td>
						<td bgcolor="#efefef">
							用户密码:
						</td>
						<td>
							<h:inputSecret id="vc_accountpassword"
								value="#{AccountMB.vc_accountpassword}" styleClass="datetime" />
						</td>
						<td bgcolor="#efefef">
							状态:
						</td>
						<td>
							<h:selectOneMenu id="ch_accountstatus"
								value="#{AccountMB.ch_accountstatus}" styleClass="selectItem">
								<f:selectItem itemLabel="帐套不可用" itemValue="0" />
								<f:selectItem itemLabel="帐套可用" itemValue="1" />
							</h:selectOneMenu>
						</td>
					</tr>
					<tr>
						<td bgcolor="#efefef">
							链接参数:
						</td>
						<td>
							<h:selectOneMenu id="nv_accountparm"
								value="#{AccountMB.nv_accountparm}" styleClass="selectItem">
								<f:selectItem itemLabel="----选择参数----" itemValue="0" />
								<f:selectItem itemLabel="SQL Server 2000"
									itemValue="com.microsoft.jdbc.sqlserver.SQLServerDriver" />
								<f:selectItem itemLabel="SQL Server 2005"
									itemValue="com.microsoft.sqlserver.jdbc.SQLServerDriver" />
								<f:selectItem itemLabel="Oracle"
									itemValue="oracle.jdbc.driver.OracleDriver" />
							</h:selectOneMenu>
						</td>
						<td bgcolor="#efefef">
							备注:
						</td>
						<td colspan="3">
							<h:inputText id="nv_remark" value="#{AccountMB.nv_remark}"
								styleClass="datetime"></h:inputText>
						</td>
					</tr>
					<tr>
						<td colspan="6" align="center">
							<a4j:commandButton id="asId"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								action="#{AccountMB.saveVouch}" value="保存"
								reRender="accountList,reRenderArea"
								onclick="if(!formcheck()){return false};"
								oncomplete="showMsg();endDo();" />
							<a4j:commandButton id="usId"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								action="#{AccountMB.updateVouch}" value="修改"
								reRender="accountList,reRenderArea"
								onclick="if(!formcheck()){return false};"
								oncomplete="showMsg();" />
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								value="返回" onclick="hideDiv();" />
						</td>
					</tr>
					<tr>
						<a4j:outputPanel id="reRenderArea">
							<h:inputHidden id="mes" value="#{AccountMB.mes}" />
						</a4j:outputPanel>
					</tr>
				</table>
			</h:form>
		</f:view>
	</body>
</html>
