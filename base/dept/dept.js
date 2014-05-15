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
		var dpid = $("edit:dpid");
		var upid = $('edit:upid');
		if(dpid==null || dpid.value.Trim().length<=0){
			Gwin.alert("系统提示","部门编码不能为空!","!",document);
			dpid.focus();
			return false;
		}else{
			if(existzh_CN(dpid.value)){
				Gwin.alert("系统提示","部门编码不能为中文!","!",document);
				dpid.value="";
				dpid.focus();
				return false;
			}
		}

		if($("edit:dpna").value.Trim().length <= 0){
			Gwin.alert("系统提示","部门名称不能为空!","!",document);
			$("edit:dpna").value="";
			$("edit:dpna").focus();
			return false;
		}
		
		if(upid==null || upid.value.Trim().length <= 0){
			Gwin.alert("系统提示","上级编码不能为空!","!",document);
			upid.value="";
			upid.focus();
			return false;
		}		
		
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function endDo(){
		Gwin.close("progress_id");
		var message = $("edit:renderArea_mes").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("deptWin");
		}else{ 
			type = "X";
		}
		if($("edit:updateflag").value == "EDIT"){
			$("edit:upid").disabled= "TRUE";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		$("edit:dpid").disabled = "";
		$("edit:upid").disabled= "";
		showDiv("新增部门");
	}

	function clearText(){
		textClear('edit','dpid,dpna,upid,leve,rema,geco,udid','N');
		$("edit:stat").value="1";
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"deptWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:180,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("deptWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("deptWin");
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("deptWin");	
	}

	//编辑回调
	function Edit(id){
		showDiv("编辑");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value = "EDIT";
		$("edit:dpid").disabled = "TRUE";
		$("edit:upid").disabled= "TRUE";
		Gwin.setLoadok("deptWin");
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
		if($('list:dpid')!=null){
     		$('list:dpid').value="";
     		$('list:dpid').focus();
     	}
     	if($('list:udid')!=null){
   			$('list:udid').value="";
   		}
   		if($('list:dpna')!=null){
   			$('list:dpna').value="";
   		}
   		if($('list:stat')!=null){
   			$('list:stat').value="1";
   		}
	}
	
	function setCode(){
		var upid = $('edit:upid');
		var dpid = $('edit:dpid');
		if(dpid && upid){
			if(upid.value.Trim()=='ROOT'){
				dpid.value= '';
			}else{
				dpid.value=upid.value;
			}
		}
	}
//-->	