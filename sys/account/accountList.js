<!--
	var Obj=''; 
	document.onmouseup=MUp; 
	document.onmousemove=MMove;
	
	function MDown(Object)
	{ 
		Obj=Object.id; 
		document.all(Obj).setCapture(); 
		pX=event.x-document.all(Obj).style.pixelLeft; 
		pY=event.y-document.all(Obj).style.pixelTop; 
	}
	
	function MMove()
	{ 
		if(Obj!='')
		{ 
			document.all(Obj).style.left=event.x-pX; 
			document.all(Obj).style.top=event.y-pY; 
		} 
	}
	
	function MUp()
	{ 
		if(Obj!='')
		{ 
			document.all(Obj).releaseCapture(); 
			Obj=''; 
		} 
	} 			  				  
  
	function doSubmit()
	{
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
  			  			  
	function doDelete()
	{
	   countSelect();
	   if(selResult.length>0)
	   {
		if(!confirm('确定要删除当前记录吗?'))
			return false;
	    document.getElementById("list:item").value=selResult;
	 	 return true; 
	   }else
	   {
	   	alert('请选择需要进行删除的记录!');
	   	return false;
	   }
	}

	//点击"新增帐套"按钮时调用的方法
	function addDiv()
	{
		document.getElementById("add:nv_accountname").value="";
		document.getElementById("add:nv_accountserver").value="";
		document.getElementById("add:nv_accountdatabase").value="";
		document.getElementById("add:vc_accountlogin").value="";
		document.getElementById("add:vc_accountpassword").value="";
		document.getElementById("add:ch_accountstatus").value="0";
		document.getElementById("add:nv_accountparm").value="0";
		document.getElementById("add:nv_remark").value="";
		document.getElementById("add:asId").style.display="inline";
		document.getElementById("add:usId").style.display="none";				
		document.getElementById("dmId").innerText="\u65b0\u589e\u5e10\u5957";
		showDiv();
	}	
	//编辑帐套时所调用的方法
	function editDiv(accountBean)
	{	
		//给编辑页面赋值		
		document.getElementById("add:ii_accountid").value=accountBean.ii_accountid;								
		document.getElementById("add:nv_accountname").value=accountBean.nv_accountname;
		document.getElementById("add:nv_accountserver").value=accountBean.nv_accountserver;
		document.getElementById("add:nv_accountdatabase").value=accountBean.nv_accountdatabase;
		document.getElementById("add:vc_accountlogin").value=accountBean.vc_accountlogin;
		document.getElementById("add:vc_accountpassword").value=accountBean.vc_accountpassword;
		document.getElementById("add:ch_accountstatus").value=accountBean.ch_accountstatus;
		document.getElementById("add:nv_accountparm").value=accountBean.nv_accountparm;
		document.getElementById("add:nv_remark").value=accountBean.nv_remark;
		document.getElementById("add:asId").style.display="none";
		document.getElementById("add:usId").style.display="inline";							
		document.getElementById("dmId").innerText="编辑帐套";
		showDiv();
	}
	//编辑回调
	function Edit(id)
	{						
		var ii_accountid =id;				
		AccountBean.getAccountBean(ii_accountid,editDiv);
	}							
	//显示层
	function showDiv()
	{
		mask.style.visibility='visible';massage_box.style.visibility='visible';
	}
	//隐藏层
	function hideDiv()
	{
		massage_box.style.visibility='hidden';
		mask.style.visibility='hidden';
	}
	//表单验证
	function formcheck()
	{
		if(document.getElementById("add:nv_accountname")==null || document.getElementById("add:nv_accountname").value.length<=0)
		{
			alert("帐套名不能为空!");
			document.getElementById("add:nv_accountname").focus();
			return false;
		}
//		if(document.getElementById("add:nv_accountserver")==null || document.getElementById("add:nv_accountserver").value.length<=0)
//		{
//			alert("服务器不能为空!");
//			document.getElementById("add:nv_accountserver").focus();
//			return false;
//		}
		if(document.getElementById("add:nv_accountdatabase")==null || document.getElementById("add:nv_accountdatabase").value.length<=0)
		{
			alert("数据库不能为空!");
			document.getElementById("add:nv_accountdatabase").focus();
			return false;
		}				
		if(document.getElementById("add:vc_accountlogin")==null || document.getElementById("add:vc_accountlogin").value.length<=0)
		{
			alert("登录用户不能为空!");
			document.getElementById("add:vc_accountlogin").focus();
			return false;
		}
		if(document.getElementById("add:vc_accountpassword")==null || document.getElementById("add:vc_accountpassword").value.length<=0)
		{
			alert("用户密码不能为空!");
			document.getElementById("add:vc_accountpassword").focus();
			return false;
		}				
		return true;
	}
	//帐套成功保存完后调用的方法
	function endDo()
	{
		document.getElementById("add:nv_accountname").value="";
		document.getElementById("add:nv_accountserver").value="";
		document.getElementById("add:nv_accountdatabase").value="";
		document.getElementById("add:vc_accountlogin").value="";
		document.getElementById("add:vc_accountpassword").value="";
		document.getElementById("add:ch_accountstatus").value="0";
		document.getElementById("add:nv_accountparm").value="0";
		document.getElementById("add:nv_remark").value="";
	}
	//信息反馈
	function showMsg(){
		if(document.getElementById("add:mes")!=null){
			if(document.getElementById("add:mes").value.length>0){
				alert(document.getElementById("add:mes").value);
			}	
		}
	}
//-->