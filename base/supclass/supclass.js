<!--
function doSubmit()
	{	
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
function formsubmit(){
		if (event.keyCode==13)
		{
			var obj=$("list:sid");
			obj.onclick();
			return true;
		}
	}	
	
	function startDo(){
		Gwin.progress("",10,document);
	}
	
	function addDiv(){
		clearText();
		$("edit:stco").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("新增供应商类别");
	}

	function clearText(){
		textClear('edit','stco,tyna,rema','N');
		$('edit:stat').value='1';
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"supclassWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:500,
			height:150,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("supclassWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("supclassWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("supclassWin");	
	}
	
	//编辑回调
	function Edit(id){
		showDiv("编辑供应商类别");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:stco").disabled = "true";
		Gwin.setLoadok("supclassWin");
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
	//验证form
	function formCheck(){
		var stco = document.getElementById("edit:stco");
		if(stco==null || stco.value.Trim().length<=0){
			Gwin.alert("系统提示","供应商类别编码不能为空！","!",document);
			$("edit:stco").focus();
			return false;
		}else{
			if(existzh_CN(stco.value)){
				Gwin.alert("系统提示","供应商类别编码不能为中文!","!",document);
				stco.value="";
				stco.focus();
				return false;
			}
		}
		var tyna = document.getElementById("edit:tyna");
			if(tyna==null || tyna.value.Trim().length<=0){
			Gwin.alert("系统提示","供应商类别名称不能为空！","!",document);
			$("edit:tyna").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}	
	
	function endDo()
	{	
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("supclassWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}

	function clearData(){
		if($('list:stco')!=null){
			$('list:stco').value="";
			$('list:stco').focus();
		}
		if($('list:tyna')!=null){
   			$('list:tyna').value="";
   			
   		}
	}
	
//-->