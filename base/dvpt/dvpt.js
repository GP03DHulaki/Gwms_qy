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
			Gwin.close("dvptWin");
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
		if($("edit:pstn").value==null ||$("edit:pstn").value.length<=0){
			Gwin.alert("系统提示","部位编码不能为空!","!",document);
			$("edit:pstn").focus();
			return false;
		}	
		if($("edit:psna").value==null ||$("edit:psna").value.length<=0){
			Gwin.alert("系统提示","部位名称不能为空!","!",document);
			$("edit:psna").focus();
			return false;
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(){
		$("edit:pstn").value="";
		$("edit:psna").value="";
		$("edit:stat").value="1";
		$("edit:rema").value="";

		$("edit:updateflag").value = "ADD";
		showDiv("添加尺寸");
	}

	function clearText(){
		$("list:pstn").value="";
		$("list:psna").value="";
		$("edit:pstn").value="";
		$("edit:psna").value="";
		$("edit:stat").value="1";
		$("edit:rema").value="";	
		$("list:sid").click();
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		showDiv("编辑部位");
		$("edit:edit").click();
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
//		$("edit:syit").disabled="true";
		Gwin.setLoadok("dvptWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"dvptWin",	
			title:title,
			contextType:"ID",
			context:"editDvpt",
			dom:document,
			width:420,
			height:170,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("dvptWin");
		Gwin.setLoadok("dvptWin");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("dvptWin");
	}
	
	function clearData(){
		if($('list:pstn')!=null){
     		$('list:pstn').value="";
     		$('list:pstn').focus();
     	}
   		if($('list:psna')!=null){
   			$('list:psna').value="";
   		}
	}

//-->	