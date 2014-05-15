///列表页面/
function startDo(){
	Gwallwin.winShowmask("TRUE");
}
function clearSearchKey(){
	$("edit:start_date").value="";
	$("edit:end_date").value="";
	$("edit:sk_biid").value="";
	$("edit:sk_flag").value="";
	$("edit:inco").value="";
	$("edit:orid").value="";
}

function formsubmit(){
	if(event.keyCode==13){
		var obj =$("edit:sid");
		obj.onclick();
		return true;		
	}
}

function doSearch(){
	var obj =$("edit:sid");
	obj.onclick();
	return true;		
}

/////////////////////////新增////////////////////////////////////
//打开新增表头界面
function addNew(){
	window.location.href="move_add.jsf";
}


function addHead(){
	var whna = $("edit:whna").value;
	if(whna.length==0 || whna==""){
		alert("请选择移库仓库!");
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddHead(){

	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	if(msg.indexOf("单据添加成功")!=-1){
		window.location.href="move_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
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
	if(null!=$("edit:orna")){
		$("edit:orna").value="";
		$("edit:orid").value="";
	}
}

function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+$('edit:orid').value+"&retid=edit:whid&retname=edit:whna"
	showModal(url);
	return false;
}
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}




////////////////////////////////////编辑////////////////////////////////////////////////////

function selectWahod(){
	var url = "../../common/waho/waho.jsf?type=4,5,6,7,9,13&orid="+$('edit:orid').value+"&pwid="+$('edit:whid').value+"&retid=edit:fhid&retname=";
	showModal(url);
	return false;
}
function selectWahod2(){
	var url = "../../common/waho/waho.jsf?type=4,5,6,7,9,13&orid="+$('edit:orid').value+"&pwid="+$('edit:whid').value+"&retid=edit:owid&retname=";
	showModal(url);
	return false;
}

function selectInveAdd(){
	var url="../../common/stin/stin.jsf?retid=edit:inco&whid="+$('edit:fhid').value+"";
	showModal(url);
	return false;
}

function initEdit(){
	clareDetail();
}

function updateHead(){
	addHead();
	
}
function endUpdateHead(){
	endAddHead();
	
}

function clareDetail(){
	if(null!=$("edit:owid")){
		$("edit:owid").value="";
	}
	if(null!=$("edit:qty")){
		$("edit:qty").value="";
	}
	if(null!=$("edit:inco")){
		$("edit:inco").value="";
	}
	if(null!=$("edit:fhid")){
		$("edit:fhid").value="";
	}
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
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href = "move.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}
//首页
function deleteHeadAll(obj){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.length<=0){
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

function app(){
	if(confirm("确定要审核单据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
function addDetail(){
	if($("edit:fhid").value.Trim().length<=0){
		alert("请输入移出库位");
		$("edit:fhid").focus();
		return false;
	}
	if($("edit:inco").value.Trim().length<=0){
		alert("请输入条码");
		$("edit:inco").focus();
		return false;
	}

	if($("edit:owid").value.Trim().length<=0){
		alert("请输入移入库位");
		$("edit:owid").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddDetail(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("添加成功")==-1){
		clareDetail();
	}
	Gwallwin.winShowmask("FALSE");
}

/////////////////明细操作////////////////
function delDetail(obj){
	var dids = Gtable.getselectid(obj);
	if(dids.length>0){	
		if(confirm("确定要删除你当前选中的记录吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = dids;
			return true;
		}
	}else{
		alert("请选择你要删除的记录");
		return false;
	}
}
function endDelDetail(){
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

function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i]) ){
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

function endUpdateDetail(){
	if($("edit:msg").value.indexOf("修改成功")!=-1){
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}

function selectCode(){
	var fbid =$('edit:fhid').value;
	 if(fbid=='' ||fbid==null){
		 alert("请先选择移出库位.");
		 return false;
	 }
		 
	var batp='';
    if($('edit:radio:0').checked==true){
    	batp='04';
    }
    else if($('edit:radio:1').checked==true){
    	batp='02';
    }
    else {
    	alert('请选择条码类型!');
    	return;
    }
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
   
	if(batp == '02'){
    	showModal("barcode_sel.jsf?stat=1&retid=edit:inco&retqty=edit:qty&ctype="
    	+batp+"&whid="+fbid,'680px','500px');
    }else if(batp == '04'){
    	showModal("barcode_sel.jsf?stat=1&retid=edit:inco&retqty=edit:qty&ctype="
    	    +batp+"&whid="+fbid,'680px','500px');
    }
	return true;
}
function autoFill(){
	var obj = "edit:fhid,edit:inco,edit:owid";
	if($('edit:autoItem').value=='1'){
		addEvent(obj,autoSubmit);
	}
	else{
		removeEvent(obj,autoSubmit);
	}
}
function autoSubmit(event){
	var objs = "edit:fhid,edit:inco,edit:owid".split(",");
	for(var o in objs){
		if($(objs[o])==null||$(objs[o]).value==""){
			return;
		}
	}
	var e=window.event||event;
	var key=window.event?e.keyCode:e.which;
	if(key==13)
	$("edit:addDBut").click();
}
function addEvent(obj,func){
	var objs = obj.split(",");
	for(var o in objs){
		if($(objs[o])){
			if(window.attachEvent)
    			$(objs[o]).attachEvent('onkeyup',func);
			else
   				$(objs[o]).addEventListener('keyup',func,false);
		}
		
	}
}
function removeEvent(obj,func){
	var objs = obj.split(",");
	for(var o in objs){
		if(window.attachEvent)
    			$(objs[o]).detachEvent('onkeyup',func);
			else
   				$(objs[o]).removeEventListener('keyup',func,false);
	}
}

var retid = "", dwhid = "",retqty="";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2, parm3) {
	retid = $("edit:retid").value;
	dwhid = $("edit:dwhid").value;
	retqty = $('edit:retqty').value;
	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
	if(isGwin === false){
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
	if ( retid != "" && retid != null){
 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	if (retqty != "" && retqty != null) {
		parm3 = parseInt(parm3);
		isGwin ? parent.document.getElementById(retqty).value = parm3 : callBack.document.getElementById(retqty).value = parm3;
	}
	if(callBack && callBack.document.getElementById('edit:setCode4DBean')){
		callBack.document.getElementById('edit:setCode4DBean').onclick();
	}else{
		if(parent.document.getElementById('edit:setCode4DBean')!=null){
			parent.document.getElementById('edit:setCode4DBean').onclick();
		}
		
		
	}
	isGwin ? Gwin.close(document.GwinID) : window.close();	
}

function formsubmit() {
	if (event.keyCode == 13) {
		var obj = $("edit:sid");
		obj.onclick();
		return true;
	}
}

function cleartext() {
	var a = $("edit:id");
	var b = $("edit:sk_inco");
	if (a != null) {
		a.value = "";
		a.focus();
	}
	if (b != null) {
		b.value = "";
	}
}

