function addNew()
{
	window.location.href="returncheck_add.jsf";
}

//初始化添加页面
function initAdd(){	
	$("edit:biid").value="自动生成";
	$("edit:vc_checkuserid").value="";
	$("edit:nv_checkusername").value="";
	$("edit:suna").value="";
	$("edit:suid").value="";	
	$("edit:rema").value="";
	
	//设置默认仓库
	//$("edit:whid")[0].selected=true;
}

function doDeleteHead()
{
	$("list:item").value = $("list:biid").value;
	return true;
}

function doDeleteHeadAll()
{
	var biids =  Gtable.getselcolvalues("gtable","biid");
	if(biids == '')
	{
		alert('请选择删除行!');
		return false;
	}
	$("list:item").value = biids;
	return true;
}

function endDoList()
{
	var msg = $("list:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}
	window.location.href="returncheck.jsf";
}

function addReturnCheckDetails()
{
	var url = 'returnaddDetail.jsf?cbiid='+$("list:biid").value;	
	showModal(url,'580','520');
}

function endAddHead()
{
	var msg = $("edit:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}

	if(msg.indexOf("成功")!=-1){
		window.location.href="returncheck_edit.jsf";
	}
}

function addDetails()
{
	var socos =  Gtable.getselcolvalues("gtable","biid");
	var incos = Gtable.getselcolvalues("gtable","inco");
	var qtys = Gtable.getselcolvalues("gtable","wqty");
	if(socos == '' || incos == '' && qtys == '')
	{
		alert('请选择添加行!');
		return false;
	}
	$("edit:socos").value = socos;
	$("edit:incos").value = incos;
	$("edit:qtys").value = qtys;
	Gwallwin.winShowmask('TRUE');
	return true;
}

function doDeleteDetail()
{
	var dids =  Gtable.getselcolvalues("gtable","did");
	if(dids == '')
	{
		alert('请选择删除行!');
		return false;
	}
	$("list:item").value = dids;
	Gwallwin.winShowmask('TRUE');
	return true;
}

function endAddDetails()
{
	var msg = $("edit:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}
	Gwallwin.winShowmask('FALSE');
	parent.document.getElementById("list:refBut").onclick();
}

function endAddDetail()
{
	var msg = $("list:msg").value;
	if(msg!="")	
	{
		alert(msg);
	}
	Gwallwin.winShowmask('FALSE');
}

function approveVouch()
{
	$("list:item").value = $("list:biid").value;
	if($("list:item").value == '')
	{
		alert('删除单号不能为空!');
		return false;
	}
	return true;
}

function headCheck()
{
	if($("edit:vc_checkuserid")==null || $("edit:vc_checkuserid").value.length<=0)
	{
		alert("检验员不能为空!");
		$("edit:vc_checkuserid").focus();
		return false;
	}
	
	if($("edit:suid")==null || $("edit:suid").value.length<=0)
	{
		alert("供应商不能为空!");
		$("edit:suid").focus();
		return false;
	}

	return true;
}

function selectCheckuserid()
{
	showModal("../../common/user/user.jsf?&retid=edit:vc_checkuserid&retname=edit:nv_checkusername","580px","380px");
}

// 打开选择供应商页面
function selectSuin(){
	showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna','528','525');
	return false;
}
