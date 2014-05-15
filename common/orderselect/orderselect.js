
	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,param2){
    	retid = $('edit:retid').value;
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
		var a = $("edit:biid");
		var b = $("edit:inco");

		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
			b.focus();
		}

	}
	

	
