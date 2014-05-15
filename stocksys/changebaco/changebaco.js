<!--
function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}
function printReport(){
	Gwallwin.winShowmask('TRUE');
}

function endDo(){
	var message = $("edit:msg").value;
	if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="changebaco_edit.jsf";
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

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
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
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			textClear('edit','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('edit','sk_biid,sk_crna,sk_start_date,sk_end_date,sk_flag,orid');
	}
}

function doDeleteDetail(obj){
	var ids = Gtable.getselectid(obj);
	//var ids = Gtable.getselcolvalues(obj,'hid_voucherid');
	if(ids.length>0){
		if(confirm("确定要打印当前你选中的记录吗？")){
		startDo();
			$("edit:deleteitemid").value=ids;
			return true;
		}else{
		Gwallwin.winShowmask("FALSE");
			return false;
		}
	}else{
		alert("请选择你要打印的订单记录!");
		Gwallwin.winShowmask("FALSE");
		return false;
	}
}

function clear(){
	if(null!=$("edit:opna")){
		$("edit:opna").value="";
	}
	/*
	if(null!=$("edit:whid")){
		$("edit:whid").value="";
	}
	if(null!=$("edit:whna")){
		$("edit:whna").value="";
	}
	*/
	if(null!=$("edit:rema")){
		$("edit:rema").value="";
	}if(null!=$("edit:biid")){
		$("edit:biid").value="自动生成";
		$("edit:opna").focus();
	}
}

function cleartext(){
	if(null!=$("edit:inco")){
		$("edit:inco").value="";
	}
	if(null!=$("edit:inna")){
		$("edit:inna").value="";
	}
	
	
}
function initAdd(){
   if(null!=$("edit:biid")){
        $("edit:biid").value="自动生成";
	}
	if(null!=$("edit:whna")){
		$("edit:whna").value="";
		$("edit:whid").value="";
	}
	if(null!=$("edit:rema")){
		$("edit:rema").value="";
	}
}
//跳转添加
function addNew(){
	window.location.href = "changebaco_add.jsf";
}

function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
}

//添加单据完成
function endHeadAdd(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("成功")!=-1){
		window.location.href="changebaco_edit.jsf";
	}else{
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}
	
function addHead(){
	if($("edit:opna")==null||$("edit:opna").value.Trim().length<=0){
		alert("经手人不能为空!")
		$("edit:opna").focus();
		return false;
	}
	if($("edit:whid")==null||$("edit:whid").value.Trim().length<=0){
		alert("变更仓库不能为空!")
		$("edit:whid").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

function addDetail(){
	var num = /^[1-9][0-9]*$/;
	if($("edit:soty").value=='01'){
		if($("edit:whid1")==null || $("edit:whid1").value.Trim().length<=0){
			alert("库位不能为空!");
			$("edit:whid1").focus();
			return false;
		}
	}
	
	
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("原有的物料编码不能为空!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:obco")==null || $("edit:obco").value.Trim().length<=0){
		alert("变更后的物料编码不能为空！");
		$("edit:obco").focus();
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
//完成删除明细
function endDelDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function hideDiv(){
	Gwallwin.winClose();		
}

//删除单据(首页)
function deleteHeadAll(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
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
		window.location.href = "changebaco.jsf";
	}
}

// 批量添加明细
function addDetails(){
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
function endAddDetails(){
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

// 完成添加明细
function endAddDetail(){
	var msg = $("edit:msg").value
	alert(msg);
	if(msg.indexOf("添加成功")!=-1){
		$("edit:whid1").value = "";
		$("edit:baco").value="";
		$("edit:obco").value="";
		$("edit:whid1").focus();
	}
	Gwallwin.winShowmask("FALSE");
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


//花色转换
function transfercolor(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('请确认要变更花色的商品的数量!')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value=arr;
			//alert($("edit:sellist").value);
		}
    }else{
	   	alert("请选择需要转换花色的商品!");
	   	return false;
    }
	return true;
}

//完成删除明细
function endtransfercolor(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[0-9]\d*$/;
	var num1 = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行计划数量格式错误!  \n";
		}
	}

	if(msg.length<=0){
		Gwallwin.winShowmask("TRUE");
		var updatedate = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedate;
	   	
	   	return true;
	}else{
		alert(msg);
		return false;
	}
	return true;
}

//结束添加明细
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function initEdit(){
	clearDetail();
}


function clearDetail(){
	if(null!=$("edit:whid1")){
		$("edit:whid1").value="";
	}
	
	if(null!=$("edit:baco")){
		$("edit:baco").value="";
	}
	if(null!=$("edit:obco")){
		$("edit:obco").value="";
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

//清空商品选择页面筛选的值

function clearwhao(){
	var id = $("edit:id");
	var name = $("edit:name");
	if(id!=null){
		id.value=""
		id.focus();
	}
	if(name!=null){
		name.value="";
	}
	
}


//清空变更前商品 筛选条件的值
function clearMaterials1(){
	if($("edit:materials")!=null){
		$("edit:materials").value="";
		$("edit:materials").focus();
	}

}

//清空变更后商品筛选条件的值
function clearMaterials2(){
	if($("edit:amaterials")!=null){
		$("edit:amaterials").value="";
		$("edit:amaterials").focus();
	}
	if($("edit:name")!=null){
		$("edit:name").value="";
	}
}


// 打开选择库位页面(主页面)
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna&pwid=all');
	return false;
}

// 打开选择库位页面(明细表页面)
function selectWaho1(soty){
	var whid = $("edit:whid").value;
	if(soty=='01'){
		showModal('../../common/waho/waho.jsf?type=4,6&retid=edit:whid1&pwid='+whid);
	}else if(soty=='02'){
		showModal('../../common/waho/waho.jsf?type=8&retid=edit:whid1&pwid='+whid);
	}
	return false;
}


// 选择变更前商品编码
function beforechange(){
	var number=$("edit:whid1").value;
	showModal('beforechangebaco.jsf?retid=edit:baco&pwid='+number,'550','500');
	return false;
}

//选择变更后商品编码
function afterchange(){
	var baco = $("edit:baco").value;
	showModal('afterchangebaco.jsf?retid=edit:obco&pwid1='+baco,'720','500');
	return false;
}

function selectThis(parm1){
   	retid = $("edit:retid").value;
   	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
   	if ( retid != "" && retid != null){
 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}if(isGwin === false){
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
	isGwin ? Gwin.close(document.GwinID) : window.close();	
}
function selectuser()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
}

var t;

//初始化edit
function initDetail(){
	t = new TailHandler('out');
	$('edit:batp:1').checked = true;
	t.setBatp('04');
}

// 打开选择条码
function selectCode(baco){
	/*
    if(i==Obj.length){
    	alert("没有选择条码类型！");
    	return false;
    }
    */
    var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid='+baco,600,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid="+baco+"&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'720px','550px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid="+baco+"&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'380px','450px');
    }
	return true;
}

