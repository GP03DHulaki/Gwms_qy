

function addNew()
{
	window.location.href='returnputaway_add.jsf';
}

function selectSoco()
{
	showModal('selectSoco.jsf?');
}

function endAlertMsg()
{
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//初始化添加页面
function initAdd(){
	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
	if($("edit:orid")!=null){
		$("edit:orid").value="";
	}
	if($("edit:whna")!=null){
		$("edit:whid").value="";
	}
	if($("edit:opna")!=null){
		$("edit:opna").value="";
	}
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
}

function endAddHead()
{
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf('成功'))
	{
		window.location.href='returnputaway_edit.jsf';
	}
}

function addDetail()
{
	var num = /^[1-9][0-9]*$/
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("条码不能为空!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("数量不能为空!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("数量只能是正整数!");
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
	if(msg.indexOf("添加成功")!=-1){
		initEdit();
	}else{
		alert(msg);
		initEdit();
	}
	Gwallwin.winShowmask("FALSE");
}

//初始化Edit页面
function initEdit(){
	textClear('edit','baco,dwhid,qty','Y');
}

// 删除明细
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

// 打开选择库位页面
function selectWahod(){
	var url = "../../common/waho/waho.jsf?type=4,5,6,7,8&pwid="+$('edit:whid').value+"&retid=edit:dwhid&retname=";
	showModal(url);
	return false;
}

//删除单据(首页)
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
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("成功")!=-1){
		window.location.href = "returnputaway.jsf";
	}
}

function onchangeWhid()
{
	
}