<!--
function doSearch(){
	$("list:sid").click();
}



function startDo(){
	
   //if($("edit:biid")==null || $("edit:biid").value.Trim().length<=0){
	//	alert("请输入出库订单!");
		//return false;
	//}
    Gwallwin.winShowmask("TRUE");
    return true;
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


function endDo(){
	Gwallwin.winShowmask('FALSE');
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="picksche_edit.jsf";
    }else{
    	alert(message);
    }
}

// 打开选择仓库页面
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&retid=edit:whid&retname=edit:whna&pwid=all');
	return false;
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


	function cleartext(){
	if($("edit:biid").value!=null || $("edit:biid").value.trim().length> 0){
			$("edit:biid").value =""
			
	}
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
