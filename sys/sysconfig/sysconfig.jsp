<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>系统参数管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="系统参数管理">
		<link href="<%=request.getContextPath()%>/gwall/all.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="sysconfig.js"></script>
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
							rendered="#{SysconfigMB.ADD}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{SysconfigMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							rendered="#{SysconfigMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select id , syit,pait,
			   				    		vaty =case when vaty='1' then 'null/true/false类型' when vaty='2' then '字符串' when vaty='3' then '列表选择' end,
			   				    		syva,sywp,sylp,itde,
			   				    		itty =case when itty='C' then '内核' when itty='S' then '预置' when itty='U' then '用户' end 
			   				    		from syco "
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),value = 编辑);
								gcid = syit(headtext = 参数项目,name = syit,width = 100,headtype = sort,align = left,type = text);
								gcid = pait(headtext = 父项目,name = pait,width = 50,headtype = sort,align = left,type = text);
								gcid = vaty(headtext = 参数值类型,name = vaty,width = 70,headtype = sort,align = center,type = text);
								gcid = syva(headtext = 参数值,name = syva,width = 120,headtype = sort,align = left,type = text);
								gcid = itde(headtext = 描述,name = itde,width = 200,headtype = sort,align = left,type = text);
								gcid = sywp(headtext = 参数一,name = sywp,width = 80,headtype = sort,align = left,type = text);
								gcid = sylp(headtext = 参数二,name = sylp,width = 80,headtype = sort,align = left,type = text);
								gcid = itty(headtext = 类型,name = itty,width = 30,headtype = sort,align = left,type = text);							
								" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{SysconfigMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editSysconfig" style="display: none">
					<h:form id="edit">
						<h:inputHidden id="selid" value="#{SysconfigMB.selid}" />
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑" 
								action="#{SysconfigMB.getSysconfig}"
								reRender="outTable,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
								<tr>
									<td bgcolor="#efefef">
										参数项目:
									</td>
									<td>
										<h:inputText id="syit"
											value="#{SysconfigMB.bean.syit}"
											styleClass="inputtext"></h:inputText>
										<h:inputHidden id="id"
											value="#{SysconfigMB.bean.id}"></h:inputHidden>
									</td>

									<td bgcolor="#efefef">
										父项目:
									</td>
									<td>
										<h:inputText id="pait"
											value="#{SysconfigMB.bean.pait}"
											styleClass="inputtext"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										参数值类型:
									</td>
									<td>
										<h:selectOneMenu id="vaty"
											value="#{SysconfigMB.bean.vaty}">
											<f:selectItem itemLabel="null/true/false类型" itemValue="1" />
											<f:selectItem itemLabel="字符串型" itemValue="2" />
											<f:selectItem itemLabel="下拉列表选择" itemValue="3" />
										</h:selectOneMenu>
									</td>

									<td bgcolor="#efefef">
										参数类型:
									</td>
									<td>
										<h:selectOneMenu id="itty"
											value="#{SysconfigMB.bean.itty}">
											<f:selectItem itemLabel="系统核心" itemValue="C" />
											<f:selectItem itemLabel="系统预置" itemValue="S" />
											<f:selectItem itemLabel="用户手工添加" itemValue="U" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										参数值:
									</td>
									<td colspan="3">
										<h:inputText id="syva"
											value="#{SysconfigMB.bean.syva}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										参数项的参数一:
									</td>
									<td>
										<h:inputText id="sywp"
											value="#{SysconfigMB.bean.sywp}"
											styleClass="inputtext"></h:inputText>
									</td>

									<td bgcolor="#efefef">
										参数项的参数二:
									</td>
									<td>
										<h:inputText id="sylp"
											value="#{SysconfigMB.bean.sylp}"
											styleClass="inputtext"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										参数项目的描述:
									</td>
									<td colspan="3">
										<h:inputText id="itde"
											value="#{SysconfigMB.bean.itde}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden id="updateflag" value="#{SysconfigMB.updateflag}" />
										<a4j:commandButton id="s" action="#{SysconfigMB.save}"
											value="保存" reRender="outTable,msg"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />

										<h:inputHidden id="msg" value="#{SysconfigMB.msg}"></h:inputHidden>
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