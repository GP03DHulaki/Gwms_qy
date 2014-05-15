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
			Gwin.close("sysconfigWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
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
		if($("edit:syit").value==null ||$("edit:syit").value.length<=0){
			Gwin.alert("系统提示","参数项目不能为空!","!",document);
			$("edit:syit").focus();
			return false;
		}	
//		if($("edit:pait").value==null ||$("edit:pait").value.length<=0){
//			Gwin.alert("系统提示","父项目不能为空!","!",document);
//			$("edit:pait").focus();
//			return false;
//		}
		if($("edit:vaty").value==null ||$("edit:vaty").value.length<=0){
			Gwin.alert("系统提示","参数值类型不能为空!","!",document);
			$("edit:vaty").focus();
			return false;
		}
//		if($("edit:syva").value==null ||$("edit:syva").value.length<=0){
//			Gwin.alert("系统提示","参数值不能为空!","!",document);
//			$("edit:syva").focus();
//			return false;
//		}
		if($("edit:itde").value==null ||$("edit:itde").value.length<=0){
			Gwin.alert("系统提示","参数项目描述不能为空!","!",document);
			$("edit:itde").focus();
			return false;
		}
		if($("edit:itty").value==null ||$("edit:itty").value.length<=0){
			Gwin.alert("系统提示","参数类型不能为空!","!",document);
			$("edit:itty").focus();
			return false;
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:syit").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加系统参数");
	}

	function clearText(){
		$("edit:syit").value="";
		$("edit:pait").value="";
		$("edit:vaty").value="2";
		$("edit:syva").value="";	
		$("edit:sywp").value="";	
		$("edit:sylp").value="";
		$("edit:itde").value="";	
		$("edit:itty").value="S";
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑参数");
		$("edit:edit").click();
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		$("edit:syit").disabled="true";
		Gwin.setLoadok("sysconfigWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"sysconfigWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:190,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("sysconfigWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("sysconfigWin");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("sysconfigWin");
	}

//-->	