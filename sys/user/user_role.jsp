<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>用户资料</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="查看用户">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
		<script type='text/javascript'
			src='<%=request.getContextPath()%>/js/Gwallwin.js'></script>
	</head>

	<script type="text/javascript">
	   	function selectThis(target){
	   		Gwin.open({
				id:"selectRoleWin",
				title:"添加岗位",
	   			contextType:"URL",
	   			context:"select_role.jsf",
	   			width:475,
	   			height:300,
	   			scrolling:'yes',		//要滚动条
	   			showbt:false,
	   			auotLoad:false,	//手动设置载入完成
	   			lock:true,
	   			dom:parent.document
		   	}).show("selectRoleWin");		   	   
	    }
	    function loadok(){
		    Gwin.setLoadok("selectRoleWin");
		}

	    var delstate = false;
		function deleteRole(obj)	{	
			if(delstate){
				delstate = false;
				return true;
			}else{
				var arr = Gtable.getselectid(obj);
				if(arr.length>0){
					Gwin.confirm("showMsg2","系统提示","确定要删除选中的数据吗?","?",document,
						[{lable:'确定',click:function(){
							$("edit:sellist").value = arr;
							Gwin.progress("正在删除...",10,document);
							delstate = true;
							$("edit:sg").onclick();
							Gwin.close("showMsg2");
						}},
						{lable:'取消',click:function(){
							Gwin.close("showMsg2");
						}}]);
				}else{
					Gwin.alert("系统提示","请选择要需要删除的数据!","!",document);
			   }
			}
			return false;	
		}
		function controlEditable(value){
			document.getElementById("edit:deleteButton").disabled=value;
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
	</script>

	<body id=mmain_body >
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<table align="center" width="100%">
						<tr>
							<td>
								<DIV ID=mmain_opt>
								</div>
								<div id=mmain_free>
									<font style="background-color: #efefef">用户编码:</font>
									<h:inputText id="userid" styleClass="inputtext"
										value="#{user.bean.usid}" readonly="true"></h:inputText>
									&nbsp;
									<font style="background-color: #efefef">用户名称:</font>
									<h:inputText id="userName" styleClass="inputtext"
										value="#{user.bean.usna}" readonly="true"></h:inputText>
								</div>
								<a4j:outputPanel id="outTable1">
									<h:panelGroup id="sp" rendered="#{user.APP}">
										<a4j:commandButton value="添加岗位" type="button"
											onmouseover="this.className='a4j_over1'"
											onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
											onclick="selectThis();" reRender="outTable1" id="ag" 
											oncomplete="loadok();"	/>
										<a4j:commandButton value="删除岗位"
											onmouseover="this.className='a4j_over1'"
											action="#{user.deleterole}" id="sg"
											onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
											oncomplete="endDo();" onclick="if(!deleteRole(gtable1)){return false;}"
											reRender="msg,outTable1" />
									</h:panelGroup>

									<g:GTable gid="gtable1" gtype="grid" gversion="2"
										gselectsql=" select b.id,c.grid,c.grna
											from usin a 
											join usgr b on a.usid = b.usid 
											join grin c on c.grid=b.grid
											where a.usid = '#{user.bean.usid}' "
										gcolumn="
											gcid = id(headtext = selall,name = selall,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = grid(headtext = 岗位编码,name = grid,width = 120,headtype = text,align = center,type = text,datatype=string);
											gcid = grna(headtext = 岗位名称,name = grna,width = 200,headtype = text,align = center,type = text,datatype=string);

									" />
								</a4j:outputPanel>
								<h:inputHidden id="sellist" value="#{user.sellist}"></h:inputHidden>
								<h:inputHidden id="msg" value="#{user.msg}" />
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>