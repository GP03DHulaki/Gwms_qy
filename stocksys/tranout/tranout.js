<!--
function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function endDo(){
	Gwallwin.winShowmask('FALSE');
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="tranout_edit.jsf";
    }else{
    	alert(message);
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
	window.location.href = "tranout_add.jsf";
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
		window.location.href="tranout_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
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
	showModal("../../common/stin/stin.jsf?retid=edit:inco&whid="+$('edit:dwhid').value+"&retname=",'560px');
	return false;
}

// 打开选择库位页面
function selectWaho(retid,retname){
	showModal('../../common/waho/waho.jsf?type=1&retid='+retid+'&retname='+retname+'&pwid=all');
	return true;
}
function selectWaho1(retid,retname){
	showModal('waho.jsf?type=1&retid='+retid+'&retname='+retname+'&pwid=all');
	return true;
}

// 打开出库订单选择页面
function selectFrom(){
	showModal('../../common/tran_sel/tran_sel.jsf?retvid=edit:soco&retpfid=edit:pfwh&retpoid=edit:powh');
	return false;
}

function selectDWare(){
	var pwid = $('edit:pfwh').value;
	var url = '../../common/waho/waho.jsf?type=4,5,6,7,8&retid=edit:dwhid&pwid=&retname=';
	showModal(url);
	return false;
}

	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,parm2){
    	
    	retid = $('edit:retid').value;
	    retname = $('edit:retname').value;
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
    	if ( retid != "" && retid != null){
			callBack.document.getElementById(retid).value=parm1;
		}
		
		if ( retname != "" && retname != null){
			callBack.document.getElementById(retname).value=parm2;
		}
		window.close();	
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
		window.location.href = "tranout.jsf";
	}
}

// 添加明细
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("商品条码不能为空!");
		$("edit:baco").focus();
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
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value
	if(msg.indexOf("添加成功")!=-1){
		$("edit:baco").value = "";
		$("edit:baco").focus();
	}
	else {
		$("edit:baco").value = "";
	}
	alert(msg);
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

function selectInveAdd(){

	var batp = t.getBatp();//获得条码类型编码
	var dwhid = "";
    if($('edit:dwhid')){
    	dwhid = $('edit:dwhid').value;
    }
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&dwhid="+dwhid,'710px','550px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&dwhid="+dwhid,'380px','450px');
    }
	return true;
}

function initEdit(){
	t = new TailHandler('out');
	textClear('edit','qty,dwhid','N');
}
function initDetail(){
if($('edit:batp:0')){
	t = new TailHandler('in');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	}
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

function changeFrom(){
	$('edit:fwna').value = '';
	$('edit:owna').value = '';
	$('edit:soco').value = '';
	$('edit:pfwh').value = '';
	$('edit:powh').value = '';
	if($('edit:soty').value==''){
		$('soco_td').style.display = 'none';
		$('owid_img').style.display = '';
		$('iwid_img').style.display = '';
		
	}else{
		$('soco_td').style.display = '';
		$('owid_img').style.display = 'none';
		$('iwid_img').style.display = 'none';
	}
}

function addHead(){
	if($('edit:soty').value==''){
		if($("edit:pfwh")==null || $("edit:pfwh").value.Trim().length<=0){
			alert("出库仓库不能为空!");
			return false;
		}
		if($("edit:powh")==null || $("edit:powh").value.Trim().length<=0){
			alert("入库仓库不能为空!");
			return false;
		}
		if($("edit:pfwh").value.Trim()==$("edit:powh").value.Trim()){
			alert("出入库仓库不能相同!");
			return false;
		}
	}else{
		if($("edit:soco")==null || $("edit:soco").value.Trim().length<=0){
			alert("来源单号不能为空!");
			return false;
		}
		if($("edit:pfwh")==null || $("edit:pfwh").value.Trim().length<=0){
			alert("来源单据未指定出库仓库!");
			return false;
		}
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}


function finishimport(){
	var message = $("edit:msg").value;
	alert(message);
		Gwallwin.winShowmask("FALSE");
	if(message.indexOf('导入计划明细成功')!=-1){
     	//alert(window.dialogArguments.document.getElementById("showRe"));
     	$("edit:refBut").onclick();
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
	window.open( projectName+'/excel/tranoutdetail.xls','newwindow');
}