<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.PickRuleMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
    PickRuleMB ai = (PickRuleMB) MBUtil.getManageBean("#{pickRuleMB}");
    ai.initBean();
%>
<html>
	<head>
		<title>上架策略</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="上架策略">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="pickrule.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<link href="pickrule.css" rel="stylesheet" type="text/css" />
		<link href="roletree.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="roletree.js"></script>
		<script type="text/javascript" src="role.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_free>
						<div>
							<a4j:outputPanel id="output">
								<ul>
									<li>
										<b>订单合并策略</b>
										<div class="rule">
											<div class="rule">
												<span>一单一货订单数满</span>
												<h:inputText id="orderNum" styleClass="inputtextedit"
													size="12" value="#{pickRuleMB.orderBean.pkva}" />
												<%-- 
													单触发 &nbsp; 一单一货商品数满
													<h:inputText id="goodsNum" styleClass="inputtextedit"
														value="#{pickRuleMB.goodsBean.pkva}" />
													--%>
												<span>个触发</span> &nbsp;
												<span>一单多货订单数满</span>
												<h:inputText id="orderMoreNum" styleClass="inputtextedit"
													size="12" value="#{pickRuleMB.orderMoreBean.pkva}" />
												<span>个触发</span> &nbsp;
												<span>每次生成</span>
												<h:inputText id="taskNU" styleClass="inputtextedit"
													size="12" value="#{pickRuleMB.taskBean.pkva}" />
												<span>个备货任务</span>
											</div>
											<div class="rule">
												<h:selectManyCheckbox id='role' layout="lineDirection"
													value="#{pickRuleMB.selectedTypes}">
													<f:selectItems value="#{pickRuleMB.combineTypes}" />
												</h:selectManyCheckbox>
											</div>
											<div class="rule">
											</div>
										</div>
									</li>
									<li>
										<b>创建备货任务</b>
										<div id=mmain_free>
											<a4j:outputPanel id="out_module">
												<div id="treeInit"
													style="height: 300px; white-space: nowrapstyle; overflow: auto;"></div>
												<script type="text/javascript">
												
												//alert('roleid:'+roleid);
												Tree.init();
												</script>
											</a4j:outputPanel>
										</div>
									</li>
									<div class="rule">
										<div class="rule">
											<a4j:commandButton id="s" value="保存策略"
												reRender="orderNum,goodsNum,role,msg"
												onclick="if(!formCheck()){return false} else{startDo('正在保存...');}"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over1'"
												action="#{pickRuleMB.update}"
												onmouseout="this.className='a4j_buton1'"
												styleClass="a4j_but1" />
											<a4j:commandButton id="createOutTask" value="自动备货"
												reRender="orderNum,goodsNum,role,msg"
												onclick="if(!isCreateTask()){return false};"
												oncomplete="endDo();"
												onmouseover="this.className='a4j_over1'"
												action="#{pickRuleMB.createOutTask}"
												onmouseout="this.className='a4j_buton1'"
												styleClass="a4j_but1" />
										<%-- 	
											<a4j:commandButton id="saveoperate" value="保存权限" type="button"
												action="#{pickRuleMB.update}"
												onmouseover="this.className='a4j_over1'"
												onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
												reRender="out_module,out_hidden"
												onclick="if ($('edit:roleoperate').value != '')
													startDo('正在保存...');} else {return false;}"
												oncomplete="endDo();" requestDelay="50" />
										--%>
										</div>		
										<div id="hiroleoperate" >
											<a4j:outputPanel id="out_hidden">
												<h:inputHidden id="roleoperate" value="#{pickRuleMB.roleoperate}" />
											</a4j:outputPanel>
										</div>
										<div style="display: none;">
											<a4j:commandButton value="刷新" id="refBut" action="#{pickRuleMB.spiltOper}"
												reRender="out_hidden" />
										</div>
											
											
									</div>
									<%-- 
								<h:selectOneRadio layout="lineDirection" value="1">
									<f:selectItem itemLabel="自动合并" itemValue="1" />
									<f:selectItem itemLabel="手动触发" itemValue="0" />
								</h:selectOneRadio>
								<li>
									<b>任务策略</b>
									<div class="rule">
										任务分配
										<div class="rule">
											<h:selectOneRadio layout="lineDirection" value="1">
												<f:selectItem itemLabel="分配到组" itemValue="1" />
												<f:selectItem itemLabel="分配到人" itemValue="2" />
												<f:selectItem itemLabel="不分配" itemValue="0" />
											</h:selectOneRadio>
										</div>
										商品分配
										<div class="rule">
											<h:selectOneRadio layout="lineDirection" value="1">
												<f:selectItem itemLabel="分配到商品" itemValue="1" />
												<f:selectItem itemLabel="分配到批次" itemValue="2" />
											</h:selectOneRadio>
										</div>
										<div class="rule">
											批次控制
											<h:selectOneRadio layout="lineDirection" value="1">
												<f:selectItem itemLabel="控制" itemValue="1" />
												<f:selectItem itemLabel="提醒" itemValue="2" />
												<f:selectItem itemLabel="授权" itemValue="3" />
												<f:selectItem itemLabel="不处理" itemValue="0" />
											</h:selectOneRadio>
											批次规则
											<h:selectOneMenu>
												<f:selectItem itemLabel="先进先出" itemValue="1" />
												<f:selectItem itemLabel="到期先出" itemValue="2" />
												<f:selectItem itemLabel="先进后出" itemValue="3" />
												<f:selectItem itemLabel="到期后出" itemValue="4" />
												<f:selectItem itemLabel="任意出" itemValue="0" />
											</h:selectOneMenu>
										</div>
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
								--%>
								</ul>
								<h:inputHidden id="msg" value="#{pickRuleMB.msg}" />
								<h:inputHidden id="sellist" value="#{pickRuleMB.sellist}"></h:inputHidden>
							</a4j:outputPanel>
						</div>
					</div>

				</h:form>
				<!-- 编辑预售商品 -->
				<div id="ysiv" style="display: none;">
					<div id=mmain_nav>
						<font color="#000000">系统管理&gt;&gt;</font>
						<b>预售商品</b>
						<br>
					</div>
					<h:form id="edit1">
						<div id=mmain_opt1>
							<a4j:commandButton id="sid" value="查询"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								action="#{pickRuleMB.searchEx}" type="button"
								reRender="outputEx" requestDelay="50" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="clearSearchKey();" />
						</div>
						<div id=mmain_cnd>
							<div>
								物料编码:
								<h:inputText id="eq_inco" styleClass="inputtext" size="12"
									value="#{pickRuleMB.eq_inco}" />
								人员名称:
								<h:inputText id="eq_crna" styleClass="inputtext" size="12"
									value="#{pickRuleMB.eq_crna}" />
							</div>
						</div>
						<a4j:outputPanel>
							<div id=mmain_opt>
								<a4j:commandButton id="updateDetail" value="添加明细"
									onclick="if(addDetail()){}else{return false;}"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{pickRuleMB.addDetail}"
									reRender="msg,outputEx" requestDelay="50"
									oncomplete="showMsg()" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									id="deleteId" value="删除单据" action="#{pickRuleMB.deleteDetail}"
									onclick="if(!deleteDetail(gtable)){return false};"
									reRender="msg,outputEx" oncomplete="showMsg();"
									requestDelay="50" />
							</div>

							<div>
								物料编码:
								<h:inputText id="inco" styleClass="inputtext" size="20"
									value="#{pickRuleMB.psinBean.inco}"
									style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
								<img id="emp_img" style="cursor: hand"
									src="../../images/find.gif" onclick="selectInve();" />
								物料名称:
								<h:inputText id="inna" styleClass="datetime" size="20"
									style="readonly:expression(this.readOnly=true);color:#7f7f7f;"
									value="#{pickRuleMB.psinBean.inna}" />
								<br>
								备注:
								<h:inputText id="rema" styleClass="datetime" size="100"
									value="#{pickRuleMB.psinBean.rema}" />
							</div>
						</a4j:outputPanel>
						<!-- 物料编码，创建时间，人员编码，人员名称，状态(stat 0,1),备注，结束时间 -->
						<a4j:outputPanel id="outputEx">
							<g:GTable gid="gtable" gversion="2" gtype="grid"
								gselectsql="
							SELECT a.inco,a.inna,a.crna,a.stat,a.crdt,a.eddt,a.rema
								FROM psin a  
								where 1=1 #{pickRuleMB.searchSQL}"
								gpage="(pagesize = 20)"
								gcolumn="
							gcid = inco(headtext = selcheckbox,name = selcheckbox,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = inco(headtext = 物料编码,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = inna(headtext = 物料名称,name = inna,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = crna(headtext = 人员名称,name = crna,width = 80,align = center,type = text,headtype = sort,datatype = string);
							gcid = stat(headtext = 状态,name = stat,width = 80,align = center,type = mask,typevalue=1:有效/0:无效,headtype = sort,datatype = string);
							gcid = crdt(headtext = 创建时间,name = crdt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = eddt(headtext = 结束时间,name = eddt,width = 100,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = rema(headtext = 备注,name = rema,width = 200,align = center,type = text,headtype = sort,datatype = string);
						" />

							<h:inputHidden id="msgEx" value="#{pickRuleMB.msgEx}" />
							<h:inputHidden id="sellistEx" value="#{pickRuleMB.sellistEx}"></h:inputHidden>		
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>