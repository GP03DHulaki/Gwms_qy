<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>已复核明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="已复核明细">
		<script type="text/javascript" src="oqc.js"></script>
		<script type="text/javascript">
			function init(){
				if(parent.Gskin){
					parent.Gskin.setSkinCss(document);
				}
			}
		</script>
	</head>
	<body id="mmain_body" onload="init();initEdit();initDetail();">
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:outputPanel id="detailButton">
						<a4j:outputPanel rendered="#{reviewLibraryMB.commitStatus}">
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="添加明细" oncomplete="endAddDetail();"
								reRender="output2,msg" action="#{reviewLibraryMB.addDetail}"
								onclick="if(!checkAdd()){return false};" id="addDBut"
								rendered="#{reviewLibraryMB.ADD && reviewLibraryMB.commitStatus}" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="清空已复核"
								reRender="output2,orderTable,msg"
								action="#{reviewLibraryMB.updateDetail}"
								onclick="if(!doConFirm('确定清空已复核明细,重新复核?')){return false;}"
								oncomplete="endmostock();" />
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="刷新待复核"
								reRender="output2,orderTable,msg"
								action="#{reviewLibraryMB.refreshDetail}"
								onclick="if(!doConFirm('确定刷新待复核明细?')){return false;}"
								oncomplete="endmostock();" />
								&nbsp;&nbsp;
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
								type="button" onmouseout="this.className='a4j_buton1'"
								styleClass="a4j_but1" value="封箱" id="packageBut"
								reRender="output2,orderTable,msg,boid,renderArea"
								action="#{reviewLibraryMB.doPackageWithBoid}"
								onclick="if(!doConFirm('确定当前商品装箱?')){return false;}"
								oncomplete="endmostock1($('edit:boid').value);" />
							<div id="mmain_cnd">
								<div style="display: none;">
									<a4j:commandButton id="setCode4DBean" requestDelay="50"
										action="#{reviewLibraryMB.setCode4DBean}" onclick="startDo();"
										oncomplete="endCode4DBean();"
										reRender="codePanel,renderArea,msg" />
								</div>
								<table border="0" cellpadding="1" cellspacing="0">
									<tr>
										<td>
											<h:outputText value="锁定数量:" title="设置为【是】扫描条码后自动添加明细"></h:outputText>
										</td>
										<td>
											<h:selectOneMenu id="autoItem"
												value="#{reviewLibraryMB.autoItem}"
												onchange="t.setIsAutoAdd(this.value);">
												<f:selectItem itemValue="0" itemLabel="否" />
												<f:selectItem itemValue="1" itemLabel="是" />
											</h:selectOneMenu>
										</td>
										<td>
											<h:outputText value="条码类型:" title="F9键切换条码类型" />
										</td>
										<td>
											<h:selectOneRadio id="batp" style="width:220px;"
												value="#{reviewLibraryMB.dbean.codetype}"
												layout="lineDirection"
												onclick="initEdit();t.batyClick(this);">
												<f:selectItems value="#{reviewLibraryMB.codetypes}" />
											</h:selectOneRadio>
										</td>
									</tr>
								</table>
								<a4j:outputPanel id='codePanel'>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="30px;">
												<h:outputText id="codeTitle" value="条码:"></h:outputText>
											</td>
											<td>
												<h:inputText id="baco" value="#{reviewLibraryMB.dbean.baco}"
													onfocus="this.select();" styleClass="datetime" size="42"
													onkeypress="doaddetail(this);t.keyPressDeal(this);" />
												<img id="invcode_img" style="cursor: pointer"
													src="../../images/find.gif" onclick="selectCode();" />
											</td>
											<td width="30px;">
												<h:outputText value="数量:"></h:outputText>
											</td>
											<td oncontextmenu='return(false);' onpaste='return false'>
												<h:inputText id="qty" value="#{reviewLibraryMB.dbean.fqty}"
													onfocus="t.canFocus(this);"
													onkeydown="t.keyPressDeal(this);" styleClass="datetime"
													size="10" />
											</td>
										</tr>
									</table>
								</a4j:outputPanel>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
				</div>
				<a4j:outputPanel id="output2">
					<g:GTable gid="gtable2" gtype="grid" gversion="2" gdebug="false"
						gsort="swdt" gsortmethod="DESC" gpage="(pagesize = 10)"
						gselectsql="SELECT a.did,a.inco,b.inna,b.inty,b.inpr,b.colo,b.inse,(a.fqty-ISNULL(c.qty,0)) AS fqty,a.swdt FROM rede a  
								LEFT JOIN inve b ON b.inco=a.inco 
								LEFT JOIN (SELECT inco,SUM(qty) AS qty FROM sobx WHERE biid='#{reviewLibraryMB.mbean.biid}' GROUP BY inco) c ON a.inco=c.inco
								WHERE biid='#{reviewLibraryMB.mbean.biid}' AND a.fqty-ISNULL(c.qty,0)>0 "
						gcolumn="
								gcid = did(headtext = selall,name = id_id,width = 20,headtype = hidden,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
								gcid = inco(headtext = 商品编码,name = inco,width = 150,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inna(headtext = 商品名称,name = inna,width = 180,align = left,type = text,headtype = sort ,datatype = string);
								gcid = colo(headtext = 规格,name = colo,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = inse(headtext = 规格码,name = inse,width = 120,align = left,type = text,headtype = sort ,datatype = string);
								gcid = fqty(headtext = 已复核数量,name = fqty,width = 70,headtype = sort,align = right,type = number,datatype=number,dataformat={0},summary=this);
								" />
				 
				</a4j:outputPanel>
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="item" value="#{reviewLibraryMB.sellist}" />
						<h:inputHidden id="msg" value="#{reviewLibraryMB.msg}" />
						<h:inputHidden id="boid" value="#{reviewLibraryMB.boid}" />
					</a4j:outputPanel>
				</div>
			</h:form>
		</f:view>
	</body>
</html>