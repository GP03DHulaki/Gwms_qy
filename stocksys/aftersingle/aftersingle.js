function doSearch(){
	$("list:sid").click();
}
function initFrame(){
	$('tabContent2').className = 'hidetab_body';
	endWinShow();
}
function endWinShow(){
    Gwallwin.winShowmask("FALSE");
}
function addNew(){
	window.location.href="aftersingle_add.jsf";
}
//选择移动库位
function selectWhid(whty,pwid,retid,retname){
	var url = "../../common/waho/waho.jsf?type="+whty+"&pwid="+pwid+"&retid="+retid+"&retname="+retname;
	showModal(url,'600px','480px');
	return false;
}
//选择经手人
function selectuser(){
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","480px");
}

//选择快递单
function selectLoco(){
	showModal("selectloco.jsf","580px","460px");
}

//输入快递点击enter后自动提交
function formsubmit(){
	if (event.keyCode==13){
		addDetail();
	}
}

function initload(){
	$("edit:loco").value="";
}

function clearText(){
	$("edit:biid").value="自动生成功";
	$("edit:whid").value="";
	$("edit:opna").value="";
	$("edit:rema").value="";
}

//添加单据
function headAdd(){
	if($("edit:whid").value.Trim().length==0){
		alert("请输入存放的移动库位!");
		$("edit:whid").focus();;
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加单据完成
function endHeadAdd(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("成功")!=-1){
		window.location.href="aftersingle_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
}

//添加明细
function addDetail(){
	if($("edit:loco").value.Trim().length==0){
		alert("请输入快递单号!");
		$("edit:loco").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddDetail1(){
	var msg = $("edit:msg").value
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		$("edit:loco").focus();
	}
	Gwallwin.winShowmask("FALSE");
}

//删除明细
function delDetail(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value=arr;
		}
    }else{
	   	alert("请选择要删除的记录!");
	   	return false;
    }
	return true;
}
//完成删除明细
function endDelDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


//审核
function app(){
	if(!confirm("确定审核当前单据吗?")){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

//结束审核
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


//删除单据
function doDel(){
	if(confirm("确定要删除单据吗？")){
		$("edit:sellist").value = $("edit:biid").value;
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
function endDele(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		window.location.href="aftersingle.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}


//保存单据
function updateHead(){
	return headAdd();
}
//结束保存单据
function endUpdateHead(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


//首页
function deleteHeadAll(obj){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.Trim().length<=0){
		alert("请选择需要删除的单据!");
		return false;
	}else{
		if(confirm("确定要删除选中单据吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}
// 结束删除单据(首页)
function endDeleteHeadAll(){
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		alert($("edit:msg").value);
	}else if($("edit:msg").value.indexOf("<br>")!=-1){
		var msgs = $("edit:msg").value.split('<br>');
		var msg = "";
		for(i = 0;i < msgs.length;i++){
			msg += msgs[i] + "\n";
		}
		alert(msg);
	}else{
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}



