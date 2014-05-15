<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.TranPlanMB"%>

<%
    TranPlanMB ai = (TranPlanMB) MBUtil.getManageBean("#{tranPlanMB}");
    ai.getVouch();
    ai.setBoxInco("");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑调拨计划明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑调拨计划明细">
		<script type="text/javascript" src="tran.js"></script>
		<script type="text/javascript" src="<%=srcPath%>/GwallJS/Gtab/Gtab.js"></script>
		<link href="<%=srcPath%>/GwallJS/Gtab/GtabPage.css" rel="stylesheet"
			type="text/css"></link>
		<script type="text/javascript"
			src="<%=srcPath%>/GwallJS/Gtab/GtabPage.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						库内处理&gt;&gt;
						<a id="linkid" title="返回" class="return" href="tran.jsf">调拨计划</a>&gt;&gt;
						<b>编辑调拨计划明细</b>
						<br>
					</div>
					<a4j:outputPanel id="headButton">
						<div id=mmain_opt>
							<gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{tranPlanMB.clearMBean}" oncomplete="addNew();"
								id="addHead" rendered="#{tranPlanMB.ADD}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{tranPlanMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{tranPlanMB.MOD && tranPlanMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{tranPlanMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{tranPlanMB.DEL && tranPlanMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{tranPlanMB.APP && tranPlanMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{tranPlanMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{tranPlanMB.APP && !tranPlanMB.commitStatus}"
								id="auditBut" value="回写锁定数量" type="button"
								action="#{tranPlanMB.audit}"
								onclick="if(!auditApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{tranPlanMB.SPE && tranPlanMB.closeShow}"
								id="closeVouch" value="关闭订单" type="button"
								action="#{tranPlanMB.closeVouch}"
								onclick="if(!closeVouch()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail"
								oncomplete="endCloseVouch();" requestDelay="50" />

							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />

							<gw:GAjaxButton theme="b_theme" id="lockbill" value="锁定库存"
								type="button" action="#{tranPlanMB.lockbill}"
								onclick="if(!isLockBill()){return false};" oncomplete="endDo();"
								requestDelay="50"
								reRender="renderArea,headButton,headmain,detailButton,ifplandetail"
								rendered="#{tranPlanMB.SPE}" />
						</div>
					</a4j:outputPanel>
					<a4j:outputPanel id="headmain">
						<div id=mmain_cnd>
							<table cellpadding="0" cellspacing="3" border="0">
								<tr>
									<td>
										调拨计划单:
									</td>
									<td>
										<h:inputText id="biid" styleClass="inputtext" size="20"
											value="#{tranPlanMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										调拨类型:
									</td>
									<td>
										<h:selectOneMenu id="ifib" value="#{tranPlanMB.mbean.ifib}"
											style="width:130px;" disabled="true">
											<f:selectItems value="#{tranPlanMB.ifibs}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{tranPlanMB.mbean.orid}"
											disabled="#{!tranPlanMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										调出仓库:
									</td>
									<td>
										<h:inputText id="outwhna" styleClass="inputtext" size="20"
											value="#{tranPlanMB.mbean.outwhna}" disabled="true" />
										<h:inputHidden id="pfwh" value="#{tranPlanMB.mbean.pfwh}" />
										<a4j:outputPanel
											rendered="#{tranPlanMB.commitStatus && false}">
											<img id="fwh_img" style="cursor: pointer"
												src="../../images/find.gif"
												onclick="return selectWaho1('edit:pfwh','edit:outwhna');" />
										</a4j:outputPanel>
									</td>
									<td>
										调入仓库:
									</td>
									<td>
										<h:inputText id="inwhna" styleClass="inputtext" size="20"
											value="#{tranPlanMB.mbean.inwhna}" disabled="true" />
										<h:inputHidden id="powh" value="#{tranPlanMB.mbean.powh}" />
										<a4j:outputPanel
											rendered="#{tranPlanMB.commitStatus && false}">
											<img id="twh_img" style="cursor: pointer"
												src="../../images/find.gif"
												onclick="return selectWaho1('edit:powh','edit:inwhna');" />
										</a4j:outputPanel>
									</td>
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{tranPlanMB.mbean.lico}"
											disabled="#{!tranPlanMB.commitStatus}">
											<f:selectItem itemLabel="" itemValue="" />
											<f:selectItems value="#{lineMB.itemlist}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										经手人:
									</td>
									<td>
										<h:inputText id="opna" styleClass="inputtext" size="20"
											disabled="#{!tranPlanMB.commitStatus}"
											value="#{tranPlanMB.mbean.opna}" />
									</td>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="70"
											disabled="#{!tranPlanMB.commitStatus}"
											value="#{tranPlanMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</div>
					</a4j:outputPanel>
					<div id="pdetail" gtype="Gtab">
						<div id="plandetail">
							<a4j:outputPanel id='ifplandetail'>
								<iframe frameborder="0" src="plandetail.jsf" width="100%"
									onload="Javascript:SetCwinHeight('ifplandetail')"
									id="ifplandetail" name="ifplandetail">
								</iframe>
							</a4j:outputPanel>
						</div>
						<div id="lockdetail">
							<a4j:outputPanel id='iflockdetail'>
								<iframe frameborder="0" src="lockdetail.jsf" width="100%"
									height="200" id="iflockdetail" name="iflockdetail">
								</iframe>
							</a4j:outputPanel>
						</div>
						<div id="taskdetail">
						</div>
					</div>


					<div style="display: none;">
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="outdetail" />
						<a4j:commandButton id="showRe" value="刷新全部" style="display:none;"
							reRender="outdetail,iflockdetail,ifplandetail" />
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranPlanMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{tranPlanMB.updatedata}" />
							<h:inputHidden id="filename" value="#{tranPlanMB.fileName}" />
						</a4j:outputPanel>
					</div>
				</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{tranPlanMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="hideDiv()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{tranPlanMB.uploadFile}" />
						</div>
					</h:form>
			</f:view>
		</div>
		<script type="text/javascript">
			var tab = new GtabPage("pdetail","click");
		  	tab.setTabs([{title:"计划明细",context:"plandetail"},
		  	     		{title:"待分配明细",context:"lockdetail"}]);
		  	tab.setFun(function(o){
	  	    	if(o.index==1){
	  	    		SetCwinHeight('iflockdetail');
	  	    		$('iflockdetail').contentWindow.renderTable();
	  	    		$('iflockdetail').contentWindow.startDo();
	  	    	}
	  	    });
		</script>
	</body>
</html>