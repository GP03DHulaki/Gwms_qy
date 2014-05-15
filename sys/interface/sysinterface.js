<!--
	var Obj=''; 
	
	function doSubmit(){
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
	
	function startDo(msg){
		Gwin.progress(msg,10,document);
	}

	function endDo(){
		Gwin.close("progress_id");
		var message = $("edit:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("sysinterfaceWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}

	function endRefreshFilter(){
		alert($("edit:msg").value);
	}

	var delstate = false;
	function deleteAll(obj)	{	
		if(delstate){
			delstate = false;
			return true;
		}else{
			var arr = Gtable.getselectid(obj);
			if(arr.length>0){
				Gwin.confirm("showMsg2","系统提示","确定要删除选中的数据吗?","?",document,
					[{lable:'确定',click:function(){
						$("list:sellist").value = arr;
						startDo("正在删除...");
						delstate = true;
						$("list:delButton").onclick();
						Gwin.close("showMsg2");
					}},
					{lable:'取消',click:function(){
						Gwin.close("showMsg2");
					}}]);
			}else{
				Gwin.alert("系统提示","请选择要需要删除的数据!","!",document);
		   }
		}
		return false;	
	}


	//验证id="edit"的form表单				
	function formCheck(){	
		if($("edit:ipid").value==null ||$("edit:ipid").value.length<=0){
			Gwin.alert("系统提示","IP地址不能为空!","!",document);
			$("edit:ipid").focus();
			return false;
		}	
		if($("edit:apse").value==null ||$("edit:apse").value.length<=0){
			Gwin.alert("系统提示","appSecret不能为空!","!",document);
			$("edit:apse").focus();
			return false;
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:ipid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加系统参数");
	}

	function clearText(){
		$("edit:ipid").value="";
		$("edit:apke").value="";
		$("edit:apse").value="";
		$("edit:rema").value="";	
		$("edit:statu").value="Y";
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:seid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑参数");
		$("edit:edit").click();
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		$("edit:ipid").disabled="true";
		Gwin.setLoadok("sysinterfaceWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"sysinterfaceWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:190,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("sysinterfaceWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("sysinterfaceWin");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("sysinterfaceWin");
	}

//-->	