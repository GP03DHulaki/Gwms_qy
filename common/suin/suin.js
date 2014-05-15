
	retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,parm2){
		retid = $('edit:retid').value;
		retname = $('edit:retname').value;
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
		isGwin ? Gwin.close(document.GwinID) : window.close();	
    } 
    function selectSuin(cuid,param2,param3,param4,sipr,puni){
    	if(sipr==""){
    		if(confirm("单价为空!是否跳转到维护页面?")){
    			showModal("../../../common/suin/inve_suinpric.jsf?suid="+cuid+"&inco="+$("edit:inco").value,"800px","450px",parent.document,document.GwinID,"价格维护");
    		}
    		return false;
    	}
    	retid = $('edit:retid').value;
		retname = $('edit:retname').value;
		retsuco = $('edit:retsuco').value;
		retsucoid = $('edit:retsucoid').value;
		retunit = $('edit:retunit').value;
		retsipr = $('edit:retsipr').value;
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
    		isGwin ? parent.document.getElementById(retid).value = cuid : callBack.document.getElementById(retid).value=cuid;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value = param2 : callBack.document.getElementById(retname).value=param2;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retsucoid).value = param3 : callBack.document.getElementById(retsucoid).value=param3;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retsuco).value = param4 : callBack.document.getElementById(retsuco).value=param4;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retsipr).value = sipr : callBack.document.getElementById(retsipr).value=sipr;
		}
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retunit).value = puni : callBack.document.getElementById(retunit).value=puni;
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
	function update(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','sipr');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
		}
	}
	if(msg.length<=0){
		Gwin.progress("正在更新...",10,parent.document);
		var updatedate = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedate;
	   	return true;
	}else{
		alert(msg);
		return false;
	}
	
}
	function endUpdate(){
		Gwin.close("progress_id");
		if($("edit:msg").value.indexOf("成功")!=-1){
			 Gwin.getObjById(document.GwinParentID,"edit:refBut").click();
		}
		if($("edit:msg").value!="")
			alert($("edit:msg").value);
	}
	function closeWin(){
		 Gwin.close(document.GwinID);
	}
function openbase(){
	top.window.autoOpenTree("BASE","SUPPLIER");
}
function openinve(){
	top.window.autoOpenTree("BASE","SCMINVE");
}