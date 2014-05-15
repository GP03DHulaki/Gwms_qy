function showModal(newurl)
{
	alert(newurl);
	newurl = newurl + "?time=" + (new Date().getTime());
	window.showModalDialog(newurl,window,'dialogHeight:560px;dialogWidth:700px;status:no;resizable:no;');
} 
//打印条码
function print()
{
	var usids = Gtable.getselcolvalues('gtable1','usid');
	if(usids.length>0){
		startDo();
		$("list:sellist").value=usids;
	}else{
		Gwin.alert("系统提示","请选择需要进行条码打印的记录!","!",document);
		return false;
	}
	return true	
}
//查看打印条码
function lookPrint()
{	
	var mes =$("list:mes").value;
	Gwin.alert("系统提示",mes,"!",document);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("list:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwin.close("progress_id")
 }
// **编辑用户资料 BEGIN
var edituser = function(parm1,parm2){
	ShowDiv("editDetail","编辑");
	$("edit:selid").value = parm1;
	$("edit:useredit").click();
}

function edituser_show(){
	$("edit:updateflag").value = "EDIT";
	$("edit:userid").disabled = "TRUE";
	$("edit:passWord").value = "password";
	$("edit:passWord1").value = "password";
	$("edit:passWord").disabled = "TRUE";
	$("edit:passWord1").disabled = "TRUE";
	Gwin.setLoadok("userWin");
}
// **编辑用户资料 END

// **编辑用户密码 BEGIN
function editpw(parm1,parm2){
	Gwin.open({
		id:"editPWDWin",
		title:"修改密码",
		contextType:"URL",
		context:"user_pw.jsf",
		width:500,
		height:220,
		autoLoad:false,		
		showbt:false,
		lock:true,
		dom:document
	}).show("editPWDWin");
	$("edit:selid").value = parm1;
	$("edit:pwedit").click();
}

function editpw_show(){
	Gwin.setLoadok("editPWDWin");
}
// **编辑用户密码 END

// **编辑数据权限密码 BEGIN
function editdatarights(parm1,parm2){
	Gwin.open({
		id:"editdatarightsWin",
		contextType:"URL",
		context:"user_datarights.jsf",
		width:500,
		height:400,
		autoLoad:false,
		left:100,
		top:10,
		showbt:false,
		lock:true,
		dom:document
	}).show("editdatarightsWin");
	$("edit:selid").value = parm2;
	$("edit:dredit").click();
}

function editdatarights_show(){
	Gwin.setLoadok("editdatarightsWin");
}
// **编辑数据权限密码 END

// **编辑角色 BEGIN
function editrole(parm1,parm2){
	Gwin.open({
		id:"editroleWin",
		title:"岗位权限",
		contextType:"URL",		
		context:"user_role.jsf",
		width:500,
		height:400,
		scrolling:'yes',
		autoLoad:false,
		showbt:false,
		lock:true,
		dom:document
	}).show("editroleWin");
	$("edit:selid").value = parm1;
	$("edit:roleedit").click();
}

function editrole_show(){
	Gwin.setLoadok("editroleWin");
}
// **编辑角色 END


//验证id="edit"的form表单				
function formCheck(){
	var reg = $("edit:userid").value;
	if(reg.Trim().length<=0){
		Gwin.alert("系统提示","用户编码不能为空!","!",document);
		$("edit:userid").focus();
		return false;
	}else{
		if(existzh_CN(reg.Trim())){
			Gwin.alert("系统提示","用户编码不能为中文!","!",document);
			$("edit:userid").select();
			return false;
		}
	}
	reg=$("edit:userName").value;
	if(reg.Trim().length <= 0){
		Gwin.alert("系统提示","请填写员工名称!","!",document);
		$("edit:userName").focus();
		return false;
	}
	
	reg=$("edit:passWord").value;
	if(reg.Trim().length <= 0){
		Gwin.alert("系统提示","密码不能为空!","!",document);
		$("edit:passWord").focus();
		return false;
	}	
	
	if($("edit:passWord").value != $("edit:passWord1").value){
		Gwin.alert("系统提示","密码与重复密码应该一致!","!",document);
		$("edit:passWord").focus();
		return false;
	}	
	
	//校验"身份证号"（15位或18位数字）
	reg=$("edit:vc_pid").value;
	if(reg.Trim().length>0){			
		regs = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
		if(!regs.test(reg.Trim())){		
			Gwin.alert("系统提示",'"身份证号(15位或18位数字)"格式不正确!',"!",document);
			$("edit:vc_pid").select();
			return false;
		}
	}	
	//校验"电子邮箱地址"
	reg=$("edit:email").value;
	if(reg.Trim().length>0){
		regs=/(\S)+[@]{1}(\S)+[.]{1}(\w)+/;
		if(!regs.test(reg.Trim())){
			Gwin.alert("系统提示",'"电子邮箱地址"格式不正确!',"!",document);
			$("edit:email").select();
			return false;
		}
	}
	
	var nv_userid=document.getElementById("edit:userid").value;
	var passWord=document.getElementById("edit:passWord").value;
	if(nv_userid.indexOf("-")>=0){
		Gwin.alert("系统提示","用户编码不能包括'-'号！","!",document);
		return false;
	}
	if(passWord.indexOf("-")>=0){
		Gwin.alert("系统提示","密码不能包括'-'号！","!",document);
		return false;
	}
	if(nv_userid.indexOf(".")>=0){
		Gwin.alert("系统提示","用户名不能包括'.'号！","!",document);
		return false;
	}
	if(passWord.indexOf(".")>=0){
		Gwin.alert("系统提示","密码不能包括'.'号！","!",document);
		return false;
	}
	if(nv_userid==""){
		Gwin.alert("系统提示","用户编码不能为空！","!",document);
		return false;
	}
	if(passWord==""){
		Gwin.alert("系统提示","密码不能为空！","!",document);
		return false;
	}
	if($("edit:orid")!=null && $("edit:orid").value.Trim().length<=0){
		Gwin.alert("系统提示","组织架构不能为空！","!",document);
		return false;
	}
	Gwin.progress("正在保存...",10,document);
	return true;
}

function doNew(){
	ShowDiv("editDetail","新增");
	$("edit:userid").value = "";
	$("edit:userName").value = "";
	$("edit:passWord").value = "";
	$("edit:passWord1").value = "";
	$("edit:vc_pid").value = "";
	$("edit:email").value = "";
	$("edit:sex").value = "";
	$("edit:status").value = "";
	$("edit:telephone").value = "";
	$("edit:othercontact").value = "";
	$("edit:orid").value = "";
	$("edit:remark").value = "";
	$("edit:updateflag").value = "ADD";
	$("edit:userid").disabled = "";
	$("edit:passWord").disabled = "";
	$("edit:passWord1").disabled = "";
	$("edit:dpid").value = "";
}


function ShowDiv(divid,title){
	Gwin.open({
		id:"userWin",	
		title:title,
		contextType:"ID",
		context:divid,
		dom:document,
		width:610,
		height:300,
		autoLoad:false,
		showbt:false,
		lock:true
	}).show("userWin");
	if(title.indexOf("新增")!=-1)Gwin.setLoadok("userWin");
}

//隐藏层
function hideDiv(){
	Gwin.close("userWin")
}
	
function startDo(){
	Gwin.progress("",10,document);
}

function endDo( m ){
	Gwin.close("progress_id");
	var msg = m ? m : $('list:mes').value;
	var type = "X";
	if(msg.indexOf("成功")!=-1){
		type = "Y";
		Gwin.close("userWin");
	}
 	Gwin.alert("系统提示",msg,type,document);
}

function endUser(){
	var msg = $('edit:msg').value;
	endDo(msg);
	if("ADD"==$("edit:updateflag").value){
		$("edit:userid").value = "";
		$("edit:userName").value = "";
		$("edit:passWord").value = "";
		$("edit:passWord1").value = "";
		$("edit:vc_pid").value = "";
		$("edit:email").value = "";
		$("edit:sex").value = "";
		$("edit:status").value = "";
		$("edit:telephone").value = "";
		$("edit:othercontact").value = "";
		$("edit:orid").value = "";
		$("edit:remark").value = "";
		$("edit:dpid").value = "";	
		$("edit:userid").disabled = "";
		$("edit:passWord").disabled = "";
		$("edit:passWord1").disabled = "";
	}
}

function controlEditable(value){
// 	$("list:deleteButton").disabled=value;
// 	$("list:addButton").disabled=value;
}

var delstate = false;
function doDelete(obj)	{	
	if(delstate){
		delstate = false;
		return true;
	}else{
		var arr = Gtable.getselectid(obj);
		if(arr.length>0){
			Gwin.confirm("showMsg2","系统提示","确定要删除选中的数据吗?","?",document,
				[{lable:'确定',click:function(){
					$("list:sellist").value = arr;
					Gwin.progress("正在删除...",10,document);
					delstate = true;
					$("list:deleteButton").onclick();
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

function reset(){
	$("list:searchuserid").value = "";
	$("list:searchuser").value = "";
	$("list:roleid").value = "";
	$("list:dpid").value = "";
}

