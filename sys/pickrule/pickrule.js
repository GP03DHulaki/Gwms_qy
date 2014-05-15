

	function addNew()
	{
		showModal("../../common/inve/inve.jsf?retid=edit1:inco",'560px');
		return false;
	}
	function addDetail()
	{
		if($("edit1:inco").value == null || $("edit1:inco").value == '')
		{
			alert('物料编码不能为空!');
			return false;
		}
		return true;
	}
	
	function deleteDetail(obj)
	{
		var arr = Gtable.getselectid(obj);
		$("edit1:sellistEx").value = arr;
		return true;
	}
	
	function clearSearchKey()
	{
		$("edit1:eq_inco").value="";
		$("edit1:eq_crna").value="";
		$("edit1:inco").value="";
		$("edit1:inna").value="";
		$("edit1:rema").value="";	
	}
	
	function showMsg()
	{
		if($("edit1:msgEx").value != null && $("edit1:msgEx").value != '')
		{
			alert($("edit1:msgEx").value);
		}
	}
	
	function selectInve()
	{
		showModal("../../common/inve/inve.jsf?retid=edit1:inco&retname=edit1:inna",'560px');
		return false;
	}
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
		Gwallwin.winShowmask("FALSE");
		Gwin.close("progress_id");
		var message = $("edit:msg").value;
		$("edit:roleoperate").value="";
		var type = "X";
		if(message.indexOf("成功")!=-1){
			clearText();
			hideDiv();	
			type = "Y";
		}
		Gwin.alert("系统提示",message,type,document);
	//	window.location.reload(true);
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
//		if($("edit:ruid").value==null ||$("edit:ruid").value.length<=0){
//			Gwin.alert("系统提示","模板编码不能为空!","!",document);
//			$("edit:ruid").focus();
//			return false;
//		}
//		if($("edit:baru").value==null ||$("edit:baru").value.length<=0){
//			Gwin.alert("系统提示","规则不能为空!","!",document);
//			$("edit:baru").focus();
//			return false;
//		}
		
		
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:ruid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("添加系统参数");
	}

	function clearText(){
		//$("edit:ruid").value="";
		//$("edit:baru").value="";
		//$("edit:rema").value="";	
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
		$("edit:ruid").disabled = "true";
		Gwin.setLoadok("pickruleWin");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"pickruleWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:190,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("pickruleWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("pickruleWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("pickruleWin");		
	}
	
	function isCreateTask(){
		if(confirm("确定按系统订单合并规则自动生成备货任务?")){
			Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
	}

//-->	