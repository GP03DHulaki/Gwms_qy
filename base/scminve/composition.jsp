<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.base.ScmInveMB"%>
<%
//需要有来源单号和物料编号来保存信息
if(request.getParameter("date")!=null) {
			String inco = request.getParameter("id");
			if(inco==null||inco.equals("")) {
			out.print("物料信息未初始化");
			return;
			}
			ScmInveMB ai = (ScmInveMB) MBUtil.getManageBean("#{scmInveMB}");
			ai.getBean().setInco(inco);
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>成分表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
<script type="text/javascript">
//以下为成份明细的添加删除方法
function dAddDetail(){
	if($("edit:ctna").value=="") {
		alert("成分名称为空");
		return false;
	}
	if($("edit:dperc").value=="") {
		alert("百分比为空");
		return false;
	}
	Gwin.progress("正在添加...",10,document);
	return true;
}
function endDAddDetail() {
	Gwin.close("progress_id");
	var msg = $("edit:msg").value;
	if(msg.indexOf("成功")!=-1){
		$("edit:dcona").value="";
		$("edit:dperc").value="";
	}
	alert(msg);
}
function DDelDetail(obj) {
	var arr=Gtable.getselectid(obj);
	if(arr.length<=0){		    	
		alert("请选择要删除的行!");
	   	return false;
	}
	if(confirm("确认删除?")) {
		$("edit:sellist").value=arr;
		Gwin.progress("正在删除...",10,document);
		return true;
	}
}
function endDDelDetail(){
	Gwin.close("progress_id");
	var msg = $("edit:msg").value;
	if(msg!="")
	alert(msg);
}
function cleartext(){
	$("edit:ctna").value="";
	$("edit:ctid").value="";
	$("edit:dperc").value="";
}
function selectcomp(){
	showModal("../../common/scmcomp/scmcomp.jsf?&retid=edit:ctid&retname=edit:ctna","580px","380px",parent.document,parent.document.GwinID);
}
</script>
		<style type="text/css">
#select{border:1px solid ##009933; }
#select td{width:30px;height:30px;display:block;background-color:#C7DCED;cursor:pointer}
</style>
	</head>
	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
						<div id=mmain_opt>
						<a4j:outputPanel id="detailbutton">
							<a4j:outputPanel
								rendered="true">
								<a4j:commandButton id="addDBut" value="保存"
									onclick="if(!dAddDetail()){return false};"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{scmInveMB.addComposition}"
									reRender="renderArea,output"
									rendered="true"
									oncomplete="endDAddDetail();" requestDelay="50" />
								<a4j:commandButton id="deleteDBut" value="刪除"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{scmInveMB.deleteComposition}"
									onclick="if(!DDelDetail(gtable)){return false};"
									reRender="renderArea,output"
									rendered="true"
									oncomplete="endDDelDetail();" requestDelay="50" />
							</a4j:outputPanel>
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="input">
						<a4j:outputPanel rendered="true">
							<div id=mmain_cnd>
								<a4j:outputPanel id='codePanel'>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td >
												<h:outputText id="codeTitle" value="成分名称:"></h:outputText>
												<h:inputHidden id="inco" value="#{scmInveMB.bean.inco}" />
											</td>
											<td>
												<h:inputText id="ctna" value="#{scmInveMB.ctna}" disabled="true"
													styleClass="datetime" />
												<h:inputHidden id="ctid" value="#{scmInveMB.ctid}" />
												<img id="emp_img" style="cursor: pointer;" src="../../images/find.gif" onclick="selectcomp();" />
											</td>
											<td >
												<h:outputText value="百分比:"></h:outputText>
											</td>
											<td>
												<h:inputText id="dperc" value="#{scmInveMB.ctpv}"	styleClass="datetime" size="10" />
											</td>
										</tr>
									</table>
								</a4j:outputPanel>
							</div>
						</a4j:outputPanel>
					</a4j:outputPanel>
					<div>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="false"
								gselectsql="select a.id,a.inco,b.name,a.ctpv from inct a
								left join comp b on a.ctna = b.id
								 where a.inco='#{scmInveMB.bean.inco}'"
								gpage="(pagesize = 10)" gversion="2"
								gupdate="(table = {oide},tablepk = {did})"
								gcolumn="gcid = id(headtext = selall,name = id,width = 20,align = center,type = checkbox,headtype =checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = name(headtext = 成份,name = name,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = ctpv(headtext = 百分比%,name = ctpv,width = 80,align = left,type = text,headtype = sort ,datatype = number,dataformat=0.##,summary=this);
								" />
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{scmInveMB.msg}"></h:inputHidden>
							<h:inputHidden id="sellist" value="#{scmInveMB.sellist}"></h:inputHidden>
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>