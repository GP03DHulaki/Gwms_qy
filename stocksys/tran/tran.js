<!--

function test(){
	var o = $("GtabPage_pdetail_te_0");
	
	var w;
	if(o.className == "hover"){
		w = $("ifplandetail").contentWindow;
	}else{
		w = $("iflockdetail").contentWindow;
	}
	w.getExcel();
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


function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function clearData(){
	if($("edit:start_date").value!=null || $("edit:start_date").value.trim().length>0){
		$("edit:start_date").value="";
	}
	if($("edit:end_date").value!=null || $("edit:end_date").value.trim().length>0){
		$("edit:end_date").value="";
	}
	if($("edit:sk_biid").value!=null || $("edit:sk_biid").value.trim().length>0){
		$("edit:sk_biid").value="";
	}
	if($("edit:sk_flag").value!=null || $("edit:sk_flag").value.trim().length>0){
		$("edit:sk_flag").value="";
	}
	if($("edit:outwhna").value!=null || $("edit:outwhna").value.trim().length>0){
		$("edit:outwhna").value="";
	}
	if($("edit:inwhna").value!=null || $("edit:inwhna").value.trim().length>0){
		$("edit:inwhna").value="";
	}
	if($("edit:orid").value!=null || $("edit:orid").value.trim().length>0){
		$("edit:orid").value="";
	}
	if($("edit:sk_inse").value!=null || $("edit:sk_inse").value.trim().length>0){
		$("edit:sk_inse").value="";
	}
	if($("edit:ifib").value!=null || $("edit:ifib").value.trim().length>0){
		$("edit:ifib").value="";
	}
}

function createTask(obj){
	var codes = Gtable.getselcolvalues(obj,'baco');
	var whids = Gtable.getselcolvalues(obj,'whid');
	if(codes==''){
		alert('请勾选明细!');
		return false;
	}
	if(confirm("确定将勾选项生成任务?")){
		$('edit:item').value=codes+','+whids;
		startDo();
		return true;
	}else{
		return false;
	}
}

function showImport(){
    parent.$("mes").innerHTML="";
    parent.Gwallwin.winShow("import","选择导入文件");	
}

function endDo(){
	Gwallwin.winShowmask('FALSE');
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="tran_edit.jsf";
    }else if(message!='解锁成功!'){
    	alert(message);
    }
}

function selectWaho1(retid,retname,reifib){
	showModal('waho.jsf?type=1&retid='+retid+'&retname='+retname+'&reifib='+reifib+'&pwid=all');
	 $("edit:ifibs").value= $("edit:ifib").value; 
	//alert($("edit:ifibs").value)
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
}

	// 打开选择库位页面
	var type="";
function selectWaho(retid,retname){
		showModal('waho.jsf?type=1&retid='+retid+'&retname='+retname+'&pwid=all');
		return true;
	}



// 打开选择库位页面(主页面)
	/*var type="";
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:pfwh&retname=edit:outwhna&pwid=all');
	return false;
}*/

	var retid = "", retpfid = "", retpoid = "";		//返回刷新的字段，如无，则不刷新
	function selectThis(parm1, parm2, parm3) {
		retid = $("edit:retid").value;
		retpfid = $("edit:retname").value;
		retpoid = $("edit:reifib").value;
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
		if (retid != "" && retid != null) {
			isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
		}
		if (retpfid != "" && retpfid != null) {
			isGwin ? parent.document.getElementById(retpfid).value = parm2 : callBack.document.getElementById(retpfid).value = parm2;
		}
		if (retpoid != "" && retpoid != null) {
			isGwin ? parent.document.getElementById(retpoid).value = parm3 : callBack.document.getElementById(retpoid).value = parm3;
		}
		
		isGwin ? Gwin.close(document.GwinID) : window.close();	
	}

	function formsubmit(){
		if (event.keyCode==13){
			var obj=$("edit:sid");
			obj.onclick();
			return true;
		}
	}
	
	function cleartext(){
		var a = $("edit:id");
		var b = $("edit:name");
		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
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

/**回车监听*/
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			textClear('list','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('list','sk_voucherid,start_date,end_date,sk_flag,sk_expressname,sk_barcode,sk_districtname,sk_customername,b_date,e_date');
	}
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
	window.location.href = "tran_add.jsf";
}

function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
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
	
function addHead(){
	//var orid = $("edit:orid");
	var pfwh = $("edit:pfwh");
	var powh = $("edit:powh");
	/*
	if(orid==null || orid.value.Trim().length<=0){
		alert("组织架构不能为空!");
		return false;
	}
	*/
	if(powh==null || powh.value.Trim().length<=0){
		alert("调入仓库不能为空!");
		return false;
	}
	if(pfwh==null || pfwh.value.Trim().length<=0){
		alert("调出仓库不能为空!");
		return false;
	}
	if(powh.value.Trim() == pfwh.value.Trim()){
		alert("调出仓库与调入仓库不允许相同!");
		return false;
	}
	
	Gwallwin.winShowmask("TRUE");
	return true;
}




//删除明细
function delDetail(obj){
	var arr=Gtable.getselcolvalues(obj,'roid');
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value=arr.replaceAll('#@#',',');
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
	showModal('../../common/inve/inve.jsf?retid=edit:inco');
	return false;
}

// 打开选择组织架构页面
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}

// 打开选择库位页面
//function selectWaho(id,name,type){
	/*
	if('fwh_img' == window.event.srcElement.id){
		var orig = $('edit:orid');
		if(orig.value.Trim().length<=0){
			alert('请先选择组织架构!');
			return false;
		}
		showModal('../../common/waho/waho.jsf?type='+type+'&retid='+id+'&retname='+name+'&orid='+orig.value);
	}else{
		showModal('../../common/waho/waho.jsf?type='+type+'&retid='+id+'&retname='+name);
	}
	*/
	//showModal('../../common/waho/waho.jsf?type='+type+'&retid='+id+'&retname='+name+'&pwid=all');
	//return true;
	
//}

// 打开客户选择页面
function selectCuin(){
	showModal('../../common/customer_sel/customer_sel.jsf?retid=edit:cuid&retname=edit:cuna');
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
		window.location.href = "tran.jsf";
	}
}

	// 打开选择商品信息页面
function showAddDetail(){
	showModal('addDetail.jsf','700','550',parent.document);
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
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	//window.parent.document.getElementById('learning_nav').innerHTML = '内容';

	var showTable = window.parent.document.getElementById("edit:showRe");
	
	if(showTable != null){	
		showTable.onclick();
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


function clearNoNum(obj){   
	obj.value = obj.value.replace(/[^\d.]/g,"");  //清除“数字”和“.”以外的字符  
	obj.value = obj.value.replace(/^\./g,"");  //验证第一个字符是数字而不是. 
	obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.   
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");

}



// 添加明细
/*function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("商品编码不能为空!");
		$("edit:inco").focus();
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
		$("edit:inco").value = "";
		$("edit:qty").value = "";
		$("edit:inco").focus();
	}
	Gwallwin.winShowmask("FALSE");
}
*/
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

function search(){
	Gwallwin.winShowmask("TRUE");
}

function endSearch(){
	Gwallwin.winShowmask("FALSE");
}

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
 	if($("edit:asco")!=null){
 		$("edit:asco").value = "";
 	}
 	if($("edit:psco")!=null){
 		$("edit:psco").value = "";
 	}
 	if($("edit:inpr")!=null){
 		$("edit:inpr").value = "0";
 	}
 }



//修改明细
//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[0-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行计划数量格式错误!  \n";
		}
		if(qty[i] <= 0){
			msg += "第"+(i+1)+"行计划数量必须大于零!  \n";
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

function initEdit(){
	textClear('edit','inco,qty','N');
}

//审核
function checkApp(){
	if(!confirm("确定审核当前单据吗?")){
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

//审核
function auditApp(){
	if(!confirm("确定回写当前单据的锁定数量?")){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
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


function SetCwinHeight(freamid){
	var iframe=document.getElementById(freamid); 
	if(!iframe){
		iframe=parent.document.getElementById(freamid); 
	}
	var bHeight = iframe.contentWindow.document.body.scrollHeight;
	var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
	var height = bHeight>dHeight?bHeight:dHeight;
	iframe.height = height;
}

function setlsDetailCol(gcolumnid,clickid){
	var i = 1;
	var gid = $(gcolumnid+'_'+i);
	while(gid){
		gid.style.color = '#000000';
		if(gid==$(clickid)){
			gid.style.color = 'red';
		}
		i++;
		gid = $(gcolumnid+'_'+i);
	}
}

function isLockBill(){
	if(!confirm('点击确定系统会继续锁定[锁定数量]小于[计划数量]的明细,是否确定?')){
		return false;
	}else{
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}