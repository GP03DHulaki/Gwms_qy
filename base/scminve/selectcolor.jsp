<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>规格多选</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
<script type="text/javascript">
function formsubmit(){
		if (event.keyCode==13)
		{
			var obj=$("list:sid");
			obj.onclick();
			return true;
		}
	}
function cleartext(){
	$("edit:color").value="";
}

function add() {
	var parentContent = Gwin.getObjById(document.GwinParentID,"mmain_free");
	var hcolodata = Gwin.getObjById(document.GwinParentID,"hcolodata");
	var arr = Gtable.getselectid("gtable");
	
	var na = Gtable.getselcolvalues("gtable","cona");
	var data="",hdata = ""; //数据和隐藏返回数据
	if(arr.length>0){
		arr = arr.split(",");
		na = na.split("#@#");
		for(var i=0;i<arr.length ;i++){
			if(!Gwin.getObjById(document.GwinParentID,arr[i])) {
			data += "<span class='element' id="+arr[i]+">["+arr[i]+"]"+na[i]+"<img src='delete.gif' title='删除' onclick='del("+arr[i]+")'/></span>"
			hdata+=arr[i]+":"+na[i]+";";
			}
		}
		hcolodata.innerHTML += hdata;
		parentContent.innerHTML+=data;
		Gwin.close(document.GwinID);
		return true;
	}
	else{
		alert("请选择规格");
		return false;
	}
}
</script>
	</head>
	<body id=mmain_body >
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button"
							action=""
							oncomplete=""
							onclick="Gwallwin.winShowmask('TRUE');" reRender="output"
							requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							action="#{purchaseMB.clearList}"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
						<a4j:commandButton type="button" value="添加"
							onmouseover="this.className='a4j_over1'"
							onclick='if(!add()){return false};'
							oncomplete="closeDiag()" reRender="renderArea,output"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="规格:">
						</h:outputText>
						<h:inputText id="color" styleClass="inputtextedit" size="15"
							value="#{purchaseMB.pubdid}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">	
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="select a.id,a.colo,a.cona,a.rema,
											b.cona as skna,c.ceve
											from colo a join cono b on a.skid=b.id join suin c on b.cuid=c.suid
											where a.stat=1 #{coloCOM.sql}"
								gwidth="550" gpage="(pagesize = 10)" gdebug="false"
								gcolumn="gcid = id(headtext = selall,name = id,width = 30,align = center,type = checkbox,headtype = checkbox);
									gcid = 0(headtext = 行号,name = rowid,width = 30,align = center,type = text,headtype = string);
									gcid = skna(headtext = 色卡名称,name = skna,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = colo(headtext = 色号,name = coid,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = cona(headtext = 规格,name = cona,width = 80,align = left,type = text,headtype = sort ,datatype = string);
									gcid = rema(headtext = 备注,name = rema,width = 200,align = left,type = text,headtype = sort ,datatype = string);
								" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{purchaseMB.msg}" />
							<h:inputHidden id="dbdata" value="#{purchaseMB.dbdata}" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>