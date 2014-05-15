<!--
	var Obj=''; 
	
	function doSubmit(){
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
	
	function startDo(){
		 Gwin.progress("",10,document);
	}

	function endDo(){
		Gwin.close("progress_id");
		var message = $("edit:msg").value;
		var type = "X";
		if(message.indexOf("成功")!=-1){
			clearText();
			hideDiv();	
			type = "Y";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	//选择		
	function selectObj(url){	
		window.showModalDialog(url,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
		return false;
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
						Gwin.progress("正在删除...",10,document);
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
//		if($("edit:moid").value==null ||$("edit:moid").value.length<=0){
//			alert("模块ID不能为空!");
//			$("edit:moid").focus();
//			return false;
//		}	
		
//		if($("edit:pait").value==null ||$("edit:pait").value.length<=0){
//			alert("父项目不能为空!");
//			$("edit:pait").focus();
//			return false;
//		}

		if($("edit:mona").value==null ||$("edit:mona").value.length<=0){
			Gwin.alert("系统提示","模块名称不能为空!","!",document);
			$("edit:mona").focus();
			return false;
		}
		if($("edit:mdes").value==null ||$("edit:mdes").value.length<=0){
			Gwin.alert("系统提示","模块描述不能为空!","!",document);
			$("edit:mdes").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:moid").disabled="";
		$("edit:updateflag").value = "ADD";
		showDiv("添加模块");
	}

	function clearText(){
		$("edit:moid").value="";
		$("edit:mona").value="";
		$("edit:mdes").value="";
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑模块");
		$("edit:editbut").click();	
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		$("edit:moid").disabled = "true";
		Gwin.setLoadok("modulesetWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"modulesetWin",	
			title:title,
			contextType:"ID",
			context:"editdiv",
			dom:document,
			width:460,
			height:150,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("modulesetWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("modulesetWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("modulesetWin");	
	}

//-->	