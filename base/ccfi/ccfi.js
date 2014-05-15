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

	var delstate = false;
	function deleteAll(obj,id){	
		$('list:saveType').value=id;
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
						if(id=="sk"){
							$("list:delButton").onclick();
						}else if(id=="sh"){
							$("list:pDelButton").onclick();
						}	
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
	function formCheck(type){	
		if(type=="sk"){
			if($("editsk:colo").value==""){
				alert("色卡编号不能为空！");
				$("editsk:colo").focus();
				return false;
			}
			if($("editsk:cona").value==""){
				alert("色卡名称不能为空！");
				$("editsk:cona").focus();
				return false;
			}
			if($("editsk:suna").value==""){
				alert("供应商不能为空！");
				$("editsk:suna").focus();
				return false;
			}
		}else if(type=="sh"){
			if($("editsh:seka").value==""){
				alert("色卡不能为空！");
				$("editsh:seka").focus();
				return false;
			}
			if($("editsh:colo").value==""){
				alert("色号不能为空！");
				$("editsh:colo").focus();
				return false;
			}
			if($("editsh:cona").value==""){
				alert("颜色不能为空！");
				$("editsh:cona").focus();
				return false;
			}
		}
		return true;
	}

	function addDiv(type){
		var title="";
		clearText();
		$("editsk:updateflag").value = "ADD";
		$("editsh:updateflag").value = "ADD";
		if(type=='sk') {
			$("editsk:saveType").value=type;
			showModal("detail.jsf");
		}
		else if(type=='sh') {
			$("editsh:saveType").value=type;
			showDivSh("添加");
		}
	}

	function clearText(){
		$("editsk:colo").value="";
		$("editsk:cona").value="";
		$("editsk:suna").value="";
		$("editsk:stat").value="1";
		$("editsk:lrema").value="";
		
		$("editsh:colo").value="";
		$("editsh:cona").value="";
		$("editsh:seka").value="";
		$("editsh:stat").value="1";
		$("editsh:nrema").value="";
		
		$("list:cnno").value="";
		$("list:cnna").value="";
		$("list:cuid").value="";
		$("list:skno").value="";
		$("list:skna").value="";
		$("list:colo").value="";
		$("list:cona").value="";
	}
	
	//编辑
	function Edit(id,type){	
		if(type=='sk'){
			$("editsk:updateflag").value="EDIT"
			$("editsk:saveType").value = type;
			$("editsk:selid").value = id;
			showDivSk("编辑");
			$("editsk:editbut").click();
		}
		else if(type=='sh'){
			$("editsh:updateflag").value="EDIT"
			$("editsh:saveType").value = type;
			$("editsh:selid").value = id;
			showDivSh("编辑");
			$("editsh:editbut").click();
		}
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){
		Gwin.setLoadok("ccfiSkWin");
	}
	function edit_show1(){
		Gwin.setLoadok("ccfiShWin");
	}

	//显示层	function showDivSk(title){
		Gwin.open({
			id:"ccfiSkWin",	
			title:title,
			contextType:"ID",
			context:"editsk",
			dom:document,
			width:450,
			height:130,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("ccfiSkWin");
		Gwin.setLoadok("ccfiSkWin");	
	}
	//显示层
	function showDivSh(title){
		Gwin.open({
			id:"ccfiShWin",	
			title:title,
			contextType:"ID",
			context:"editsh",
			dom:document,
			width:400,
			height:130,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("ccfiShWin");
		Gwin.setLoadok("ccfiShWin");	
	}
	
	//隐藏层	function hideDivSk(){
		Gwin.close("ccfiSkWin");
	}
	function hideDivSh(){
		Gwin.close("ccfiShWin");
	}
	function clearDataSk(){
		if($('list:cnno')!=null){
     		$('list:cnno').value="";
     		$('list:cnno').focus();
     	}
   		if($('list:cnna')!=null){
   			$('list:cnna').value="";
   		}
		if($('list:cuid')!=null){
     		$('list:cuid').value="";
     	}
	}
	function clearDataSh(){
   		if($('list:skno')!=null){
   			$('list:skno').value="";
   			$('list:skno').focus();
   		}
		if($('list:skna')!=null){
     		$('list:skna').value="";
     	}
   		if($('list:colo')!=null){
   			$('list:colo').value="";
   		}
		if($('list:cona')!=null){
     		$('list:cona').value="";
     	}
	}
	// 打开选择供应商页面
	function selectSuin(){
		showModal('../../common/suin/suin.jsf?retid=editsk:suid&retname=editsk:suna');
		return false;
	}
	// 打开色卡页面
	function selectCono(){
		showModal('../../common/cono/cono.jsf?retid=editsh:skid&retname=editsh:seka');
		return false;
	}
	function endDo(){
		var msg = $("list:msg").value;
		Gwin.close("progress_id");
		alert(msg)
	}
	function endSk(){
		var msg = $("editsk:msg").value;
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close("ccfiSkWin");
		}
		Gwin.close("progress_id");
		alert(msg)
	}
	function endSh(){
		var msg = $("editsh:msg").value;
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close("ccfiShWin");
		}
		Gwin.close("progress_id");
		alert(msg)
	}
	function showColors(param){
		showModal("detail.jsf?pid="+param,"800px")
	}
//-->	