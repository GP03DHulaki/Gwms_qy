
	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
    function selectThis(parm1,parm2,parm3,parm4){
    	retid = $('edit:retid').value;
    	retname = $('edit:retname').value;
    	chie = $('edit:chie').value;
    	addr = $('edit:addr').value;
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
		
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value = parm2 : callBack.document.getElementById(retname).value=parm2;
		}
		if ( chie != "" && chie != null){
    		isGwin ? parent.document.getElementById(chie).value = parm3 : callBack.document.getElementById(chie).value=parm3;
		}
		
		if ( addr != "" && addr != null){
			isGwin ? parent.document.getElementById(addr).value = parm4 : callBack.document.getElementById(addr).value=parm4;
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
		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
		}  
	}

	function doSearch(){
		$("edit:sid").onclick();
	}
	function init(){
		//$("edit:whtys").style.display=$("edit:isabled").value;
	}
	
