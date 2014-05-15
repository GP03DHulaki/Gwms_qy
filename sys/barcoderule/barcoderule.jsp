<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>条码规则模板</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="条码规则模板">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="barcoderule.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="添加" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							tabindex="5" rendered="#{barcoderuleMB.ADD}" />
						<a4j:commandButton id="delButton" value="删除" type="button"
							action="#{barcoderuleMB.delete}"
							onclick="if(!deleteAll(gtable2)){return false};"
							reRender="outTable,msg" oncomplete="endDo();" requestDelay="50"
							rendered="#{barcoderuleMB.DEL}"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="Select id,ruid,baru,miid,maid,rema From baru  "
							gpage="(pagesize = 20)"
							gcolumn="gcid = id(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit(gcolumn[1]),value = 编辑);
								gcid = ruid(headtext = 模块编码,name = ruid,width = 60,headtype = sort,align = left,type = mask,typevalue={barcoderule:物料条码/boxcoderule:箱条码});
								gcid = baru(headtext = 条码规则,name = baru,width = 250,headtype = sort,align = left,type = text);
								gcid = miid(headtext = 最小值,name = miid,width = 60,headtype = sort,align = left,type = text);
								gcid = maid(headtext = 最小值,name = maid,width = 60,headtype = sort,align = center,type = mask,typevalue={M:分钟/H:小时/D:天/W:周/Y:月});
								gcid = rema(headtext = 备注,name = rema,width = 150,headtype = sort,align = left,type = text);							
								" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{barcoderuleMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="edit" style="display: none">
					<h:form id="edit">
						<h:inputHidden id="selid" value="#{barcoderuleMB.selid}" />
						<div id=mmain_hide>
							<a4j:commandButton id="edit" value="编辑"
								action="#{barcoderuleMB.getBarcoderuleinfo}"
								reRender="outTable,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
								<tr>
									<td bgcolor="#efefef">
										模板编码:
									</td>
									<td>
										<h:inputText id="ruid" value="#{barcoderuleMB.bean.ruid}"
											styleClass="inputtext" />
									</td>

								</tr>
								<tr>
									<td bgcolor="#efefef">
										条码规则:
									</td>
									<td colspan="3">
										<h:inputText id="baru" value="#{barcoderuleMB.bean.baru}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										规则类型:
									</td>
									<td>
										<h:selectOneMenu id="keys" onchange="seladd();">
											<f:selectItem itemLabel="<请选择>" itemValue="" />
											<f:selectItem itemLabel="[来源单号]" itemValue="[来源单号]" />
											<f:selectItem itemLabel="[本单单号]" itemValue="[本单单号]" />
											<f:selectItem itemLabel="[来源行序号]" itemValue="[来源行序号]" />
											<f:selectItem itemLabel="[本单行序号]" itemValue="[本单行序号]" />
											<f:selectItem itemLabel="[商品编码]" itemValue="[商品编码]" />
											<f:selectItem itemLabel="[商品条码]" itemValue="[商品条码]" />
											<f:selectItem itemLabel="[年]" itemValue="[YYYY]" />
											<f:selectItem itemLabel="[月]" itemValue="[MM]" />
											<f:selectItem itemLabel="[日]" itemValue="[DD]" />
											<f:selectItem itemLabel="[时]" itemValue="[HH]" />
											<f:selectItem itemLabel="[周]" itemValue="[WW]" />
											<f:selectItem itemLabel="[流水]" itemValue="[ID0000]" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注:
									</td>
									<td colspan="3">
										<h:inputText id="rema" value="#{barcoderuleMB.bean.rema}"
											styleClass="inputtext" size="62" maxlength="500"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden id="updateflag"
											value="#{barcoderuleMB.updateflag}" />
										<a4j:commandButton id="s" action="#{barcoderuleMB.save}"
											value="保存" reRender="outTable,msg"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />

										<h:inputHidden id="msg" value="#{barcoderuleMB.msg}"></h:inputHidden>
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