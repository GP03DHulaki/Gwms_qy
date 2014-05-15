function Edit(obj)
{
	$("list:hiddenBiid").value = obj;
	$("list:editbut").click();
}


//开始合并
function sk_meger(obj){
	var biids = Gtable.getselectid(obj);
	if(biids.length>0){	
		if(confirm("确定要合并你当前选中的记录吗？")){
			Gwallwin.winShowmask("TRUE");
			$("list:sellist").value = biids;
			return true;
		}
	}else{
		alert("请选择你要合并的记录");
		return false;
	}
}
//结束合并
function end_meger(){
	var message=$("list：msg").value;
	alert(message);
	Gwallwin.winShowmask("false");
}


function clearSearchKey(){
	textClear('list','biid,soco,crna,flag','Y');
}
