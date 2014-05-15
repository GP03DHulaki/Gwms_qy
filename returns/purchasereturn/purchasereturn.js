//跳转到添加表头页面
function addNew(){
	 window.location.href='purchasereturn_add.jsf';
}
//添加表头清空
function initAdd(){   
   	textClear("edit","soco,whna,whid,rema,msg,opna");
   	
   	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
}
function initEdit(){
	textClear("edit","baco,qty,dwhid,msg",'Y');
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
	if($("edit:soty").value.Trim().length==0 || $("edit:soty").value.Trim()==""){
		alert("请选择来源单据业务类型!");
		$("edit:soty").focus();
		return false;
	}	
	if($("edit:soco").value.Trim().length==0 || $("edit:soco").value.Trim()==""){
		alert("请选择采购退货计划单号!");
		return false;
	}
	if($("edit:opna").value.Trim().length==0||$("edit:opna").value.Trim()==""){
		alert("经手人不能为空!");
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
		window.location.href="purchasereturn_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}

function startDo(){
	Gwallwin.winShowmask("TRUE");
}

//初始化edit
function initDetail(){
	if($('edit:qty')){
	t = new TailHandler('out');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	$('edit:dwhid').focus();
	}
}
// 打开选择供应商页面
function selectstus(){
	showModal('../../common/suin/suin.jsf?retid=edit:stus&retname=edit:stna');
	return false;
}
//选择退货计划单号
function selectformvoucherid(){
	showModal("selectfromvoucherid.jsf","670px","480px");
}
//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+$('edit:orid').value+"&retid=edit:whid&retname=edit:whna"
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
	$("edit:ch_start_date").value="";
	$("edit:ch_end_date").value="";
	$("edit:sk_biid").value="";
	$("edit:sk_soco").value="";
	$("edit:sk_flag").value="";
	$("edit:orid").value="";
	$("edit:crna").value="";
	$("edit:chna").value="";
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
	var url="../../common/stin/stin.jsf?retid=edit:baco&whid="+$('edit:dwhid').value+"";
	showModal(url,'800px');
	return false;
}
//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=3,4,5,6,8&pwid="+$('edit:fwhid').value+"&orid="+$('edit:orid').value+"&retid=edit:dwhid&retname="
	showModal(url,'','520');
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
		window.location.href="purchasereturn.jsf";
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
	if($("edit:dwhid").value.Trim().length<=0 || $("edit:dwhid").value==""){
		alert("请输入货位");
		$("edit:dwhid").focus();
		return false;
	}
	if($("edit:baco").value.Trim().length<=0 || $("edit:baco").value==""){
		alert("请输入条码");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty").value.Trim().length<=0){
		alert("请输入数量");
		$("edit:qty").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加明细后
function endAddDetail(){
	var msg = $("edit:msg").value
	if(msg.indexOf("添加成功")!=-1){
	}else{
		alert(msg);
		$("edit:baco").value="";
		$("edit:baco").focus();
	}
	Gwallwin.winShowmask("FALSE");
}
//清空明细数据
function clareDetail(){
	$("edit:baco").value="";
	$("edit:qty").value="";
	$("edit:dwhid").value="";
}

//删除明细
function delDetail(obj){
	var roids = Gtable.getselcolvalues('gtable','roid');
	if(roids.length>0){	
		if(confirm("确定要删除你当前选中的记录吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = roids.split("#@#").join(",");
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
		clareDetail();
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
function endCode4DBean(){
	Gwallwin.winShowmask('FALSE');
	if($('edit:msg').value != ''){
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
	}
}

function showImport(){
	$("mes").innerHTML="";
	Gwallwin.winShow("import","选择导入文件");	
}
function doImport(){
	var flag=true;
	var file=$("file:upFile").value;
	var filelength = file.length;
	var filetype = file.indexOf('.xls');
	if(file==""){
		$("mes").innerHTML="<Font Color=\"red\"><B>请选择上传的文件!<B></Font>";
		return false;
	}
	if(filetype==-1 || (filelength-filetype)!=4 ){
		$("mes").innerHTML="<Font Color=\"red\"><B>上传的文件必须是xls类型!<B></Font>";
		return false;
	}else{
		$("mes").innerHTML="数据导入中......";
	}
	$("file:import").disabled=true;
	startDo();
	$("file:importBut").click();
	return flag;
}

//隐藏层
function Close(){
	var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
	isGwin ? Gwin.close(document.GwinID) : window.close();
	return true;	
}
function downloadmb(){
	//获取主机地址之后的目录，
    var pathName=window.document.location.pathname;
    //获取带"/"的项目名，
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	window.open( projectName+'/excel/purchasereturndetail.xls','newwindow');
}