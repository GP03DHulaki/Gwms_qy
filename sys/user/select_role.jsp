<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base target="_self" />
		<title>添加角色</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="添加角色">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='<%=request.getContextPath()%>/js/Gbase.js'></script>
		<script type='text/javascript' src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
	</head>
	<script type="text/javascript">
			function endDo(){
				Gwin.close("progress_id");
		        controlEditable(false);
		     	var message = $('edit:msg').value;
		     	var type = "X";
		     	if(message.indexOf("成功!")!=-1){
			     	type = "Y";
			     	Gwin.reloadWin("editroleWin");//刷新父界面
				}
		     	Gwin.alert("系统提示",message,type,parent.document);
		     	if(type == "Y") Gwin.close("selectRoleWin");
		   	}
		   	
		    function controlEditable(value){
		    	$("edit:deleteButton").disabled=value;
		    }
		    
		    function doSaveAll(obj){
				var arr=Gtable.getselectid(obj);
			  	$("edit:roleitem").value=arr;
			  	Gwin.progress("正在保存...",10,parent.document);
		 		controlEditable(true);
		 	}	
	</script>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<b>系统管理</b>&gt;&gt;
					<b>添加岗位</b>
					<br>
					<div id=mmain_opt>
						<a4j:commandButton id="deleteButton" value="保存" type="button"
							action="#{user.saveRole}" onclick="doSaveAll('gtable1');"
							reRender="msg,output" oncomplete="endDo();"
							requestDelay="50" onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
						<input type="button" value="返回" class="but"
							onmouseover="this.className='search_over'"
							onmouseout="this.className='search_buton'"
							onclick="javascript:Gwin.close('selectRoleWin');" />
					</div>
					<a4j:outputPanel id="output">
						<g:GTable gid="gtable1" gtype="grid" gversion="2"
							gselectsql="Select grid,grna From grin 
								where stat='1' And grid
									not in (select grid from usgr where usid = '#{user.bean.usid}' )"
							gpage="(pagesize = -1)"
							gcolumn="gcid = grid(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = grid(headtext = 岗位编码,name = grid,width = 100,headtype = sort,align = left,type = text,datatype=string);
								gcid = grna(headtext = 岗位名称,name = grna,width = 280,headtype = text,align = left,type = text,datatype=string);
						" />
					</a4j:outputPanel>
					<h:inputHidden id="msg" value="#{user.msg}" />
					<h:inputHidden id="roleitem" value="#{user.roleitem}"></h:inputHidden>
				</h:form>
			</f:view>
		</div>
	</body>
</html>