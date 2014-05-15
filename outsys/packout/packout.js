
function addNew(){
	window.location.href="packout_add.jsf";
}


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

function valuechanger(){
	var obj = $("edit:soty").value;
	var count = obj.indexOf('@');
	var count2 = obj.indexOf(',');
	var sotyv = obj.substring(0,count);
	var maint = obj.substring(count+1,count2);
	
	$("edit:sotyvalue").value=sotyv;
	$("edit:maintable").value=maint;
}

//打开调整库存页面
function openMod(){
	var url="modstock.jsf?dety="+$('edit:dety').value+"&time="+new Date().getTime();
	showModal(url,630,550);
}

//关闭窗体
function closewin(){
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
			}else{
				callBack = parent;
			}
			isGwin ? Gwin.close(document.GwinID) : window.close();	
	
}

function modstock(){
 	Gwallwin.winShowmask("TRUE");
 	return true;
}
function endmostock(){
	var msg = $("edit:msg").value;
	if("ok"!=msg){
		alert(msg);
	}
	parent.$('ifpackdetail').contentWindow.renderTable();
	SetCwinHeight('ifpackdetail');
	Gwallwin.winShowmask("FALSE");
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function startApp(){
	//var arr = Gtable.getselcolvalues("gtable2","inco");
	//if(arr==null ||  arr.length<=0){
		if(confirm("确定要审核吗?")){
		 	Gwallwin.winShowmask("TRUE");
		 	return true;
		}else{
			return false;
		}
	//}
}

function endDo(){
	
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf('删除成功')!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	if(msg.indexOf('单据添加成功')!=-1){
		Gwallwin.winShowmask("FALSE");
		window.location.href="packout_edit.jsf?time="+new Date().getTime();
	}
	Gwallwin.winShowmask("FALSE");
}

function Edit(vc_voucherid){	
	if($("edit:vc_voucherid")!=null){
		$("edit:vc_voucherid").value=vc_voucherid;
	}
	
	//$("edit:nv_fromvoucherid").value=nv_fromvoucherid;
	$("edit:editbut").click();
}

function doSearch(){
	$("edit:sid").click();
}

function formsubmit(){
	if (event.keyCode==13){
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}

function doaddetail(){
	if (event.keyCode==13){
		var obj=$("edit:addDBut");
		if($("edit:baco")!='' && $("edit:qty")!=''){
			obj.onclick();
			return true;
		}
	}
}

function cleartext(){
	$("edit:searchpicktaskkey").value="";
}

function clearDetail(){
	textClear('edit','vc_warehouseid,vc_barcode,dc_qty');
}

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			textClear('edit','sk_voucherid,start_date,end_date,sk_flag,sk_fomvoucherid,vc_barcode');
			$('edit:sk_flag').value="01";
		}
	}else{
		textClear('edit','sk_voucherid,start_date,end_date,sk_flag,sk_fomvoucherid,vc_barcode');
		//$('edit:sk_flag').value="01";
	}
}

function addClear(){
	textClear('edit','soco,nv_remark');
	$('edit:biid').value="自动生成";
//	$("edit:dety").value="02";
//	$("opna_td1").style.display = 'none';
//	$("opna_td2").style.display = 'none';
//	$('edit:opna').value="";
//	$('edit:bity').value="01";
}


function selectFromNo(){
	//打开选择
		showModal('selectOrder.jsf',600,300);
}

function goEdit(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value;
	if(msg.Trim()=="保存成功!" || msg.Trim()=="添加成功!"){
	//window.location.href="pickdown_edit.jsf?time="+new Date().getTime();
		//savecleartext();
		$("edit:editbut").click();
	}else{
		alert(msg);
		//savecleartext();
	}
}


function savecleartext(){
	$("edit:nv_dealer").value="";
	$("edit:nv_address").value="";

}

/*
function doAddDetail(){
	if (event.keyCode==13){
		if(!int_validator($("edit:dc_qty"),'Y')){
			alert("数量输入错误!");
			return false;
		}
		var obj=$("edit:addDBut");
		if(obj){
			obj.onclick();
		}
		return true;
	}else{
		return true;
	}
}
*/
function checkAdd(){
	var code = $("edit:baco");
	if(code.value.Trim()=='' || code.value==null ){
		alert('条码不能为空!');
		code.focus();
		return false;
	}
	if($("edit:qty").value=='' || $("edit:qty").value==null){
		if(!int_validator($("edit:qty"),'Y')){
			alert("数量输入错误!");
			return false;
		}
		alert("数量不能为空!");
		$("edit:qty").focus();
		return false;
	}
	startDo();
	return true;
}

//打开添加页面
function showAddDetail(){
	Gwallwin.winShowmask("TRUE");
	showModal("addDetail.jsf",'750','480');
	Gwallwin.winShowmask("FALSE");
}

function checkSkip(vc_invcode,vc_warehouseid,dc_qty){
	if(confirm('确定跳过当前货位?')){
		$('edit:skp_invcode').value=vc_invcode;
		$('edit:skp_warehouseid').value=vc_warehouseid;
		$('edit:skp_qty').value=dc_qty;
		$('edit:skipBut').onclick();
	}
}

function showAll(){
	showModal("showAllInventory.jsf","700px","420px");
}
function headCheck(){
	
//	if($("edit:dety")==null || $("edit:dety").value.length<=0){
//		alert("请选择业务类型!");
//		$("edit:dety").focus();
//		return false;
//	}
	if($('edit:soty')==null||$('edit:soty').value.length<=0){
		alert("请选择拆包来源类型!");
		$('edit:soty').focus();
		return false;
	}
	if($('edit:soco')==null||$('edit:soco').value.length<=0){
		alert("请选择拆包来源单号!");
		$('edit:soco').focus();
		return false;
	}
	Gwallwin.winShowmask('TRUE');
	return true;
}

//显示层

function showDiv(title){
	Gwallwin.winShow("edit",title,260);	
}

//隐藏层
function hideDiv(){
	Gwallwin.winClose();		
}

//批量删除
function doDeleteAll(obj){
	var arr=Gtable.getselcolvalues(obj,'biids');
	if(arr.length>0){		    	
		if(!confirm('确定删除当前单据吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:item").value=arr;
		}
	}else{
	   	alert("请选择要删除的单据!");
	   	return false;
	}
	return true;		
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

function doDeleteAll2(obj){
	if(!confirm('确定删除当前单据吗?')){
		return false;
	}else{
		Gwallwin.winShowmask("TRUE");
		$("edit:item").value=$("edit:biid").value;
		return true;
	}
}

function endDo2(){
	var msg = $("edit:msg");
	alert(msg.value);
	Gwallwin.winShowmask("FALSE");
	if(msg.value.indexOf('删除成功')!=-1){
		window.location.href="packout.jsf?isAll=0&time="+new Date().getTime();
	}
}

function initEdit(){
	textClear('edit','baco,qty','Y');
}

//初始化edit
function initDetail(){
	t = new TailHandler('in');
	if($("edit:qty")!=null){
		$('edit:batp:1').checked = true;
		$('edit:qty').value='1';
		$('edit:autoItem').value='1';
	}
	t.setLastElement('edit:qty');
}

function selectCode(){
	/*
    if(i==Obj.length){
    	alert("没有选择条码类型！");
    	return false;
    }
    */
    var batp = t.getBatp();//获得条码类型编码
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'710px','550px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=1&retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'380px','450px');
    }
	return true;
}

//开始添加明细
function addDetails(){
	var incos = Gtable.getselcolvalues('gtable','inco');
	var qtys = Gtable.getselcolvalues('gtable','qty');
	if(incos.length<=0){
		alert("请选择需要重新打包的商品!");
		return false;
	}else{
		$("edit:sellist").value = incos;
		$("edit:qtys").value = qtys;
		parent.Gwallwin.winShowmask("TRUE");
		return true;
	}
}
// 完成添加明细
function endAddDetails(){
	
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("添加成功")!=-1){
		alert("添加成功");
	}else{
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}

function initAdd(){
	var batp = t.getBatp();
	if( batp=='02' || (batp=='04' && t.getIsAutoAdd()=='0') ){
		textClear('edit','baco,qty','Y');
	}else{
		textClear('edit','baco','Y');
	}
}

function endCode4DBean(){
	Gwallwin.winShowmask("FALSE");
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
	}
}

function changeEvent(obj){
	if(obj.value=='01'){
		$("opna_td1").style.display = 'none';
		$("opna_td2").style.display = 'none';
	}else{
		$("opna_td1").style.display = '';
		$("opna_td2").style.display = '';
	}
	$('edit:opna').value="";
}


function doConFirm(msg){
	if(!confirm(msg)){
		return false;
	}else{
		Gwallwin.winShowmask("TRUE");
		return true;
	}
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


function renderGtable(gcolumnid,expression){
	var i = 1;
	var gid=$(gcolumnid+'_'+i);
	var exp = expression.split(':');
	if(exp.length>0){
		name = exp[0];
		value = exp[1];
		while(gid){
			gid.style[name] = value;
			i++;
			gid = $(gcolumnid+'_'+i);
		}
	}
}

function showPkDetail(boid,crdt){
	var url = "showpackdetail.jsf";
	url = url+"?boid="+boid+"&crdt="+crdt;
	showModal(url,600,500,parent.document);
}

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

function endmostock1(pboid){
	var msg = $("edit:msg").value;
	if("ok"!=msg){
		alert(msg);
	}
	if(msg.indexOf('成功')>0 && pboid!=''){
		parent.Gwallwin.winShowmask("TRUE");
		parent.$('ifpackdetail').contentWindow.print2PDF(pboid);
		parent.$('ifpackdetail').contentWindow.renderTable();
		parent.$('ifpackdetail').contentWindow.renderGtable('gtable2_detail','color:#0000FF');
		parent.$('ifpackdetail').contentWindow.renderGtable('gtable2_pirint','color:#0000FF');
		//SetCwinHeight('ifpackdetail');
	}
	Gwallwin.winShowmask("FALSE");
}