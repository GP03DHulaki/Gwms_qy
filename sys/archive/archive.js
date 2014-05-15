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
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("archiveWin");
		}else{ 
			type = "X";
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
		if($("edit:arid").value==null ||$("edit:arid").value.length<=0){
			Gwin.alert("系统提示","归档编码不能为空!","!",document);
			$("edit:arid").focus();
			return false;
		}
		if($("edit:arpa").value==null ||$("edit:arpa").value.length<=0){
			Gwin.alert("系统提示","归档参数不能为空!","!",document);
			$("edit:arpa").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:arid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加数据归档");
	}

	function clearText(){
		$("edit:arid").value="";
		$("edit:arty").value="";
		$("edit:arpa").value="";
		$("edit:rema").value="";	
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑数据归档");
		$("edit:edit").click();	
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		//显示层	
		$("edit:arid").disabled = "true";
		Gwin.setLoadok("archiveWin");
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"archiveWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:460,
			height:160,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("archiveWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("archiveWin");
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("archiveWin");
	}

//-->	