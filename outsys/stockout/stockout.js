<!--
function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function endDo(){
	Gwallwin.winShowmask('FALSE');
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="stockout_edit.jsf";
    }else{
    	alert(message);
    }
}

function printReport(){
	Gwallwin.winShowmask('TRUE');
}
function endPrintReport(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("打印成功")!=-1){
		var filename=$("edit:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}
	Gwallwin.winShowmask('FALSE');
}

function printReportPackage(){
	Gwallwin.winShowmask('TRUE');
}
function endPrintReportPackage(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("打印成功")!=-1){
		var filename=$("edit:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}
	Gwallwin.winShowmask('FALSE');
}

function printReportLt(){
	Gwallwin.winShowmask('TRUE');
}
function endPrintReportLt(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("打印成功")!=-1){
		var filename=$("edit:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}
	Gwallwin.winShowmask('FALSE');
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
	window.location.href = "stockout_add.jsf";
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
		window.location.href="saleorder_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
}
	
function addHead(){
	if($("edit:soco")==null || $("edit:soco").value.Trim().length<=0){
		alert("来源单号不能为空!");
		return false;
	}
	if($("edit:whid")==null || $("edit:whid").value.Trim().length<=0){
		alert("出库仓库不能为空!");
		return false;
	}
	/*
	if($("edit:opna")==null || $("edit:opna").value.Trim().length<=0){
		alert("经手人不能为空!");
		return false;
	}
	*/
	Gwallwin.winShowmask("TRUE");
	return true;
}




//删除明细
function delDetail(obj){
	var arr = Gtable.getselcolvalues(obj,"roid");
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			while(arr.indexOf("#@#")!=-1){
				arr= arr.replace("#@#",",");
			}
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

// 打开选择信息页面
function selectInve(){
	showModal("../../common/stin/stin.jsf?retid=edit:inco&whid="+$('edit:dwhid').value+"&retname=",'560px');
	return false;
}

// 打开选择库位页面
function selectWaho(){

	var orid = $('edit:orid').value;
	var soco = $('edit:soco').value;
	if(soco.Trim() == ""){
		alert('请先选择来源单据!');
		return false;
	}
	showModal('../../common/waho/waho.jsf?type=1&pwid=all&retid=edit:whid&retname=edit:whna&orid=%');
	return true;
}


// 打开出库订单选择页面
function selectFrom(){
	var key = $('edit:soty').value;
	showModal(urlmap.Get(key));
	return false;
}

function selectDWare(){
	var orid = $('edit:orid').value;
	showModal('../../common/waho/waho.jsf?type=3&pwid='+$('edit:whid').value+'&retid=edit:dwhid&orid='+orid+'&rename=edit:dwhna');
	$('edit:inco').value='';
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
		window.location.href = "stockout.jsf";
	}else if($("edit:msg").value.indexOf("<br>")!=-1){
		var msgs = $("edit:msg").value.split('<br>');
		var msg = "";
		for(i = 0;i < msgs.length;i++){
			msg += msgs[i] + "\n";
		}
	}	
}

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:dwhid")==null || $("edit:dwhid").value.Trim().length<=0){
		alert("库位不能为空!");
		$("edit:dwhid").focus();
		return false;
	}
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("条码不能为空!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("数量只能是正整数!");
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
	if(msg.indexOf("添加成功")!=-1){
		initAdd();
		$("edit:baco").focus();
	}else{
		alert(msg);
		initAdd();
	}
	Gwallwin.winShowmask("FALSE");
}

function initAdd(){
	var batp = t.getBatp();
	if( batp=='02' || (batp=='04' && t.getIsAutoAdd()=='0') ){
		textClear('edit','baco,qty','Y');
	}else{
		textClear('edit','baco','Y');
	}
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
	Gwallwin.winShowmask("FALSE");
	var msg = $('edit:msg').value;
	//alert(msg.replaceAll('<p>','\n') );
	mes.innerHTML = msg;
	Gwallwin.winShow('errmsg','信息提示',350);
}

function initEdit(){
	textClear('edit','dwhid,baco,qty','Y');
}


function cleartext(){
	if($("edit:soco")!=null||$("edit:soco").value.trim().length>0){
		$("edit:soco").value="";	
		$("edit:soco").focus();
	}
	if($("edit:opna")!=null||$("edit:opna").value.trim().length>0){
		$("edit:opna").value="";	
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

//初始化edit
function initDetail(){
	if($('edit:qty')){
	t = new TailHandler('out');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	}
}

// 打开选择库位页面
function selectWahod(){
	var url = "../../common/waho/waho.jsf?type=4,5,6&pwid="+$('edit:whid').value+"&retid=edit:dwhid&retname=";
	showModal(url);
	return false;
}
// 打开选择条码
function selectCode(){
	/*
    if(i==Obj.length){
    	alert("没有选择条码类型！");
    	return false;
    }
    */
	var time = new Date().getTime();
    var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,'528px');
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=0&retid=edit:baco&ctype="
    	+batp+"&time="+time,'724px','528px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=1&retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'380px','450px');
    }
	return true;
}

function endCode4DBean(){
	endLoad();
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
	}
}
function selectuser(){
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","520px");
}