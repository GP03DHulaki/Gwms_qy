var retid = "", retname = "";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2) {
	retid = $("edit:retid").value;
	retname = $("edit:retname").value;
	if (retid != "" && retid != null) {
		window.dialogArguments.document.getElementById(retid).value = parm1;
	}
	if (retname != "" && retname != null) {
		window.dialogArguments.document.getElementById(retname).value = parm2;
	}

	window.close();
}

function  checkModifysius(){
	if($("edit:sius1")==null ||$("edit:sius1").value.Trim().length<=0){
		alert("修改后的任务执行人不能为空!");
		return false;
	}
		return true;
}

function endcheckModifysius(){
	var message = $("edit:msg").value;
	alert(message);
	if(message.indexOf('修改成功')!=-1){
     	window.close();
     	//alert(window.dialogArguments.document.getElementById("showRe"));
     	window.dialogArguments.document.getElementById("edit:showRe").onclick();
    }
}

//重置首页查询条件
function clearData(){
	if($("edit:sk_start_date")!=null){
		$("edit:sk_start_date").value = "";
	}
	if($("edit:sk_end_date")!=null){
		$("edit:sk_end_date").value = "";
	}
	
	if($("edit:ch_start_date")!=null){
		$("edit:ch_start_date").value = "";
	}
	if($("edit:ch_end_date")!=null){
		$("edit:ch_end_date").value = "";
	}
	if($("edit:sk_biid")!=null){
		$("edit:sk_biid").value = "";
		$("edit:sk_biid").focus();
	}
	if($("edit:sk_suid")!=null){
		$("edit:sk_suid").value = "";
	}
	if($("edit:sk_suna")!=null){
		$("edit:sk_suna").value = "";
	}
	if($("edit:sk_flag")!=null){
		$("edit:sk_flag").value = "00";
	}
	if($("edit:crna")!=null){
		$("edit:crna").value = "";
	}
	if($("edit:chna")!=null){
		$("edit:chna").value = "";
	}
	if($("edit:usna")!=null){
		$("edit:usna").value = "";
	}
}

function init(){
	if($("edit:sius1").value!=null || $("edit:sius1").value.Trim().length>0){
		$("edit:sius1").value=""
	}
	if($("edit:sina1").value!=null || $("edit:sina1").value.Trim().length>0){
		$("edit:sina1").value=""
	}
}

function selectModifyUser(){
	showModal('user.jsf?retid=edit:sius1&retname=edit:sina1');
	 $("edit:nsina").value = $("edit:sina1").value;
	return false;
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
	if($("edit:opna")!=null){
		$("edit:opna").value="";
	}
	if($("edit:pudt")!=null){
		$("edit:pudt").value="";
	}
	if($("edit:buty")!=null){
		$("edit:buty").value = '01';
	}
	if($("edit:suna")!=null){
		$("edit:suna").value="";
		$("edit:suid").value="";
	}
	if($("edit:indt")!=null){
		$("edit:indt").value="";
	}
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
}


// 查看拣货路径
 function showPath(){
 	Gwallwin.winShowmask("TRUE");
 	showModal("showPath.jsf",'550','550');
 	Gwallwin.winShowmask("false");
 }

// 添加明细
function addHead(){
	if($("edit:whna")==null || $("edit:whna").value.Trim().length<=0){
		alert("入库仓库不能为空!");
		return false;
	}
	if($("edit:orna")==null || $("edit:orna").value.Trim().length<=0){
		alert("组织架构不能为空!");
		$("edit:orna").focus();
		return false;
	}

	if($("edit:pudt")==null || $("edit:pudt").value.Trim().length<=0){
		alert("采购时间不能为空!");
		$("edit:pudt").focus();
		return false;
	}else{
		if($("edit:pudt").value.Trim().search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("采购时间格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:pudt").select();
	  		return false;
		}
	}
	if($("edit:suna")==null || $("edit:suna").value.Trim().length<=0){
		alert("供应商不能为空!");
		$("edit:suna").focus();
		return false;
	}
	if($("edit:indt")==null || $("edit:indt").value.Trim().length<=0){
		alert("预计到货时间不能为空!");
		$("edit:indt").focus();
		return false;
	}else{
		if($("edit:indt").value.Trim().search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("预计到货时间格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:indt").select();
	  		return false;
		}
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

 //修改任务执行人
  function modifysius(){
 	Gwallwin.winShowmask("TRUE");
 		showModal("modifysius.jsf",'650','500');
 	Gwallwin.winShowmask("false");
 }

// 完成添加明细
function endAddHead(){
	alert($("edit:msg").value);
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("添加成功")!=-1){
		window.location.href="po_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
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

// 打开选择库位页面
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna&pwid=');
	return false;
}

// 打开选择物料信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco');
	return false;
}

//选着物料信息后续操作
function selectInveAdd(){
	selectInve();
	//$("edit:selInveBut").onclick();
	return true;
}

// 打开选择用户界面
function selectUser(){
	showModal('../../common/user/user.jsf?dpid=05&retid=edit:sius&retname=edit:sina');
	return false;
}

//回车时触发 
function clickInve(){
	if(event.keyCode==13){
		//$("edit:selInveBut").onclick();
		$("edit:qty").select();
		return true;
	}
}

// 查询物料信息
function selInveBut(){
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("物料信息不能为空!");
		$("edit:inco").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
// 结束查询物料信息
function endSelInveBut(){
	Gwallwin.winShowmask("FALSE");
	$("edit:qty").select();
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
		alert("物料数量不能为空!");
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
	showModal('po_selbar.jsf?roid='+roid);
	Gwallwin.winShowmask("FALSE");
}

// 查看全部条码
function selAllBar(){
	Gwallwin.winShowmask("TRUE");
	showModal("po_selbar.jsf?roid=");
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
//删除单据(首页)
function deleteHeadAll(){
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
		window.location.href = "po.jsf";
	}
}

//保存单据
function updateHead(){
	Gwallwin.winShowmask("TRUE");
	return true;
	//return addHead();
}
//结束保存单据
function endUpdateHead(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//审核单据
function app(){
	if($("edit:whna")==null || $("edit:whna").value.Trim().length<=0){
		alert("入库仓库不能为空!");
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
function print()
{
	var bacos = Gtable.getselcolvalues('gtable','inco');
	if(bacos.length>0){
		Gwallwin.winShowmask("TRUE");
		$("edit:sellist").value=bacos;
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















//-------------------------------------------------------------------  以下为旧版本 ---------------------------------------------------------------
//关闭计划单
function endDot()
{
	Gwallwin.winShowmask("FALSE");
	
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf('导出成功')!=-1){
		window.open('../../'+$("edit:outPutFileName").value);
	}
}

function doClose(){
	if(!confirm('确定要关闭单据吗?')){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//完成单据关闭
function endDoClose(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//添加预约单

function addPurApp(){
	Gwallwin.winShowmask("TRUE");
}
//结束添加预约
function endAddPurApp(){
	alert("已生成预约单!");
	Gwallwin.winShowmask("FALSE");
	//window.location.href="../app/app_edit.jsf";
	parent.openmodule('PurApp','../../app/app_edit.jsf');
}

//进入页面时

function showMesList(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			clearAllData();
		}
	}else{
		clearAllData();
	}
}
//清空数据
function clearAllData(){
	if($("edit:sk_start_date")!=null){
		$("edit:sk_start_date").value="";
	}
	if($("edit:sk_end_date")!=null){
		$("edit:sk_end_date").value="";
	}
	if($("edit:sk_supplierid")!=null){
		$("edit:sk_supplierid").value="";
	}
	if($("edit:sk_suppliername")!=null){
		$("edit:sk_suppliername").value="";
	}
	if($("edit:sk_voucherid")!=null){
		$("edit:sk_voucherid").value="";
	}
	if($("edit:sk_ch_flag")!=null){
		$("edit:sk_ch_flag").value="";
	}
	if($("edit:vc_barcode")!=null){
		$("edit:vc_barcode").value="";
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
// 查询
function checkList()
{
	var startDate =$("edit:sk_start_date").value;
	var enddate =$("edit:sk_end_date").value;
	if(startDate.Trim().length>0)
	{
		if(startDate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("开始日期格式错误!\n正确格式(YYYY-MM-DD)"+startDate);
	  		
	  		$("edit:sk_start_date").value="";
	  		return false;
		}
	}
	if(enddate.Trim().length>0)
	{
		if(enddate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("结束日期格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:sk_end_date").value="";
	  		return false;
		}
	}	
	if(startDate.Trim().length>0&&enddate.Trim().length>0)
	{
		if(enddate<startDate)
		{
			alert("结束日期应大于开始日期!!");
			$("edit:sk_start_date").value="";
			$("edit:sk_end_date").value="";
			$("edit:sk_start_date").focus();
			return false;
		}
	}
	return true;
}

// 同步
function syn(){
	Gwallwin.winShowmask("TRUE");
}
//  同步完成
function endSyn(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function selectVendor(){
	showModal('../../common/vendor/selectvendor.jsf?retid=list:vc_supplierid&retname=list:nv_suppliername');
}

function selectInventory(){
	showModal('../../common/inventory/selectinventory_po.jsf?retid=list:vc_invcode');
}

function addNew(){
	window.location.href="po_add.jsf";
}

function endDo(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("list:msg").value;
	msg = "保存成功";
	if(msg.indexOf("保存成功") != -1){
		alert(msg);
		window.location.href="po_edit.jsf?pid="+$("list:vc_voucherid").value+"";
	}else{
		alert(msg);
		window.open('../../'+$("list:outPutFileName").value);
	}
}

/* 列新明细 */
function checkUpdate(){
   	var updatedate = Gtable.getUpdateinfo('gtable');
   	$("list:updatedata").value = updatedate;
	
	//JSON OBJ
	var gtable = eval("(" + updatedate + ")");
	
	//以下值是从JSON中取得


	var records = gtable.records;
	
	Gwallwin.winShowmask("TRUE");
	return true;
}

function doDeleteDetail(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length<=0){		    	
		alert("请选择要删除的行!");
	   	return false;
	}
	$("list:item").value=arr;
	Gwallwin.winShowmask("TRUE");
	return true;
}

function clearDetail(){
	textClear('list','vc_invcode,dc_qty');
}
var remark;
function doEidt(){
	remark = $('list:nv_remark').value;
}

function beforeForm(){
	$('list:nv_remark').style.color='#000000';
	$('list:nv_remark').readOnly='';
	$('list:nv_remark').focus();
}

function lastForm(){
	var new_remark=$('list:nv_remark').value;
	if(remark!=new_remark){
		if(confirm("备注信息已改变,是否保存?")){
			$('list:new_remark').value=$('list:nv_remark').value;
			if($('list:addrUpdate')){
				$('list:addrUpdate').click();
			}else{
				alert('当前用户无修改权限!');
				$('list:nv_remark').style.color='#7f7f7f';
				$('list:nv_remark').readOnly='true';
				$('list:nv_remark').value=remark;
			}
		}else{
			$('list:nv_remark').style.color='#7f7f7f';
			$('list:nv_remark').readOnly='true';
			$('list:nv_remark').value=remark;
		}
	}else{
		$('list:nv_remark').style.color='#7f7f7f';
		$('list:nv_remark').readOnly='true';
	}
}

function openExcel(){
	window.location.href = "Test.jsf";

}
function openExcel2(){
	window.location.href = "Test1.jsf";

}
// 打开选择用户界面
function selectUser(){
	showModal('../../common/user/user.jsf?retid=edit:sius&retname=edit:sina');
	return false;
}
