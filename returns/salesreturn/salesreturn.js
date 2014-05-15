//跳转到添加表头页面
function addNew(){
	 window.location.href='salesreturn_add.jsf';
}
//添加表头清空
function initAdd(){   
   	textClear("edit","soco,soty,whna,whid,stus,stna,rema,msg,socos,outorder,opna");
   	
   if($("edit:soty").value==""){
		$("st1").style.display="none";
		$("st2").style.display="none";
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

function startDo(){
	Gwallwin.winShowmask("TRUE");
}
function initEdit(){
	textClear("edit","baco,qty,whid,msg");
	
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
//初始化edit
function initDetail(){
if($('edit:batp:0')){
	t = new TailHandler('in');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	}
}
function addHead(){
	
	if($("edit:orid1").value.Trim().length==0 || $("edit:orid1").value==""){
		alert("组织架构不能为空！");
		return false;
	}
	if($("edit:whid").value.length==0 || $("edit:whid").value==""){
		alert("请选择退货入库仓库!");
		return false;
	}

	if($("edit:opna").value==""){
		if($("edit:opna").value.Trim().length==0 || $("edit:opna").value.Trim()==""){
			alert("经手人不能为空!");
			return false;
		}
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddHead(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	if(msg.indexOf("单据添加成功")!=-1){
		window.location.href="salesreturn_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}


//选择来源类型切换
function change(){
	if($("edit:soty").value=="RETURNPLAN"){
		$("st1").style.display="";
		$("st2").style.display="none";
	}else if($("edit:soty").value=="RETURNRECEIPT"){
		$("st2").style.display="";
		$("st1").style.display="none";
	}
	else if($("edit:soty").value==""){
		$("st1").style.display="none";
		$("st2").style.display="none";
		$("edit:soco").value="";
	}
}




// 打开选择出库订单
function selectoutorder(){
	showModal('../../common/outorder_sel/outorder_sel.jsf?&stus=edit:stus&retvid=edit:outorder&stna=edit:stna');
	return false;
}

//选择退货计划单号
function selectformvoucherid(){
	if($("edit:soty").value=="RETURNPLAN"){
		showModal("selectfromvoucherid.jsf?edit:soco=","550px","500px");
	}
	if($("edit:soty").value=="RETURNRECEIPT"){
		showModal("selectreceiptfromvoucherid.jsf?","560px","500px");
	}
}
//选择组织架构
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}
//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&retid=edit:whid&retname=edit:whna"
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
	$("edit:sk_flag").value="";
	$("edit:sk_soco").value="";
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
	 var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }

    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco','580','520');
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=1&retid=edit:baco&ctype="
    	+batp+"&whid=&dwhid=&soco=",'730px','520px');
    }
    
	return false;
}
//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=4,5,6,7,8,9&pwid="+$('edit:fwhid').value+"&orid="+$('edit:orid').value+"&retid=edit:dwhid&retname="
	showModal(url,"500px","500px");
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
		window.location.href="salesreturn.jsf";
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
	if($("edit:dwhid").value.Trim().length<=0 || $("edit:dwhid").value==""){
		alert("请输入货位");
		$("edit:dwhid").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加明细后
function endAddDetail(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
	$("edit:baco").value="";
	$("edit:baco").focus();
	//$("edit:drema").value="";
	}else{$("edit:baco").value="";}
	
}
//清空明细数据
function clareDetail(){
	$("edit:baco").value="";
	$("edit:drema").value="";
	$("edit:whid").value="";
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
function selectCheckuserid()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
}


function downloadmb(){
	//获取主机地址之后的目录，
    var pathName=window.document.location.pathname;
    //获取带"/"的项目名，
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
	window.open( projectName+'/excel/purchasereturndetail.xls','newwindow');
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
