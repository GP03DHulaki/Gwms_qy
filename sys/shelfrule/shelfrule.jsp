<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>上架策略</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="上架策略">
		<script type="text/javascript" src="shelfrule.js"></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="s" value="保存" reRender="outTable,msg"
							onclick="if(!formCheck()){return false};" oncomplete="endDo();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
					</div>
					<div id=mmain_free>
						<div>
							<ul>
								<li>
									<b>常规</b>
									<div>
										<div class="rule">
											库位分配
											<div class="rule">
												<h:selectOneRadio layout="lineDirection" value="1">
													<f:selectItem itemLabel="自动分配" itemValue="1" />
													<f:selectItem itemLabel="任意存放" itemValue="0" />
												</h:selectOneRadio>
											</div>
										</div>
										<div class="rule">
											任务分配
											<div class="rule">
												<h:selectOneRadio layout="lineDirection" value="1">
													<f:selectItem itemLabel="分配到组" itemValue="1" />
													<f:selectItem itemLabel="分配到人" itemValue="2" />
													<f:selectItem itemLabel="不分配" itemValue="0" />
												</h:selectOneRadio>
											</div>
										</div>
										<div class="rule">
											属性校验
											<div class="rule">
												<h:selectManyCheckbox layout="lineDirection">
													<f:selectItem itemLabel="校验商品与库位的属性" itemValue="1" />
												</h:selectManyCheckbox>
											</div>
										</div>
									</div>
								</li>
								<li>
									<b>库位策略</b>
									<div class="rule">
										库位分配策略
										<div class="rule">
											<h:selectManyCheckbox layout="lineDirection" value="1">
												<f:selectItem itemLabel="默认库位" itemValue="1" />
												<f:selectItem itemLabel="同标识库位" itemValue="2" />
												<f:selectItem itemLabel="受控库位" itemValue="3" />
												<f:selectItem itemLabel="同品牌库位" itemValue="4" />
												<f:selectItem itemLabel="同商品库位" itemValue="5" />
												<f:selectItem itemLabel="同供应商库位" itemValue="6" />
												<f:selectItem itemLabel="同客户库位" itemValue="7" />
												<f:selectItem itemLabel="同批次库位" itemValue="8" />
											</h:selectManyCheckbox>
										</div>
									</div>
								</li>
								<li>
									<b>任务策略</b>
									<div class="rule">
										每任务控制
										<div class="rule">
											每任务 重&nbsp;&nbsp;&nbsp;量
											<h:selectOneMenu>
												<f:selectItem itemLabel="大于" itemValue="1" />
												<f:selectItem itemLabel="小于" itemValue="2" />
											</h:selectOneMenu>
											<h:inputText id="g1" value="0" styleClass="inputtextedit" />
											每任务 体&nbsp;&nbsp;&nbsp;积
											<h:selectOneMenu>
												<f:selectItem itemLabel="大于" itemValue="1" />
												<f:selectItem itemLabel="小于" itemValue="2" />
											</h:selectOneMenu>
											<h:inputText id="g2" value="0" styleClass="inputtextedit" />
											<br />
											每任务 种类数
											<h:selectOneMenu>
												<f:selectItem itemLabel="大于" itemValue="1" />
												<f:selectItem itemLabel="小于" itemValue="2" />
											</h:selectOneMenu>
											<h:inputText id="g3" value="0" styleClass="inputtextedit" />
											每任务 商品数
											<h:selectOneMenu>
												<f:selectItem itemLabel="大于" itemValue="1" />
												<f:selectItem itemLabel="小于" itemValue="2" />
											</h:selectOneMenu>
											<h:inputText id="g4" value="0" styleClass="inputtextedit" />
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>

					<a4j:outputPanel id="outTable">

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
										库位分配策略:
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
										<h:selectOneMenu id="keys">
											<f:selectItem itemLabel="来源单号" itemValue="1" />
											<f:selectItem itemLabel="来单单号" itemValue="2" />
											<f:selectItem itemLabel="来源序号" itemValue="3" />
											<f:selectItem itemLabel="本单序号" itemValue="4" />
											<f:selectItem itemLabel="商品编码" itemValue="5" />
											<f:selectItem itemLabel="商品条码" itemValue="6" />
											<f:selectItem itemLabel="年" itemValue="7" />
											<f:selectItem itemLabel="月" itemValue="8" />
											<f:selectItem itemLabel="日" itemValue="9" />
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