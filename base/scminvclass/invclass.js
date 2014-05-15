<!--
	
	function doSubmit()
	{
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
	
	function startDo(){
		Gwin.progress("",10,document);
	}

	var delstate = false;
    function deleteAll(obj)	{	
    	if(delstate){
			delstate = false;
			return true;
		}else{
			var arr = Gtable.getselectid($(obj.id));
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
		var inty = $("edit:inty");
		var upty = $('edit:upty');
		if(inty==null || inty.value.Trim().length<=0){
			Gwin.alert("系统提示","商品类别编码不能为空!","!",document);
			inty.focus();
			return false;
		}else{
			if(existzh_CN(inty.value)){
				Gwin.alert("系统提示","商品类别编码不能为中文!","!",document);
//				inty.value="";
				inty.select();
				return false;
			}
		}

		if($("edit:tyna").value.Trim().length <= 0){
			Gwin.alert("系统提示","商品类别名称不能为空!","!",document);
			$("edit:tyna").value="";
			$("edit:tyna").focus();
			return false;
		}
		
		if(upty==null || upty.value.Trim().length <= 0){
			Gwin.alert("系统提示","上级编码不能为空!","!",document);
			upty.value="";
			upty.focus();
			return false;
		}		
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function endDo(){
		Gwin.close("progress_id");
		//Gwallwin.winShowmask("FALSE");
		var message = $("edit:renderArea_mes").value;
		var type = "Y";
		if(message.indexOf("添加成功")!=-1 || message.indexOf("修改成功") != -1){
			textClear('edit','inty,tyna,upty,leve,rema','N');	
			Gwin.close("invclassWin");
		}
		if($("edit:updateflag").value == "EDIT"){
			$("edit:upty").disabled= "TRUE";
		}
		if(message.indexOf("成功")==-1){
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		$("edit:inty").disabled = "";
		$("edit:upty").disabled= "";
		$("intyid").innerHTML = "";
		showDiv("新增商品类别",500,200);
	}
	
	function showupty(){
		$("edit:inty").size = 15;
		if($("edit:upty").value.indexOf("ROOT")!=-1){
			$("intyid").innerHTML = "";
		}else{
			$("intyid").innerHTML = $("edit:upty").value;
		}
	}
	

	function clearText(){
		textClear('edit','inty,tyna,upty,leve,rema,bsul','N');
		$("edit:stat").value="1";
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"invclassWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:450,
			height:140,
			autoLoad:false,
			showbt:false,			
			lock:true
		}).show("invclassWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("invclassWin");
	}
	
	//显示层
	function showDiv(title,width,height){
		Gwin.open({
			id:"invclassWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:width,
			height:height,
			autoLoad:false,
			showbt:false,			
			lock:true
		}).show("invclassWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("invclassWin");
	}
	
	//隐藏层
	function hideDiv(){
		//Gwallwin.winClose();
		Gwin.close("invclassWin");
	}

	//编辑回调
	function Edit(id){
		showDiv("编辑物料信息");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value = "EDIT";
		$("edit:inty").disabled = "TRUE";
		$("edit:upty").disabled= "TRUE";
		Gwin.setLoadok("invclassWin");
		//Gwallwin.winShowmask("FALSE");
		//showDiv("编辑商品类别资料");
	}
	
	String.prototype.Trim=function(){
		return this.replace(/(^\s*)|(\s*$)/g, "");
	}
	
	function formsubmit(){
		if (event.keyCode==13)
		{
			var obj=$("list:sid");
			obj.onclick();
			return true;
		}
	}	
	
	function clearData(){
		if($('list:inty')!=null){
     		$('list:inty').value="";
     		$('list:inty').focus();
     	}
   		if($('list:tyna')!=null){
   			$('list:tyna').value="";
   		}
   		if($('list:stat')!=null){
   			$('list:stat').value="1";
   		}
	}
//-->	