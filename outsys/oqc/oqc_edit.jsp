<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@page import="com.gwall.view.ReviewLibraryMB"%>
<%
    String srcPath = request.getContextPath();
    ReviewLibraryMB ai = (ReviewLibraryMB) MBUtil
            .getManageBean("#{reviewLibraryMB}");
    if (request.getParameter("pid") != null) {
        ai.getMbean().setBiid(request.getParameter("pid"));
    }
    ai.getVouch();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>出库复核</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库复核">
		<script type="text/javascript" src="oqc.js"></script>
		<link href="<%=srcPath%>/GwallJS/Gtab/GtabPage.css" rel="stylesheet"
			type="text/css"></link>
		<script type="text/javascript"
			src="<%=srcPath%>/GwallJS/Gtab/GtabPage.js"></script>
		<script type='text/javascript' src='<%=srcPath%>/gwall/all.js'></script>
		<link rel="stylesheet" type="text/css"
			href="<%=srcPath%>/gwall/all.css">
	</head>
	<body id="mmain_body">
		<div id="mmain">
			<f:view>
				<h:form id="edit">
					<div id=mmain_nav>
						<a id="linkid" href="oqc.jsf" class="return" title="返回">出库处理</a>&gt;&gt;
						<b>编辑出库复核单</b>
						<br>
					</div>
					<div id="mmain_opt">
						<a4j:outputPanel id="mainBut">
							<a4j:commandButton value="添加单据" type="button"
								onmouseover="this.className='a4j_over1'" id="addBut"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								oncomplete="addNew();" rendered="#{reviewLibraryMB.ADD}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="updateId" value="保存单据" type="button"
								onclick="if(!headCheck()){return false};"
								reRender="msg,headPanel,output,outTable,detailButton"
								action="#{reviewLibraryMB.updateHead}" oncomplete="endDo();"
								requestDelay="50"
								rendered="#{reviewLibraryMB.MOD && reviewLibraryMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								onclick="if(!doDeleteAll2()){return false};" value="删除单据"
								id="delMBut"
								reRender="output,renderArea,main,mainBut,msg,output2"
								oncomplete="endDo2();" action="#{reviewLibraryMB.deleteHead}"
								styleClass="a4j_but1"
								rendered="#{reviewLibraryMB.DEL && reviewLibraryMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="审核单据" oncomplete="endDo();location.reload();"
								action="#{reviewLibraryMB.approveVouch}"
								onclick="if(!startApp()){return false;}"
								reRender="orderTable,output,renderArea,main,mainBut,msg,output2,detailButton,detailFrame"
								rendered="#{reviewLibraryMB.APP && reviewLibraryMB.commitStatus}"
								id="appBut" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								onclick="openMod();" styleClass="a4j_but1" value="查看调整库存" />
						</a4j:outputPanel>
					</div>
					<div id="mmain_cnd">
						<a4j:outputPanel id="main">
							<table cellpadding="1" cellspacing="1" border="0">
								<tr>
									<td>
										复核单号:
									</td>
									<td oncontextmenu='return(false);' onpaste='return false'>
										<h:inputText id="biid" styleClass="inputtext" size="18"
											value="#{reviewLibraryMB.mbean.biid}"
											onfocus="t.canFocus(this);" style="color:#7f7f7f;" />
									</td>
									<td>
										创&nbsp;建&nbsp;&nbsp;人:
									</td>
									<td>
										<h:inputText id="nv_creatorname" styleClass="inputtext"
											size="18" value="#{reviewLibraryMB.mbean.crna}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										创建时间:
									</td>
									<td>
										<h:inputText id="crdt" styleClass="inputtext" size="20"
											value="#{reviewLibraryMB.mbean.crdt}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
								</tr>
								<tr>
									<td>
										来源类型:
									</td>
									<td>
										<h:selectOneMenu id="soty"
											value="#{reviewLibraryMB.mbean.soty}" disabled="true">
											<f:selectItem itemLabel="无" itemValue="" />
											<f:selectItems value="#{reviewLibraryMB.sotys}" />
										</h:selectOneMenu>

									</td>
									<td>
										来源单号:
									</td>
									<td>
										<h:inputText id="soco" styleClass="inputtext" size="20"
											value="#{reviewLibraryMB.mbean.soco}"
											style="readonly:expression(this.readOnly=true);color:#7f7f7f;" />
									</td>
									<td>
										业务类型:
									</td>
									<td>
										<h:selectOneMenu id="dety"
											value="#{reviewLibraryMB.mbean.dety}" disabled="true">
											<f:selectItem itemLabel="无" itemValue="" />
											<f:selectItem itemLabel="部分复核" itemValue="01" />
											<f:selectItem itemLabel="全部复核" itemValue="02" />
										</h:selectOneMenu>
									</td>

								</tr>
								<tr>
									<td valign="top">
										备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注:
									</td>
									<td colspan="9">
										<h:inputText size="100" id="rema" styleClass="inputtext"
											value="#{reviewLibraryMB.mbean.rema}" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="orderTable">
						<div style="vertical-align: top;"></div>
						<SPAN ID="detail_ctrl" class="ctrl_show"
							onclick="JS_ExtraFunction();"></SPAN>
						<font color="#4990dd" style="font-weight: bolder; cursor: pointer"
							onclick="JS_ExtraFunction();">待复核明细列表:</font>
						<div id="ExtraFunction">
							<div id="mmain_cnd">
								<iframe frameborder="0" src="outordesrs.jsf" width="100%"
									id="orders" name="orders">
								</iframe>
							</div>
						</div>
					</a4j:outputPanel>
					<div id="Gtabdetail" gtype="Gtab">
						<div id="oqcdetail" glable="已复核明细">
							<iframe frameborder="0" src="oqcdetail.jsf" width="100%"
								onload="Javascript:SetCwinHeight('ifoqcdetail')"
								id="ifoqcdetail" name="ifoqcdetail">
							</iframe>
						</div>
						<div id="packdetail" glable="已封箱明细">
							<iframe frameborder="0" src="packdetail.jsf" width="100%"
								id="ifpackdetail" height="400" name="ifpackdetail">
							</iframe>
						</div>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="item" value="#{reviewLibraryMB.sellist}" />
							<h:inputHidden id="msg" value="#{reviewLibraryMB.msg}" />
						</a4j:outputPanel>
					</div>
					<script type="text/javascript"">
						var tab = new GtabPage("Gtabdetail","click");
					  		tab.setTabs(
					  			[{title:"已复核明细",context:"oqcdetail"},
					  	     	{title:"已封箱明细",context:"packdetail"}]
					  	     );
					  	    tab.setFun(function(o){
					  	    	if(o.index==1){
					  	    		$('ifpackdetail').contentWindow.renderGtable('gtable2_pirint','color:#0000FF');
					  	    		$('ifpackdetail').contentWindow.renderGtable('gtable2_detail','color:#0000FF');
					  	    	}
					  	    });
					</script>
				</h:form>
			</f:view>
		</div>
	</body>
</html>