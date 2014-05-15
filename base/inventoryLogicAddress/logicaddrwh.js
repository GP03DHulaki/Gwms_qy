
	
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
	
	// 打开WMS仓库编码页面
	function selectInty(){
		showModal('../../common/waho/waho.jsf?retid=edit:intywaid&retname=edit:waid');
		return false;
	} 
	
	// 打开SAP仓库编码页面
	function selectintysapid(){
		showModal('../../common/SAPWaho/SAPWaho.jsf?retid=edit:intysapid&retname=edit:sapid');
		return false;
	} 
	
//批量更新
	function updateALl(){
		if(!"".equals($("update:up_prvena").value))
			$("update:up_prvena").value="";
		if(!"".equals($("update:up_prve").value))
			$("update:up_prve").value="";
		if(!"".equals($("update:up_cityna").value))
			$("update:up_cityna").value="";
		if(!"".equals($("update:up_city").value))
			$("update:up_city").value="";
		if(!"".equals($("update:up_areana").value))
			$("update:up_areana").value="";
		if(!"".equals($("update:up_waid").value))
			$("update:up_waid").value="";
		if(!"".equals($("update:up_fosx").value))
			$("update:up_fosx").value="";
		if(!"".equals($("update:up_basx").value))
			$("update:up_basx").value="";
		if(!"".equals($("update:up_dosx").value))
			$("update:up_dosx").value="";
		if(!"".equals($("update:up_blvl").value))
			$("update:up_blvl").value="";
		if(!"".equals($("update:up_isdo").value))
			$("update:up_isdo").value="";
		if(!"".equals($("update:up_posj").value))
			$("update:up_posj").value="";
		if(!"".equals($("update:up_stat").value))
			$("update:up_stat").value="";
		if(!"".equals($("update:up_dpty").value))
			$("update:up_dpty").value="";
		$("update:up_updateflag").value = "UpdateAll";	
	    //$("edit:xh").disabled = "TRUE";
		//showDiv("批量更新");
		Gwin.open({
			id:"lpblupdateWin",	
			title:"批量更新",
			contextType:"ID",
			context:"update",
			dom:document,
			width:650,
			height:200,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("lpblupdateWin");
		Gwin.setLoadok("lpblupdateWin");
	}
	function beginUpdateAll(){
		var prve = $('update:up_prve');
		if(prve==null || prve.value.Trim().length <= 0){
			Gwin.alert("系统提示","省不能为空!","!",document);
			return false;
		}
		var num = /^[0-9]\d*$/;
		if($('update:up_fosx').value.Trim().length > 0)
			if(!num.test($('update:up_fosx').value.replace('.',''))){
				alert("配送时效输入的格式错误！");
				$('update:up_fosx').value="";
				return false;
			}
		if($('update:up_basx').value.Trim().length > 0)
			if(!num.test($('update:up_basx').value.replace('.',''))){
				alert("返货时效输入的格式错误！");
				$('update:up_basx').value="";
				return false;
			}
		if($('update:up_dosx').value.Trim().length > 0)
			if(!num.test($('update:up_dosx').value.replace('.',''))){
				alert("上门取货时效输入的格式错误！");
				$('update:up_dosx').value="";
				return false;
			}
		if($('update:up_blvl').value.Trim().length > 0)
			if(!num.test($('update:up_blvl').value.replace('.',''))){
				alert("妥投率输入的格式错误！");
				$('update:blvl').value="";
				return false;
			}
		if(confirm("请仔细检查省，市，区所设定范围,确认批量修改？")){
			Gwallwin.winShowmask("TRUE");
			return true;
		}else return false;
	}
	//批量更新结束
		function endDoU(){
		Gwallwin.winShowmask("FALSE");
		var message = $("update:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("lpblupdateWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	function chan(){
		var obj=$("list:sid");
		obj.onclick();
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
		
		var waid = $('edit:waid');
		var sapid = $('edit:sapid');
		if(waid==null || waid.value.Trim().length <= 0){
			Gwin.alert("系统提示","仓库编码不能为空!","!",document);
			waid.value="";
			waid.focus();
			return false;
		}
		if(sapid==null || sapid.value.Trim().length <= 0){
			Gwin.alert("系统提示","SAP仓库编码不能为空!","!",document);
			sapid.value="";
			sapid.focus();
			return false;
		}
		
		Gwin.progress("正在保存...",10,document);
		return true;
	}
/*
	function endDo(){
		Gwin.close("progress_id");
		var message = $("edit:rendersite_mes").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("siteWin");
		}else{ 
			type = "X";
		}
		if($("edit:updateflag").value == "EDIT"){
			$("edit:lpna").disabled= "TRUE";
		}
		Gwin.alert("系统提示",message,type,document);
	}*/
	
	function endDo()
	{	
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("siteWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	
	
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		showDiv("新增库存逻辑仓库");
	}

	function clearText(){
		textClear('edit','waid,wana,chie,addr,rema,sapid','N');
	}

	//显示层
	function showDiv(title){
		Gwin.open({
			id:"siteWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:500,
			height:180,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("siteWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("siteWin");
		//$("edit:waid").disabled = "TRUE";
		//$("edit:wana").disabled = "TRUE";
		//$("edit:chie").disabled = "TRUE";
		//$("edit:addr").disabled = "TRUE";
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("siteWin");	
		Gwin.close("lpblupdateWin");	
	}

	//编辑回调
	function Edit(id){
		showDiv("编辑库存逻辑仓库");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value = "EDIT";
	//	$("edit:waid").disabled = "TRUE";
	//	$("edit:wana").disabled = "TRUE";
	//	$("edit:chie").disabled = "TRUE";
	//	$("edit:addr").disabled = "TRUE";
		Gwin.setLoadok("siteWin");
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
		if($('list:sapid')!=null){
     		$('list:sapid').value="";
     		$('list:sapid').focus();
     	}
   		if($('list:waid')!=null){
   			$('list:waid').value="";
   			$('list:waid').focus();
   		}
   		
	}
	function clearlpbl(){
   		if($('list:id')!=null){
   			$('list:id').value="";
   		}
   		if($('list:name')!=null){
     		$('list:name').value="";
     	}
   		if($('list:ids')!=null){
     		$('list:ids').value="";
     	}
   		if($('list:iss')!=null){
     		$('list:iss').value="";
     	}
	}		
	// 打开仓库信息页面
	function selectwaid(){
		var gorid =  $('edit:gorid').value;
		showModal('waho.jsf?retid=edit:waid&retname=edit:wana&chie=edit:chie&addr=edit:addr&orid='+gorid,570,350);
		return false;
	}

	