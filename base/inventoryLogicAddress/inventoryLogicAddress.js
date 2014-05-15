<!--
function EditLogicaddress(logicaddressid){
	showModal('logicaddrwh.jsf?logicaddressid='+logicaddressid,500,450);
}
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
	
//	// 打开WMS仓库编码页面
//	function selectInty(){
//		showModal('../../common/waho/waho.jsf?retid=edit:intywaid&retname=edit:waid');
//		return false;
//	} 
//	
//	// 打开SAP仓库编码页面
//	function selectintysapid(){
//		showModal('../../common/SAPWaho/SAPWaho.jsf?retid=edit:intysapid&retname=edit:sapid');
//		return false;
//	} 
	
	function addDiv(){
		clearText();
		$("edit:logicaddressid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("新增库存逻辑地点设置");
	}

	function clearText(){
		textClear('edit','logicaddressid,logicname,sapid,waid,remark','N');
		$('edit:state').value='1';
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"inventoryLogicAddressWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:550,
			height:200,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("inventoryLogicAddressWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("inventoryLogicAddressWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("inventoryLogicAddressWin");	
	}
	
	//编辑回调
	function Edit(id){
		showDiv("编辑库存逻辑地点");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		//$("edit:stco").disabled = "true";
		Gwin.setLoadok("inventoryLogicAddressWin");
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
		var logicaddressid = document.getElementById("edit:logicaddressid");
		if(logicaddressid==null || logicaddressid.value.Trim().length<=0){
			Gwin.alert("系统提示","库存逻辑地点编码不能为空！","!",document);
			$("edit:logicaddressid").focus();
			return false;
			}
//		}else{
//			if(existzh_CN(stco.value)){
//				Gwin.alert("系统提示","供应商类别编码不能为中文!","!",document);
//				stco.value="";
//				stco.focus();
//				return false;
//			}
//		}
		var logicname = document.getElementById("edit:logicname");
			if(logicname==null || logicname.value.Trim().length<=0){
			Gwin.alert("系统提示","库存逻辑地点名称不能为空！","!",document);
			$("edit:logicname").focus();
			return false;
		}
//		var sapid = document.getElementById("edit:sapid");
//			if(sapid==null || sapid.value.Trim().length<=0){
//			Gwin.alert("系统提示","SAP仓库编码不能为空！","!",document);
//			$("edit:sapid").focus();
//			return false;
//		}
//		var waid = document.getElementById("edit:waid");
//			if(waid==null || waid.value.Trim().length<=0){
//			Gwin.alert("系统提示","WMS仓库编码不能为空！","!",document);
//			$("edit:waid").focus();
//			return false;
//		}
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
		hideDiv();
		Gwin.alert("系统提示",message,type,document);
	}

	function clearData(){
		if($('list:logicaddressid')!=null){
			$('list:logicaddressid').value="";
			$('list:logicaddressid').focus();
		}
		if($('list:logicname')!=null){
   			$('list:logicname').value="";
   			
   		}
		if($('list:sapid')!=null){
   			$('list:sapid').value="";
   			
   		}
		if($('list:waid')!=null){
   			$('list:waid').value="";
   			
   		}
		if($("list:flags")!=null){
			$("list:flags").value = "00";
		}
		
		
		
		
	}
	
//-->