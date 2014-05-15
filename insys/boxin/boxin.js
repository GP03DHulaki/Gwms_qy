
function addNew(){
	window.location.href="boxin_add.jsf";
}

function selectSoco(){
	showModal("soco.jsf?retid=edit:soco");
	return false;
}
//修改单据选择来源单号
function selectMSoco(){
	showModal("soco.jsf?retid=edit:m_soco");
	return false;
}
//选择物料编码
function selectInco(){
	var soco = $("edit:soco").value;
	if(soco==null || soco.Trim().length<1){
		alert("来源单号不能为空！");
		return false;
	}else{
		showModal("inve.jsf?retid=edit:inco&soco="+soco);
		return false;
	}
}
//修改单据选择物料
function selectMInco(){
	var soco = $("edit:m_soco").value;
	if(soco==null || soco.Trim().length<1){
		alert("来源单号不能为空！");
		return false;
	}else{
		showModal("inve.jsf?retid=edit:inco&soco="+soco);
		return false;
	}
}
function updateHead(){
	var num = /^[1-9]\d*$/;
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("物料编码不能空!");
		$("edit:inco").focus();
		return false;
	}
	if($("edit:m_qty")==null || $("edit:m_qty").value.Trim().length<=0){
		alert("装箱数量不能能空!");
		$("edit:m_qty").focus();
		return false;
	}
	if(!num.test($("edit:m_qty").value.Trim())){
		alert("数量只能是正整数!");
		$("edit:m_qty").focus();
		return false;
	}
	return true;
}

function initAdd(){
	$("edit:biid").value="单号自动生成";
	textClear("edit","soco,inco,qty,rema","Y");
}

function endUpdate(){
	alert($("edit:msg").value);
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("修改成功")!=-1){
		window.location.href="boxin_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}

function addHead(){
	var num = /^[1-9]\d*$/;
	var soco = $("edit:soco").value;
	var inco = $("edit:inco").value;
	var qty = $("edit:qty").value;
	if(soco==null||soco.Trim().length<=0){
		alert("来源单号不能为空");
		return false;
	}
	else if(inco==null||inco.Trim().length<=0){
		alert("物流编码不能为空");
		return false;
	}
	else if(qty==null||qty.Trim().length<=0){
		alert("数量不能为空");
		return false;
	}
	
	else if(!num.test(qty.Trim())){
		alert("数量只能是正整数!");
		$("edit:qty").select();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
function endAddHead(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg!=null && $("edit:msg").value.Trim().indexOf("添加成功")!=-1)
		window.location.href="boxin_edit.jsf";
	else
		Gwallwin.winShowmask("FALSE");
}
function endUpdate(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("添加成功")!=-1){
		window.location.href="boxin_edit.jsf";
	}
}

function initDetail(){
	$("edit:baco").value="";
	$("edit:qty").value="";
}

function selectCode(){
	showModal("../../common/barcode_sel/barcode_sel.jsf?ctype=03&retid=edit:baco&retqty=edit:qty","750px","480px");
}

//清空单据查询数据
function clearData(){
	textClear('edit','sk_start_date,sk_end_date,sk_inco,sk_soco,sk_biid,sk_qty,sk_crna','N');
}

function addDetail(){
	var num = /^[1-9]\d*$/;
	var baco = $("edit:baco").value;
	var qty = $("edit:qty").value;
	if(baco==null||baco.Trim().length<=0){
		alert("条码不能为空");
		return false;
	}
	else if(qty==null||qty.Trim().length<=0){
		alert("数量不能为空");
		return false;
	}
	
	else if(!num.test(qty.Trim())){
		alert("数量只能是正整数!");
		$("edit:qty").select();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}

function delDetail(obj){
	var dids = Gtable.getselectid(obj);
	if(dids.length<=0){
		alert("请选择需要删除的行!");
		return false;
	}else{
		if(!confirm("确定删除选定行？")){
			return false;
		}else{
			$("edit:sellist").value = dids
			Gwallwin.winShowmask("TRUE");
			return true;
		}
	}
}

function deleteHeadAll(){
	var biids = Gtable.getselcolvalues('gtable','biids');
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

function endDelDetail(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

function endDeleteHeadAll(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

function app(){
	if(confirm("确定要审核单据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}

function endApp(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
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

//开始查询
function search(){
	var startDate =$("edit:sk_start_date").value;
	var enddate =$("edit:sk_end_date").value;
	if(startDate.Trim().length>0)
	{
		if(startDate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("开始日期格式错误!\n正确格式(YYYY-MM-DD)"+startDate);
	  		$("edit:sk_start_date").select();
	  		return false;
		}
	}
	if(enddate.Trim().length>0)
	{
		if(enddate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("结束日期格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:sk_end_date").select();
	  		return false;
		}
	}	
	return true;
}