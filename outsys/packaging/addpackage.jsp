<%@ page language="java" pageEncoding="UTF-8"%>
<%@	page import="com.gwall.util.MBUtil"%>
<%@ page import="com.gwall.view.PackagingMB"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>物料信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='packaging.js'></script>
	</head>
	<%
		PackagingMB ai = (PackagingMB) MBUtil
				.getManageBean("#{packagingMB}");
		if (request.getParameter("time") != null) {
			ai.setSql("");
		}

		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
	%>
	<body id=mmain_body onload="initEdit();initDetail();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="add" value="增加" type="button"
							onclick="if(!addDetail()){return false};" reRender="output,msg"
							action="#{packagingMB.addDetail}" oncomplete="endAddDetail();"
							requestDelay="50" />
						<a4j:commandButton id="deleteDBut" value="刪除"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							type="button" action="#{packagingMB.deleteDetail}"
							onclick="if(!delDetail(gtable)){return false};"
							reRender="renderArea,output"
							rendered="#{packagingMB.MOD && packagingMB.commitStatus}"
							oncomplete="endDelDetail();" requestDelay="50" />
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="addpackage" value="打包" type="button"
							reRender="output,renderArea,msg"
							onclick="if(!addpackage(gtable)){return false};"
							action="#{packagingMB.updateDetail}" oncomplete="endDelDetail();"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<table>
							<tr>
								<td>
									<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
								</td>
								<td>
									<h:selectOneMenu id="autoItem" value="#{otherOutMB.autoItem}"
										onchange="t.setIsAutoAdd(this.value);">
										<f:selectItem itemValue="0" itemLabel="否" />
										<f:selectItem itemValue="1" itemLabel="是" />
									</h:selectOneMenu>
								</td>
								<td>
									<h:outputText value="条码类型:" title="F9键切换条码类型" />
								</td>
								<td colspan="3">
									<h:selectOneRadio id="batp" style="width:220px;"
										value="#{returnRecodeMB.dbean.codetype}"
										layout="lineDirection" onclick="initEdit();t.batyClick(this);">
										<f:selectItem itemValue="03" itemLabel="商品条码" />
										<f:selectItem itemValue="04" itemLabel="商品编码" />
									</h:selectOneRadio>
								</td>
							</tr>
							<tr>
								<td>
									<h:outputText value="条码:"></h:outputText>
								</td>
								<td>
									<h:inputText id="inco" styleClass="datetime"
										onkeypress="formsubmit(event);"
										value="#{packagingMB.dbean.inco}" />
									<a4j:outputPanel>
										<img id="whid_img" style="cursor: hand"
											src="../../images/find.gif" onclick="selectBarcodes();" />
									</a4j:outputPanel>
								</td>
								<td>
									<h:outputText value="数量"></h:outputText>
								</td>
								<td>
									<h:inputText id="qty" styleClass="datetime"
										value="#{packagingMB.dbean.qty}" size="8"></h:inputText>
								</td>
								<td>
									<h:outputText value="包号:"></h:outputText>
								</td>
								<td>
									<h:inputText id="boco" styleClass="datetime"
										onkeypress="formsubmit(event);"
										value="#{packagingMB.dbean.bxid}" />
									<img id="whid_img" style="cursor: hand"
										src="../../images/find.gif" onclick="selectPackNo();" />
								</td>
							</tr>
							<tr>
								
							</tr>
						</table>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid"
								gselectsql=" SELECT a.did,a.biid,a.inco,a.qty
	    							FROM gpad a WHERE boco is null and a.biid = '#{packagingMB.mbean.biid}' "
								gpage="(pagesize = -1)" gversion="2"
								gupdate="(table={inco},tablepk = {did})"
								gcolumn="gcid = did(headtext = selall,name = did,width = 30,align = center,type = checkbox ,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = inco(headtext = 物料条码,name = inco,width = 240,align = left,type = text,headtype = sort ,datatype = string);
									gcid = qty(headtext =  打包数量,name = qty,width = 150,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this);
									" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="retid" value="#{packagingMB.retid}" />
							<h:inputHidden id="msg" value="#{packagingMB.msg}" />
							<h:inputHidden id="updatedata" value="#{packagingMB.updatedata}" />
							<h:inputHidden id="sellist" value="#{packagingMB.sellist}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>