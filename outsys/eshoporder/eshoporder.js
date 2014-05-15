<!--
var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1){
    	retid = $('edit:retid').value;
	  
    	if ( retid != "" && retid != null){
			window.dialogArguments.document.getElementById(retid).value=parm1;
		}
		window.close();	
    }


	function cleartext(){
		var a = $("edit:biid");
		if(a!=null){
			a.value="";
			a.focus();
		}

	}
function doSearch(){
	$("list:sid").click();
}


function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function printReport(){
	Gwallwin.winShowmask('TRUE');
}

//显示层
 function showDiv(title){
		Gwallwin.winShow("edit",title,430);	
	}
	
function addDiv(){
		clear();
		$("edit:updateflag").value = "ADD";
		showDiv("新增订单信息");
	}

//点击编辑按钮
function edit_show(){
		Gwallwin.winShowmask("FALSE");
		$("edit:updateflag").value="EDIT";
		$("edit:soco").disabled = "true";
		showDiv("编辑订单信息");
	}

function endDo(){
	var message = $("edit:msg").value;
	if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="eshoporder.jsf";
    }else{
    	alert(message);
    }
    Gwallwin.winShowmask('FALSE');
}

// 结束清除明细
function endClearDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}



function endLoad(){
	Gwallwin.winShowmask('FALSE');
}


function Edit(vc_voucherid){	
	if($("edit:soco")!=null){
	$("edit:selid").value = vc_voucherid;
	}
	$("edit:editbut").click();
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("list:sid").click();
}

function search(){
	Gwallwin.winShowmask("TRUE");
}

function endSearch(){
	Gwallwin.winShowmask("FALSE");
}

/**回车监听*/
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("list:sid");
		obj.onclick();
		return true;
	}
}

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){startDo
			textClear('edit','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('list','sk_crna,sk_start_date,sk_end_date,sk_flag,sk_soco,orid,cuna');
	}
}



//跳转添加
function addNew(){
	window.location.href = "eshoporder_add.jsf";
}

function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
}


//添加单据完成
function endHeadAdd(){
	alert($("list:msg").value);
	 window.close();
	Gwallwin.winShowmask("FALSE");
}
	
function addHead(){
	if($("edit:soco").value=="" || $("edit:soco").value.length==0){
		alert("请输入来源单号");
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
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
//打包判断
function addpackage(){
	Gwallwin.winShowmask("TRUE");
	return true;
}
function hideDiv(){
	Gwallwin.winClose();		
}


function selectOrder(){
	showModal('orderselect.jsf?retid=edit:soco');
}


function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco','560','440');
}
//删除单据(首页)
function deleteHeadAll(){
	var biids = Gtable.getselcolvalues('gtable','selall');
	alert(Gtable.getselcolvalues('gtable','selall'));
	if(biids.Trim().length<=0){
		alert("请选择需要删除的单据!");
		return false;
	}else{
		if(confirm("确定要删除选中单据吗?")){
			Gwallwin.winShowmask("TRUE");
			$("list:sellist").value = biids;
			return true;
		}
	}
}

function deleteAll(obj)	{		
		var arr=Gtable.getselectid(obj);
    	if(arr.length>0){		    	
    		if(!confirm('确定删除当前记录吗?')){
				return false;
			}else{
				$("list:sellist").value=arr;
			}
	   }else{
		   	alert("请选择要删除的记录!");
		   	return false;
	   }
	   return true;					
	}

// 结束删除单据(首页)
function endDeleteHeadAll(){
	if($("list:msg").value.indexOf("删除成功")!=-1){
		alert($("list:msg").value);
	}else if($("list:msg").value.indexOf("<br>")!=-1){
		var msgs = $("list:msg").value.split('<br>');
		var msg = "";
		for(i = 0;i < msgs.length;i++){
			msg += msgs[i] + "\n";
		}
		alert(msg);
	}else{
		alert($("list:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}

// 删除当前单据
function deleteHead(){
	if(!confirm("确定删除当前单据吗?")){
		return false;
	}
	$("edit:sellist").value = $("edit:biid").value;
	Gwallwin.winShowmask("TRUE");
	return true;
}
// 结束删除当前单据
function endDeleteHead(){
	Gwallwin.winShowmask("FALSE");
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href = "eshoporder.jsf";
	}
}

// 批量添加明细
function addDetail(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(incos.length<=0){
		alert("请选择需要添加的商品!");
		return false;
	}else{
		$("edit:sellist").value = incos;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}
//结束批量添加明细
function endAddDetail(){
	var msg = $("edit:msg").value
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	//var showTable = window.dialogArguments.document.getElementById("edit:showTable")
	//if(showTable != null){
	//	alert("执行");
	//	showTable.onclick();
	//}
	// window.close();

}

// 监听数量
function addDetailKey(){
	if (event.keyCode==13)
	{	
		if($("edit:addDBut")!=null){
			$("edit:addDBut").click();
		}
		return true;
	}
}

//审核
function checkApp(){
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

function clear(){
	if($("edit:soco")!=null|| $("edit:soco").value.Trim().length>=0){
		$("edit:soco").value="";
		//$("edit:soco").focus();
	}
	if($("edit:opna")!=null|| $("edit:opna").value.Trim().length>=0){
		$("edit:opna").value="";
	}if($("edit:rema")!=null|| $("edit:rema").value.Trim().length>=0){
		$("edit:rema").value="";
		
	}
}

//显示和隐藏扩展功能
function JS_ExtraFunction(){
	var extraFunction = document.getElementById("ExtraFunction");
	var detail_ctrl = document.getElementById("detail_ctrl");
	if(extraFunction.style.display=='none'){
		extraFunction.style.display="";
		detail_ctrl.className="ctrl_hide";
	}else{
		extraFunction.style.display="none";
		detail_ctrl.className="ctrl_show";
	}
}

