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
		$("edit:lico").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("新增品牌");
	}

	function clearText(){
		textClear('edit','lico,lina,ceve,phon,adde,emai,rema,suty,cous','N');
		$('edit:stat').value='1';
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"lineWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:500,
			height:150,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("lineWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("lineWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("lineWin");	
	}
	
	//编辑回调
	function Edit(id){
		showDiv("编辑");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:lico").disabled = "true";
		Gwin.setLoadok("lineWin");
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
		var lico = document.getElementById("edit:lico");
		if(lico==null || lico.value.Trim().length<=0){
			Gwin.alert("系统提示","品牌编码不能为空！","!",document);
			$("edit:lico").focus();
			return false;
		}else{
			if(existzh_CN(lico.value)){
				Gwin.alert("系统提示","路线编码不能为中文!","!",document);
				lico.value="";
				lico.focus();
				return false;
			}
		}
		var lina = document.getElementById("edit:lina");
			if(lina==null || lina.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:lina").focus();
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
			Gwin.close("lineWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}

	function clearData(){
		if($('list:lico')!=null){
			$('list:lico').value="";
			$('list:lico').focus();
		}
		if($('list:lina')!=null){
   			$('list:lina').value="";
   			
   		}
	}
	
//-->