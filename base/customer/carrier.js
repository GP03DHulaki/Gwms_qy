
	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1){
    	retid = $('edit:retid').value;
		//retname = $('edit:retname').value;
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
		
		/*if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value = parm2 : callBack.document.getElementById(retname).value=parm2;
		}*/
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
		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
		}  
	}
	
