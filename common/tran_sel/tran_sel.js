
var retid = "", retpfid = "", retpoid = "", flag = "";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2, parm3, parm4, parm5) {
	retid = $("edit:retvid").value;
	retpfid = $("edit:retpfid").value;
	retpoid = $("edit:retpoid").value;
	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
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
	if (retid != "" && retid != null) {
		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	if (retpfid != "" && retpfid != null) {
		isGwin ? parent.document.getElementById(retpfid).value = parm2 : callBack.document.getElementById(retpfid).value = parm2;
	}
	if (retpoid != "" && retpoid != null) {
		isGwin ? parent.document.getElementById(retpoid).value = parm3 : callBack.document.getElementById(retpoid).value = parm3;
	}
	
	if(parm4 != null && parm4 != '' && parent.document.getElementById("edit:fwna"))
	{
		parent.document.getElementById("edit:fwna").value = parm4;
	}
	
	if(parm5 != null && parm5 != '' && parent.document.getElementById("edit:owna"))
	{
		parent.document.getElementById("edit:owna").value = parm5;
	}
	

	isGwin ? Gwin.close(document.GwinID) : window.close();	
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

