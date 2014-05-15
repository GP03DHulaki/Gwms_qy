<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>数据权限</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="查看用户">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
	</head>
	<script type="text/javascript">
	<!--
		function showModal(newurl){
			newurl = newurl + "?time=" + (new Date().getTime());
			window.showModalDialog(newurl,window,'dialogHeight:500px;dialogWidth:500px;status:no;resizable:no;');
	   	} 

	    function selectThis(target){
	    	Gwin.open({
				id:"datarightsWin",
				title:"添加岗位",
	   			contextType:"URL",
	   			context:"select_datarights.jsf",
	   			width:475,
	   			height:300,
	   			scrolling:'yes',		//要滚动条
	   			showbt:false,
	   			auotLoad:false,	//手动设置载入完成
	   			lock:true,
	   			dom:parent.document
		   	}).show("datarightsWin");		   
	    }
	    function loadok(){
		    Gwin.setLoadok("datarightsWin");
		}
	    function deleteRole(obj){
	    	var arr=Gtable.getselectid(obj);
			if(arr.length>0){
				startDo();		    	
				$("edit:itmes").value=arr;
				return true;
			}else{
			   	alert("请选择需要删除的数据!");
			   	return false;
			}
	    }		    
		function endDo(){
			Gwin.close("progress_id");
		    var msg = $('edit:msg').value;
		    var type = "X"; 
		    if(msg.indexOf("成功")!=-1){
				type = "Y";
			}
			Gwin.alert("系统提示",msg,type,parent.document);
	    }

		function controlEditable(value){
			$("edit:deleteButton").disabled=value;
		}	
		    
		function doLink(){
			var pid=$("edit:userid").value;
			window.location.href="update_user.jsf?pid="+pid;
		}
		 	//-->
	</script>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain>
						<div id=mmain_free>
							<h:panelGroup id="sp" rendered="#{user.canSpe}">
								<font style="background-color: #efefef">用户编码:</font>
								<h:inputText id="userid" styleClass="inputtext"
									value="#{user.bean.usid}" readonly="true"></h:inputText>
								&nbsp;
								<font style="background-color: #efefef">用户名称:</font>
								<h:inputText id="userName" styleClass="inputtext"
									value="#{user.bean.usna}" readonly="true"></h:inputText>
							</h:panelGroup>
						</div>
						<a4j:commandButton value="添加数据权限" type="button"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="selectThis();" reRender="outTable" 
							oncomplete="loadok();"	/>
						<a4j:commandButton value="删除数据权限"
							onmouseover="this.className='a4j_over'"
							action="#{user.deleteDataright}"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							onclick="if(!deleteRole(gtable)){return false}"
							oncomplete="endDo();"
							reRender="msg,outTable" />
						<a4j:outputPanel id="outTable">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gsort="ch_righttype"
								gselectsql=" Select a.id_id,a.ch_righttype,a.ch_keytype,a.vc_keyid,a.vc_keyvalue,a.vc_remark,b.nv_warehousename AS keyvaluename
									From gt_datarights a join gt_warehouse b on a.vc_keyvalue = b.vc_warehouseid 
									Where a.ch_keytype = 'U' And a.ch_righttype = 'W' And a.vc_keyid='#{user.bean.usid}'
									Union All
									Select a.id_id,a.ch_righttype,a.ch_keytype,a.vc_keyid,a.vc_keyvalue,a.vc_remark,b.vc_storehousename AS keyvaluename
									From gt_datarights a join gt_storehouse b on a.vc_keyvalue = b.vc_storehouseid 
									Where a.ch_keytype = 'U' And a.ch_righttype = 'S' And a.vc_keyid='#{user.bean.usid}'
									"
								gpage="(pagesize = -1)"
								gcolumn="gcid = id_id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
									gcid = 0(headtext = 序号,name = id_userid,width = 30,headtype = sort,align = center,type = text,datatype=string);
									gcid = ch_righttype(headtext = 权限类型,name = ch_righttype,width = 60,headtype = sort,align = center,type = mask,typevalue=S:仓库权限/W:库位权限 ,datatype=string);
									gcid = vc_keyvalue(headtext = 权限值,name = vc_keyvalue,width = 200,headtype = text,align = left,type = text,datatype=string);
									gcid = keyvaluename(headtext = 权限值说明,name = keyvaluename,width = 300,headtype = text,align = left,type = text,datatype=string);
								" />
						</a4j:outputPanel>
						<h:inputHidden id="itmes" value="#{user.itmes}"></h:inputHidden>
						<h:inputHidden id="msg" value="#{user.msg}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>