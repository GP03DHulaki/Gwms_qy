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
			Gwin.close("crinWin");
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
		if($("edit:cfco").value==null ||$("edit:cfco").value.length<=0){
			Gwin.alert("系统提示","工艺编码不能为空!","!",document);
			$("edit:cfco").focus();
			return false;
		}	
		if($("edit:cfna").value==null ||$("edit:cfna").value.length<=0){
			Gwin.alert("系统提示","工艺名称不能为空!","!",document);
			$("edit:cfna").focus();
			return false;
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(){
		$("edit:cfco").value="";
		$("edit:cfna").value="";
		$("edit:stat").value="1";
		$("edit:rema").value="";	

		$("edit:updateflag").value = "ADD";
		showDiv("添加工艺信息");
	}

	function clearText(){
		$("list:cfco").value="";
		$("list:cfna").value="";
		$("edit:cfco").value="";
		$("edit:cfna").value="";
		$("edit:stat").value="1";
		$("edit:rema").value="";	
		$("list:sid").click();
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑工艺信息");
		$("edit:edit").click();
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
//		$("edit:syit").disabled="true";
		Gwin.setLoadok("sizeWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"crinWin",	
			title:title,
			contextType:"ID",
			context:"editCrin",
			dom:document,
			width:420,
			height:170,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("crinWin");
		Gwin.setLoadok("crinWin");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("crinWin");
	}
	
	function clearData(){
		if($('list:cfco')!=null){
     		$('list:cfco').value="";
     		$('list:cfco').focus();
     	}
   		if($('list:cfna')!=null){
   			$('list:cfna').value="";
   		}
	}

//-->	