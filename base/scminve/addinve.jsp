<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.scm.BomMB"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>配色配码方案表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<script type="text/javascript" src="inventory.js"></script>
		<style type="text/css">
#select{border:1px solid ##009933; }
#select td{width:30px;height:30px;display:block;background-color:#C7DCED;cursor:pointer}
</style>
<script>
function init() {
	$("edit:inco").value="自动生成";
	$("edit:inun").value="物料类别带入";
	$("edit:colorlist").value="";
	$("edit:sizelist").value="";
	$("edit:updateflag").value = "ADD";
	$("inty_img").style.display="";
	textClear('edit','inna,bupr,dfus,nstv,stat,colorlist,sizelist,rema,tyna,inty,prefix','N');
}
function closeDiv(){
	Gwin.close();
}
function save(){
	$("edit:inpr").value="M";
		var inco = document.getElementById("edit:inco"); // 物料编码
		var a = /^[0-9]\d*$/;
		var b = /^\d+(\.\d+)?$/;
		var c = /^[1-9]\d*[.]?\d*$/;
		
		if(inco==null || inco.value.Trim().length<=0){
			Gwin.alert("系统提示","物料编码不能为空！","!",document);
			$("edit:inco").focus();
			return false;
		}
		
		var inna = document.getElementById("edit:inna");
		if(inna==null || inna.value.Trim().length<=0){
			Gwin.alert("系统提示","物料名称不能为空！","!",document);
			$("edit:inna").focus();
			return false;
		}
		var inty = document.getElementById("edit:inty");
			if(inty==null || inty.value.Trim().length<=0){
				Gwin.alert("系统提示","物料类别不能为空！","!",document);
			return false;
		}
		
		Gwin.progress("正在保存...",10,document);
		return true;
}
function endSave(){
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("inventoryWin");
		}else{ 
			type = "X";
		}
		alert(message);
}
</script>
	</head>
	<body id=mmain_body onload="init()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑" type="button" onclick="editDo()"
								action="#{scmInveMB.getInventory}" reRender="editpanel"
								oncomplete="edit_show();" requestDelay="50" />
							<h:inputHidden id="selid" value="#{scmInveMB.selid}" />
							<h:inputHidden id="updateflag" value="#{scmInveMB.updateflag}"></h:inputHidden>
						</div>
						<div style="display: none">
							<h:commandButton id="saveImg" action="#{scmInveMB.saveImg}"></h:commandButton>
						</div>
						<a4j:outputPanel id="editpanel">
							<h:inputHidden id='imgPath' value="#{scmInveMB.bean.imid}"></h:inputHidden>
							<table align=center>
								<tr>
									<td bgcolor="#efefef">
										物料编码：
									</td>
									<td>
										<h:inputText id="inco" value="#{scmInveMB.bean.inco}" disabled="true"
											styleClass="inputtext" />
									</td>
									<td bgcolor="#efefef">
										物料名称：
									</td>
									<td>
										<h:inputText id="inna" value="#{scmInveMB.bean.inna}"
											styleClass="inputtext" onfocus="this.select()" />
										<span style="">*</span>
									</td>
									<td bgcolor="#efefef">
										物料类别：
									</td>
									<td>
										<h:inputText id="tyna" value="#{scmInveMB.bean.tyna}" 
											disabled="true" styleClass="inputtext" />
										<img id="inty_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectInty();" />
										<h:inputHidden id="inty" value="#{scmInveMB.bean.inty}" />
										<h:inputHidden id="prefix" value="#{scmInveMB.bean.prefix}"/>
									</td>
									
								</tr>
								<tr>
									<td bgcolor="#efefef">
										基准单位：
									</td>
									<td>
										<h:inputText id="inun" value="#{scmInveMB.bean.inun}" 
											styleClass="inputtext" readonly="true" style="color:#A0A0A0"/>
									</td>
									<td bgcolor="#efefef">
										进货价格：
									</td>
									<td>
										<h:inputText id="bupr" value="#{scmInveMB.bean.bupr}"
											styleClass="inputtext" onfocus="this.select()" />
									</td>
									<td bgcolor="#efefef">
										原始用量:
									</td>
									<td>
										<h:inputText id="dfus" value="#{scmInveMB.bean.dfus}"
											styleClass="inputtextedit" />
									</td>
								</tr>
								
								<tr>
									<td bgcolor="#efefef">
										默认布封:
									</td>
									<td>
										<h:inputText id="nstv" value="#{scmInveMB.bean.nstv}"
											styleClass="inputtextedit" />
									</td>
									<td bgcolor="#efefef">
										图样：
									</td>
									<td>
										
									</td>
									<td bgcolor="#efefef">
										状态：
									</td>
									<td>
										<h:selectOneMenu id="stat" value="#{scmInveMB.bean.stat}"
											styleClass="selectItem">
											<f:selectItem itemLabel="有效" itemValue="1" />
											<f:selectItem itemLabel="注销" itemValue="0" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										是否配色：
									</td>
									<td >
										<h:selectOneMenu id="isco" value="#{scmInveMB.bean.isco}"
											styleClass="selectItem">
											<f:selectItem itemLabel="是" itemValue="1" />
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									<td bgcolor="#efefef">
										是否配码：
									</td>
									<td colspan="3">
										<h:selectOneMenu id="issi" value="#{scmInveMB.bean.issz}"
											styleClass="selectItem">
											<f:selectItem itemLabel="是" itemValue="1" />
											<f:selectItem itemLabel="否" itemValue="0" />
										</h:selectOneMenu>
									</td>
									
								</tr>
								<tr>
									<td bgcolor="#efefef">
										规格列表：
									</td>
									<td>
										<h:inputText  value="点击查看" styleClass="inputtext" id="colorbtn" style="color:#A0A0A0;cursor:pointer" readonly="true" onclick="colorlist();"/>
										<h:inputHidden id="colorlist" value="#{scmInveMB.bean.colo}"></h:inputHidden>
										<img  style="cursor: pointer"
											src="../../images/find.gif" onclick="colorlist();" />
									</td>
									<td bgcolor="#efefef" >
										规格码列表：
									</td>
									<td colspan="3">
										<h:inputText  value="点击查看" styleClass="inputtext" id="sizebtn"  style="color:#A0A0A0;cursor:pointer"  readonly="true" onclick="sizelist();"/>
										<h:inputHidden id="sizelist" value="#{scmInveMB.bean.inse}"></h:inputHidden>
										<img  style="cursor: pointer"
											src="../../images/find.gif" onclick="sizelist();" />
									</td>
								
								</tr>
								<tr>
									<td bgcolor="#efefef">
										备注：

									</td>
									<td colspan="5">
										<h:inputText id="rema" value="#{scmInveMB.bean.rema}"
											styleClass="inputtext" onfocus="this.select()" size="80" />
									</td>
								</tr>
								<tr>
									<td colspan="6" align="center">
										<h:inputHidden value="#{scmInveMB.bean.inpr}" id="inpr"></h:inputHidden>
										<a4j:commandButton id="saveid" action="#{scmInveMB.save}"
											value="保存" 
											onclick="if(!save()){return false};"
											oncomplete="endSave();"
											onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											rendered="#{scmInveMB.MOD || scmInveMB.ADD}">
										</a4j:commandButton>
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="closeDiv();" />
									</td>
								</tr>
							</table>
						</a4j:outputPanel>
						<div style="display: none;">
							
						</div>
					</h:form> 
			</f:view>
		</div>
	</body>
</html>