//跳转到添加表头页面
function addNew(){
	 window.location.href='purchasereturnplan_add.jsf';
}
//添加表头清空
function initAdd(){   
   	textClear("edit",",stdt,stus,stna,rema,msg,opna");
   	
   	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
}
function initEdit(){
	textClear("edit","inco,qty,whid,msg,incos");
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
	
	if($("edit:stdt").value.Trim().length==0 || $("edit:stdt").value.Trim()==""){
		alert("请选择退货时间!");
		$("edit:stdt").focus();
		return false;
	}
	if($("edit:whid").value.length==0 || $("edit:whid").value==""){
		alert("请选择退货出库仓库!");
		return false;
	}
	if($("edit:stus").value.Trim().length==0 || $("edit:stus").value.Trim()==""){
		alert("请选择退货商!");
		$("edit:stus").focus();
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
		window.location.href="purchasereturnplan_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}



// 打开选择供应商页面
function selectstus(){
	showModal('../../common/suin/suin.jsf?retid=edit:stus&retname=edit:stna');
	return false;
}
//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+$('edit:orid').value+"&retid=edit:whid&retname=edit:whna"
	showModal(url);
	return false;
}

//选择组织架构
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
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
//选择物料
function selectInveAdd(){
	var url="../../common/inve/inve.jsf?retid=edit:baco&retname="
	showModal(url);
	return false;
}
//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=3&pwid=all&orid="+$('edit:orid').value+"&retid=edit:whid&retname="
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
		window.location.href="purchasereturnplan.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}

//清空manyinve.jsp页面
function cleartext(){
	$("edit:id").value="";
	$("edit:name").value="";
	$("edit:colo").value="";
	$("edit:inst").value="";
}

// 批量添加明细
function addDetailincos(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	var biids = Gtable.getselcolvalues('gtable','biid');
	if(incos.length<=0){
		alert("请选择需要添加的商品!");
		return false;
	}else{
		retid = $('edit:retid').value;
		//alert(retid);
		var iscor = incos.split("#@#").join(",");
		var biids = biids.split("#@#").join(",");
		//iscor = iscor+"&"+scor;
		//alert(iscor);
		if(parent.window.document.getElementById(retid)!=null){
			parent.window.document.getElementById(retid).value = iscor;
	        if(parent.window.document.getElementById('edit:soco')!=null){
	        parent.window.document.getElementById('edit:soco').value = biids;	
			}
			parent.window.document.getElementById('edit:insertadds').click();
		}
	}
	window.close();	
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
//选择状态查询
function doSearch(){
	var obj =$("edit:sid");
	obj.onclick();
	return true;	
}

//添加明细
function addDetail(){
	$("edit:incos").value="";
	var url="manyinve.jsf?retid=edit:incos&retname="
	showModal(url,590,500);
	//insertin();
	return false;
}

function insertin(){
	Gwallwin.winShowmask("TRUE");
	if($("edit:incos").value.length==0){
		Gwallwin.winShowmask("FALSE");
		return false;
	}
	return true;
}

//添加明细后
function endAddDetail(){
	if($("edit:incos").value.length!=0){
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}


//删除明细
function delDetail(obj){
	var roids =  Gtable.getselcolvalues('gtable','roid');
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

// 清除明细表中数量为0的数据
function clearDetail(){
	if(confirm("确定清除明细表中数量为0的数据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
// 结束清除明细
function endClearDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//修改明细
function updateDetail(){
	Gwallwin.winShowmask("TRUE");
	var updatedate = Gtable.getUpdateinfo('gtable');
   	$("edit:updatedata").value = updatedate;
   	return true;
	
	var msg = "";
	var num = /^[0-9]*$/;
	var prnum = /^[0-9]*[.]?[0-9]*]$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var buprs = Gtable.getcolvalues('gtable','bupr');
	var qty = qtys.split("#@#");
	var bupr = buprs.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i]) ){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
		}
		if(!prnum.test(bupr[i]) ){
			msg += "第"+(i+1)+"行价格格式错误!  \n";
		}
	}
	if(msg.length<=0){
		
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



