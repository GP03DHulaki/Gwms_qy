<%@ page language="java" pageEncoding="UTF-8"%><%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="search" />
		<title>选择规格</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" >
		
	function cleartext(){
		var a = $("edit:skna");
		var b = $("edit:colo");
		var c = $("edit:cona");
		var d = $("edit:ceve");
		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
		}   
		if(c!=null){
			c.value="";
		}
		if(d!=null){
			d.value="";
		}  
	}
	
	//添加明细
	function addRiDetails(){
		$("edit:updateflag").value = "ADD";
		$('edit:coids').value = "";
	
		var coids = Gtable.getselcolvalues('gtable','id');

		if(coids.Trim().length<=0 ){
			alert("请勾选需要添加的明细!");
			return false;
		}
		alert(document.GwinParentID);
		//return false;
		$('edit:coids').value = coids;
		Gwin.progress("正在添加...",10,document);
		return true;
	}
	
	function endAddRiDetail(){
		Gwin.close("progress_id");
		if($("edit:msg").value != "")
		{
			var msgs = $("edit:msg").value.split("###");
			var msg = "";
			for(var i =0; i < msgs.length; i++)
			{
				if(msgs[i].length > 0)
				{
					msg += msgs[i]+"\n";
				}
			}
			alert(msg);
		}
		Gwin.getIframeObjById(document.GwinParentID,"iframeRici","list:refBut").click();
		return true;
	}
		</script>
	</head>

	<body id=mmain_body onload="cleartext();">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
							<a4j:commandButton onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								id="sid" value="查询" type="button" action="#{riciMB.searchColo}"
								reRender="output" requestDelay="50" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="cleartext();" />
							<a4j:commandButton type="button" value="添加明细"
								action="#{riciMB.addDetail}"
								onmouseover="this.className='a4j_over1'"
								onclick='if(!addRiDetails()){return false};'
								oncomplete="endAddRiDetail()" reRender="renderArea"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="色卡名称:">
						</h:outputText>
						<h:inputText id="skna" styleClass="inputtextedit" size="15"
							value="#{riciMB.skna}" onkeypress="formsubmit(event);" />
						<h:outputText value="色号:">
						</h:outputText>
						<h:inputText id="colo" styleClass="inputtextedit" size="15"
							value="#{riciMB.colo}" onkeypress="formsubmit(event);" /><br/>
						<h:outputText value="规格:">
						</h:outputText>
						<h:inputText id="cona" styleClass="inputtextedit" size="15"
							value="#{riciMB.cona}" onkeypress="formsubmit(event);" />
						<h:outputText value="供应商名称:">
						</h:outputText>
						<h:inputText id="ceve" styleClass="inputtextedit" size="15"
							value="#{riciMB.ceve}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">	
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.colo,a.cona,a.rema,
											b.cona as skna,c.ceve
											from colo a join cono b on a.skid=b.id join suin c on b.cuid=c.suid
											where a.stat=1 #{riciMB.sql}"
								gwidth="550" gpage="(pagesize = 10)" gdebug="false"
								gcolumn="gcid = id(headtext = selall,name = selall,width = 20,align = center,type = checkbox,headtype =checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = id(headtext = id,name = id,width = 70,headtype = sort,align = right,type = hidden,datatype=number);
									gcid = ceve(headtext = 供应商名称,name = ceve,width = 160,align = left,type = text,headtype = sort ,datatype = string);
									gcid = skna(headtext = 色卡名称,name = skna,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 色号,name = coid,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = cona(headtext = 规格,name = cona,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = rema(headtext = 备注,name = rema,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div>
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="updateflag" value="#{riciMB.updateflag}"></h:inputHidden>
							<h:inputHidden id="msg" value="#{riciMB.msg}"></h:inputHidden>		
							<h:inputHidden id="coids" value="#{riciMB.coids}"></h:inputHidden>
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>