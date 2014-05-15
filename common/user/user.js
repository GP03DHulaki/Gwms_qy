var isGwin = typeof window.Gwin === 'object';
var retid = "", retname = "";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2, parm3) {
	retid = $("edit:retid").value;
	retname = $("edit:retname").value;
	if(isGwin === false){
		is_IE = (navigator.appName == "Microsoft Internet Explorer");
		var callBack = null;  
		if(is_IE) {
			callBack = window.dialogArguments;
		}
		else {
			if (window.opener.callBack == undefined) {   
				window.opener.callBack = window.dialogArguments;   
			}   
			callBack = window.opener.callBack;   
		}
	}
	if ( retid != "" && retid != null){
		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	
	if ( retname != "" && retname != null){
		isGwin ? parent.document.getElementById(retname).value = parm2 : callBack.document.getElementById(retname).value=parm2;
	}
	isGwin ? Gwin.close(document.GwinID) : window.close();	
}
// 批量添加明细
function addDetails(){
	var incos = Gtable.getselcolvalues('gtable','usid');
	if(incos.length<=0){
		alert("请选择需要添加的用户!");
		return false;
	}else{
		retid = $('edit:retid').value;
		var iscor = incos.split("#@#").join(",");
		if(isGwin){
			Gwin.setObjById(document.GwinParentID,retid,"value",iscor);	//设置父窗口的中的ID=retid的value属性值为iscor
			Gwin.getObjById(document.GwinParentID,"list:adduser").onclick();	//获取窗口中指定对象
		}else{
			if(window.dialogArguments.document.getElementById(retid)!=null){
				window.dialogArguments.document.getElementById(retid).value = iscor;
			}
			window.close();
			if (window.dialogArguments.document.getElementById("list:adduser")) {
				window.dialogArguments.document.getElementById("list:adduser").onclick();
			}
		}
	}
	if(isGwin){
		Gwin.close(document.GwinID);
	}else{
		window.close();
	}
}
function formsubmit() {
	if (event.keyCode == 13) {
		var obj = $("edit:sid");
		obj.onclick();
		return true;
	}
}
function cleartext() {
	var a = $("edit:id");
	var b = $("edit:name");
	if (a != null) {
		a.value = "";
		a.focus();
	}
	if (b != null) {
		b.value = "";
	}
}
function openuser(){
	top.window.autoOpenTree("../sys/user/user.jsf");
}

