//跳转到添加表头页面
function addNew() {
	window.location.href = "packbox_add.jsf";
}
//添加表头清空
function showMes_add() {
	textClear("edit", "boco,nv_remark,msg,soco", "N");
	if ($("edit:vc_voucherid") != null) {
		$("edit:vc_voucherid").value = "\u81ea\u52a8\u751f\u6210";
	}
	$('explain').style.left=70;
	$('explain').style.top=75;
	$('edit:soty').value='01';

}

function hiddenSpan(obj){
	$(obj).style.display  = 'none';
	$('edit:boco').focus();
}

function hiddenSoco(obj){
	var soty= obj.value;
	$('edit:soco').value='';
	if(soty=='01'){
		$('td_soco').style.display  = '';
	}else{
		$('td_soco').style.display  = 'none';
	}
}
//审核前
function app() {
	if (confirm("\u786e\u5b9a\u8981\u5ba1\u6838\u5355\u636e\u5417\uff1f")) {
		Gwallwin.winShowmask("TRUE");
		return true;
	} else {
		return false;
	}
}
//审核后
function endApp() {
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//清空查询条件
function clearSearchKey() {
	$("edit:start_date").value = "";
	$("edit:end_date").value = "";
	$("edit:sk_voucherid").value = "";
	$("edit:ch_flag").value = "";
}
function doDeleteDetail(obj) {
	var biids = Gtable.getselectid("gtable2");
	var dids=biids.split("#@#");
	if (biids.Trim().length <= 0) {
		alert("请选择需要删除的明细!");
		return false;
	} else {
		if (confirm("确定删除?")) {
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}
function headCheck() {
	/*
	if ($("edit:boco").value == "") {
		alert("\u7bb1\u7801\u4e0d\u80fd\u4e3a\u7a7a!");
		return false;
	}
	if ($("edit:whid").value == "") {
		alert("仓库不能为空!");
		return false;
	}*/
	Gwallwin.winShowmask("TRUE");
	return true;
}
function headCheck_update() {
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endDo() {
	Gwallwin.winShowmask("FALSE");
	var message = $("edit:msg").value;
	alert(message);
	if (message.indexOf("添加成功") != -1) {
		window.location.href = "packbox_edit.jsf";
		return;
	}
	if (message.indexOf("删除成功") != -1) {
		window.location.href = "packbox.jsf";
		return;
	}
}

function selectSoco(){
	showModal('selectSocoIntask.jsf?retid=edit:soco');
}
 
 
 //选择商品条码
 function selectBarcode(){
 	var url="selectbarcode.jsf";
 	showModal(url);
	return false;
 }
 
 //选择托盘
function selectPaco() {
	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:boco&ctype=02","500px","450px")
	return false;
}
function selectfromvoucherid() {
	showModal("selectfromvoucherid.jsf?", "560px", "450px");
}
function selectWhousehouse() {
	var fromvoucherid = $("edit:nv_fromvoucherid").value;
	if (fromvoucherid == "") {
		alert("\u8bf7\u5148\u9009\u62e9\u6765\u6e90\u5355\u53f7");
	} else {
		var newurl = "selectWhousehouse.jsf?&fromvoucherid=" + fromvoucherid;
		showModal(newurl, "460px", "500px");
	}
}
function doDel() {
	if (confirm("\u786e\u5b9a\u8981\u5220\u9664\u5355\u636e\u5417\uff1f")) {
		$("edit:sellist").value = $("edit:biid").value;
		Gwallwin.winShowmask("TRUE");
		return true;
	} else {
		return false;
	}
}
function endDele() {
	var msg = $("edit:msg").value;
	alert(msg);
	if (msg.indexOf("\u6210\u529f") != -1) {
		window.location.href = "packbox.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}

//保存单据
function updateHead() {
	return addHead();
}
//结束保存单据
function endUpdateHead() {
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//首页
function deleteHeadAll(obj) {
	var biids = Gtable.getselcolvalues("gtable", "biids");
	if (biids.Trim().length <= 0) {
		alert("\u8bf7\u9009\u62e9\u9700\u8981\u5220\u9664\u7684\u5355\u636e!");
		return false;
	} else {
		if (confirm("\u786e\u5b9a\u8981\u5220\u9664\u9009\u4e2d\u5355\u636e\u5417?")) {
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}
// 结束删除单据(首页)
function endDeleteHeadAll() {
	if ($("edit:msg").value.indexOf("\u5220\u9664\u6210\u529f") != -1) {
		alert($("edit:msg").value);
	} else {
		if ($("edit:msg").value.indexOf("<br>") != -1) {
			var msgs = $("edit:msg").value.split("<br>");
			var msg = "";
			for (i = 0; i < msgs.length; i++) {
				msg += msgs[i] + "\n";
			}
			alert(msg);
		} else {
			alert($("edit:msg").value);
		}
	}
	Gwallwin.winShowmask("FALSE");
}
function doSearch() {
	var obj = $("edit:sid");
	obj.onclick();
	return true;
}
function onkeypressvalue() {
	if (event.keyCode == 13) {
		var obj = $("edit:addDBut");
		obj.onclick();
		return true;
	}
}
function addDetail() {
	if ($("edit:baco").value.Trim().length <= 0) {
		alert("\u8bf7\u8f93\u5165\u6761\u7801");
		$("edit:baco").focus();
		return false;
	}
	if ($("edit:qty").value.Trim().length <= 0) {
		$("edit:qty").value = 1;
		<!--
		alert("\u8bf7\u8f93\u5165\u6570\u91cf");
		$("edit:qty").focus();
		return false;
		-->
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddDetail() {
	var msg = $("edit:msg").value;
	if(msg.indexOf("成功")<0){
		alert(msg);
	}
	//设置qty
	$("edit:baco").value = "";
	$("edit:baco").focus();
	Gwallwin.winShowmask("FALSE");
	/*
	if($('edit:batp:1').checked==true){
			$('edit:qty').value='';
	}
	*/
}
function clareDetail() {
	$("edit:baco").value = "";
	$("edit:qty").value = "";
	//$("edit:rema").value = "";
}
/////////////////明细操作////////////////
function delDetail(obj) {
	var dids = Gtable.getselectid(obj);
	if (dids.length > 0) {
		if (confirm("\u786e\u5b9a\u8981\u5220\u9664\u4f60\u5f53\u524d\u9009\u4e2d\u7684\u8bb0\u5f55\u5417\uff1f")) {
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = dids;
			return true;
		}
	} else {
		alert("\u8bf7\u9009\u62e9\u4f60\u8981\u5220\u9664\u7684\u8bb0\u5f55");
		return false;
	}
}
function endDelDetail() {
	if ($("edit:msg").value.indexOf("\u5220\u9664\u6210\u529f") != -1) {
		alert($("edit:msg").value);
	} else {
		if ($("edit:msg").value.indexOf("<br>") != -1) {
			var msgs = $("edit:msg").value.split("<br>");
			var msg = "";
			for (i = 0; i < msgs.length; i++) {
				msg += msgs[i] + "\n";
			}
			alert(msg);
		} else {
			alert($("edit:msg").value);
		}
	}
	Gwallwin.winShowmask("FALSE");
}
function updateDetail() {
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues("gtable2", "fqty");
	var qty = qtys.split("#@#");
	for (i = 0; i < qty.length; i++) {
		if (!num.test(qty[i])) {
			msg += "\u7b2c" + (i + 1) + "\u884c\u6570\u91cf\u683c\u5f0f\u9519\u8bef!  \n";
		}
	}
	if (msg.length <= 0) {
		Gwallwin.winShowmask("TRUE");
		var updatedate = Gtable.getUpdateinfo("gtable2");
		$("edit:updatedata").value = updatedate;
		return true;
	} else {
		alert(msg);
		return false;
	}
}
function endUpdateDetail() {
	if ($("edit:msg").value.indexOf("\u4fee\u6539\u6210\u529f") != -1) {
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}


//删除多条表头同时删除明细
function doDelete(obj) {
	var arr = Gtable.getselectid(obj);
	var ids = arr.split(",");
	if (ids.length > 0) {
		if (!confirm("\u786e\u5b9a\u5220\u9664\u9009\u4e2d\u7684\u8bb0\u5f55\u5417?")) {
			return false;
		} else {
			$("edit:sellist").value = arr;
			Gwallwin.winShowmask("TRUE");
		}
	} else {
		alert("\u8bf7\u9009\u62e9\u8981\u5220\u9664\u7684\u8bb0\u5f55!");
		return false;
	}
	return true;
}
function formsubmit() {
	if (event.keyCode == 13) {
		var obj = $("edit:sid");
		obj.onclick();
		return true;
	}
}

//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+$('edit:orid').value+"&retid=edit:whid&retname=edit:whna"
	showModal(url);
	return false;
}

// 打开选择库位页面
function selectWahod() {
	var type = '';
	if($("edit:soty").value == '01')
	{
		type = '8';
	}else
	{
		type = '4';
	}
	var url = "../../common/waho/waho.jsf?type="+type+"&retid=edit:dwhid&retname=";
	showModal(url);
	return false;
}



//初始化edit
function initDetail(){
	if($('edit:batp:0')){
		t = new TailHandler('out');
		$('edit:batp:0').checked = true;
		//$('edit:qty').value='1';
		t.setLastElement('edit:baco');
		$('edit:autoItem').value='0';
	}
}

//初始化Edit页面
function initEdit(){
	textClear('edit','dwhid,baco','Y');
}


//初始化Edit页面
function continueAdd(){
	textClear('edit','baco,qty','N');
}


function startDo(){
	Gwallwin.winShowmask("TRUE");
}

// 打开选择条码
function selectCode(){
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
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=0&retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'710px','550px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
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
		$('edit:baco').focus();
	}
}

function endLoad(){
	Gwallwin.winShowmask('FALSE');
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