function endPrintReport(){
	var msg = $("edit:msg").value;
	if(msg.indexOf("打印成功")!=-1){
		var filename=$("edit:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}else{
		alert(msg);
	}
	Gwallwin.winShowmask('FALSE');
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
	if($("edit:sk_SaleSoco")!=null){
		$("edit:sk_SaleSoco").value="";
	}
	
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
// 选类型
function onSoty(){
	var soty = $("edit:soty").value;
	if(soty=='PICKTASK'){
		$('st_img').className = 'hidetab_body';
		$('pt_img').className = '';
		$('car').className = 'hidetab_body';
	}else if(soty=='shelftask'){
		$('pt_img').className = 'hidetab_body';
		$('st_img').className = '';
		$('car').className = '';
	}
}


//跳过
function skip(){
	var ids = Gtable.getselcolvalues('gtable1','id');
	if(ids.length<=0){
		alert("请选择跳过的明细!");
		return false;
	}else{
		if(confirm("确定跳过当前选中明细吗？")){
			$("edit:sellist").value = ids;
			parent.Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
	}
}

// 导出数据
function showOutput(tableid,objid){
	var curTbl = $(tableid);
	//var bFind = true;
	var parentitem
	var item;
	var tmp;
	var i = 0;
	do {
		tmp = tableid + "_" + objid + "_" + i+ "_td"
		item = $(tmp)
		if (item == null){
			break;
		}
		if(item.type=='CHECKBOX'){
			item.innerText = "";
		}
		parentitem = $(tableid + "_g@r" + i) //item.offsetParent;
//		parentitem.removeChild(item);
		i = i + 1;
	} while (1 == 1)
	var oXL = new ActiveXObject("Excel.Application");
	//var oXL = new ActiveXObject("et.Application");
	//创建AX对象excel
	var oWB = oXL.Workbooks.Add();
	//获取workbook对象
	var oSheet = oWB.ActiveSheet;
	//激活当前sheet
	var sel = document.body.createTextRange();
	sel.moveToElementText(curTbl);
	//把表格中的内容移到TextRange中
	sel.select();
	//全选TextRange中内容
	sel.execCommand("Copy");
	//复制TextRange中内容 
	oSheet.Paste();
	//粘贴到活动的EXCEL中
	oXL.Visible = true;
	//设置excel可见属性
}

//end跳过
function endSkip(){
	alert($("edit:msg").value);
	parent.Gwallwin.winShowmask("FALSE");
	parent.document.getElementById("edit:showtable").onclick();
}


function addNew(){
	window.location.href="pickdown_add.jsf";
}

//初始化添加页面
function initAdd(){
	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
	if($("edit:soco")!=null){
		$("edit:soco").value="";
	}
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
	var soty = $("edit:soty").value;
	if(soty=='PICKTASK'){
		$('st_img').className = 'hidetab_body';
		$('pt_img').className = '';
		$('car').className = 'hidetab_body';
	}else if(soty=='shelftask'){
		$('pt_img').className = 'hidetab_body';
		$('st_img').className = '';
		$('car').className = '';
	}
	
}

// 添加明细
function addHead(){
	if($("edit:soco")==null || $("edit:soco").value.Trim().length<=0){
		alert("来源单号不能为空!");
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

// 完成添加明细
function endAddHead(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf('添加成功')!=-1){
		window.location = "pickdown_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
}

// 打开添加页面
function showAddDetail(){
	Gwallwin.winShowmask("TRUE");
	showModal("addDetail.jsf",'300','260');
	Gwallwin.winShowmask("FALSE");
}


// 打开选择供应商页面
function selectSoco(){
	showModal('selectSoco.jsf');
	return false;
}

// 打开选择
function selectPtma(){
	showModal('selectPtma.jsf',520,500);
	return false;
}
// 打开选择
function selectStma(){
	showModal('selectStma.jsf',520,500);
	return false;
}

// 打开选择供应商页面
function selectSuin(){
	showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna');
	return false;
}

// 打开选择用户界面
function selectUser(){
	showModal('../../common/user/user.jsf?retid=edit:sius&retname=edit:sina');
	return false;
}

// 打开选择组织架构页面
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}

// 打开选择库位页面
function selectWahod(){
	showModal('../../common/waho/waho.jsf?pwid=0&type=4&retid=edit:dwhid&retname=');
	return false;
}
// 选择仓库
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=2&retid=edit:whid&retname=edit:whna');
	return false;
}
// 选择仓库
function selectWaid(){
	showModal('../../common/waho/waho.jsf?type=9&retid=edit:waid&retname=edit:wana&pwid=all');
	return false;
}

// 打开选择商品信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:baco');
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
	var num = /^[1-9]\d*$/;
	if($("edit:dwhid")==null || $("edit:dwhid").value.Trim().length<=0){
		alert("拣货货位不能为空!");
		return false;
	}
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("条码不能为空!");
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("拣货数量不能为空!");
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("拣货数量只能是正整数!");
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
		initAddDetail();
		$("edit:baco").focus();
	}else{
		alert(msg);
		initAddDetail();
	}
	Gwallwin.winShowmask("FALSE");
}

function initAddDetail(){
	var batp = t.getBatp();
	if( batp=='02' || (batp=='04' && t.getIsAutoAdd()=='0') ){
		textClear('edit','baco,qty','Y');
	}else{
		textClear('edit','baco','Y');
	}
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
	showModal('pickdown_selbar.jsf?roid='+roid);
	Gwallwin.winShowmask("FALSE");
}

// 查看全部条码
function selAllBar(){
	Gwallwin.winShowmask("TRUE");
	showModal("pickdown_selbar.jsf?roid=");
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

// 批量添加明细
function addDetails(){
	var ids = Gtable.getselcolvalues('gtable1','id');
	if(ids.length<=0){
		alert("请选择快捷拣货的行项目!");
		return false;
	}else{
		$("edit:sellist").value = ids;
		parent.Gwallwin.winShowmask("TRUE");
		return true;
	}
}
//结束批量添加明细
function endAddDetails(){
	var msg = $("edit:msg").value
	alert(msg);
	parent.Gwallwin.winShowmask("FALSE");
	parent.document.getElementById('edit:showtable').onclick();
}



// 添加明细查询
function addSearch(){
	Gwallwin.winShowmask("TRUE");
}
// 结束添加明细查询
function endAddSearch(){
	Gwallwin.winShowmask("FALSE");
}

// 清除查询条件
 function cleartext(){
 	if($("edit:id")!=null){
 		$("edit:id").value = "";
 	}
 	if($("edit:name")!=null){
 		$("edit:name").value = "";
 		$("edit:name").focus();
 	}
 	if($("edit:colo")!=null){
 		$("edit:colo").value = "";
 	}
 	if($("edit:inst")!=null){
 		$("edit:inst").value = "";
 	}
 	if($("edit:tyna")!=null){
 		$("edit:tyna").value = "";
 	}
 	if($("edit:brde")!=null){
 		$("edit:brde").value = "";
 	}
 	if($("edit:inpr")!=null){
 		$("edit:inpr").value = "0";
 	}
 }
 
 // 打开查询商品类型页面
function selectSK_Inty(){
	showModal('../../common/invclass_sel/invclass_sel.jsf?retname=edit:tyna&retid=');
	return false;
}
// 打开查询品牌页面
function selectSK_Bran(){
	showModal('../../common/brand_sel/brand_sel.jsf?retname=edit:brde&retid=');
	return false;
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
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href = "pickdown.jsf";
	}
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
//审核单据
function app(){
	Gwallwin.winShowmask("TRUE");
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
	var num = /^[0-9]\d*$/;
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
	if($("edit:dwhna")!=null){
		$("edit:dwhna").value = "";
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

var t;
//初始化edit
function initDetail(){
	if($('edit:batp:0')){
	t = new TailHandler('out');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	}
}
function initEdit(){
	textClear('edit','dwhid,baco,qty','Y');
	var soty = $("edit:soty").value;
	if(soty=='PICKTASK'){
		$('car').className = 'hidetab_body';
	}else if(soty=='shelftask'){
		$('car').className = '';
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

//开始批量复核
function pickdown_oqc_batch(){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.length<=0){
		alert("请选择需要复核的拣货下架单!");
		return false;
	}else{
		$("edit:sellist").value = biids;
	}
	if(!confirm("确定后系统会自动走完出库复核流程！\n确定选中任务出库复核?")){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}


//结束批量复核
function endpickdown_oqc_batch(){
	Gwallwin.winShowmask("FALSE");
	var message = $("edit:msg").value;
	if(message.indexOf("成功")!=-1){
		type = "Y";
	}else{ 
		type = "X";
	}
	Gwin.alert("系统提示",message,type,document);
}


function excelios_begin(obj){
	var s = Gtable.getSQL(obj);
	$("edit:gsql").value = s
	startDo();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}


function excelios_end(){
	Gwallwin.winShowmask('FALSE');
	var message =$('edit:msg').value;
	
	alert($('edit:msg').value);
	//alert($("edit:outPutFileName").value);
	if(message.indexOf('导出成功')!=-1){
		window.open('../../'+$("edit:outPutFileName").value);
	}
}