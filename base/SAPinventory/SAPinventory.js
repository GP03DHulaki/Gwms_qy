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

//ly
//上传excell
function showImport(){
	$("mes").innerHTML="";
	Gwallwin.winShow("import","选择导入文件");	
}
隐藏上传层import
function hideDi(){
Gwallwin.winClose();		
}

function doImport(){
	//alert(1);
	var flag=true;
	var file=$("file:upFile").value;
	//alert(file+"l;");
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

	
function doSearch(){
	$("edit:query").click();
}

function startDo(){
		Gwin.progress("",10,document);
}
	
	function addDiv(){
		clearText();
		initAdd();
		$("edit:sapid").disabled="true";//"禁用".
		$("edit:waid").disabled = ""; //点击编辑的时候，这个waid按钮是禁用的，只读权限，不可编辑状态，再次恢复
		$("edit:companyCode").disabled= "";//点击编辑的时候，这个companyCode按钮是禁用的，只读权限，不可编辑状态，在此恢复
		$("edit:companyCode").disabled= "";
		$("edit:updateflag").value = "ADD";
		showDiv("新增SAP仓库地点");
	}
	
	function initAdd(){
		if($("edit:sapid")!=null){
			$("edit:sapid").value="自动生成";
		}
		//if($("edit:whna")!=null){
		//	$("edit:whna").value="";
		//	$("edit:whid").value="";
		//}
	
	}
	
	function addNew(){
		window.location.href="SAPinventory_add.jsf";
	}

	function clearText(){
		textClear('edit','sapid,companyCode,waid,whna,rema','N');
		$('edit:stat').value='是';
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"SAPinventoryWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:700,
			height:200,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("SAPinventoryWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("SAPinventoryWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("SAPinventoryWin");	
	}
	
	//编辑回调
	function Edit(id){
		showDiv("编辑SAP仓库地点");	
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:sapid").disabled = "true";
		$("edit:companyCode").disabled="true";//"禁用".
		$("edit:waid").disabled="true";//"禁用".
		Gwin.setLoadok("SAPinventoryWin");
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
		var stco = document.getElementById("edit:companyCode");
		if(stco==null || stco.value.Trim().length<=0){
			Gwin.alert("系统提示","公司编码不能为空！","!",document);
			$("edit:companyCode").focus();
			return false;}
//		}else{
//			if(existzh_CN(stco.value)){
//				Gwin.alert("系统提示","公司编码不能为中文!","!",document);
//				stco.value="";
//				stco.focus();
//				return false;
//			}
//		}
		var tyna = document.getElementById("edit:waid");
			if(tyna==null || tyna.value.Trim().length<=0){
			Gwin.alert("系统提示","仓库编码不能为空！","!",document);
			$("edit:waid").focus();
			return false;
		}
			var tyna = document.getElementById("edit:whna");
			if(tyna==null || tyna.value.Trim().length<=0){
			Gwin.alert("系统提示","仓库名称不能为空！","!",document);
			$("edit:whna").focus();
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
		hideDiv();
		Gwin.alert("系统提示",message,type,document);
	}

	function clearData(){
		if($('list:sapid')!=null){
			$('list:sapid').value="";
			$('list:sapid').focus();
		}
		if($('list:companyCode')!=null){
   			$('list:companyCode').value="";
   			
   		}
		if($('list:waid')!=null){
   			$('list:waid').value="";
   			
   		}
		if($('list:whna')!=null){
   			$('list:whna').value="";
   			
   		}
		if($("list:flags")!=null){
			$("list:flags").value = "00";
		}
	}
	
//-->