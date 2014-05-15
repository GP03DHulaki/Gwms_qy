<!--

var retid="",retname="";		//返回刷新的字段，如无，则不刷新

   function selectThis(parm1,parm2){
   	retid = $('edit:retid').value;
    retname = $('edit:retname').value;

   	if ( retid != "" && retid != null){
		window.dialogArguments.document.getElementById(retid).value=parm1;
	}
	
	if ( retname != "" && retname != null){
		window.dialogArguments.document.getElementById(retname).value=parm2;
	}

	window.close();	
   }

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
    	window.location.href="picksche_edit.jsf";
    }else{
    	alert(message);
    }
}

// 打开选择仓库页面
function selectWaho(){
	showModal('waho.jsf?type=4&retid=edit:whid&retname=edit:whna&pwid=all');
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

	function cleartext(){
	if($("edit:obid").value!=null || $("edit:obid").value.trim().length> 0){
			$("edit:obid").value =""
			$("edit:obid").focus();
	}

	if($("edit:inco").value!=null || $("edit:inco").value.trim().length> 0){
			$("edit:inco").value =""
	}
	
	if($("edit:inna").value!=null || $("edit:inna").value.trim().length> 0){
			$("edit:inna").value =""
	}
	if($("edit:whid").value!=null || $("edit:whid").value.trim().length> 0){
			$("edit:whid").value =""
			
	}
	if($("edit:whna").value!=null || $("edit:whna").value.trim().length> 0){
			$("edit:whna").value =""
	}
	if($("edit:cuna").value!=null || $("edit:cuna").value.trim().length> 0){
			$("edit:cuna").value =""
	}
	if($("edit:sk_chdt_start").value!=null || $("edit:sk_chdt_start").value.trim().length> 0){
			$("edit:sk_chdt_start").value =""
	}
	if($("edit:sk_chdt_end").value!=null || $("edit:sk_chdt_end").value.trim().length> 0){
			$("edit:sk_chdt_end").value =""
	}
}

	function clearData(){
		if($("edit:id").value!=null || $("edit:id").value.trim().length> 0){
				$("edit:id").value =""
		}
		
		if($("edit:name").value!=null || $("edit:name").value.trim().length> 0){
				$("edit:name").value =""
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
