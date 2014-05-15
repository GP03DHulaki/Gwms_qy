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
	
	function selWorkgroup(){
		showModal('../../common/workgroup/selectworkgroup.jsf?&time='+new Date().getTime() + '&retid=edit:vc_workgroupid&retname=edit:nv_workgroupname');
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
		var wid = $("edit:orid").value.Trim();
		var pid = $('edit:poid').value;
		if(wid==null || wid.Trim().length<=0){
			Gwin.alert("系统提示","组织架构编码不能为空!","!",document);
			$("edit:orid").focus();
			return false;
		}else{
			if(existzh_CN(wid)){
				Gwin.alert("系统提示","组织架构不能为中文!","!",document);
				$("edit:orid").value="";
				$("edit:orid").focus();
				return false;
			}
		}

		if($("edit:orna").value.Trim().length <= 0){
			Gwin.alert("系统提示","组织架构名称不能为空!","!",document);
			$("edit:orna").value="";
			$("edit:orna").focus();
			return false;
		}
		
		if($("edit:poid").value.Trim().length <= 0){
			Gwin.alert("系统提示","上级编码不能为空!","!",document);
			$("edit:poid").value="";
			$("edit:poid").focus();
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
			Gwin.close("organizeWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		showDiv("新增组织架构");
	}

	function clearText(){
		$("edit:orid").value="";
		$("edit:orna").value="";
		$("edit:poid").value="";
		$("edit:stat").value="1";
		$("edit:chie").value="";
		$("edit:addr").value="";
		$("edit:tele").value="";
		$("edit:rema").value="";
		$("edit:ifsv").value= "";
		$("edit:ifdb").value= "";
		$("edit:ifus").value= "";
		$("edit:ifpw").value= "";
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"organizeWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:480,
			height:230,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("organizeWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("organizeWin");
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("organizeWin");
	}

	//编辑回调
	function Edit(id){
		showDiv("编辑组织架构");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value = "EDIT";
		$("edit:orid").disabled = "TRUE";
		$("edit:poid").disabled= "TRUE";
		Gwin.setLoadok("organizeWin");
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
		if($('list:orid')!=null){
     		$('list:orid').value="";
     		$('list:orid').focus();
     	}
   		if($('list:orna')!=null){
   			$('list:orna').value="";
   		}
   		if($('list:stat')!=null){
   			$('list:stat').value="1";
   		}
	}
//-->	