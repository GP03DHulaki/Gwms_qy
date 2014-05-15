	var iu = 'r';
	
	onPageload = function (){
		RoleClick(0,'NULL','NULL');
	}
	
	function clearRoles(){
		$('subform:roleoperate').value='';
	}

	function doNew(){
		return false;
	}
		
	function startDo(msg){
		Gwin.progress(msg,10,document);
		controlEditable("disabled");
	}

	function endDo(){
		Gwin.close("progress_id");
		controlEditable("");
		if($("ajaxbutton:saveoperate")){
			$("ajaxbutton:saveoperate").disabled=true;
		}
		Gwin.alert("系统提示",$('outMessage').value,"!",document);
	}
	
	function endrefresh(){
		Gwin.close("progress_id");
		if($('ajaxbutton:saveoperate')){
			$('ajaxbutton:saveoperate').disabled=true;
		}
	}
	
	function controlEditable(value){
		if($("ajaxbutton:saveoperate")){
			$("ajaxbutton:saveoperate").disabled=value;
		}
		$("ajaxbutton:refreshoperate").disabled=value;
	}
    
	function RoleClick(id,roleid,rolename){
		this.iu = 'r';
		if($("subform:selid")){	
			$("subform:selid").value = id;
		}

		if($("subform:roleid")){	
			$("subform:roleid").value = roleid;
		}
				
		//先提交数据
		$('subform').submit();
		//再刷新
		var refmodule = $("ajaxbutton:refreshoperate");
		refmodule.onclick();
		$("helptext").innerHTML = "<font style='color:#FF0000;font-weight:bold'>角色: "+	rolename + " 权限列表</font>";
		if($('ajaxbutton:saveoperate')){
			$('ajaxbutton:saveoperate').disabled = true;
		}
	}
	
	function deleteAll(obj){	
		var arr=Gtable.getselectid(obj);
		if(arr.length>0){		    	
	   		if(!confirm('确定删除当前记录吗?')){
				return false;
			}else{
				$("list:sellist").value=arr;
				startDo();
			}
		}else{
		   	alert("请选择要删除的记录!");
			return false;
		}
	   
		return true;
	}
	
	function editrole_click(){	
		$("edit:editrole").click();
	}
	
	function editrole(obj){	
		var arr=Gtable.getselectid(obj);
	  	if(arr.length>0){
			var arrlst = arr.split(",");
	   		if ( arrlst.length > 1){
			   	Gwin.alert("系统提示","请选择单个角色进行编辑!","!",document);
			   	return false;
	   		}
		}else{
			Gwin.alert("系统提示","请选择要编辑的角色!","!",document);
			return false;
		}
	  	showDiv("编辑岗位");
		return true;
	}
	
	//点击编辑按钮
	function editrole_show(id){
		$("edit:updateflag").value = "EDIT";
		$("edit:groupid").disabled = "true";
		Gwin.setLoadok("roleWin");
	}
	
	//验证id="edit"的form表单				
	function roleFormcheck(){
		var groupid=$("edit:groupid").value;
		var groupname=$("edit:groupname").value;
		var status=$("edit:status").value;
		if(groupid==null||groupid.length<=0){
			Gwin.alert("系统提示","岗位编码不能为空!","!",document);
			$("edit:groupid").focus();
			return false;
		}
		
		if(groupname==null||groupname.length<=0){
			Gwin.alert("系统提示","岗位名称不能为空!","!",document);
			$("edit:groupname").focus();
			return false;
		}
		
		if(status==null||status.length<=0){
			Gwin.alert("系统提示","状态不能为空!","!",document);
			return false;
		}
		return true;
	}
	
	//添加角色完成后执行的方法
	function roleEndDo(){
		var type = "X";
		Gwin.close("progress_id");
		var message = $("edit:msg").value;
		$("subform:selid").value = "";
		if(message.indexOf("增加成功")!=-1){
			$("edit:groupid").value="";
			$("edit:groupname").value="";
			$("edit:status").value="1";
		}else if(message.indexOf("已存在")!=-1){
			$("edit:groupid").value="";
		}
		if(message.indexOf("成功")!=-1){
			type = "Y";
			hideDiv();
		}
		
		Gwin.alert("系统提示",message,"!",document);
	}
	
	//点击添加角色按钮时调用的方法
	function addDiv(){
		$("edit:groupid").value="";
		$("edit:groupname").value="";
		$("edit:status").value="1";
		
		$("edit:updateflag").value = "ADD";
		$("edit:groupid").disabled="";
		showDiv("新增岗位");
	}
	
	//显示层
	function showDiv(title){
		Gwin.open({
			id:"roleWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:490,
			height:100,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("roleWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("roleWin");
	}
	//隐藏层
	function hideDiv(){
		Gwin.close("roleWin");
	}

	//显示和隐藏扩展功能

function JS_ExtraFunction(){
	var extraFunction = document.getElementById("ExtraFunction");
	var detail_ctrl = document.getElementById("detail_ctrl");
	if(extraFunction.style.display=='none'){
		extraFunction.style.display="";
		detail_ctrl.className="ctrl_hide";
	}else{
		extraFunction.style.display="none";
		detail_ctrl.className="ctrl_show";
	}
}

function selectUser(){
	if($('list:selroleid').value != 'NULL'){
		showModal("../../common/user/user_more.jsf?retid=list:userids&func=list:addButton&retname=",500,400,parent.document,document.GwinID);
	}
}

function doUserDel(obj){
	var arr=Gtable.getselcolvalues(obj,'usid');
	if(arr.length>0){		    	
		if(confirm('确定删除选择的用户吗?')){
			$("list:userids").value=arr;
			Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
   }
   else {
	   	alert("请选择要删除的用户!");
	   	return false;
   }
}

function endDo2(){
	Gwin.progress("progress_id");
	alert($('list:usgrmsg').value);
	window.location.reload();
}
function showUser(id,roleid,rolename){
	RoleClick(id,roleid,rolename);
	iu = 'u';
}

function showUserModal(){
	if(iu == 'u'){
		showModal("user.jsf");
	}
}
