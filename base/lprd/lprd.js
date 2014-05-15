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
		$("edit:lpco").disabled="";//"禁用".
		$("edit:prve").disabled="";//"禁用".
		$("edit:city").disabled="";//"禁用".
		$("edit:area").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("新增品牌");
	}

	function clearText(){
		textClear('edit','lpco,prve,city,area,prrd','N');
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
	
	//编辑回调
	function Edit(id){
		showDiv("编辑");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:lpco").disabled="true";//"禁用".
		$("edit:prve").disabled="true";//"禁用".
		$("edit:city").disabled="true";//"禁用".
		$("edit:area").disabled="true";//"禁用".
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
		var lpco = document.getElementById("edit:lpco");
			if(lpco==null || lpco.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:lpco").focus();
			return false;
		}
			var prve = document.getElementById("edit:prve");
			if(prve==null || prve.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:prve").focus();
			return false;
		}
			var city = document.getElementById("edit:city");
			if(city==null || city.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:city").focus();
			return false;
		}
			var area = document.getElementById("edit:area");
			if(area==null || area.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:area").focus();
			return false;
		}
			var prrd = document.getElementById("edit:prrd");
			if(prrd==null || prrd.value.Trim().length<=0){
			Gwin.alert("系统提示","路线名称不能为空！","!",document);
			$("edit:prrd").focus();
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
		if($('list:lpco')!=null){
			$('list:lpco').value="";
		}
		if($('list:lpna')!=null){
			$('list:lpna').value="";
		}
		if($('list:area')!=null){
			$('list:area').value="";
		}
		if($('list:arna')!=null){
			$('list:arna').value="";
		}
		if($('list:prrd')!=null){
			$('list:prrd').value="";
		}
	}
	function showImport(){
		$("mes").innerHTML="";
		Gwallwin.winShow("import","选择导入文件");	
	}
	function doImport(){
		var flag=true;
		var file=$("file:upFile").value;
		var filelength = file.length;
		var filetype = file.indexOf('.xls');
		if(file==""){
			$("mes").innerHTML="<Font Color=\"red\"><B>请选择上传的文件!<B></Font>";
			return false;
		}
		if(filetype==-1 || (filelength-filetype)!=4 ){
			$("mes").innerHTML="<Font Color=\"red\"><B>上传的文件必须是xls类型!<B></Font>";
			return false;
		}else{
			$("mes").innerHTML="数据导入中......";
		}
		$("file:import").disabled=true;
		startDo();
		$("file:importBut").click();
	return flag;
}
function hideDiv(){
	Gwin.close("lineWin");	
}
function hideDiv1(){
	Gwallwin.winClose();	
}
//导出开始
function excelios_begin(obj){
	var s = Gtable.getSQL(obj);
	$("list:gsql").value = s;
	
	startDo();
}


//导出结束
function excelios_end(){
	Gwallwin.winShowmask('FALSE');
	var message =$('list:msg').value;
	alert($('list:msg').value);
	if(message.indexOf('导出成功')!=-1){
		window.open('../../'+$("list:outPutFileName").value);
	}
	}
//-->