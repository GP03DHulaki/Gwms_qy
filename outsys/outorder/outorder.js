//关闭出库单
function closeOrder()
{
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		alert("请选择需要关闭订单!");
		return false;
	}else{
		var flags = Gtable.getselcolvalues('gtable','flag');
		if(flags.indexOf('16')!=-1 || flags.indexOf('17')!=-1){
			if(confirm("勾选的订单中存在已拣货的商品，确定商品已放回原库位？\n否则订单关闭后请把中已拣下的商品放回原库位！")){
				$("edit:sellist").value = biids;
				Gwallwin.winShowmask("TRUE");
				return true;
			}
		}else{
			if(confirm("确定关闭所选订单?")){
				$("edit:sellist").value = biids;
				Gwallwin.winShowmask("TRUE");
				return true;
			}
		}
	}
	return false;
}


//拒绝出库单
function rejectOrder()
{
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		alert("请选择需要关闭订单!");
		return false;
	}else{
		var flags = Gtable.getselcolvalues('gtable','flag');
		if(confirm("确定关闭所选订单?\n如订单存在已件货商品，库存将移动到拒单商品库位")){
			$("edit:sellist").value = biids;
			Gwallwin.winShowmask("TRUE");
			return true;
		}
	}
	return false;
}

function closeOrderEnd()
{
	Gwallwin.winShowmask("FALSE");
	alert($("edit:msg").value);	
}

function keyhandle(obj){

	e = window.event;
	
	var keycode = e.which ? e.which : e.keyCode; 
	alert(keycode);
	if ( keycode == 13 || keycode == 108){
		var n = obj.id;
		var l = n.length;
		var fk,fn;
		for (var i = l - 1; i >= 0;i--){
			fk = n.substring(i,i+1);
			if (fk == "_"){
				fk = n.substring(0,i);
				fn = n.substring(i+1,l);
				break;
			}
		}
		
		fn = eval(fn + "+ 1");
		fk = fk + "_" + fn;
		//存在才跳
		if ( $(fk) != null){
			$(fk).focus();
		}else{
			return;
		}
	}
}

function keyhandleupdown(obj){
	e = window.event;
	
	var keycode = e.which ? e.which : e.keyCode; 
	if ( keycode == 38 ){
		var n = obj.id;
		var l = n.length;
		var fk,fn;
		for (var i = l - 1; i >= 0;i--){
			fk = n.substring(i,i+1);
			if (fk == "_"){
				fk = n.substring(0,i);
				fn = n.substring(i+1,l);
				break;
			}
		}
		
		fn = eval(fn + "- 1");
		fk = fk + "_" + fn;
		//存在才跳
		if ( $(fk) != null){
			$(fk).focus();
		}
	} else if ( keycode == 40 ){
				var n = obj.id;
		var l = n.length;
		var fk,fn;
		for (var i = l - 1; i >= 0;i--){
			fk = n.substring(i,i+1);
			if (fk == "_"){
				fk = n.substring(0,i);
				fn = n.substring(i+1,l);
				break;
			}
		}
		
		fn = eval(fn + "+ 1");
		fk = fk + "_" + fn;
		//存在才跳
		if ( $(fk) != null){
			$(fk).focus();
		}
	}
}

//合并订单
function mergerorder(){
	window.location.href = "outorder_merger.jsf";
}



function merger(obj){
	var biids = Gtable.getselectid(obj);
	//alert(biids);
	if(biids.length<=0){
		alert("请选择需要合并的订单!");
		return false;
	}else{
		$("edit:orderlist").value = biids;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
	return false;
}
//导出开始
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


function startDo(){
    Gwallwin.winShowmask("TRUE");
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

	// 打开选择批量选择添加商品信息页面
function showAddDetail(){
	showModal('addDetail.jsf','900','528');
	
}


// 批量添加明细
function addDetails(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	if(incos.length<=0){
		alert("请选择需要添加的商品!");
		return false;
	}else{
		$("edit:sellist").value = incos;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

//结束批量添加明细
function endAddDetails(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value
	alert(msg);
	parent.window.document.getElementById("edit:refBut").onclick();
}

 function cleartext(){
 	if($("edit:id")!=null){
 		$("edit:id").value = "";
 	}
 	if($("edit:asco")!=null){
 		$("edit:asco").value = "";
 	}
 	if($("edit:psco")!=null){
 		$("edit:psco").value = "";
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
//
function updateCarrier(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	var lpco = $('edit:lpco').value;
	var flag = $('edit:sk_flag').value;
	/*
	if(flag!='11'){
		alert("请选择正式单据!");
		return false;
	}else*/
	if(biids.Trim().length<=0){
		alert("请选择需要修改的单据!");
		return false;
	}else  if(lpco.Trim().length<=0){
		alert("请选择一个物流商!");
		return false;
	}else{
		if(confirm("确定要修改物流商吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}

function endDo(){
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="outorder_edit.jsf";
    }else{
    	alert(message);
    }
    Gwallwin.winShowmask('FALSE');
}


 function clearfina(){
 	if($("edit:oori")!=null){
 		$("edit:fina").value = "";
 		$("edit:finm").value = "";
 	}
 }
 
  function clearoori(){
 	if($("edit:fina")!=null){
 		$("edit:oori").value = "";
 	}
 }
 
function endLoad(){
	Gwallwin.winShowmask('FALSE');
}

function getVouch(){
	if($('edit:getvouch')){
		startDo();
		$('edit:getvouch').click();
	}
}

function Edit(vc_voucherid){	
	if($("edit:biid")!=null){
		$("edit:biid").value=vc_voucherid;
	}
	$("edit:editbut").click();
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
}


function search(){
	Gwallwin.winShowmask("TRUE");
}

function endSearch(){
	Gwallwin.winShowmask("FALSE");
}

/**回车监听*/
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
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


function clearSearchKey(){
	textClear('edit','sk_biid,start_date,loco,end_date,sk_lodt_start,sk_lodt_end,sk_endt_start,sk_endt_end,start_date_padt,end_date_padt,sk_cuid,sk_cbid,sk_whfl,issp','Y');
	textClear('edit','iscancle,sk_flag,sk_soco,crna,orid,sk_chdt_start,sk_chdt_end,rena,inty,lico,loco','N');
	textClear('edit','paty,tale,invo,stat,sk_inco,sk_fopl,lpco,arealist,lockwhid,fgallery,ogallery,loco,baqty,eaqty','N');
	selectAllItems('edit:foplList',true);
	$('edit:foplList:5').checked = true;
	$('edit:foplList:8').checked = true;
	selectAllItems('edit:shopList',true);
}

function doDeleteDetail(obj){
	var ids = Gtable.getselectid(obj);
	//var ids = Gtable.getselcolvalues(obj,'hid_voucherid');
	if(ids.length>0){
		if(confirm("确定要打印当前你选中的记录吗？")){
		startDo();
			$("edit:deleteitemid").value=ids;
			return true;
		}else{
		Gwallwin.winShowmask("FALSE");
			return false;
		}
	}else{
		alert("请选择你要打印的订单记录!");
		Gwallwin.winShowmask("FALSE");
		return false;
	}
}

//跳转添加
function addNew(){
	window.location.href = "outorder_add.jsf";
}

function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
}


//调整商品
function modifyinco(){
	var biids = Gtable.getselcolvalues('gtable','inco');
	var bids = biids.split("#@#");
	//alert(biids);
	if(biids.Trim().length<=0){
		alert("请选择需要调整的商品!");
		return false;
	}
	if(bids.length!=1){
		//alert()
		alert("每次只能调整一种商品!");
		return false;
	}
	else{
		if(confirm("确定要调整选中商品吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:inco1").value=biids;
			//alert($("edit:inco1").value)
			document.getElementById("edit:refBut").onclick();
			showModal('material.jsf','500','200');
			return true;
		}
	}
}

function checkMerger(){

	var oorid = $("edit:oinco").value;
	var norid = $("edit:ninco").value;
	if(norid==null||norid.Trim().length<=0){
		alert("调整后的商品编码不能为空!");
		$("edit:ninco").focus();
		return false;
	}
	if(oorid==norid){
		alert("调整前后的商品编码不能相同!");
		$("edit:ninco").value='';
		return false;
	}
	return true;
}


 function clearData(){
	textClear('edit','ninco','N');
	document.getElementById("edit:refBut").onclick();
 }
function finishcheckMerger(){
	var message = $("edit:msg").value;
	alert(message);
	if(message.indexOf('调整成功')!=-1){
     	window.close();
     	//alert(window.dialogArguments.document.getElementById("showRe"));
     	window.dialogArguments.document.getElementById("edit:showRe").onclick();
    	//Gwallwin.winShowmask("TRUE");
    }
   Gwallwin.winShowmask("FALSE");
}


//添加单据完成
function endHeadAdd(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("成功")!=-1){
		window.location.href="saleorder_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
}
	
function finishMergerOrder(){
	var message = $("edit:msg").value;
	alert(message);
    Gwallwin.winShowmask("FALSE");
}
function addHead(){
	/*
	if($("edit:whna")==null || $("edit:whna").value.Trim().length<=0){
		alert("出库仓库不能为空!");
		return false;
	}
	*/
	if($("edit:orid")==null || $("edit:orid").value.Trim().length<=0){
		alert("组织架构不能为空!");
		return false;
	}
	/*
	if($("edit:cuid")==null || $("edit:cuid").value.Trim().length<=0){
		alert("客户不能为空!");
		return false;
	}*/
	Gwallwin.winShowmask("TRUE");
	return true;
}

// 关闭
function closeVouch(){
	if(!confirm('确定关闭当前单据吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			return true;
		}
}
function endCloseVouch(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
// 弃审
function unApp(){
	if(!confirm('确定弃审当前单据吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			return true;
		}
}
function endUnApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	document.getElementById("edit:showRe").onclick();
}

//删除明细
function delDetail(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value=arr;
		}
    }else{
	   	alert("请选择要删除的记录!");
	   	return false;
    }
	return true;
}
//完成删除明细
function endDelDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function hideDiv(){
	Gwallwin.winClose();		
}

// 打开选择商品信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:ninco');
	return false;
}

// 打开选择组织架构页面
function selectOrga(){
	showModal('../../common/orga/gtree.jsp?retid=edit:orid&retname=edit:orna');
	return false;
}

// 打开选择库位页面
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna');
	return false;
}

// 打开客户选择页面
function selectCuin(){
	showModal('../../common/customer_sel/customer_sel.jsf?retid=edit:cuid&retname=edit:cuna');
	return false;
}

// 打开客户选择页面
function selectCuin1(){
	var cori = $("edit:cori").value;
	showModal('../../common/customer_sel/customer_sel.jsf?retid=edit:fina&retname=edit:finm&retorid='+cori);
	if($("edit:finm")!=null && $("edit:finm").value.Trim().length>0){
		$("edit:oori").value = "";
	}
	return false;
}

//删除单据(首页)
function deleteHeadAll(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
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


//确认通过的订单
function isED(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.Trim().length<=0){
		alert("请选择需要允许发货的单据!");
		return false;
	}else{
		if(confirm("确定要允许选中单据发货吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}

// 结束确认通过的订单
function endIsED(){
	if($("edit:msg").value.indexOf("已允许订单发货")!=-1){
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
	Gwallwin.winShowmask("FALSE");
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href = "outorder.jsf";
	}
}

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:ninco")==null || $("edit:ninco").value.Trim().length<=0){
		alert("商品编码不能为空!");
		$("edit:ninco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
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
		$("edit:ninco").value = "";
		$("edit:qty").value = "";
		$("edit:ninco").focus();
	}
	Gwallwin.winShowmask("FALSE");
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

//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var prs = /^\d{0,}\.{0,1}\d{0,}$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
//	var prics = Gtable.getcolvalues('gtable','pric');
//	alert("qtys:"+qtys);
//	alert("prics:"+prics);
	
	var qty = qtys.split("#@#");
//	var pric = prics.split("#@#");
	
	
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
		}
	//	if(!prs.test(pric[i])){
	//		msg += "第"+(i+1)+"行价格格式错误!  \n";
	//	}
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
function isDouble(e) {

	var key = (e.keyCode || e.which);
	
	return ((key >= 48 && key <= 57) || (key == 8 || key == 13 || key == 46));
}
//结束添加明细
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

function initEdit(){
	textClear('edit','ninco,qty','N');
}

//审核
function checkApp(){
	if(!confirm("确定审核当前单据吗?")){
		return false;
	}
	var bity = $("edit:bity").value
	var infl = $("edit:infl").value
	if(bity=='EBUS'||bity=='import'){
		var lpco = $("edit:lpco").value;
		if(lpco.length==0){
			alert('物流商不能为空!');
			return false;
		}
	}
	if((bity=='KA'||bity=='POS')&&infl==1){
		var oori = $("edit:oori").value
		var finm = $("edit:finm").value
		if(oori.length==0 && finm.length==0){
			alert("‘目标公司(专柜)’和‘最终客户’至少需要选择一个!");
			return false;
		}
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

//结束审核
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	document.getElementById("edit:showRe").onclick();
}

function backList(){
	window.location.href="outorder.jsf";
}

function gotoImp(){
	window.location.href="outorder_import.jsf";
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

function changeStat(){
	var flag = $('edit:flag').value;
	if(flag>=11){
		startDo();
		$('edit:hidupbut').click();
	}	
}

function endChaStat(){
	endLoad();
	var msg = $("edit:msg");
	if(msg.value.indexOf('成功')<0){
		alert(msg.value);
	}
}


//同步淘宝订单(首页)
function downloadTaobaoData(){
	if(confirm("确定要同步订单吗?")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

// 结束同步淘宝单据(首页)
function endDownloadTaobaoData(){
	if($("edit:msg").value.indexOf("同步成功")!=-1){
		alert($("edit:msg").value);
	}else{
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
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
function selectuser()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
}

//生成任务
function createTask()
{
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		alert("请选择要生成备货任务的订单!");
		return false;
	}else{
		$("edit:sellist").value = biids;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
	return false;
}

function endCreateTask()
{
	Gwallwin.winShowmask("FALSE");
	alert($("edit:msg").value);	
}

function isCreateTask(){
	if(confirm("确定按系统订单合并规则自动生成备货任务?")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}

function goToErr(param){
	if(param==1){
		window.location.href='outorder_errorder.jsf?isAll=0';
	}else if(param==0){
		window.location.href='outorder.jsf?isAll=0';
	}
}

// 关闭
function errorso2task(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		alert("请勾选需要生成任务的订单!");
		return false;
	}else{
		if(!confirm('请将异常订单和已拣商品放入拣货车,并确认与列表勾选订单一致?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}

function endErrorso2task(){
	Gwallwin.winShowmask("FALSE");
	var message = $("edit:msg").value;
	if(message.indexOf("成功")!=-1){
		type = "Y";
	}else{ 
		type = "X";
	}
	Gwin.alert("系统提示",message,type,document);
}

function isToTask(){
	if(!confirm('点击确定系统会把未锁定的且在架可用库存足够的商品生成备货任务,\n生成备货任务后仍然存在未锁定数量,可以继续点击生成任务,是否确定?')){
		return false;
	}else{
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

function endSoInv(){
	Gwallwin.winShowmask("FALSE");
	var message = $("edit:msg").value;
	clearSearchKey();
	if(message.indexOf("成功") < 0){
		type = "X";
		Gwin.alert("系统提示",message,type,document);
	}
}

//统计选中的销售订单个数   --hwf--
function selectorder(){
	$('edit:orderNumBut').click();
}
function getOrderNums(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		$('edit:ordernums').value=0;
	}
	else{
		var orderlist = biids.split("#@#");
		var ordernums=orderlist.length;
		$('edit:ordernums').value=ordernums;
	}
}

//选中订单，生成调拨计划，根据订单内容自动生成计划明细
function creatTranPlan(){
	var biids = Gtable.getselcolvalues('gtable','hid_biid');
	if(biids.length<=0){
		alert("请选择需要生成调拨计划的订单!");
		return false;
	}else{
		var flags = Gtable.getselcolvalues('gtable','flag');
		if(flags.indexOf('16')!=-1 || flags.indexOf('17')!=-1){
			if(confirm("勾选的订单中存在已拣货的商品，确定商品已放回原库位？\n否则订单关闭后请把中已拣下的商品放回原库位！")){
				$("edit:sellist").value = biids;
				Gwallwin.winShowmask("TRUE");
				return true;
			}
		}else{
			if(confirm("确定生成调拨计划?")){
				$("edit:sellist").value = biids;
				Gwallwin.winShowmask("TRUE");
				return true;
			}
		}
	}
	return false;
}


