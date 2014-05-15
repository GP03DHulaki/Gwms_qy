<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@	page import="com.gwall.view.OwTranMB"%>
<%@page import="com.gwall.view.SAPinventoryMB"%>

<%
OwTranMB ai = (OwTranMB) MBUtil.getManageBean("#{owTranMB}");
    ai.getVouch();
    ai.setBoxInco("");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>编辑货主转换计划明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="编辑货主转换计划明细">
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
						<a id="linkid" title="返回" class="return" href="owtran.jsf">货主转换计划</a>&gt;&gt;
						<b>编辑货主转换计划明细</b>
						<br>
					</div>
					<a4j:outputPanel id="headButton">
						
						<gw:GAjaxButton value="保存" theme="b_theme"
								action="#{owTranMB.save}" oncomplete="endDo();"
						     id="addHeadf" rendered="msg" />
						<gw:GAjaxButton theme="b_theme"
								rendered="#{owTranMB.APP && !owTranMB.commitStatus}"
								id="auditButt" value="保存" type="button"
								action="#{owTranMB.save}"
								
								reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail"
								oncomplete="endDo();" requestDelay="50" />		
						    <gw:GAjaxButton value="添加单据" theme="b_theme"
								action="#{owTranMB.clearMBean}" oncomplete="addNew();"
						     id="addHead" rendered="#{owTranMB.ADD}" />

							<gw:GAjaxButton theme="b_theme" id="updateId" value="保存单据"
								type="button" onclick="if(!addHead()){return false};"
								action="#{owTranMB.updateHead}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endDo();" requestDelay="50"
								rendered="#{owTranMB.MOD && owTranMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme" id="delMBut" value="删除单据"
								type="button" action="#{owTranMB.deleteHead}"
								onclick="deleteHead()" oncomplete="endDeleteHead();"
								requestDelay="50"
								reRender="msg,headButton,headmain,detailButton"
								rendered="#{owTranMB.DEL && owTranMB.commitStatus}" />

							<gw:GAjaxButton theme="b_theme"
								rendered="#{owTranMB.APP && owTranMB.commitStatus}"
								id="appMBut" value="审核单据" type="button"
								action="#{owTranMB.approveVouch}"
								onclick="if(!checkApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{owTranMB.APP && !owTranMB.commitStatus}"
								id="auditBut" value="回写锁定数量" type="button"
								action="#{owTranMB.audit}"
								onclick="if(!auditApp()){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail"
								oncomplete="endApp();" requestDelay="50" />
							<gw:GAjaxButton theme="b_theme"
								rendered="#{owTranMB.SPE && owTranMB.closeShow}"
								id="closeVouch" value="关闭订单" type="button"
								action="#{owTranMB.closeVouch}"
								onclick="if(!closeVouch()){return false};"
								reRender="renderArea,headButton,detailButton,headmain,outdetail"
								oncomplete="endCloseVouch();" requestDelay="50" />

							<gw:GAjaxButton id="otpDBut" value="导出EXCEL" theme="b_theme"
								onclick="reportExcel('gtable')" type="button" />

							<gw:GAjaxButton theme="b_theme" id="lockbill" value="锁定库存"
								type="button" action="#{owTranMB.lockbill}"
								onclick="if(!isLockBill()){return false};" oncomplete="endDo();"
								requestDelay="50"
								reRender="renderArea,headButton,headmain,detailButton,ifplandetail"
								rendered="#{owTranMB.SPE}" />
								
						
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
											value="#{owTranMB.mbean.biid}"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;" />
									</td>
									<td>
										调拨类型:
									</td>
									<td>
										<h:selectOneMenu id="ifib" value="#{owTranMB.mbean.ifib}"
											style="width:130px;" disabled="true">
											<f:selectItems value="#{owTranMB.ifibs}" />
										</h:selectOneMenu>
									</td>
									<td>
										组织架构:
									</td>
									<td>
										<h:selectOneMenu id="orid" value="#{owTranMB.mbean.orid}"
											disabled="#{!owTranMB.commitStatus}">
											<f:selectItems value="#{OrgaMB.subList}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										调出货主:
									</td>
									<td>
										<h:inputText id="pfwh" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.frow}" readonly="true" />
										<h:inputHidden id="outwhna" value="" />
			                         	<h:inputHidden id="outwhna1" value="#{owTranMB.mbean.frow}" />
									
										<img id="fwh_img" style="cursor: pointer"
												src="../../images/find.gif"
												onclick="return selectintysapid();" />
										<a4j:outputPanel
											rendered="#{owTranMB.commitStatus && false}">
										</a4j:outputPanel>
									</td>
									<td>
										调入货主:
									</td>
									<td>
										<h:inputText id="powh" styleClass="inputtext" size="20"
											value="#{owTranMB.mbean.toow}" readonly="true" />
										<h:inputHidden id="inwhna" value="#{owTranMB.mbean.toow}" />
										<img id="twh_img" style="cursor: pointer"
												src="../../images/find.gif"
												onclick="return selectinty();" />
										<a4j:outputPanel
											rendered="#{owTranMB.commitStatus && false}">
											
										</a4j:outputPanel>
									</td>
									<td>
										路&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;线:
									</td>
									<td>
										<h:selectOneMenu id="lico" style="width:130px;"
											value="#{owTranMB.mbean.lico}"
											disabled="#{!owTranMB.commitStatus}">
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
											disabled="#{!owTranMB.commitStatus}"
											value="#{owTranMB.mbean.opna}" />
									</td>
									<td>
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="5">
										<h:inputText id="rema" styleClass="inputtext" size="70"
											disabled="#{!owTranMB.commitStatus}"
											value="#{owTranMB.mbean.rema}" />
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
							reRender="outdetail" />
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{owTranMB.msg}" />
							<h:inputHidden id="sellist" value="#{owTranMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{owTranMB.updatedata}" />
							<h:inputHidden id="filename" value="#{owTranMB.fileName}" />
							
						</a4j:outputPanel>
					</div>
				</h:form>
				<div id="import" style="display: none" align="left">
					<h:form id="file" enctype="multipart/form-data">
						<t:inputFileUpload id="upFile" styleClass="upfile" storage="file"
							value="#{owTranMB.myFile}" required="true" size="75" />
						<div id="mes"></div>
						<div align="center">
							<gw:GAjaxButton value="上传" onclick="return doImport();"
								id="import" theme="a_theme" />
							<gw:GAjaxButton id="closeBut" value="关闭" theme="a_theme"
								onclick="hideDiv()" type="button" />
						</div>
						<div style="display: none;">
							<h:commandButton value="上传" id="importBut"
								action="#{owTranMB.uploadFile}" />
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