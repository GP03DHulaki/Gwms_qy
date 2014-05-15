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

//导出开始
	function excelios_begin(obj){		
		Gwallwin.winShowmask("TRUE");
	}
	
	
//导出结束
	function excelios_end(){
		Gwallwin.winShowmask('FALSE');
		var message =$('list:msg').value;		
		alert($('list:msg').value);
		//alert($("edit:outPutFileName").value);
		if(message.indexOf('导出成功')!=-1){
			window.open('../../'+$("list:outPutFileName").value);
		}
  	}

function startDo(){
	Gwin.progress("",10,document);
}

function addDiv(){
	clearText();
	$("edit:inco").disabled = "true";
	$("invcode_img").style.display = "";
	$("edit:updateflag").value = "ADD";
	showDiv("新增商品默认库位",1);
}

function addDiv2(){
	clearText2();
	$("edit:updateflag").value = "ADD2";
	showDiv("新增商品默认库区",2);
}

function clearText(){
	textClear('edit','inco,inna,whid,rema','N');
}

function clearText2(){
	textClear('edit2','selid2,inty2,whco2,whid2,rema2','N');
}

//显示层
function showDiv(title,id){
	var winid = "inwhWin"+id;
	var editid = "edit"+(id == 1 ? "" : "2");
	$(editid).className = "curtab_body";
	Gwin.open({
		id:winid,	
		title:title,
		contextType:"ID",
		context:editid,
		dom:document,
		width:500,
		height:130,
		autoLoad:false,
		showbt:false,
		lock:true
	}).show(winid);
	if(title.indexOf("新增")!=-1)Gwin.setLoadok(winid);	
}
//隐藏层
function hideDiv(id){
	Gwin.close("inwhWin"+id);	//id: 1|2	
}

//编辑回调
function Edit(id){
	showDiv("编辑商品默认库位",1);
	$("edit:selid").value = id;
	$("edit:editbut").click();
}

//编辑回调
function EditItwh(id){
	showDiv("编辑商品默认库区",2);
	$("edit2:selid2").value = id;
	$("edit2:editbut2").click();
}

//点击编辑按钮
function edit_show(){
	$("edit:updateflag").value="EDIT";
	$("edit:inco").disabled = "true";
	$("invcode_img").style.display = "none";
	Gwin.setLoadok("inwhWin1");
}

//点击编辑按钮
function edit_show2(){
	$("edit:updateflag").value="EDIT";
	Gwin.setLoadok("inwhWin2");
}

var delstate = false;
function deleteAll(obj,id)	{	
	if(delstate){
		delstate = false;
		return true;
	}else{
		var arr = Gtable.getselectid(obj);
		if(arr.length>0){
			Gwin.confirm("showMsg2","系统提示","确定要删除选中的数据吗?","?",document,
				[{lable:'确定',click:function(){
					$("list"+id+":sellist"+id).value = arr;
					Gwin.progress("正在删除...",10,document);
					delstate = true;
					$("list:delButton"+id).onclick();
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
	var inco = document.getElementById("edit:inco");
	if(inco==null || inco.value.Trim().length<=0){
		Gwin.alert("系统提示","商品编码不能为空！","!",document);
		$("edit:inco").focus();
		return false;
	}else{
		if(existzh_CN(inco.value)){
			Gwin.alert("系统提示","商品编码不能为中文!","!",document);
			inco.value="";
			inco.focus();
			return false;
		}
	}
	var whid = document.getElementById("edit:whid");
		if(whid==null || whid.value.Trim().length<=0){
		Gwin.alert("系统提示","默认库位不能为空！","!",document);
		$("edit:whid").focus();
		return false;
	}
	Gwin.progress("正在保存...",10,document);
	return true;
}	

//验证form
function formCheck2(){
	var inty2 = document.getElementById("edit2:inty2");

	if(inty2==null || inty2.value.Trim().length<=0){
		Gwin.alert("系统提示","类别编码不能为空！","!",document);
		$("edit2:inty2").focus();
		return false;
	}
	
	var whid = document.getElementById("edit2:inty2");
		if(whid==null || whid.value.Trim().length<=0){
		Gwin.alert("系统提示","默认库区不能为空！","!",document);
		$("edit2:inty2").focus();
		return false;
	}
	Gwin.progress("正在保存...",10,document);
	return true;
}

function endDo(id){	
	var msgid = "list"+(id == "1" ? "" : "2")+":msg";
	Gwin.close("progress_id");
	var message = $(msgid).value;
	var type = "Y";
	if(message.indexOf("成功")!=-1){
		id == "1" ? clearText() : clearText2();
		Gwin.close("inwhWin"+id);
	}else{ 
		type = "X";
	}
	Gwin.alert("系统提示",message,type,document);
}

function clearData(){
	if($('list:inco')!=null){
		$('list:inco').value="";
		$('list:inco').focus();
	}
	if($('list:whid')!=null){
		$('list:whid').value="";
	}
}

function clearData2(){
	if($('list2:inty2')!=null){
		$('list2:inty2').value="";
		$('list2:inty2').focus();
	}
	if($('list2:whid2')!=null){
		$('list2:whid2').value="";
	}
}

function selectDWare(){
	showModal("../../common/waho/waho.jsf?type=4&retid=edit:whid&rename=&orid=all");
	return false;
}

function selectDWare2(obj){
	showModal("../../common/waho/waho.jsf?type=2&retid=edit2:"+obj+"&rename=&orid=all");
	return false;
}

// 打开选择商品信息页面
function selectInve(){
	showModal("../../common/inve/inve.jsf?retid=edit:inco&retname=edit:inna",'560px');
	return false;
}

// 打开选择商品信息页面
function selectInty(){
	showModal("selectInty.jsf?retid=edit2:inty2",'420px');
	return false;
}

//-->