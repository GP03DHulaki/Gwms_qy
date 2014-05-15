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
	
	function startDo(){
		Gwin.progress("",10,document);
	}
	
	function showModal(newurl){
		window.showModalDialog(newurl,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
	} 
	
	function selWorkgroup(){
		showModal('../../common/workgroup/selectworkgroup.jsf?&time='+new Date().getTime() + '&retid=edit:vc_workgroupid&retname=edit:nv_workgroupname');
	}
	
	function addDiv(){
		clearText();
		$("edit:suid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		showDiv("新增供应商");
	}

	function clearText(){
		textClear('edit','suid,suna,ceve,cori,phon,adde,emai,rema,suty,cous,erpc','N');
		$('edit:stat').value='1';
		//$('edit:isym').value='0';
		//$('conatd').style.display = "none";
		//$('coritd').style.display = "none";
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"supplierWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:500,
			height:300,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("supplierWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("supplierWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("supplierWin");	
	}
	
	//编辑回调
	function Edit(id){
		showDiv("编辑供应商信息");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:suid").disabled = "true";
		Gwin.setLoadok("supplierWin");
	}
	
	function selectWhouse(form,id,sid){
		var newurl="gselectWhouse.jsp?form="+form+"&id="+id+"&sid="+sid;
		window.showModalDialog(newurl,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
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
		var suid = document.getElementById("edit:suid");
		if(suid==null || suid.value.Trim().length<=0){
			Gwin.alert("系统提示","供应商编码不能为空！","!",document);
			suid.focus();
			return false;
		}else{			
			//if(existzh_CN(suid.value)){
			//	Gwin.alert("系统提示","客户编码不能为中文!","!",document);
			//	suid.value="";
			//	suid.focus();
			//	return false;
			//}
		}
		
		var suna = document.getElementById("edit:suna");
		if(suna==null || suna.value.Trim().length<=0){
			Gwin.alert("系统提示","供应商名称不能为空！","!",document);
			suna.focus();
			return false;
		}
		
		//var isym = $('edit:isym').value;
		//if(isym=="1"){
			//if($('edit:cori').value==""){
				//Gwin.alert("系统提示","目标公司不能为空！","!",document);
				//return false;
			//}
		//}
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
			Gwin.close("supplierWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	//填入数字的列 如果为空自动补0
	function notnull(){
		if($("edit:volu")!=null && $("edit:volu").value.Trim().length<=0){
			$("edit:volu").value="0";
		}
		if($("edit:vole")!=null && $("edit:vole").value.Trim().length<=0){
			$("edit:vole").value="0";
		}
		if($("edit:vowi")!=null&&$("edit:vowi").value.Trim().length<=0){
			$("edit:vowi").value="0";
		}
		if($("edit:vohe")!=null&&$("edit:vohe").value.Trim().length<=0){
			$("edit:vohe").value="0";
		}
		if($("edit:inpa")!=null&&$("edit:inpa").value.Trim().length<=0){
		   $("edit:inpa").value="0";
		}
		if($("edit:oupa")!=null&&$("edit:oupa").value.Trim().length<=0){
		   $("edit:oupa").value="0";
		}
		if($("edit:grwe")!=null&&$("edit:grwe").value.Trim().length<=0){
			$("edit:grwe").value="0";
		}
		if($("edit:newe")!=null&&$("edit:newe").value.Trim().length<=0){
			$("edit:newe").value="0";
		}
		if($("edit:tawe")!=null&&$("edit:tawe").value.Trim().length<=0){
			$("edit:tawe").value="0";
		}

	}

	function clearData(){
		if($('list:suid')!=null){
			$('list:suid').value="";
			$('list:suid').focus();
		}
		if($('list:suna')!=null){
   			$('list:suna').value="";
   			
   		}
   		if($('list:erpc')!=null){
   			$('list:erpc').value="";
   			
   		}
	}
	
	function excelstock_begin(obj){
		var s;
		
		s = Gtable.getSQL(obj);
		$("list:gsql").value = s;
		
		s = Gtable.getCOLHEADTEXT(obj);
		$("list:gcolheadtext").value = s;

		s = Gtable.getCOLDATATYPE(obj);
		$("list:gcoldatatype").value = s;
		
		startDo();
	}
	
	function excelstock_end(){
		Gwin.close("progress_id");
		var message =$('edit:msg').value;
		Gwin.alert("系统提示",message,"!",document);
		if(message.indexOf('导出成功')!=-1){
			window.open('../../'+$("list:outPutFileName").value);
		}
  	}
  	
  	//打印条码
function print()
{
	var inbas = Gtable.getselcolvalues('gtable2','inba');
	if(inbas.length>0){
		startDo();
		$("list:sellist").value=inbas;
	}else{
		Gwin.alert("系统提示","请选择需要进行条码打印的记录!","!",document);
		return false;
	}
	return true	
}
//查看打印条码
function lookPrint()
{
	var mes =$("list:msg").value;
	Gwin.alert("系统提示",mes,"!",document);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("list:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwin.close("progress_id");
 }
  	
// 打开选择供应商分类页面
function selectSuty(){
	showModal('../../common/suty/suty.jsf?retid=edit:stco&retname=edit:suty');
	return false;
}

// 打开选择地区分类页面
function selectGeid(){
	showModal('../../common/gein/gein.jsf?retid=edit:geid&retname=edit:gena');
	return false;
}	

function changeIsym(){
	var isym = $('edit:isym').value;
	if(isym=='1'){
		$('conatd').style.display = "";
		$('coritd').style.display = "";
		$('coritd').bgcolor = "#efefef";
	}else{
		$('conatd').style.display = "none";
		$('coritd').style.display = "none";
		$('coritd').bgcolor = "#FFFFFF";
	}
	$('edit:refBut').onclick();
}
  	
//-->