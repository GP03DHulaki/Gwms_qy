<!--
function doSubmit(){	
	if(event.keyCode==13){
		document.forms[0].submit();
	}
}
function formsubmit(){
	if (event.keyCode==13){
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
	$("edit:updateflag").value = "ADD";
	showDiv("新增物流商");
}

function clearText(){
	textClear('edit','lpco,lpna,rema,rena,reph','N');
	$('edit:stat').value='1';
	$('edit:prst').value='0';
}

//显示层function showDiv(title){
	Gwin.open({
		id:"carrierWin",	
		title:title,
		contextType:"ID",
		context:"edit",
		dom:document,
		width:480,
		height:160,
		autoLoad:false,
		showbt:false,
		lock:true
	}).show("carrierWin");
	if(title.indexOf("新增")!=-1)Gwin.setLoadok("carrierWin");
}

//隐藏层function hideDiv(){
	Gwin.close("carrierWin");	
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
	$("edit:lpco").disabled = "true";
	Gwin.setLoadok("carrierWin");
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

function deleteLines(){
	var arr=Gtable.getselcolvalues('gtable2','lico');
   	if(arr.length>0){		    	
   		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			$("edit:licos").value=arr.split("#@#").join(",");
		}
   }else{
	   	Gwin.alert("系统提示","请选择要删除的记录!","!",document);
	   	return false;
   }
   return true;
}

//验证form
function formCheck(){
	var lpco = document.getElementById("edit:lpco");
	if(lpco==null || lpco.value.Trim().length<=0){
		Gwin.alert("系统提示","物流商编码不能为空！","!",document);
		$("edit:lpco").focus();
		return false;
	}else{
		if(existzh_CN(lpco.value)){
			Gwin.alert("系统提示","物流商编码不能为中文!","!",document);
			lpco.value="";
			lpco.focus();
			return false;
		}
	}
	var lpna = document.getElementById("edit:lpna");
		if(lpna==null || lpna.value.Trim().length<=0){
		Gwin.alert("系统提示","物流商名称不能为空！","!",document);
		$("edit:lpna").focus();
		return false;
	}
	Gwin.progress("正在保存...",10,document);
	return true;
}	

function endDo(){	
	Gwin.close("progress_id");
	var message = $("list:msg").value;
	var type = "Y";
	if(message.indexOf("成功")!=-1){
		clearText();
		Gwin.close("carrierWin");
	}else{ 
		type = "X";
	}
	Gwin.alert("系统提示",message,type,document);
}

function clearData(){
	if($('list:sk_lpco')!=null){
		$('list:sk_lpco').value="";
		$('list:sk_lpco').focus();
	}
	if($('list:sk_lpna')!=null){
		$('list:sk_lpna').value="";
	}
}

function refreshLine(lpco){
	$('list:lpco').value=lpco;
	$('list:hidBut').onclick();
}
function showLines(){
	var lpco = $('edit:lpco').value;
	showModal('../../common/line/manyline.jsf?retid='+lpco+'&retname','500','550');
	return true;
}

function endDeleteLines(){
	var msg = $('edit:msg').value;
	Gwin.alert("系统提示",msg,"!",document);
}
//-->