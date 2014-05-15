function excelios_begin(obj){
	var s = Gtable.getSQL(obj);
	$("edit:gsql").value = s
	
	startDo();
}

//导出结束
function excelios_end(){
	Gwallwin.winShowmask('FALSE');
	var message =$('edit:msg').value;
	
	alert($('edit:msg').value);
	//alert($("edit:outPutFileName").value);
	if(message.indexOf('导出成功')!=-1){
		window.open('../../'+$("edit:outPutFileName").value);
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
	if($("edit:sk_biid")!=null){
		$("edit:sk_biid").value = "";
		$("edit:sk_biid").focus();
	}
	if($("edit:sk_soco")!=null){
		$("edit:sk_soco").value = "";
	}
	if($("edit:sk_suna")!=null){
		$("edit:sk_suna").value = "";
	}
	if($("edit:sk_flag")!=null){
		$("edit:sk_flag").value = "00";
	}
	if($("edit:sk_flag2")!=null){
		$("edit:sk_flag2").value = "00";
	}
	if($("edit:sk_flag3")!=null){
		$("edit:sk_flag3").value = "00";
	}
	
	if($("edit:sk_inco")!=null){
		$("edit:sk_inco").value = "";
	}
	if($("edit:sk_inna")!=null){
		$("edit:sk_inna").value = "";
	}	
	
}
//跳转到添加表头页面
function addNew(){
	 window.location.href='noticeofarrive_add.jsf';
}

function tobarcode(){
	if( $("edit:ispaco:0").checked==true){	
		$("st1").style.display="none";
		$("st2").style.display="none";		
	
	}
	if( $("edit:ispaco:1").checked==true){
		$("st1").style.display="block";
		$("st2").style.display="block";
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
//添加单据
function headAdd(){
	if($("edit:suid")==null || $("edit:suid").value.Trim().length==0){
		alert("供应商不能为空！");
		return false;
	}
	if($("edit:indt")==null || $("edit:indt").value.Trim().length==0){
		alert("预计到货时间不能为空！");
		return false;
	}
	if($("edit:bato")==null || $("edit:bato").value.Trim().length==0){
		alert("批次号不能为空！");
		return false;
	}
	
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加单据完成
function endHeadAdd(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("添加成功")!=-1){
		window.location.href="noticeofarrive_edit.jsf";
	}
	return true;
}

function endAddDetails(){
	Gwallwin.winShowmask("FALSE");
	parent.document.getElementById("edit:refBut").onclick();
	alert($("edit:msg").value.replaceAll('<p>','\n'));
	Gwallwin.winClose();
}

//选择仓库
function selectWaho(){
	var url="../../common/waho/waho.jsf?type=1&pwid=all&retid=edit:whid&retname=edit:whna"
	showModal(url);
	return false;
}

//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=3&pwid="+$('edit:fwhid').value+"&orid="+$('edit:orid').value+"&retid=edit:whid&retname="
	showModal(url);
	return false;
}

//选择用户
function selectUser(){
	var url="../../common/user/user.jsf?type=1&pwid=all&retname=edit:opna"
	showModal(url);
	return false;
}

function checkBarcode(){
	if($('edit:baco').value!='' && $('edit:baco').value.length>0){
		return true;
	}
	return false;
}


function setCode4DBean(para){
	var obj=$("edit:setCode4DBean");
	if(para=='1'){
		if (event.keyCode==13){
			obj.onclick();
			return true;
		}
	}else{
		obj.onclick();
		return true;
	}
}

function endCode4DBean(){
	endLoad();
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		//$('edit:baco').select();
	}else{
		if($('edit:qty').disabled == false ){
			$('edit:qty').focus();
		}
	}
}

// 打开选择条码
function selectCode(){
	var Obj = document.getElementsByName('edit:ispaco');
	for(i=0;i<Obj.length;i++){
		if(Obj[i].checked){
	 		break;
	 	}
	};
    if(i==Obj.length){
    	alert("没有选择条码类型！");
    	return false;
    }
    var url="../../common/tray_stock/tray_stock.jsf?retid=edit:baco&ctype="+Obj[i].value ;
	showModal(url,'550px');
	return true;
}

//选择采购订单
function selectSoco(){
	var url="selectSoco.jsf?retid=edit:soco";
	var ret = showModal(url);
	return false;
}

//添加页面初始化
function clearText(){
	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
	if($("edit:suna")!=null){
		$("edit:suna").value="";
	}
	if($("edit:suid")!=null){
		$("edit:suid").value="";
	}
	if($("edit:nv_remark")!=null){
		$("edit:nv_remark").value="";
	}
	if($("edit:isch")!=null){
		$("edit:isch").value="0";
	}
	if($("edit:indt")!=null){
		$("edit:indt").value="";
	}
	if($("edit:bato")!=null){
		$("edit:bato").value="";
	}
}
function clearDetailText(){
	if($("edit:poid")!=null){
		$("edit:poid").value="";
	}
	if($("edit:id")!=null){
		$("edit:id").value="";
	}
	if($("edit:name")!=null){
		$("edit:name").value="";
	}
	if($("edit:colo")!=null){
		$("edit:colo").value="";
	}
	if($("edit:inst")!=null){
		$("edit:inst").value="";
	}
}

//开始删除明细
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



//添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:dwhid")==null || $("edit:dwhid").value.Trim().length<=0){
		alert("库位不能为空!");
		$("edit:dwhid").focus();
		return false;
	}
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("条码不能为空!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
		if($("edit:qty").disabled==false){
			$("edit:qty").focus();
		}
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

//添加明细后
function endAddDetail(){
	var msg = $("edit:msg").value;
	if(msg.indexOf("成功")!=-1){
		clareDetail();
		alert(msg);
	}
	Gwallwin.winShowmask("FALSE");
}

function clareDetail(){
	$("edit:baco").value="";
	$("edit:qty").value="";
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
		window.location.href="noticeofarrive.jsf";
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

function clearedetail(){
	$("edit:baco").value="";
	$("edit:qty").value="";
	$("edit:dwhid").value="";

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

function commitrelf(){
	if($("edit:refl").value.Trim().length<=0 || $("edit:refl").value==""){
		alert("请输入质检结果!");
		$("edit:refl").focus();
		return false;
	}else{	
		if(confirm("确定要提交质检结果？")){
			Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
	}
}
function endcommitrelf(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


// 打开选择条码
function selectCode(){
	var Obj = document.getElementsByName('edit:batp');
	for(i=0;i<Obj.length;i++){
		if(Obj[i].checked){
	 		break;
	 	}
	};
    if(i==Obj.length){
    	alert("没有选择条码类型！");
    	return false;
    }
	showModal("../../common/tray_stock/tray_stock.jsf?retid=edit:baco&ctype="+Obj[i].value+"&whid="+$('edit:whid').value+"&dwhid=",'550px');
	return true;
}

function changeCode(){
	if($('edit:batp:0').checked==true){
		$('edit:qty').disabled = true;
	}else if($('edit:batp:1').checked==true){
		$('qtyPanel').style.display = "";
	}
	else if($('edit:batp:2').checked==true){
		$('edit:qty').disabled = false;
	}
	//$('edit:baco').focus();
	textClear('edit','dwhid,baco,qty','Y');
}

function setCode(){
	if($('edit:baco').value=='' || $('edit:baco').value.lengh<=0){
		$('edit:baco').focus();
	}
}

function checkBarcode(){
	if($('edit:baco').value!='' && $('edit:baco').value.length>0){
		startDo();
		return true;
	}
	return false;
}

function setCode4DBean(para){
	var obj=$("edit:setCode4DBean");
	if(para=='1'){
		if (event.keyCode==13){
			obj.onclick();
			return true;
		}
	}else{
		obj.onclick();
		return true;
	}
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}
function endLoad(){
	Gwallwin.winShowmask('FALSE');
}
function doSearch(){
	$("edit:sid").click();
}
function endCode4DBean(){
	endLoad();
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:qty').value="";
		$('edit:baco').focus();
		//$('edit:baco').select();
	}else{
		if($('edit:qty').disabled == false ){
			$('edit:qty').focus();
		}
	}
}
function checkWhid(){
	if($('edit:dwhid').value==""){
		$('edit:dwhid').focus();
	}
}

function selectDWare(){
	var orid = $('edit:orid').value;
	showModal('../../common/waho/waho.jsf?type=3&pwid='+$('edit:whid').value+'&retid=edit:dwhid&orid='+orid+'&rename=null');
	//$('edit:baco').value='';
	return false;
}

// 监听数量
function addDetailKey(){
	if (event.keyCode==13)
	{	
		if($("edit:addDBut")!=null){
			$("edit:addDBut").click();
		}
		return true;
	}
}

function setHidValue(obj){
	$(obj.id+'_hid').value=obj.value;
}

//显示添加明细页面
function showAddDetail(){
	var url = "";
//	var soty = $('edit:soty').value;
//	if('PO'==soty){
		url = 'addDetail.jsf';
//	}else{
		
//	}
	showModal(url,'850px','500px');
	return true;
}

//添加明细列表添加明细按钮
function addDetails(){
	var socos = Gtable.getselcolvalues('gtable','biid');//采购订单号
	var incos = Gtable.getselcolvalues('gtable','inco');
	var qtys = Gtable.getselcolvalues('gtable','dqty');
	if(incos.Trim().length<=0 || qtys.Trim().length<=0){
		alert("请勾选需要添加的明细!");
		return false;
	}
	$('edit:socos').value = socos;
	$('edit:sellist').value = incos;
	$('edit:qtys').value = qtys;
	Gwallwin.winShowmask("TRUE");
	return true;
}


//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	///var qtys = Gtable.getcolvalues('gtable','qty');
	//var qty = qtys.split("#@#");
	///for(i=0;i<qty.length;i++){
	////	if(!num.test(qty[i])){
	//		msg += "第"+(i+1)+"行数量格式错误!  \n";
	//	}
	//}
	if(msg.length<=0){
		Gwallwin.winShowmask("TRUE");
		var updatedata = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedata;
	   	return true;
	}else{
		alert(msg);
		return false;
	}
}

//调整明细数量
function updateDetailEx(){

	//编辑页面调整明细数量
	if(!confirm("确定要调整明细数量吗?")){
		return false;
	}
	
	var msg = "";
	var qtys = Gtable.getcolvalues('gtable','uqty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		var num = parseInt(qty[i]);
		if(num < 0 || num >= 0)
		{			
		}else
		{
			msg += "第"+(i+1)+"行数量格式错误!  \n";
			alert(msg);
			return false
		}
	}
	if(msg.length<=0){
		Gwallwin.winShowmask("TRUE");
		var updatedata = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedata;
	   	return true;
	}else{
		alert(msg);
		return false;
	}
}

//结束添加明细
function endUpdateDetail(){	
	var msg = $('edit:msg').value;
	alert(msg.replaceAll('<p>','\n') );
	Gwallwin.winShowmask("FALSE");
}

//结束添加明细
function endUpdateDetailEx(){	
	var msg = $('edit:msg').value;
	alert(msg.replaceAll('<p>','\n') );
	window.location.href="arrive.jsf";
	Gwallwin.winShowmask("FALSE");
}

//选择输入数量后的明细 wonderful
function selectCheckBox(obj)
{
	var str = obj.id.split('_');
	var id = "checkbox"+str[2];
	
	document.getElementById(id).checked = true;
	return true;
}

//开始确认到货
function cfmArriv(){
	if(confirm("确定要确认到货!")){
		var updatedata = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedata;
	   	Gwallwin.winShowmask("TRUE");
	   	return true;
	}
	return false;
}
//结束确认到货
function endcfmarrvie(){
	var msg = $('edit:msg').value;
	alert(msg.replaceAll('<p>','\n') );
	Gwallwin.winShowmask("FALSE");
}

//开始拒收 
function st_reject(){
	if(confirm("确定要拒收!")){
		Gwallwin.winShowmask("TRUE");
	   	return true;
	}
}
//结束拒收
function end_reject(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//开始退货
function st_returns(){
	if(confirm("确定要退货!")){
		Gwallwin.winShowmask("TRUE");
	   	return true;
	}
}
//结束退货
function end_returns(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//开始转质检
function st_turncheck(obj){
	var dids = Gtable.getselectid(obj);
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(dids.length>0){	
		if(confirm("确定要对当前选中的记录下推到质检吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = incos;
			return true;
		}
	}else{
		alert("请选择你要转质检的物料的记录");
		return false;
	}
}
//结束转质检
function end_turncheck(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//开始转入库
function st_turnin(obj){
	var dids = Gtable.getselectid(obj);
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(dids.length>0){	
		if(confirm("确定要对当前选中的记录下推到入库吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = incos;
			return true;
		}
	}else{
		alert("请选择你要转入库的物料的记录");
		return false;
	}
}
//结束转入库
function end_turnin(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//开始残品转入库
function st_turndefin(obj){
	var dids = Gtable.getselectid(obj);
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(dids.length>0){	
		if(confirm("确定要对当前选中的记录下进行残品入库吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = incos;
			return true;
		}
	}else{
		alert("请选择你要进行残品入库的物料的记录");
		return false;
	}
}
//结束残品转入库
function end_turndefin(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//开始修改质检类型
function st_mdtype(){
	var qirt = $("edit:qirt").value;
	if(qirt=="0"){
		if(confirm("确定要把质检类型由全检改成抽检吗？")){
			Gwallwin.winShowmask("TRUE");
	  	 	return true;
		}else{
			return false;
		}
	}else{
		if(confirm("确定要把质检类型由抽检改成全检吗？")){
			Gwallwin.winShowmask("TRUE");
	   		return true;
		}else{
			return false;
		}
	}
}
//结束修改质检类型
function end_mdtype(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

//调整明细
function st_mddetail(){
	if(!confirm("确定要调整明细数量吗?")){
		return false;
	}
	var incos =  Gtable.getcolvalues("gtable","inco");
	var lqtys = Gtable.getcolvalues("gtable","aqty");//清点数量
	var hqtys = Gtable.getcolvalues("gtable","qfqt");//合格数量
	
	$("edit:incos").value=incos;
	$("edit:lqtys").value=lqtys;
	$("edit:hqtys").value=hqtys;
	Gwallwin.winShowmask("TRUE");
	return true;
}

function end_mddetail(){
	var msg = $('edit:msg').value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}


// 打开选择供应商页面
function selectSuin(){
	showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna','528','525');
	return false;
}
function showImport(){
	$("mes").innerHTML="";
	Gwallwin.winShow("import","选择导入文件");	
}
	function hideDiv(){
		Gwallwin.winClose();		
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
// 导出数据
function showOutput(tableid){
	var curTbl = $(tableid);
	var oXL = new ActiveXObject("Excel.Application");
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
