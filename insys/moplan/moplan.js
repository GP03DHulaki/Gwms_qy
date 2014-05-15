<!--
function doSearch(){
	$("list:sid").click();
}

function startDo(){
    Gwallwin.winShowmask("TRUE");
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

function endDo(){
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="moplan_edit.jsf";
    }else{
    	alert(message);
    }
    Gwallwin.winShowmask('FALSE');
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

// 导出数据
function showOutput1(tableid){
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

//打印条码
function print()
{
	var msg = "";
	var incos = Gtable.getselcolvalues('gtable','inco');
	var qtys = Gtable.getselcolvalues('gtable','barnum');
	var statnum = Gtable.getselcolvalues('gtable','statnum');
	var inco = incos.split('#@#');
	var qty = qtys.split('#@#');
	var stat = statnum.split('#@#');
	if(incos.length>0){
		incos = "";
		qtys = "";
		for(i=0;i<stat.length;i++){
			if(stat[i] == 0){
				incos = incos + inco[i] + "#@#";
				qtys = qtys + qty[i] + "#@#";
			}else{
				msg = msg + "商品"+inco[i]+"已打印过,无法重复打印! \n" ;
			}
		}
		if(incos.length>0){
			if(confirm(msg + "是否继续打印未打印条码？")){
				Gwallwin.winShowmask("TRUE");
				$("edit:sellist").value=incos;
				$("edit:selqtys").value=qtys;
			}else{
				return false;
			}
		}else{
			alert(msg);
			return false;
		}
		
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

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			textClear('edit','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date,dpid,dpna');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('edit','sk_biid,sk_crna,sk_start_date,sk_end_date,sk_flag,orid,dpid,dpna');
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
	window.location.href = "moplan_add.jsf";
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
		window.location.href="moplan_edit.jsf";
	}else{
	
	}
	Gwallwin.winShowmask("FALSE");
}
	
function addHead(){
	/*
	if($("edit:whna")==null || $("edit:whna").value.Trim().length<=0){
		alert("出库仓库不能为空!");
		return false;
	}
	
	if($("edit:orna")==null || $("edit:orna").value.Trim().length<=0){
		alert("组织架构不能为空!");
		return false;
	}
	if($("edit:cuid")==null || $("edit:cuid").value.Trim().length<=0){
		alert("客户不能为空!");
		return false;
	}
	*/
	Gwallwin.winShowmask("TRUE");
	return true;
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
	showModal('../../common/inve/inve.jsf?retid=edit:inco');
	return false;
}

// 打开选择商品信息页面
function showAddDetail(){
	showModal('addDetail.jsf','780','660');
	
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

// 打开选择组织架构页面
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}

// 打开选择库位页面
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna&pwid=all');
	return false;
}

// 打开客户选择页面
function selectCuin(){
	showModal('../../common/customer_sel/customer_sel.jsf?retid=edit:cuid&retname=edit:cuna');
	return false;
}

// 打开部门选择页面
function selectDept(){
	showModal('../../common/dept_sel/dept_sel.jsf?retid=edit:dpid&retname=edit:dpna');
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
		window.location.href = "moplan.jsf";
	}
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
	var msg = $("edit:msg").value
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	//var showTable = window.dialogArguments.document.getElementById("edit:showTable")
	//if(showTable != null){
	//	alert("执行");
	//	showTable.onclick();
	//}
	// window.close();

}

// 添加明细
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
	var num = /^[0-9]\d*$/;
	var num1 = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var inpas = Gtable.getcolvalues('gtable','inpa');
	var qty = qtys.split("#@#");
	var inpa = inpas.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行计划数量格式错误!  \n";
		}
		if(!num1.test(inpa[i])){
			msg += "第"+(i+1)+"行包装方式格式错误!  \n";
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