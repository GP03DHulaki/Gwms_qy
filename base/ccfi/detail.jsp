<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.gwall.view.base.CcfiMB"%>
<%@page import="com.gwall.pojo.base.CcfiBean"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
CcfiMB ai = (CcfiMB) MBUtil.getManageBean("#{ccfiMB}");
	    if (request.getParameter("pid") != null) {
	    	String id = request.getParameter("pid");
	    	ai.getBean().setSkid(id);
	        ai.getBean().setSaveType("sk");
	    	ai.getSKBean();
	        ai.getBean().setEaid(id);
	    }
	    
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>色号信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
<script type="text/javascript">
function Edit(){
	
}
function openDetail(){
	showDiv("添加色号");
}
//显示层
function showDiv(title){
		Gwin.open({
		id:"colorDetail",	
		title:title,
		contextType:"ID",
		context:"editsh",
		dom:document,
		width:450,
		height:130,
		autoLoad:false,
		showbt:false,
		lock:true
	}).show("colorDetail");
	Gwin.setLoadok("colorDetail");	
}
//隐藏层
function hideDiv(){
	Gwin.close("colorDetail");
}
function addHead() {
	if($("edit:colo").value==""){
		alert("色卡编号不能为空！");
		$("edit:colo").focus();
		return false;
	}
	if($("edit:cona").value==""){
		alert("色卡名称不能为空！");
		$("edit:cona").focus();
		return false;
	}
	if($("edit:suna").value==""){
		alert("供应商不能为空！");
		$("edit:suna").focus();
		return false;
	}
	Gwin.progress("正在保存",10,document);
	$("edit:updateflag").value=parent.document.getElementById("editsk:updateflag").value;
	$("edit:savetype").value="sk";
	return true
}
function endAddHead() {
	Gwin.close("progress_id");
	if($("edit:msg").value!=""){
		alert($("edit:msg").value);
	}
}
function addDetail() {
	if($("editsh:colo").value==""){
		alert("色号不能为空！");
		$("editsh:colo").focus();
		return false;
	}
	if($("editsh:cona").value==""){
		alert("规格不能为空！");
		$("editsh:cona").focus();
		return false;
	}
	$("editsh:updateflag").value="ADD";
	$("editsh:savetype").value="sh";
	Gwin.progress("",10,document);
	return true;
}
function endAddDetail() {
	Gwin.close("progress_id");
	if($("editsh:msg").value.indexOf("成功")!=-1){
		$("edit:refBut").click();
	}
	if($("editsh:msg").value!="")
		alert($("editsh:msg").value);
}
function deleteDetail(){
	var arr=Gtable.getselectid("gtable");
	if(arr.length<=0){		    	
		alert("请选择要删除的行!");
	   	return false;
	}
	if(confirm("确认删除?")) {
	$("edit:sellist").value=arr;
	Gwin.progress("删除中...",10,document);
	return true;
	}
	return false;
}
function endDeleteDetail() {
	Gwin.close("progress_id");
	if($("editsh:msg").value!="")
		alert($("editsh:msg").value);
}
function selectSuin(){
		showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna');
		return false;
}
</script>
	</head>
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
						<div id=mmain_opt>
				<a4j:commandButton id="saveid" action="#{ccfiMB.save}"
							value="保存" reRender="input,renderArea"
							onclick="if(!addHead()){return false};"
							oncomplete="endAddHead();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							rendered="#{ccfiMB.MOD}" />
							
					</div>
					<a4j:outputPanel id="input" rendered="#{ccfiMB.MOD}">
							<div id=mmain_cnd>
								<table border="0" cellpadding="1">
								<tr>
									<td>
										<h:outputText value="色卡编号:"></h:outputText>
									</td>
									<td>
										<h:inputText id="colo" styleClass="inputtext"
											value="#{ccfiMB.bean.skno}" />
									</td>
									<td>
										<h:outputText value="色卡名称:"></h:outputText>
									</td>
									<td>
										<h:inputText id="cona" styleClass="inputtext"
											value="#{ccfiMB.bean.skna}" />
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="供应商:"></h:outputText>
									</td>
									<td>
										<h:inputText id="suna" styleClass="datetime"
											style="readonly:expression(this.readOnly=true);color:#A0A0A0;"
											value="#{ccfiMB.bean.suna}"/>
										<h:inputHidden id="suid" value="#{ccfiMB.bean.cuid}"/>	
										<img id="suid_img" style="cursor: pointer"
												src="../../images/find.gif" onclick="selectSuin();" />
									</td>
									<td >
										<h:outputText value="状态:"></h:outputText>
									</td>
									<td>
										<h:selectOneMenu id="stat"
											value="#{ccfiMB.bean.skst}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td>
										<h:outputText value="备注:"></h:outputText>
									</td>
									<td colspan="3">
										<h:inputText id="rema" styleClass="inputtext"
											value="#{ccfiMB.bean.skma}" size="56"></h:inputText>
									</td>
								</tr>
							</table>
							</div>
					</a4j:outputPanel>
<a4j:outputPanel id="coView" rendered="#{ccfiMB.bean.haveColor}">
					<a4j:outputPanel id='codePanel'>
					<a4j:commandButton id="dbut" value="添加色号"
						onclick="openDetail()" onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						type="button"
						requestDelay="50" />
					<a4j:commandButton id="ddel" value="删除色号"
						onclick="if(!deleteDetail()){return false};" onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						type="button" action="#{ccfiMB.deleteColor}"
						reRender="renderArea,output"
						oncomplete="endDeleteDetail();" requestDelay="50" />
					<a4j:commandButton id="save" value="保存色号"
						onclick="if(!dAddDetail()){return false};" onmouseover="this.className='a4j_over1'"
						onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
						type="button" action="#{bomMB.dAddDetail}"
						reRender="renderArea,output" rendered="false"
						oncomplete="endDAddDetail();" requestDelay="50" />
					</a4j:outputPanel>
<a4j:outputPanel id="output">
	<g:GTable gid="gtable" gtype="grid" gversion="2"
		gpage="(pagesize=20)" gdebug="true"
		gselectsql="Select a.id,a.colo,a.cona,a.stat,a.rema From colo a where a.skid='#{ccfiMB.bean.skid}' "
		gcolumn="gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
			gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
			gcid = colo(headtext = 色号,name = colo,width = 80,headtype = sort,align = left,type = text);
			gcid = cona(headtext = 规格,name = cona,width = 80,headtype = sort,align = left,type = text);	
			gcid = stat(headtext = 状态,name = stat,width = 80,headtype = sort,align = left,type = mask,typevalue=0:注销/1:有效);
			gcid = rema(headtext = 描述,name = rema,width = 200,headtype = sort,align = left,type = text);
		" />
</a4j:outputPanel>
					
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg"	value="#{ccfiMB.msg}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{ccfiMB.updateflag}"></h:inputHidden>
							<h:inputHidden id="savetype" value="#{ccfiMB.bean.saveType}"></h:inputHidden>
							<h:inputHidden id="sellist" value="#{ccfiMB.sellist}"></h:inputHidden>
							<a4j:commandButton id="refBut" reRender="output"></a4j:commandButton>
						</a4j:outputPanel>
					</div>
				</h:form>
		<div style="display: none">
					<h:form id="editsh">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button" action="#{ccfiMB.getSimpleBean}" reRender="editpane"
								oncomplete="edit_show1();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{ccfiMB.selid}"></h:inputHidden>
							<h:inputHidden id="updateflag" value="#{ccfiMB.updateflag}"></h:inputHidden>
						</div>
						<a4j:outputPanel id="editpane">
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										色号:
									</td>
									<td>
										<h:inputText id="colo" styleClass="inputtext"
											value="#{ccfiMB.bean.colo}" />
									</td>
									<td bgcolor="#efefef">
										规格:
									</td>
									<td>
										<h:inputText id="cona" styleClass="inputtext"
											value="#{ccfiMB.bean.cona}" />
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										状态:
									</td>
									<td colspan="3">
										<h:selectOneMenu id="stat" value="#{ccfiMB.bean.coat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										描述:
									</td>
									<td colspan="3">
										<h:inputText id="nrema" styleClass="inputtext"
											value="#{ccfiMB.bean.coma}" size="56"></h:inputText>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										
										<a4j:commandButton id="saveid" action="#{ccfiMB.save}"
											value="保存" reRender="list,renderArea"
											onclick="if(!addDetail()){return false};"
											oncomplete="endAddDetail();"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{ccfiMB.MOD}" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>	
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg"	value="#{ccfiMB.msg}"></h:inputHidden>
							<h:inputHidden id="saveType" value="#{ccfiMB.bean.saveType}"></h:inputHidden>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>