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
	$("edit:updateflag").value = "ADD";
	showDiv("新增快递单号");
}

function clearText(){
	textClear('edit','lpco,lpna,exco,qty','N');
	$('edit:stat').value='1';
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
		Gwin.alert("系统提示","物流商不能为空！","!",document);
		$("edit:lpna").focus();
		return false;
	}
	var exco = document.getElementById("edit:exco");
	if(exco==null || exco.value.Trim().length<=0){
		Gwin.alert("系统提示","起始单号不能为空！","!",document);
		$("edit:exco").focus();
		return false;
	}else{
		if(existzh_CN(exco.value)){
			Gwin.alert("系统提示","起始单号不能为中文!","!",document);
			exco.value="";
			exco.focus();
			return false;
		}
	}
	var reg2=/^\d*$/;					//检测是否为整数
		if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		Gwin.alert('生产数量不能为空!');
		$("edit:qty").focus();
		return false;
		}
		result=reg2.test($("edit:qty").value);
		if(result){
			if($("edit:qty").value.Trim().length>11){
				Gwin.alert('生成数量位数太长!');
				$("edit:qty").focus();
				return false;
			}
		}
		if(!result){
			Gwin.alert('生成数量格式不对!');
			$("edit:qty").focus();
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
	if($('list:sk_exco')!=null){
		$('list:sk_exco').value="";
	}
}

function endDeleteLines(){
	var msg = $('edit:msg').value;
	Gwin.alert("系统提示",msg,"!",document);
}
function showImport(){
	$("file:lpna").value="";
	$("file:lpco").value="";
	$("mes").innerHTML="";
	Gwallwin.winShow("import","选择导入文件");	
}
function hideDiv1(){
	Gwallwin.winClose();		
}
function selectSK_lpco(){
	showModal('carrier.jsf?time='+new Date().getTime() + '&retid=file:lpco&retname=file:lpna');
	return false;
}
function select_lpco(){
	showModal('carrier.jsf?time='+new Date().getTime() + '&retid=edit:lpco&retname=edit:lpna');
	return false;
}
	function showModal(newurl){
		Gwin.open({
			id:"openurl",
			title:"",
			contextType:"URL",
			context:newurl,
			dom:document,
			lock:true,
			width:600,
			height:500
		}).show("openurl");
	} 
	function clearData1(){
	if($('list:sk_lpco')!=null){
		$('list:sk_lpco').value="";
		$('list:sk_lpco').focus();
	}
	if($('list:sk_lpna')!=null){
		$('list:sk_lpna').value="";
	}
}
 function selectThis(parm1,parm2){
    	retid = $('list:retid').value;
    	retname = $('list:retname').value;
		var isGwin = Gwin && document.GwinID;
		if(isGwin === false){
			is_IE = (navigator.appName == "Microsoft Internet Explorer");
			var callBack = null;  
			if(is_IE) {
				callBack = window.dialogArguments;
			}
			else {
				if (window.opener.callBack == undefined) {   
					window.opener.callBack = window.dialogArguments;   
				}   
				callBack = window.opener.callBack;   
			}
		}
		if ( retid != "" && retid != null){
    		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
		}
		
		if ( retname != "" && retname != null){
			isGwin ? parent.document.getElementById(retname).value = parm2 : callBack.document.getElementById(retname).value=parm2;
		}
		isGwin ? Gwin.close(document.GwinID) : window.close();	
    }
function doImport(){
		var flag=true;
		var lpco = $("file:lpco").value;
		var file=$("file:upFile").value;
		var filelength = file.length;
		var filetype = file.indexOf('.xls');
		if(lpco==""){
			$("mes").innerHTML="<Font Color=\"red\"><B>请选择物流商!<B></Font>";
			return false;
		}
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


function showRxpressResultList()
{
	showModal("expressresult.jsf?&retid=edit:vc_checkuserid&retname=edit:nv_checkusername","460px","470px");
}
//-->