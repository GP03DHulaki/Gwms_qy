
	var retid="",retname="",retbar="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,parm2,parm3,param4){
    	retid = $('edit:retid').value;
		retname = $('edit:retname').value;
		retcolor = $('edit:retcolor').value;
		retbar = $('edit:retbar').value;
		var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
		if(isGwin == false){
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
    		isGwin ? parent.document.getElementById(retid).value=parm1 : callBack.document.getElementById(retid).value=parm1;
		}

		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value=parm2 : callBack.document.getElementById(retname).value=parm2;
		}
		
		if ( retbar != "" && retbar != null){
			isGwin ? parent.document.getElementById(retbar).value=parm3 : callBack.document.getElementById(retbar).value=parm3;
		}
		if ( retcolor != "" && retcolor != null){
			isGwin ? parent.document.getElementById(retcolor).value=param4 : callBack.document.getElementById(retcolor).value=param4;
		}
	
		isGwin ? Gwin.close(document.GwinID) : window.close();	
    }
    
	function formsubmit(){
		if (event.keyCode==13){
			var obj=$("edit:sid");
			obj.onclick();
			return true;
		}
	}
	
	function cleartext(){
		var a = $("edit:id");
		var b = $("edit:name");
		var c = $("edit:bar");
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
		if($("edit:colo")!=null){
	 		$("edit:colo").value = "";
	 	}
	 	if($("edit:inst")!=null){
	 		$("edit:inst").value = "";
	 	}
	 	if($("edit:tyna")!=null){
	 		$("edit:tyna").value = "";
	 	}
	 	if($("edit:brde")!=null){
	 		$("edit:brde").value = "";
	 	}
	 	if($("edit:inpr")!=null){
	 		$("edit:inpr").value = "0";
	 	}
	}
	
	// 批量添加明细
	function addDetails(){
		var incos = Gtable.getselcolvalues('gtable','inco');
		if(incos.length<=0){
			alert("请选择需要添加的商品!");
			return false;
		}else{
			retid = $('edit:retid').value;
			var iscor = incos.split("#@#").join(",");
			if(window.dialogArguments.document.getElementById(retid)!=null){
				window.dialogArguments.document.getElementById(retid).value = iscor;
			}
		}
		window.close();	
	}
	
	

function search(){
	Gwallwin.winShowmask("TRUE");
}

function endSearch(){
	Gwallwin.winShowmask("FALSE");
}

function claresearch(){
	if(null!=$("edit:inst") && null!=$("edit:id") && null!=$("edit:name") && null!=$("edit:colo")){
		$("edit:id").value="";
		$("edit:name").value="";
		$("edit:colo").value="";
		$("edit:inst").value="";
	}
}
function openbase(){
	top.window.autoOpenTree("BASE","SCMINVE");
}