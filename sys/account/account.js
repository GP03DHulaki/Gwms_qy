<!--
function doNew(){
	textClear("edit","vc_accountid,vc_year,vc_servername,vc_dbname,ch_status,vc_dbuser,vc_dbpw,ch_isdefault,nv_remark","N");
	$("edit:updflag").value="ADD";//此时是添加数据
	$("edit:vc_accountname").value="自动生成";
	Gwallwin.winShow('edit','新增帐套','550');
}
function formcheck()
{
	if($("edit:vc_accountid").value=="")
	{
		alert("帐套号不能为空!");
		$("edit:vc_accountid").focus();
		return false;
	}
	
	var year = $("edit:vc_year").value;
	if (!year) {
        alert('请输入年份');
        $("edit:vc_year").focus();
        return false;
    }
    if (year.length != 4) {
        alert('年份必须是4位');
        return false;
    }
    if (!(/^[0-9]+$/.test(year))) {
        alert('年份必须是数字');
        return false;
    }
	var date = new Date();
    var max = date.getFullYear();
    var min = 1925;

    var n = new Number(year);
    if ((n.valueOf() > max) || (n.valueOf() < min)) {
        alert('请输入正确的年份范围');
        return false;
    }
    
    
	if($("edit:vc_servername").value=="")
	{
		alert("链接服务器名不能为空!");
		$("edit:vc_servername").focus();
		return false;
	}
	if($("edit:vc_dbname").value=="")
	{
		alert("数据库名不能为空!");
		$("edit:vc_dbname").focus();
		return false;
	}
	if($("edit:vc_dbuser").value=="")
	{
		alert("数据登录用户名不能为空!");
		$("edit:vc_dbuser").focus();
		return false;
	}
	if($("edit:vc_dbpw").value=="")
	{
		alert("用户密码不能为空!");
		$("edit:vc_dbpw").focus();
		return false;
	}
	
	return true; 
}
function endDo()
{
	Gwallwin.winShowmask("FALSE");
	var msg = $("list:msg").value;
	alert(msg);
	if(msg.indexOf("添加成功")>=0)
	{
		Gwallwin.winClose();
	}
}

//编辑
function edit(selitem){
	$("edit:updflag").value="EDIT";//此时是修改数据
	$("edit:selitem").value = selitem;
	$("edit:editbut").click();
}
function deleteAll(obj)	{		
		var arr=Gtable.getselectid(obj);
    	if(arr.length>0){		    	
    		if(!confirm('确定删除当前记录吗?')){
				return false;
			}else{
				$("list:selitem").value=arr;
				startDo();
			}
	   }else{
		   	alert("请选择要删除的记录!");
		   	return false;
	   }
	   return true;					
	}
function startDo(){
	Gwallwin.winShowmask("TRUE");	
}
function formSubmit()
{
	if(event.keyCode==13)
	{
		$("list:sid").click();
		return true;
	}
	return false;
}

function validateYear(year) {
    if (!year) {
        alert('请输入年份');
        return false;
    }
    if (year.length != 4) {
        alert('年份必须是4位');
        return false;
    }
    if (!(/^[0-9]+$/.test(year))) {
        alert('年份必须是数字');
        return false;
    }
	var date = new Date();
    var max = date.getFullYear();
    var min = 1925;

    var n = new Number(year);
    if ((n.valueOf() > max) || (n.valueOf() < min)) {
        alert('输入正确的时间范围');
        return false;
    }
    return true;

}


//-->