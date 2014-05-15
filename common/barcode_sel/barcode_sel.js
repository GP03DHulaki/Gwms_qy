var retid = "", dwhid = "",retqty="";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2, parm3) {
	retid = $("edit:retid").value;
	dwhid = $("edit:dwhid").value;
	retqty = $('edit:retqty').value;
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
	if ( retid != "" && retid != null){
 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	if (retqty != "" && retqty != null) {
		parm3 = parseInt(parm3);
		isGwin ? parent.document.getElementById(retqty).value = parm3 : callBack.document.getElementById(retqty).value = parm3;
	}
	if(callBack && callBack.document.getElementById('edit:setCode4DBean')){
		callBack.document.getElementById('edit:setCode4DBean').onclick();
	}else{
		if(parent.document.getElementById('edit:setCode4DBean')!=null){
			parent.document.getElementById('edit:setCode4DBean').onclick();
		}
		
		
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
	var b = $("edit:sk_inco");
	if (a != null) {
		a.value = "";
		a.focus();
	}
	if (b != null) {
		b.value = "";
	}
}

