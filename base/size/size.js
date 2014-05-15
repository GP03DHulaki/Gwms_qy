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
			Gwin.close("sizeWin");
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
		if($("edit:szco").value==null ||$("edit:szco").value.length<=0){
			Gwin.alert("系统提示","尺码编码不能为空!","!",document);
			$("edit:szco").focus();
			return false;
		}	
		if($("edit:szna").value==null ||$("edit:szna").value.length<=0){
			Gwin.alert("系统提示","尺码名称不能为空!","!",document);
			$("edit:szna").focus();
			return false;
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(){
		clearText();
//		$("edit:syit").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加尺寸");
	}

	function clearText(){
		$("list:szco").value="";
		$("list:szna").value="";
		$("edit:szco").value="";
		$("edit:szna").value="";
		$("edit:szde").value="";
		$("edit:stat").value="1";
		$("edit:rema").value="";	
		$("list:sid").click();
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑尺码");
		$("edit:edit").click();
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
//		$("edit:syit").disabled="true";
		Gwin.setLoadok("sizeWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"sizeWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:420,
			height:170,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("sizeWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("sizeWin");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("sizeWin");
	}
	
	function clearData(){
		if($('list:szco')!=null){
     		$('list:szco').value="";
     		$('list:szco').focus();
     	}
   		if($('list:szna')!=null){
   			$('list:szna').value="";
   		}
	}

//-->	