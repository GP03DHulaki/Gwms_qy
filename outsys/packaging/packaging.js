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

//选择组织架构
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
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


 function cleartext(){
 	if($("edit:inco")!=null){
 		$("edit:inco").value = "";
 	}
 	if($("edit:qty")!=null){
 		$("edit:qty").value = "";
 		$("edit:inco").focus();
 	}
 	if($("edit:boco")!=null){
 		$("edit:boco").value = "";
 		$("edit:inco").focus();
 	}
 }

function endLoad(){
	Gwallwin.winShowmask('FALSE');
}


function Edit(vc_voucherid){	
	if($("edit:biid")!=null){
		$("edit:biid").value=vc_voucherid;
	}
	$("edit:editbut").click();
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
		textClear('edit','sk_biid,sk_crna,sk_start_date,sk_end_date,sk_flag');
	}
}



//跳转添加
function addNew(){
	window.location.href = "packaging_add.jsf";
}

function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
}
//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&retid=edit:whid&retname=edit:whna"
	showModal(url);
	return false;
}

function addHead(){
	if($("edit:soco").value=="" || $("edit:soco").value.length==0){
		alert("请输入来源单号");
		return false;
	}
	if($("edit:orid").value=="" || $("edit:orid").value.length==0){
		alert("请选择组织架构!");
		return false;
	}
	if($("edit:whid").value=="" || $("edit:whid").value.length==0){
		alert("请输入仓库");
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
		window.location.href="packaging_edit.jsf";
	}else{
	
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
//打包判断
function addpackage(obj){
	//var dids = Gtable.getselectid(obj);
	//alert(dids);
	//alert(obj);
	Gwallwin.winShowmask("TRUE");
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


//选择物理条码
function selectBarcodes(){
	var url="selectbarcode.jsf";
	showModal(url);
}


// 打开来源单号选择界面
function showAddDetail(){
	showModal('addpackage.jsf','700','550');
}

//打开出库订单页面
function selectOrder(){
	showModal('../../common/orderselect/orderselect.jsf?retid=edit:soco&retid2=edit:whid');
}

function selectOrders(){
	var soty = $("edit:soty").value;
	if(soty=='OUTORDER'){
		showModal('selectOrder.jsf?retid=edit:soco&retid2=edit:whid');
	}else if(soty=='otheroutplan'){
		showModal('otheroutplan.jsf?retvid=edit:soco&retorid=edit:orid');
	}
}


//打开包条码
function selectPackNo(){
	showModal('selectBaco.jsf');
}


function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco','560','440');
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
		window.location.href = "packaging.jsf";
	}
}

// 批量添加明细
function addDetails(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(incos.length<=0){
		alert("请选择需要添加的物料!");
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

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("物料条码不能为空!");
		$("edit:inco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("物料数量只能是正整数!");
			$("edit:qty").select();
			return false;
		}
	}
	
	Gwallwin.winShowmask("TRUE");
	return true;
}

// 完成添加明细
function endAddDetail(){
	var msg = $("edit:msg").value
	alert(msg);
	if(msg.indexOf("添加成功")!=-1){
		$("edit:inco").value = "";
		$("edit:qty").value = "";
		$("edit:inco").focus();
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

//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[0-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
		for(j=0;j<qty.length;j++){
		if(num.test(qty[j])&&qty[j]==0){
			msg += "第"+(j+1)+"包装数量为0! \n";
		}
	}
	
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
}

//结束添加明细
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function initEdit(){
	textClear('edit','baco,qty','N');
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
	if($("edit:soco")!=null|| $("edit:soco").value.Trim().length<=0){
		$("edit:soco").value="";
	}if($("edit:opna")!=null|| $("edit:opna").value.Trim().length<=0){
		$("edit:opna").value="";
	}if($("edit:rema")!=null|| $("edit:rema").value.Trim().length<=0){
		$("edit:rema").value="";
		$("edit:soco").focus();
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

function selectOther(parm1) {
	window.dialogArguments.document.getElementById("edit:soco").value=parm1;
	window.close();
}


function endDeleleDetail(){
	var msg = $("edit:msg").value
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}



//初始化edit
function initDetail(){
	if($('edit:qty')){
		t = new TailHandler('out');
		$('edit:batp:0').checked = true;
		$('edit:qty').value='1';
		$('edit:autoItem').value='0';
	}
}


function endCode4DBean(){
	Gwallwin.winShowmask('FALSE');
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:inco').value="";
		$('edit:inco').focus();
		$('edit:inco').select();
	}else{
		$('edit:qty').focus();
	}
}