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
		if($("edit:ruid").value==null ||$("edit:ruid").value.length<=0){
			Gwin.alert("系统提示","模板编码不能为空!","!",document);
			$("edit:ruid").focus();
			return false;
		}
		if($("edit:baru").value==null ||$("edit:baru").value.length<=0){
			Gwin.alert("系统提示","规则不能为空!","!",document);
			$("edit:baru").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:ruid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加系统参数");
	}

	function clearText(){
		$("edit:ruid").value="";
		$("edit:baru").value="";
		$("edit:rema").value="";	
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑系统参数");
		$("edit:edit").click();	
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		//显示层	
		$("edit:ruid").disabled = "true";
		Gwin.setLoadok("barcoderuleWin");
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"barcoderuleWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:170,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("barcoderuleWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("barcoderuleWin");
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("barcoderuleWin");		
	}

	function seladd(){
		var sel = $('edit:keys').value;
		var baru = $('edit:baru');
		baru.value = baru.value + sel;
		baru.focus();
	}
	
//-->	