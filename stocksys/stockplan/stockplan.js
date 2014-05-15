function addNew(){
	window.location.href="stockplan_add.jsf";
}
function valueChange(){
   	var pmmt=$("edit:pmmt").value;
   	if(pmmt=="01"){
   		$("warehouse").style.display="";
   		$("inventory").style.display="none";
   		$("edit:vc_warehouseid").value="";
   		$("edit:vc_invcode").value="";
   	}else if(pmmt=="02"){
   		$("warehouse").style.display="none";
   		$("inventory").style.display="";
   		$("edit:vc_warehouseid").value="";
   		$("edit:vc_invcode").value="";
   	}
}

// 查看盘点状态
 function showPath(){
 	Gwallwin.winShowmask("TRUE");
 	showModal("showStatus.jsf",'700','550');
 	Gwallwin.winShowmask("false");
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

function initload(){
 	var pmmt = $("edit:pmmt").value;
 	if(pmmt=="01"){
 		$("warehouse").style.display="";
   		$("inventory").style.display="none";
 	}if(pmmt=="02"){
 		$("warehouse").style.display="none";
   		$("inventory").style.display="";
 	}
}

function addHead(){
	var pmmt = $("edit:pmmt").value;
	if($("edit:waho").value.Trim().length==0 || $("edit:waho").value==""){
		alert("请选择要盘点的仓库!");
		return false;
	}
	if(pmmt=="01"){
		if($("edit:vc_warehouseid").value.Trim().length==0 || $("edit:vc_warehouseid").value==""){
			alert("请选择要盘点的货位!");
			$("edit:vc_warehouseid").focus();
			return false;
		}
	}
	if(pmmt=="02"){
		if($("edit:vc_invcode").value.Trim().length==0 || $("edit:vc_invcode").value==""){
			alert("请选择要盘点的商品!");
			$("edit:vc_invcode").focus();
			return false;
		}
	}
	
	if($("edit:opna").value.Trim().length==0 || $("edit:opna").value==""){
		alert("请选择操作人!");
		$("edit:opna").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

function endAddHead(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		window.location.href="stockplan_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}

function clearhead(){
	if(null!=$("edit:whna")){
		$("edit:whna").value="";
		$("edit:waho").value="";
	}
	if(null!=$("edit:vc_warehouseid")){
		$("edit:vc_warehouseid").value="";
	}
	if(null!=$("edit:vc_invcode")){
		$("edit:vc_invcode").value="";
	}
	if(null!=$("edit:vc_userid")){
		$("edit:vc_userid").value="";
	}

	if(null!=$("edit:rema")){
		$("edit:rema").value="";
	}
	if(null!=$("edit:pmmt")){
		$("edit:pmmt").value="01";
	}
	if(null!=$("edit:rsmt")){
		$("edit:rsmt").value="01";
	}
	if(null!=$("edit:opna")){
		$("edit:opna").value="";
	}
	
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
function dndDele(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		window.location.href="stockplan.jsf";
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

function startDo(){
    Gwallwin.winShowmask("TRUE");
}


//重置首页查询条件
function clearData(){
	if($("edit:sk_start_date")!=null){
		$("edit:sk_start_date").value = "";
	}
	if($("edit:sk_end_date")!=null){
		$("edit:sk_end_date").value = "";
	}
	if($("edit:sk_biid")!=null){
		$("edit:sk_biid").value = "";
		$("edit:sk_biid").focus();
	}
	if($("edit:sk_soco")!=null){
		$("edit:sk_soco").value = "";
	}
	if($("edit:sk_flag")!=null){
		$("edit:sk_flag").value = "00";
	}
	
}



//初始化添加页面
function initAdd(){
	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
	if($("edit:whna")!=null){
		$("edit:whna").value="";
		$("edit:whid").value="";
	}
	/*
	if($("edit:orna")!=null){
		$("edit:orna").value="";
		$("edit:orid").value="";
	}
	
	if($("edit:suna")!=null){
		$("edit:suna").value="";
		$("edit:suid").value="";
	}
	if($("edit:deus")!=null){
		$("edit:deus").value="";
	}*/
	
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
}
// 打开选择供应商页面
function selectSoco(){
	showModal('selectSoco.jsf');
	return false;
}

// 打开选择供应商页面
function selectSuin(){
	showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna');
	return false;
}

// 打开选择组织架构页面
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}

// 打开选择仓库页面
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&orid="+$('edit:orid').value+"&retid=edit:waho&retname=edit:whna";
	showModal(url);
	return false;
}
//打开选择货位界面
function selectWarehouse(){
	var pmmt = $("edit:pmmt").value;
   
	if($("edit:waho").value.length==0 || $("edit:waho").value==""){
		alert("请选择仓库!");
		return false;
	}

	var url1="../../common/waho/manywaho.jsf?type=4,5,6,9&pwid="+$('edit:waho').value+"&orid="+$('edit:orid').value+"&retid=edit:vc_warehouseid";
	var url2 ="../../common/stin/manystin.jsf?whid="+$('edit:waho').value+"&retid=edit:vc_invcode";
	if(pmmt=="02"){
		showModal(url2);
	}else{
		showModal(url1,600,600);
	}
	return false;
}

//选择操作人
function selectUser(){
	var url="selectuser.jsf?retid=edit:opna";
	showModal(url);
	return false;
}


//选着商品信息后续操作
function selectInveAdd(){
	selectInve();
	//$("edit:selInveBut").onclick();
	return true;
}

//回车时触发 
function clickInve(){
	if(event.keyCode==13){
		//$("edit:selInveBut").onclick();
		$("edit:qty").select();
		return true;
	}
}

// 查询商品信息
function selInveBut(){
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("商品信息不能为空!");
		$("edit:inco").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
// 结束查询商品信息
function endSelInveBut(){
	Gwallwin.winShowmask("FALSE");
	$("edit:qty").select();
}

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("商品编码不能为空!");
		$("edit:inco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("商品数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("商品数量只能是正整数!");
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

// 生成条码
function createBar(){
	var roids = Gtable.getselcolvalues('gtable','roid');
	if(roids.length<=0){
		if(confirm("是否要生成全部条码？")){
			$("edit:roids").value = "ALL";
			Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
	}else{
		$("edit:roids").value = roids;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

// 结束生成条码
function endCreateBar(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

// 查看条码
function selectBar(roid){
	Gwallwin.winShowmask("TRUE");
	showModal('otherin_selbar.jsf?roid='+roid);
	Gwallwin.winShowmask("FALSE");
}

// 查看全部条码
function selAllBar(){
	Gwallwin.winShowmask("TRUE");
	showModal("otherin_selbar.jsf?roid=");
	Gwallwin.winShowmask("FALSE");
}


// 查看条码页面初始化
function initselbar(){
	if($("edit:qty")!=null){
		$("edit:qty").value = "";
	}
}

//添加条码
function addBar(){
	var num = /^[1-9]\d*$/
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("补码数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("补码数量只能为正整数");
			$("edit:qty").select();
			return false;
		}
	}
	return true;
	Gwallwin.winShowmask("TRUE");
}

// 结束添加条码
function endAddBar(){
	alert($("edit:msg").value);
	$("edit:qty").value = "";
	Gwallwin.winShowmask("FALSE");
}

// 开始查询
function search(){
	var startDate =$("edit:sk_start_date").value;
	var enddate =$("edit:sk_end_date").value;
	if(startDate.Trim().length>0)
	{
		if(startDate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("开始日期格式错误!\n正确格式(YYYY-MM-DD)"+startDate);
	  		$("edit:sk_start_date").select();
	  		return false;
		}
	}
	if(enddate.Trim().length>0)
	{
		if(enddate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("结束日期格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:sk_end_date").select();
	  		return false;
		}
	}	
	return true;
}


//反审单据
function unApp(){
	Gwallwin.winShowmask("TRUE");
}
//结束反审
function endUnApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
// 删除明细
function delDetail(obj){
	var dids = Gtable.getselectid(obj);
	if(dids.length<=0){
		alert("请选择需要删除的行!");
		return false;
	}else{
		if(!confirm("确定删除选定行？")){
			return false;
		}else{
			$("edit:sellist").value = dids
			Gwallwin.winShowmask("TRUE");
			return true;
		}
	}
}
//结束删除明细
function endDelDetail(){
	alert($("edit:msg").value);
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
//结束添加明细
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//初始化Edit页面
function initEdit(){
	if($("edit:inco")!=null){
		$("edit:inco").value = "";
		$("edit:inco").focus();
	}
	
	/*
	if($("edit:inna")!=null)
	$("edit:inna").value = "";
	
	if($("edit:colo")!=null)
	$("edit:colo").value = "";
	
	if($("edit:cecu")!=null)
	$("edit:cecu").value = "";
	
	if($("edit:inse")!=null)
	$("edit:inse").value = "";
	
	if($("edit:vers")!=null)
	$("edit:vers").value = "";
	
	if($("edit:cpri")!=null)
	$("edit:cpri").value = "";
	*/
	if($("edit:dwhid")!=null){
		$("edit:dwhid").value = "";
	}
	
	if($("edit:qty")!=null)
	$("edit:qty").value = "";
	
	
}

// 清空条码也面查询条件
function clearbar(){
	if($("edit:baco")!=null){
		$("edit:baco").value = "";
		$("edit:baco").focus();
	}
	if($("edit:inco")!=null){
		$("edit:inco").value = "";
	}
}

// 回车监听
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
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

//打印条码
function print(obj)
{
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){
		Gwallwin.winShowmask("TRUE");
		$("edit:sellist").value=arr;
	}else{
		alert("请选择需要进行条码打印的记录!");
		return false;
	}
	return true	
}
//查看打印条码
function lookPrint()
{
	var mes =$("edit:msg").value;
	alert(mes);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("edit:filename").value;	  
 		alert(name); 	
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwallwin.winShowmask("FALSE");
 }

//打印全部条码
function printAll()
{
	Gwallwin.winShowmask("TRUE");
	return true	
}
//查看打印全部条码
function lookPrintAll()
{
	var mes =$("edit:msg").value;
	alert(mes);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("edit:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwallwin.winShowmask("FALSE");
 }
function repeatCheck(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){
		Gwallwin.winShowmask("TRUE");
		$("edit:sellist").value=arr;
	}else{
		alert("请选择需要复盘的库位!");
		return false;
	}
	return true	
}
function endRepeatCheck(){
	Gwallwin.winShowmask("FALSE");
	var msg =$("edit:msg").value;
	if(msg.length>0)
	alert(msg);
	
}


