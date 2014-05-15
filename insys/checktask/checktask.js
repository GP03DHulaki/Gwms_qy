function addNew()
{
	window.location.href="check_add.jsf";
}

function clearSoty()
{
	$("edit:soco").value = "";
}

function endAddHead()
{
	var msg = $("edit:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}

	if(msg.indexOf("成功")!=-1){
		window.location.href="check_edit.jsf";
	}
}

function printReport(){
	Gwallwin.winShowmask('TRUE');
}
function endPrintReport(){
	alert($("list:msg").value);
	if($("list:msg").value.indexOf("打印成功")!=-1){
		var filename=$("list:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}
	Gwallwin.winShowmask('FALSE');
}

function endApprove()
{
	Gwallwin.winShowmask('FALSE');
	var msg = $("list:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}

	if(msg.indexOf("成功")!=-1){
		window.location.href="check_edit.jsf";
	}
}

function endAddDetail()
{Gwallwin.winShowmask('FALSE');
	var msg = $("list:msg").value;
	alert(msg);
}

function clearSearchKey(){
	textClear('list','voucherid,start_date,end_date,socoid,creatorname,checkusername,sk_inna,sk_suna,flag','Y');
}

//打印
function printEnd(){
	var msf= $("list:msg").value;

	if(msf.indexOf("打印成功")!=-1){	
		Gwallwin.winShowmask("FALSE");	
		window.open('../..'+$("list:outfilename").value);
	}else{
		alert(msf);
		Gwallwin.winShowmask("FALSE");
	}
}

/**回车监听*/
function formsubmit_saveHead(event){
	if (event.keyCode==13)
	{
		var obj=$("list:addId");
		obj.onclick();
		return true;
	}
}
/**回车监听*/
function formsubmit_gotoQty(event){
	if (event.keyCode==13)
	{
		var obj=$("list:dc_qty");
		obj.focus();
		//obj.value=1;
		return true;
	}
}

function formsubmit_addDetail(event){
	if (event.keyCode==13)
	{
		var obj=$("list:addDBut");
		obj.onclick();
		return true;
	}
}

 function formsubmit()
{
	if (event.keyCode==13)
	{
		var obj=$("list:sid");
		obj.onclick();
		return true;
	}
}	
	
function checkBarcode()
{
	if($("list:inco").value=="")
	{
		alert("请输入商品编码!");
		$("list:inco").focus();
		return false;
	}
	
	if($("list:qty").value=="")
	{
		//	如果没有输入数量，则默认为1
		$("list:qty").value=1;
		//return false;
	}
	
	return true;
}
function endDoList(){
	var message = $('list:msg').value;
	if(message !='')
	{
		alert(message);	
	}
}

function Edit(vc_voucherid)
{
	if($("list:voucherid")!=null)
	{
		$("list:voucherid").value=vc_voucherid;
	}
	$("list:editbut").click();
}



function headCheck()
{
	if($("edit:vc_checkuserid")==null || $("edit:vc_checkuserid").value.length<=0)
	{
		alert("检验员不能为空!");
		return false;
	}
	if($("edit:soco")==null || $("edit:soco").value.length<=0)
	{
		alert("来源单号不能为空!");
		return false;
	}

	return true;
}
function doDeleteDetail(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length<=0){		    	
		alert("请选择需要删除的行!");
	   	return false;
	}
	if(confirm("确定要删除条码明细吗?")){
		$("list:item").value=arr;
		Gwallwin.winShowmask("TRUE");
		return true;
	}

	return false;
	
}
function doDeleteHeadOne()
{
	if(confirm("确定删除此单据吗?"))
	{
		$("list:item").value=$("list:vc_voucherid").value;
		return true;
	}else{
		return false;
	}
}

function doDeleteHeadAll(obj){

	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			$("list:item").value=arr;
		}
	}else{
	   	alert("请选择要删除的记录!");
	   	return false;
	}
	return true;		
}
function doCloseAll(obj){

	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定关闭当前记录吗?')){
			return false;
		}else{
			$("list:item").value=arr;
		}
	}else{
	   	alert("请选择要关闭的记录!");
	   	return false;
	}
	return true;		
}
function endUpdateDetail(){

	if($("list:msg").value != null)
	{
		var msgs = $("list:msg").value.split("###");
		var msg = "";
		for(var i =0; i < msgs.length; i++)
		{
			if(msgs[i].length > 0)
			{
				msg += msgs[i]+"\n";
			}
		}
		alert(msg);
	}else
	{
		alert($("list:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
	return true;		
}

function endUpdateDetailEx(){

	if($("list:msg").value != null)
	{
		var msgs = $("list:msg").value.split("###");
		var msg = "";
		for(var i =0; i < msgs.length; i++)
		{
			if(msgs[i].length > 0)
			{
				msg += msgs[i]+"\n";
			}
		}
		alert(msg);
	}else
	{
		alert($("list:msg").value);
	}
	window.location.href="check.jsf";
	Gwallwin.winShowmask("FALSE");
	return true;		
}

function selectCheckuserid()
{
	showModal("../../common/user/user.jsf?&retid=edit:vc_checkuserid&retname=edit:nv_checkusername","580px","380px");
}

function selectCheckBarCodeList()
{
	showModal("addDetail.jsf?&retid=edit:vc_checkuserid&retname=edit:nv_checkusername","600px","480px");
}

function selectCheckWarehouseIdList(obj)
{
	if(obj != null)
	{
		showModal("../../common/waho/waho.jsf?pwid=0&type=8&retid=list:"+obj+"&retname=list:rename&orid=all","580px","380px");
	}else
	{
		showModal("../../common/waho/waho.jsf?pwid=0&type=8&retid=list:whid&retname=list:rename&orid=all","580px","380px");
	}
}

function selectCheckWarehouseIdEdit()
{
	showModal("../../common/waho/waho.jsf?type=3&retid=edit:whid&retname=edit:rename&orid=all","580px","380px");
}

//选择采购订单
function selectSoco(){
	
//	var radio1 = $("edit:radio:0").checked;
//	var radio2 = $("edit:radio:1").checked;
//	var radio3 = $("edit:radio:2").checked;
	var url="";
	
//	if(radio1 == false && radio2 == false && radio3 == false)
//	{
//		alert('请选择来源类型!');
//		return;
//	}
	
//	if(radio1 == true)
//	{
//		url="selectSoco.jsf?retid=edit:soco"
//	}else if(radio2 == true)
//	{
		url = "selectOutputArrvie.jsf?retid=edit:soco";
//	}else
//	{
//		url = "selectfromvoucherid.jsf";
//	}
	showModal(url);
	return false;
}

/**调整质检数量
**/
function updateCheckDetailsEx()
{
	//编辑页面调整明细数量
	if(!confirm("确定要调整明细数量吗?")){
		return false;
	}
	var inco =  Gtable.getcolvalues("gtable","inco");
	var uqty = Gtable.getcolvalues("gtable","uqty");
	
	$("list:incos").value=inco;
	$("list:qtys").value=uqty;
	
	return true;
}

function approveVouch()
{
	//存储执行过程的数据
	var inco =  Gtable.getcolvalues("gtable","inco");
	var col_qty = Gtable.getcolvalues("gtable","qty");
	var col_aqty = Gtable.getcolvalues("gtable","aqty");
	var col_bqty = Gtable.getcolvalues("gtable","bqty");
	var col_cqty = Gtable.getcolvalues("gtable","cqty");
    //alert(col_qty+","+col_aqty+","+col_bqty+","+col_cqty+","+col_dqty+","+col_dqty);
    var inco_array = inco.split('#@#');
    var col_qty_array = col_qty.split('#@#');
    var col_aqty_array = col_aqty.split('#@#');
    var col_bqty_array = col_bqty.split('#@#');
    var col_cqty_array = col_cqty.split('#@#');

    if(col_qty_array.length > 0)
    {    	
   		for(var i=0; i < col_qty_array.length; i++)
   		{
   			/*
			if(parseInt(col_qty_array[i]) !=(parseInt(col_aqty_array[i])+parseInt(col_bqty_array[i])+parseInt(col_cqty_array[i])+parseInt(col_cqty_array[i])))
			{
				alert("第"+(i+1)+"行数量不正错! 合格+不合格 != 检验数");
				return false;
			}
			*/
			if(parseInt(col_qty_array[i]) <(parseInt(col_aqty_array[i])+parseInt(col_bqty_array[i])+parseInt(col_cqty_array[i])))
			{
				alert("第"+(i+1)+"行数量不正错! 合格+不合格+残次品数 > 检验数");
				return false;
			}
   		}	
	}else
	{
		alert('无审核记录!');
		return false;
	}
	if(confirm('确定[检验员]、[检验数量]正确,并审核该单据吗?'))
	{
		Gwallwin.winShowmask('TRUE');
		return true;
	}else{
		return false;	
	}
	return true;
}

function approveCreate()
{
	//存储执行过程的数据
	var col_qty = Gtable.getcolvalues("gtable","qty");
    var col_qty_array = col_qty.split('#@#');
	var colFlag = 0;
	for(var i=0; i < col_qty_array.length; i++)
  	{
		if(parseInt(col_qty_array[i]) < 1)
		{
			alert("第"+(i+1)+"行数量不正错! 检验数量必须大于零!");
			return false;
		}
		if(parseInt(col_qty_array[i]) > 0)
		{
			colFlag = 1;
		}
  	}
  	if(colFlag == 0)
	{
		alert('无任务记录!');
		return false;
	}
	
	if(confirm('确定[检验员]、[检验数量]正确,并生成检验任务吗?'))
	{
		Gwallwin.winShowmask('TRUE');
		return true;
	}else{
		return false;	
	}
	return true;
}

//初始化添加页面
function initAdd(){	
	$("edit:biid").value="自动生成";
	$("edit:vc_checkuserid").value="";
	$("edit:nv_checkusername").value="";
	//$("edit:whid").value="";
	$("edit:soco").value="";
	$("edit:rema").value="";
	
	//设置默认仓库
	//$("edit:whid")[0].selected=true;
}

//修改明细
function updateDetail(){
	Gwallwin.winShowmask("TRUE");
	
	var whidBiid = $("list:biid").value;
	//存储执行过程的数据
	var item ="";
	var inco =  Gtable.getcolvalues("gtable","inco");
	var col_qty = Gtable.getcolvalues("gtable","qty");
	var col_aqty = Gtable.getcolvalues("gtable","aqty");
	var col_bqty = Gtable.getcolvalues("gtable","bqty");
	var col_dqty = Gtable.getcolvalues("gtable","cqty");
	
    //alert(col_qty+","+col_aqty+","+col_bqty+","+col_cqty+","+col_dqty+","+col_dqty);
    var inco_array = inco.split('#@#');
    var col_qty_array = col_qty.split('#@#');
    var col_aqty_array = col_aqty.split('#@#');
    var col_bqty_array = col_bqty.split('#@#');
    var col_cqty_array = col_dqty.split('#@#');

    if(col_qty_array.length > 0)
    {
   		for(var i=0; i < col_qty_array.length; i++)
   		{	
   			/*
			if(parseInt(col_qty_array[i]) !=(parseInt(col_aqty_array[i])+parseInt(col_bqty_array[i])+parseInt(col_cqty_array[i])+parseInt(col_cqty_array[i])))
			{
				alert("第"+(i+1)+"行数量不正错! 合格+不合格 != 检验数");
				Gwallwin.winShowmask("FALSE");
				return false;
			}*/
			
			if(parseInt(col_qty_array[i]) <(parseInt(col_aqty_array[i])+parseInt(col_bqty_array[i])+parseInt(col_cqty_array[i])))
			{
				alert("第"+(i+1)+"行数量不正错! 合格+不合格 > 检验数");
				Gwallwin.winShowmask("FALSE");
				return false;
			}
			
			if(item == "")
			{
				item += "check,"+whidBiid+","+inco_array[i] +"," + col_aqty_array[i]+","+col_bqty_array[i]+","+col_cqty_array[i]+",04";
			}else
			{
				item +="#@#" + "check,"+whidBiid+","+inco_array[i] + "," + col_aqty_array[i]+","+col_bqty_array[i]+","+col_cqty_array[i]+","+",04";
			}
   		}
   	}
   	else
   	{
   		alert("没有保存的明细!");
   		Gwallwin.winShowmask("FALSE");
   		return false;
   	}
   
    var OkFlag = 0;
   	for(var i = 0;i < col_aqty_array.length;i++)
	{
		if(parseInt(col_aqty_array[i]) > 0 || parseInt(col_bqty_array[i]) > 0)
		{
			OkFlag = 1;
			break;
		}
	}
	
	var NoFlag = 0;
	for(var i = 0;i < col_cqty_array.length;i++)
	{
		if(parseInt(col_cqty_array[i]) > 0)
		{
			NoFlag = 1;
			break;
		}
	}
	
   
   $("list:item").value=item;
	return true;
}

//添加明细列表添加明细按钮
function addCheckDetails(){

	var socos = Gtable.getselcolvalues('gtable','biid');
	var incos = Gtable.getselcolvalues('gtable','inco');
	//质检总数
	var aqtys = Gtable.getselcolvalues('gtable','aqty');
	//待质检数量
	var dqtys = Gtable.getselcolvalues('gtable','dqty');
	//已质检数量
	var ckqtys = Gtable.getselcolvalues('gtable','ckqty');
	if(socos.Trim().length<=0 || incos.Trim().length<=0){
		alert("请勾选需要添加的明细!");
		return false;
	}
	var qtys = "";
	var aqtysArray = aqtys.split("#@#");
	var dqtysArray = dqtys.split("#@#");
	var ckqtysArray = ckqtys.split("#@#");
	for(var i =0; i < dqtysArray.length;i++)
	{
		if(parseInt(dqtysArray[i])+parseInt(ckqtysArray[i])>parseInt(aqtysArray[i]))
		{
			alert('第'+parseInt(i+1)+'行待检数量，大于总数量-已检数！');
			return false;
		}
		if(qtys == '')
		{
			qtys = parseInt(dqtysArray[i]);
		}else
		{			
			qtys = qtys + "#@#"+ (parseInt(dqtysArray[i]));
		}
	}
	
	$('edit:socos').value = socos;
	$('edit:incos').value = incos;
	$('edit:qtys').value = qtys;
	Gwallwin.winShowmask("TRUE");
	return true;
}

//更新明细列表
function updateCheckDetails(){

	var dids = Gtable.getcolvalues('gtable','did');
	var incos = Gtable.getcolvalues('gtable','inco');
	var qtys = Gtable.getcolvalues('gtable','qty');
	if(dids.Trim().length<=0 || incos.Trim().length<=0){
		alert("请勾选需要添加的明细!");
		return false;
	}
	
	//0不能被更新
	if(qtys.Trim().length<=0)
	{
		alert("数量不能为空!");
		return false;
	}
	var qtysArray = qtys.split("#@#");
	for(var i =0; i < qtysArray.length;i++)
	{
		if(parseInt(qtysArray[i]) < 1)
		{
			alert("第"+(i+1)+"数量不能为零!");
			return false;
		}
	}
	
	$('list:item').value = dids;
	$('list:incos').value = incos;
	$('list:qtys').value = qtys;
	Gwallwin.winShowmask("TRUE");
	return true;
}

//添加明细列表添加明细按钮
function endAddCheckDetails(){
	Gwallwin.winShowmask("FALSE");
	alert($('edit:msg').value);
	parent.document.getElementById("list:refBut").onclick();
	return true;
}
