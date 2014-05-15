function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

//导出开始
function excelios_begin(obj){
	var s = Gtable.getSQL(obj);
	$("edit:gsql").value = s
	startDo();
}

//导出结束
function excelios_end(){
	Gwallwin.winShowmask('FALSE');
	var message =$('edit:msg').value;
	alert($('edit:msg').value);
	//alert($("edit:outPutFileName").value);
	if(message.indexOf('导出成功')!=-1){
		window.open('../../'+$("edit:outPutFileName").value);
	}
	}