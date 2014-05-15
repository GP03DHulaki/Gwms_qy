//跳转到添加表头页面
function addNew(){
	 window.location.href='stockopt_add.jsf';
}

//初始化Edit页面
function initEdit(){
	textClear('edit','baco,qty','N');
}
function initDetail(){
	if($('edit:qty')){
	t = new TailHandler('out');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	$('edit:baco').focus();
	}
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

//添加表头清空
function showMes_add(){   
   	textClear("edit","nv_fromvoucherid,vc_warehouseid,nv_remark,vc_warehouseid,msg","N");
   	
   	if($("edit:vc_voucherid")!=null){
		$("edit:vc_voucherid").value="自动生成";
	}
	if($("edit:nv_fromvoucher")!=null){
		$("edit:nv_fromvoucher").value="1";
	}
}
// 打开选择商品信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:baco');
	return false;
}
//审核前
function app(){
	if(confirm("确定要审核单据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
function selectWahod(){
	var url = '../../common/waho/waho.jsf?type=3,4,5,6&retid=edit:dwhid&retname=';
	showModal(url);
	return false;
}

//选择商品
function selectInveAdd(){
	//var url="../../common/stin/stin.jsf?retid=edit:baco&whid="+$('edit:whid').value+"";
	//var url="../../common/inve/inve.jsf?retid=edit:baco&retname="
	//showModal(url);
	//return false;
	var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
    //商品编码
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&dwhid="+dwhid,'710px','550px');
    //箱码
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&dwhid="+dwhid,'380px','450px');
    }
	return true;
}
//审核后
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//清空查询条件
function clearSearchKey(){
	$("edit:start_date").value="";
	$("edit:end_date").value="";
	$("edit:sk_voucherid").value="";
	$("edit:sk_fromvoucherid").value="";
	$("edit:ch_flag").value="";
	$("edit:crna").value="";
	$("edit:orid").value="";
	$("edit:whid").value="";
	$("edit:whna").value="";
}
function headCheck(){
	if($("edit:nv_fromvoucherid").value==""){
		alert("盘点计划不能为空");
		return false;
	}
	if($("edit:vc_warehouseid").value==""){
		alert("盘点库位不能为空");
		return false;
	}
	Gwallwin.winShowmask('TRUE');
	return true;
}
function endDo(){
   	Gwallwin.winShowmask('FALSE');
    var message =$('edit:msg').value;
  	alert(message); 
 	if(message.indexOf("添加成功")!=-1){	
 		window.location.href="stockopt_edit.jsf?time="+new Date().getTime();
 		return;
 	}
 	if(message.indexOf("单据刪除成功")!=-1){
 		window.location.href="stockopt.jsf";
 		return;
 	}
 }
 
 
 
function selectfromvoucherid(){
	showModal("selectfromvoucherid.jsf","600px","500px");
}
 
 function selectWhousehouse(){
	var fromvoucherid=$("edit:nv_fromvoucherid").value;
	if(fromvoucherid==""){
		alert("请先选择来源单号");
	}else{
		var newurl="selectWhousehouse.jsf?&fromvoucherid="+fromvoucherid;
		showModal(newurl,"600px","500px");
	}
}

function selectWaho(retid,retname){
	showModal('../../common/waho/waho.jsf?type=1&retid='+retid+'&retname='+retname+'&pwid=all');
	//alert($("edit:sk_warehouseID").value);
	return true;
}


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
		window.location.href="stockopt.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}

//保存单据
function updateHead(){
	return addHead();
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
function doSearch(){
	var obj =$("edit:sid");
	obj.onclick();
	return true;	
}


function onkeypressvalue(){
	if (event.keyCode==13)
	{
		var obj=$("edit:addDBut");
		obj.onclick();
		return true;
	}
}


function addDetail(){
	if($("edit:baco").value.Trim().length<=0){
		alert("请输入条码");
		$("edit:baco").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddDetail(){
	var msg = $("edit:msg").value;
	if(msg.indexOf("成功")!=-1){
		clearDetail();
	}
	else{
		alert(msg);clearDetail();
	}
	Gwallwin.winShowmask("FALSE");
}

function clearDetail(){
	$("edit:baco").value="";
	$("edit:qty").value="";
	$("edit:baco").focus();
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
	var qtys = Gtable.getcolvalues('gtable2','fqty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i]) ){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
		}
	}
	if(msg.length<=0){
		Gwallwin.winShowmask("TRUE");
		var updatedate = Gtable.getUpdateinfo('gtable2');
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


function firstDo(){
	t = new TailHandler('out');
	textClear('edit','baco,qty','N');
}



function endDetail(){
	Gwallwin.winShowmask('FALSE');
	var msg = $("edit:msg").value;
	if(msg!=""){
		alert(msg);
	}else{// 当添加明细成功时,消息为空串,此时不需要弹出对话框
		this.firstDo();
	}
} 

//删除多条表头同时删除明细
function doDelete(obj){
	var arr=Gtable.getselectid(obj);
	var ids= arr.split(',');
	if(ids.length>0){
		if(!confirm('确定删除选中的记录吗?')){
			return false;
		}else{
			$("edit:sellist").value=arr;
			Gwallwin.winShowmask('TRUE');
		}
	}else{
	   	alert("请选择要删除的记录!");
	   	return false;
	}
	return true;
}
function formsubmit()
{
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}
function startDo(){
	Gwallwin.winShowmask("TRUE");
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
function endLoad(){
	Gwallwin.winShowmask('FALSE');
}



