<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<%@page import="com.gwall.view.RiciMB"%>
<%
//传入供应商suid，显示所有传入供应商供应的物料
	if(request.getParameter("time")!=null&&request.getParameter("id")!=null) {
		RiciMB ai = (RiciMB) MBUtil.getManageBean("#{riciMB}");
		ai.setSuid(request.getParameter("id"));
		
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>色卡信息表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript">
			// 打开色号页面
			function selectColo(){
				showModal('color.jsf?retid=list:coid&retname=list:cono',580,360);
				return false;
			}
			// 打开色号多选页面
			function selectColos(){
				$("edit:updateflag").value="ADD";
				$("edit:suna").value="";
				$("edit:suid").value="";
				$("edit:cono").value="";
				$("edit:colo").value="";
				$("edit:cona").value="";
				$("edit:rema").value="";
				showDiv("添加供应商");
				return false;
			}
			function selectsuin(){
				showModal('suin.jsf?retid=edit:suid&retname=edit:suna',"580px","360px",parent.document,document.GwinID);
				return false;
			}
		function showDiv(title){
		Gwin.open({
			id:"addwin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:500,
			height:140,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("addwin");
		Gwin.setLoadok("addwin");
	}
	
//隐藏层
function hideDiv(){
	Gwin.close("addwin");
}
			function cleartext(){
			}
			
			function addRiDetail(){
				$("list:updateflag").value = "ADD";
				if($("list:cono").value=="") {
					alert("色号不能为空");
					return false;
				}
				Gwin.progress("正在添加...",10,document);
				return true;
			}
			
			function endAddRiDetail() {
				Gwin.close("progress_id");
				var msg = $("list:msg").value;
				if(msg.indexOf("成功")!=-1){
					//$("list:cono").value="";
					//$("list:sipr").value="";
				}
				cleartext();
				alert(msg);
			}
			
			function dDelRiDetail(obj) {
				var arr=Gtable.getselectid(obj);
				if(arr.length<=0){		    	
					alert("请选择要删除的行!");
				   	return false;
				}
				if(confirm("确认删除?")) {
					$("list:sellist").value=arr;
					Gwin.progress("正在删除...",10,document);
					return true;
				}
			}
			
			function endDDelRiDetail(){
				Gwin.close("progress_id");
				var msg = $("list:msg").value;
				alert(msg);
			}
			
			//更新部位明细
			function updateRiDetails(){
				$('list:ids').value = "";
			
				var ids = Gtable.getselcolvalues('gtable','id');
		
				if(ids.Trim().length<=0 ){
					alert("请勾选需要更新的明细!");
					return false;
				}
			
				var siprs = Gtable.getselcolvalues('gtable','sipr');
				var swits = Gtable.getselcolvalues('gtable','swit');
				var sweis = Gtable.getselcolvalues('gtable','swei');
				var punis = Gtable.getselcolvalues('gtable','puni');
				var rates = Gtable.getselcolvalues('gtable','rate');
				var remas = Gtable.getselcolvalues('gtable','rema');			
			
				$('list:ids').value = ids;
				$('list:siprs').value = siprs;
				$('list:swits').value = swits;
				$('list:sweis').value = sweis;
				$('list:punis').value = punis;
				$('list:rates').value = rates;
				
				
				
				Gwin.progress("",10,document);
				return true;
			}
			
			function endUpdateRiDetail(){
				if($("list:msg").value != null)
				{
					var msgs = $("list:msg").value.split("###");
					var msg = "";
					for(var i =0; i < msgs.length; i++)
					{
						if(msgs[i].length > 0)
						{
							msg += msgs[i]+"\n";
						}
					}
					alert(msg);
				}else
				{
					alert($("list:msg").value);
				}
				
				Gwin.close("progress_id");
				return true;		
			}
			function save(){
				if($("edit:suid").value==""){
					alert("供应商不能为空")
					return false;
				}
				if($("edit:cono").value==""){
					alert("色卡号不能为空")
					return false;
				}
				if($("edit:colo").value==""){
					alert("色号不能为空")
					return false;
				}
				
				if($("edit:cona").value==""){
					alert("规格不能为空")
					return false;
				}
				Gwin.progress("正在添加...",10,document);
				return true;
			}
			function endSave(){
				Gwin.close("progress_id");
				if($("edit:msg").value.indexOf("成功")!=-1){
					$("list:refBut").click();
				}
				if($("edit:msg").value!="")
					alert($("edit:msg").value);
				
			}
			function Edit(){
				showModal("","","",parent.document,document.GwinID);
			}
		</script>
		</head>

	<body id=mmain_body" onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gdebug="true"
								gselectsql="select distinct a.id,e.upco,f.cona as incolo,c.cono as skno,a.coid,d.suna,b.colo,b.cona,a.sipr,a.swit,a.puni,a.rate,a.swei,a.rema
from rici a
left join colo b on a.coid = b.id
left join cono c on b.skid = c.id
left join suin d on c.cuid = d.suid
left join inve e on e.leve='1' and left(e.inco,len(e.inco)-4) = a.inco
left join colo f on e.colo= f.id
											where c.id= '#{riciMB.suid}'"
								gpage="(pagesize = 20)" gversion="2"
								gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = id(headtext = id,name = id,width = 70,headtype = sort,align = right,type = hidden,datatype=number);
									gcid = suna(headtext = 供应商名称,name = suna,width = 110,align = left,type = text,headtype = sort,datatype = string);
									gcid = upco(headtext = 物料编码,name = upco,width = 110,align = left,type = text,headtype = sort,datatype = string);
									gcid = incolo(headtext = 物料规格,name = incolo,width = 110,align = left,type = text,headtype = sort,datatype = string);
									gcid = skno(headtext = 色卡,name = cono,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 色号,name = coid,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = cona(headtext = 规格,name = cona,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = sipr(headtext = 单价,name = sipr,width = 80,align = right,headtype = text,type = text,datatype =number,dataformat=0.##);
									gcid = swit(headtext = 可用幅宽,name = swit,width = 80,align = right,headtype = text,type = text,datatype =number,dataformat=0.##);
									gcid = swit(headtext = 实用幅宽,name = swit,width = 80,align = right,headtype = text,type = text,datatype =number,dataformat=0.##);
									gcid = swei(headtext = 克重,name = swei,width = 80,align = right,headtype = text,type = text,datatype =number,dataformat=0.##);
									gcid = puni(headtext = 采购单位,name = puni,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = rate(headtext = 换算率(%),name = rate,width = 80,align = right,headtype = text,type = text,datatype =number,dataformat=0.##);
									gcid = rema(headtext = 备注,name = rema,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="updateflag" value="#{riciMB.updateflag}"></h:inputHidden>
							<h:inputHidden id="msg" value="#{riciMB.msg}"></h:inputHidden>		
							<h:inputHidden id="ids" value="#{riciMB.ids}"></h:inputHidden>	
							<h:inputHidden id="siprs" value="#{riciMB.siprs}"></h:inputHidden>		
							<h:inputHidden id="swits" value="#{riciMB.swits}"></h:inputHidden>	
							<h:inputHidden id="sweis" value="#{riciMB.sweis}"></h:inputHidden>
							<h:inputHidden id="punis" value="#{riciMB.punis}"></h:inputHidden>	
							<h:inputHidden id="rates" value="#{riciMB.rates}"></h:inputHidden>	
							<h:inputHidden id="remas" value="#{riciMB.remas}"></h:inputHidden>		
							<h:inputHidden id="sellist" value="#{riciMB.sellist}"></h:inputHidden>
						<a4j:commandButton id="refBut" reRender="output"/>
						</a4j:outputPanel>
					</div>
				</h:form>
<div style="display: none">
<h:form id="edit">
					<a4j:outputPanel id="input">
 						<table border="0" cellpadding="0" cellspacing="0" style="margin-top: 5px;">
							<tr>
								<td bgcolor="#efefef">
									物料规格:
								</td>
								<td>
									<h:selectOneMenu id="coid" value="#{riciMB.bean.coid}" style="width:120px;">
											<f:selectItems value="#{riciMB.colors}"/>
										</h:selectOneMenu>
								</td>

								<td bgcolor="#efefef">
									供应商:
								</td>
								<td>
									<h:inputText id="suna" value="#{riciMB.bean.suna}" readonly="true" style="color:#A0A0A0" styleClass="datetime" />*
									<h:inputHidden id="suid" value="#{riciMB.bean.suid}"/>
									<img id="inty_img" style="cursor: pointer;"
											src="../../images/find.gif" onclick="selectsuin();" />
								</td>	
							</tr>
							<tr>
								<td bgcolor="#efefef">
									色卡号:
								</td>
								<td>
									<h:inputText id="cono" 
										value="#{riciMB.bean.cono}"	styleClass="datetime" />*
								</td>

								<td bgcolor="#efefef">
									色号:
								</td>
								<td>
									<h:inputText id="colo" 
										value="#{riciMB.bean.colo}"	styleClass="datetime" />*
								</td>	
							</tr>
							<tr>
								<td bgcolor="#efefef">
									规格:
								</td>
								<td colspan="3">
									<h:inputText id="cona" styleClass="inputtext"
										value="#{riciMB.bean.cona}"></h:inputText>*
								</td>
							</tr>
							<tr>
								<td bgcolor="#efefef">
									备注:
								</td>
								<td colspan="3">
									<h:inputText id="rema" styleClass="inputtext"
										value="#{riciMB.bean.rema}" size="70"></h:inputText>
								</td>
							</tr>
							<tr>
								<td colspan="4" align="center">
									<a4j:commandButton id="saveid" action="#{riciMB.saveSuco}"
										value="保存" reRender="list2,renderArea"
										onclick="if(!save()){return false};"
										oncomplete="endSave();" 
										onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										rendered="#{riciMB.MOD}" />
									<a4j:commandButton onmouseover="this.className='a4j_over'"
										onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
										value="返回" onclick="hideDiv();" />
								</td>
							</tr>
						</table>
					</a4j:outputPanel>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
						<h:inputHidden id="updateflag" value="#{riciMB.updateflag}"></h:inputHidden>
						<h:inputHidden id="sellist" value="#{riciMB.sellist}" />
						<h:inputHidden id="msg" value="#{riciMB.msg}"></h:inputHidden>
						</a4j:outputPanel>					
					</div>
</h:form>
</div>
			</f:view>
		</div>
	</body>
</html>