
	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,parm2,isym,cori){
    	retid = $('edit:retid').value;
	    retname = $('edit:retname').value;

    	if ( retid != "" && retid != null){
			window.dialogArguments.document.getElementById(retid).value=parm1;
		}
		
		if ( retname != "" && retname != null){
			window.dialogArguments.document.getElementById(retname).value=parm2;
		}
		
		if (window.dialogArguments.document.getElementById('edit:isym')){
			window.dialogArguments.document.getElementById("edit:isym").value=isym
		}
		
		if (window.dialogArguments.document.getElementById('edit:cori')){
			window.dialogArguments.document.getElementById("edit:cori").value=cori
		}
		
		if(window.dialogArguments.document.getElementById('edit:stus')){
			window.dialogArguments.document.getElementById('edit:stus').focus();
		}
		
		window.dialogArguments.document.getElementById("edit:showMe").click();
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


//跳转到添加表头页面
function addNew(){
	 window.location.href='returnplan_add.jsf';
	 if($("edit:infl")!=null){
		$("edit:infl").value="";
	}
}
//添加表头清空
function initAdd(){   
   	textClear("edit","iorid,outorder,stdt,oori,whna,whid,stus,stna,rema,msg");
   	
   	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
}	
function initEdit(){
	//textClear("edit","start_date,end_date,sk_biid,sk_flag,orid");
}

function showImport(){
	$("mes").innerHTML="";
	Gwallwin.winShow("import","选择导入文件");	
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

function hideDiv(){
	Gwallwin.winClose();		
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
}

//跳转到添加表头页面
function addNew(){
	 window.location.href='returnplan_add.jsf';
}

function addHead(){

	if($("edit:buty").value.Trim().length==0 || $("edit:buty").value==""){
		alert("请选择业务类型");
		$("edit:buty").focus();
		return false;
	}
	
	if($("edit:stdt").value.Trim().length==0 || $("edit:stdt").value.Trim()==""){
		alert("请选择退货时间!");
		$("edit:stdt").focus();
		return false;
	}
	
	
	//if($("edit:whid").value.length==0 || $("edit:whid").value==""){
	//	alert("请选择退货入库仓库!");
	//	return false;
	//}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddHead(){

	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	if(msg.indexOf("单据添加成功")!=-1){
		window.location.href="returnplan_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}


// 打开选择出库订单
function selectoutorder(){
	showModal('../../common/outorder_sel/outorder_sel_return.jsf?&stus=edit:stus&retvid=edit:outorder&stna=edit:stna&retorid=');
	return false;
}

// 打开选择供应商页面
function selectstus(){
	showModal('customer_sel.jsf?retid=edit:stus&retname=edit:stna');
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
//选择商品
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
		window.location.href="returnplan.jsf";
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
/*function addDetail(){
	$("edit:incos").value="";
	var url="../../common/inve/manyInve.jsf?retid=edit:incos&retname="
	showModal(url,800,600);
	$("edit:insertadds").onclick();
	//insertin();
	return false;
}
*/



function insertin(){
	Gwallwin.winShowmask("TRUE");
	if($("edit:incos").value.length==0){
		Gwallwin.winShowmask("FALSE");
		return false;
	}
	return true;
}

function addDetail(){
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


// 批量添加明细
// 批量添加明细
function addDetails(){
	var incos = Gtable.getselcolvalues('gtable','inco'); //商品编码
	var biids = Gtable.getselcolvalues('gtable','biid'); //出库单号
	var qtys = Gtable.getselcolvalues('gtable','qty');	//数量
	if(incos.length<=0){
		alert("请选择需要添加的商品!");
		return false;
	}else{
		incos+="######"+biids;
		incos+="######"+qtys;
		$("edit:sellist").value = incos;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

//结束批量添加明细
function endAddDetails(){
	var msg = $("edit:msg").value
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	parent.window.document.getElementById("edit:refBut").onclick();
	//var showTable = window.dialogArguments.document.getElementById("edit:showTable")
	//if(showTable != null){
	//	alert("执行");
	//	showTable.onclick();
	//}
	// window.close();

}


//删除明细
function delDetail(obj){
var roids = Gtable.getselcolvalues(obj,'roid');
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



	// 打开选择商品信息页面
function showAddDetail(){
	showModal('addDetail.jsf','780','500');
	
}
function search(){
	Gwallwin.winShowmask("TRUE");
}

function endSearch(){
	Gwallwin.winShowmask("FALSE");
}


//function showOori(){
	//var cuid = $('edit:stus').value;
	//$('edit:oori').value = "";
	//if(cuid=='99601104'){
	//	$('oori').style.display='';
	//}else{
	//	$('oori').style.display='none';
//	}
//}
