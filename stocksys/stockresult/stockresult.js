function formsubmit(){
	if(event.keyCode==13){
		$("edit:sid").onclick();
		return true;
	}
}
function clearSearchKey(){
	$("edit:start_date").value="";
	$("edit:end_date").value="";
	$("edit:nvfromvoucherid").value="";
	$("edit:biid").value="";
	$("edit:orid").value="";
}
function initload(){
	$("edit:biid").focus();
}

function startDo(){
	Gwallwin.winShowmask("TRUE");
}

function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function doSearch(){
	$("edit:sid").click();
}