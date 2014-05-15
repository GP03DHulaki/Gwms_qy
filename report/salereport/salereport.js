<!--
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

function endDo(){
	Gwallwin.winShowmask('FALSE');
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="picksche_edit.jsf";
    }else{
    	alert(message);
    }
}

function endLoad(){
	Gwallwin.winShowmask('FALSE');
}

function getVouch(){
	if($('edit:getvouch')){
		startDo();
		$('edit:getvouch').click();
	}
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
			textClear('list','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('list','sk_voucherid,start_date,end_date,sk_flag,sk_expressname,sk_barcode,sk_districtname,sk_customername,b_date,e_date');
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

//跳转添加
function addNew(){
	window.location.href = "picksche_add.jsf";
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
		window.location.href="picksche_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
}
	
function addHead(){
	/*
	if($("edit:soco")==null || $("edit:soco").value.Trim().length<=0){
		alert("来源单号不能为空!");
		return false;
	}
	if($("edit:whna")==null || $("edit:whna").value.Trim().length<=0){
		alert("出库仓库不能为空!");
		return false;
	}
	*/
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

// 打开选择物料信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco');
	return false;
}

// 打开选择库位页面
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna');
	return true;
}

// 打开出库订单选择页面
function selectFrom(){
	showModal('../../common/outorder_sel/outorder_sel.jsf?retvid=edit:soco&retorid=edit:orid');
	return false;
}

function selectDWare(){
	var orid = $('edit:orid').value;
	showModal('../../common/waho/waho.jsf?type=3&retid=edit:dwhid&orid='+orid+'&rename=');
	return false;
}

function selOutOrder(orid,moid){
	showModal('selectOrder.jsf?orid='+orid,'630px','560px');
	return false;
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
		window.location.href = "picksche.jsf";
	}
}

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("物料编码不能为空!");
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
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
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
	textClear('edit','inco,qty,dwhid','N');
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

function endAddOrder(){
	Gwallwin.winShowmask("FALSE");
	msg = $('edit:msg').value;
	//alert(msg.replaceAll('<p>','\n') );
	mes.innerHTML = msg;
	Gwallwin.winShow('errmsg','信息提示',350,null,null,5);
}

function endDelOrder(){
	parent.document.getElementById('edit:refBut').onclick();
	Gwallwin.winShowmask("FALSE");
	msg = $('edit:msg').value;
	//alert(msg.replaceAll('<p>','\n') );
	mes.innerHTML = msg;
	Gwallwin.winShow('errmsg','信息提示',350,null,null,5);
}

function selectFromId(obj){
	var arr=Gtable.getselcolvalues(obj,'biid');
	if(arr.length>0){		    	
		$('edit:sellist').value=arr;
		startDo();
		return true;
	}else{
	   	alert("请勾选单据!");
	   	return false;
	}
}



// 导出数据
function showOutput(tableid){
	var curTbl = $(tableid);
	var oXL = new ActiveXObject("Excel.Application");
	//创建AX对象excel
	var oWB = oXL.Workbooks.Add();
	//获取workbook对象
	var oSheet = oWB.ActiveSheet;
	//激活当前sheet
	var sel = document.body.createTextRange();
	sel.moveToElementText(curTbl);
	//把表格中的内容移到TextRange中
	sel.select();
	//全选TextRange中内容
	sel.execCommand("Copy");
	//复制TextRange中内容 
	oSheet.Paste();
	//粘贴到活动的EXCEL中
	oXL.Visible = true;
	//设置excel可见属性
}