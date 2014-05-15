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
	if($("edit:crna")!=null){
		$("edit:crna").value = "";
	}
	if($("edit:orid")!=null){
		$("edit:orid").value = "";
	}
}

var retid = "", dwhid = "",retqty="";		//返回刷新的字段，如无，则不刷新
function selectThis(parm1, parm2) {
	retid = $("edit:retid").value;
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
		parm2 = parseInt(parm2);
		isGwin ? parent.document.getElementById(retqty).value = parm2 : callBack.document.getElementById(retqty).value = parm2;
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


function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
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

function addNew(){
	window.location.href="poin_add.jsf";
}

//初始化添加页面
function initAdd(){
	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
	if($("edit:soco")!=null){
		$("edit:soco").value="";
		//$("edit:socoid").value="";
	}
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
}

// 添加明细
function addHead(){
	if($("edit:soco")==null || $("edit:soco").value.Trim().length<=0){
		alert("采购订单号不能为空!");
		selectSoco();
		return false;
	}
	$("edit:whid_h").value=$("edit:whid").value;
	Gwallwin.winShowmask("TRUE");
	return true;
}

// 完成添加明细
function endAddHead(){
	alert($("edit:msg").value);
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("添加成功")!=-1){
		window.location.href="poin_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}

// 打开选择供应商页面
function selectSoco(){
	var index =$("edit:soty").selectedIndex; 
	var soty = $("edit:soty").options[index].value;

	if(soty=='PO')
	{
		showModal('selectSoco.jsf?retid=edit:soco');
	}else if(soty=='check')
	{
		showModal('selectSocoCheck.jsf?retid=edit:soco');
	}else if(soty=='intask')
	{
		showModal('selectSocoIntask.jsf?retid=edit:soco&rewhid=edit:whid');
	}else
	{
		alert('请选择来源类型!');
	}
	
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

// 打开选择库位页面
function selectWahod(){
	var pwid = $("edit:whid").value;
	showModal('../../common/waho/waho.jsf?whfl=P&type=4,5,6,7,9,13,99&retid=edit:dwhid&retname=&pwid='+pwid);
	return false;
}
// 选择仓库
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna&pwid=');
	return false;
}

// 打开选择商品信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco');
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
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("条码不能为空!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("数量只能是正整数!");
			$("edit:qty").select();
			return false;
		}
	}
	if($("edit:dwhid")==null || $("edit:dwhid").value.Trim().length<=0){
		alert("仓库不能为空!");
		$("edit:dwhid").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

// 完成添加明细
function endAddDetail(){
	var msg = $("edit:msg").value
	if(msg.indexOf("添加成功")!=-1){
textClear('edit','baco','Y');
	}else{
		alert(msg);
		initEdit();
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
	showModal('poin_selbar.jsf?roid='+roid);
	Gwallwin.winShowmask("FALSE");
}

// 查看全部条码
function selAllBar(){
	Gwallwin.winShowmask("TRUE");
	showModal("poin_selbar.jsf?roid=");
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
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href = "poin.jsf";
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
	if($("edit:qty")) {
	 var batp = t.getBatp();
	 textClear('edit','baco,dwhid,qty','Y');
	 if(batp=='04')
		 $("edit:qty").value='';
	 }
	
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
//初始化edit
function initDetail(){
if($('edit:batp:0')){
	t = new TailHandler('in');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	}
}

function selectCode(){
    var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }

    if(batp == '04'){
    	showModal('inve.jsf?retid=edit:baco',660,460);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=0&retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid+"&soco="+$('edit:soco').value,'710px','500px');
    }else if(batp == '02'){
    	showModal("barcode_sel.jsf?retqty=edit:qty&retid=edit:baco",'680px','460px');
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
		$('edit:qty').focus();
	}
}
function endLoad(){
	Gwallwin.winShowmask('FALSE');
}
function selectuser()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
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
	window.open( projectName+'/excel/poindetail.xls','newwindow');
}
function showAddDetail(){
	var url = "";
	var soty = $('edit:soty').value;
	if('PO'==soty){
		url = 'addDetail_po.jsf';
	}else{
		url = 'addDetail.jsf';
	}
	showModal(url,'850px','500px');
	return true;
}
//隐藏层
function hideDivUP(){
	Gwin.close("import");	
}
//添加明细列表添加明细按钮
function addDetails(){
	var socos = Gtable.getselcolvalues('gtable','soco');
	var incos = Gtable.getselcolvalues('gtable','inco');
	var qtys = Gtable.getselcolvalues('gtable','qty');
	if(socos.Trim().length<=0 || incos.Trim().length<=0 || qtys.Trim().length<=0){
		alert("请勾选需要添加的明细,并检查明细内容是否为空!");
		return false;
	}
	$('edit:socos').value = socos;
	$('edit:incos').value = incos;
	$('edit:qtys').value = qtys;
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddDetails(){
	Gwallwin.winShowmask("FALSE");
	parent.document.getElementById("edit:refBut").onclick();
	alert($("edit:msg").value.replaceAll('<p>','\n'));
	Gwallwin.winClose();
}