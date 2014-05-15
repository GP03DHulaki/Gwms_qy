//跳转到添加表头页面
function addNew(){
	 window.location.href='returnreceipt_add.jsf';
}
//添加表头清空
function initAdd(){   
   	textClear("edit","stus,stdt,stna,soco,soty,whna,whid,rema,msg,orid,orna,opna");
   	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
}
function initEdit(){
	textClear("edit","baco,qty,whid,msg");
}
function initDetail(){
if($('edit:batp:0')){
	t = new TailHandler('in');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	}
}
function endCode4DBean(){
	Gwallwin.winShowmask('FALSE');
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
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

function addHead(){
	if($("edit:buty").value.Trim().length==0 || $("edit:buty").value==""){
		alert("请选择业务类型");
		$("edit:buty").focus();
		return false;
	}
	if($("edit:soco").value.Trim().length==0 || $("edit:soco").value.Trim()==""){
		alert("请选择退货计划单号!");
		return false;
	}
	if($("edit:orna").value.Trim().length==0 || $("edit:orna").value.Trim()==""){
		alert("请选择组织架构!");
		return false;
	}
	if($("edit:whid").value.Trim().length==0 || $("edit:whid").value.Trim()==""){
		alert("请选择收货仓库!");
		return false;
	}
	if($("edit:stdt").value.Trim().length==0 || $("edit:stdt").value.Trim()==""){
		alert("请选择收货时间!");
		$("edit:stdt").focus();
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
		window.location.href="returnreceipt_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}





//选择组织架构
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna',"500px","450px");
	return false;
}

//选择退货计划单号
function selectformvoucherid(){
	showModal("selectfromvoucherid.jsf?retid=edit:soco&retwhid=edit:whid&retwhna=edit:whna","660px","520px");
}
//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+"&retid=edit:whid&retname=edit:whna"
	showModal(url);
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
//审核后
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//清空查询条件
function clearSearchKey(){
	$("edit:start_date").value="";
	$("edit:end_date").value="";
	$("edit:sk_biid").value="";
	$("edit:sk_flag").value="";
	$("edit:orid").value="";
}
 
function selectfromvoucherid(){
	showModal("selectfromvoucherid.jsf?","560px","450px");
}
 
 function selectWhousehouse(){
	var fromvoucherid=$("edit:nv_fromvoucherid").value;
	if(fromvoucherid==""){
		alert("请先选择来源单号");
	}else{
		var newurl="selectWhousehouse.jsf?&fromvoucherid="+fromvoucherid;
		showModal(newurl,"460px","500px");
	}
}
//选择商品
function selectInveAdd(){
	 var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }

    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco','580','520');
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=1&retid=edit:baco&ctype="+batp+"&whid=&dwhid=&soco=",'700px','520px');
    }
}
function startDo(){
	Gwallwin.winShowmask("TRUE");
}
//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=4,5,6,7,9&pwid=all&orid="+$('edit:orid').value+"&retid=edit:dwhid&retname="
	showModal(url);
	return false;
}

//编辑页面删除单据
function doDel(){
	if(confirm("确定要删除单据吗？")){
		$("edit:sellist").value = $("edit:biid").value;
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
//编辑页面删除单据后
function endDele(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		window.location.href="returnreceipt.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}

//保存单据
function updateHead(){
	Gwallwin.winShowmask("TRUE");
	return true;
}
//结束保存单据
function endUpdateHead(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//首页删除
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
//选择状态查询
function doSearch(){
	var obj =$("edit:sid");
	obj.onclick();
	return true;	
}

//添加明细
function addDetail(){
	if($("edit:baco").value.Trim().length<=0 || $("edit:baco").value==""){
		alert("请输入条码");
		$("edit:baco").focus();
		return false;
	}
	//if($("edit:whid").value.Trim().length<=0 || $("edit:whid").value==""){
	//	alert("请输入货位");
	//	$("edit:whid").focus();
	//	return false;
	//}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加明细后
function endAddDetail(){
	var msg = $("edit:msg").value;
	alert(msg);
	$("edit:baco").value="";
	Gwallwin.winShowmask("FALSE");
}


//删除明细
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
//删除明细后
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

//修改明细
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
//修改明细后
function endUpdateDetail(){
	if($("edit:msg").value.indexOf("修改成功")!=-1){
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
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
function selectuser()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
}


