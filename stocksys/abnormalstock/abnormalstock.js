function clearError(obj){
	var ids = Gtable.getselectid(obj)
	if(ids.length<=0){
		alert("请选择需要删除的单据!");
		return false;
	}else{
		var id = ids.split(",");
		if(id.length>1){
			alert("只能选择一条异常进行清除!");
			return false;
		}
		if(confirm("确定要清除选中异常吗?")){
			if(confirm("是否已经查实异常库存存在于原货位?")){
				Gwallwin.winShowmask("TRUE");
				$("edit:id").value = ids;
				return true;
			}
		}
	}
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

function endClearError(){

	alert($("edit:msg").value);
	
	Gwallwin.winShowmask("FALSE");

}