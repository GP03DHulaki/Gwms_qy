<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>接口服务设置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="接口服务设置">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="sysinterface.js"></script>
		<script type="text/javascript" src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton value="新增" type="button"
							onclick="addDiv();return false;" requestDelay="50"
							onmouseover="this.className='a4j_over'"
							rendered="#{SysinterfaceMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton value="刷新" type="button"
							requestDelay="50"
							onmouseover="this.className='a4j_over'" reRender="outTable,msg"
							action="#{SysinterfaceMB.refresh}" oncomplete="endRefreshFilter();"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{SysinterfaceMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							rendered="#{SysinterfaceMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select id,ipid,apke,apse,statu = case when statu='Y' then '有效' when statu='W' then '无效' end,rema from inte"
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),value = 编辑);
								gcid = ipid(headtext = IP,name = ipid,width = 100,headtype = sort,align = left,type = text);
								gcid = apke(headtext = AppKey,name = apke,width = 50,headtype = sort,align = left,type = text);
								gcid = apse(headtext = AppSecret,name = apse,width = 70,headtype = sort,align = center,type = text);
								gcid = statu(headtext = 状态,name = statu,width = 40,headtype = sort,align = center,type = text);
								gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);							
								" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{SysinterfaceMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editSysconfig" style="display: none">
					<h:form id="edit">
						<h:inputHidden id="selid" value="#{SysinterfaceMB.selid}" />
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑" 
								action="#{SysinterfaceMB.getSysinterface}"
								reRender="outTable,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
								<tr>
									<td bgcolor="#efefef">
										IP:
									</td>
									<td>
										<h:inputText id="ipid"
											value="#{SysinterfaceMB.bean.ipid}"
											styleClass="inputtext"></h:inputText>
										<h:inputHidden id="seid"
											value="#{SysinterfaceMB.bean.id}"></h:inputHidden>
									</td>
									<td bgcolor="#efefef">
										AppKey:
									</td>
									<td>
										<h:inputText id="apke"
											value="#{SysinterfaceMB.bean.apke}"
											styleClass="inputtext"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										AppSecret:
									</td>
									<td>
										<h:inputText id="apse"
											value="#{SysinterfaceMB.bean.apse}"
											styleClass="inputtext"></h:inputText>
									</td>

									<td bgcolor="#efefef">
										状态:
									</td>
									<td>
										<h:selectOneMenu id="statu"
											value="#{SysinterfaceMB.bean.statu}">
											<f:selectItem itemLabel="有效" itemValue="Y" />
											<f:selectItem itemLabel="无效" itemValue="W" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										描述:
									</td>
									<td colspan="3">
										<h:inputText id="rema"
											value="#{SysinterfaceMB.bean.rema}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden id="updateflag" value="#{SysinterfaceMB.updateflag}" />
										<a4j:commandButton id="s" action="#{SysinterfaceMB.save}"
											value="保存" reRender="outTable,msg"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />

										<h:inputHidden id="msg" value="#{SysinterfaceMB.msg}"></h:inputHidden>
									</td>
								</tr>
								<tr>

								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>