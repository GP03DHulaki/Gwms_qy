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

	function showModal(newurl){
		window.showModalDialog(newurl,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
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

   function chooselock(obj)	{		
		var arr=Gtable.getselcolvalues('gtable','whid');
		
    	if(arr.length>0){		    	
    		if(!confirm('确定要锁定当前库位吗?')){
				return false;
			}else{
				$("list:sqllist").value=arr;
				startDo();
			}
	   }else{
		   	Gwin.alert("系统提示","请选择要锁定的的库位!","!",document);
		   	return false;
	   }
	   
	   return true;					
	}
function endchooselock()
{	
	var mes =$("edit:msg").value;
	Gwin.close("progress_id");
	Gwin.alert("系统提示",mes,"!",document);
 }
	//验证id="edit"的form表单				
	function formCheck(){
		var wid = $("edit:whid").value.Trim();
		var pid = $('edit:pwid').value;
		if(wid==null || wid.Trim().length<=0){
			Gwin.alert("系统提示","库位编码不能为空!","!",document);
			$("edit:whid").focus();
			return false;
		}else{
			if(existzh_CN(wid)){
				Gwin.alert("系统提示","库位编码不能为中文!","!",document);
				$("edit:whid").value="";
				$("edit:whid").focus();
				return false;
			}
		}

		if($("edit:whna").value.Trim().length <= 0){
			Gwin.alert("系统提示","库位名称不能为空!","!",document);
			$("edit:whna").value="";
			$("edit:whna").focus();
			return false;
		}
		if($("edit:pwid").value.Trim().length <= 0){
			Gwin.alert("系统提示","上级编码不能为空!","!",document);
			$("edit:pwid").value="";
			$("edit:pwid").focus();
			return false;
		}
		
		if($("edit:pwid").value.Trim().length <= 0){
			Gwin.alert("系统提示","上级编码不能为空!","!",document);
			$("edit:pwid").value="";
			$("edit:pwid").focus();
			return false;
		}
		
		var whty=$('edit:whty').value;
		
		if(whty==''){
			alert('未选择库位标识!');
			return false;
		}
		
		Gwin.progress("正在保存...",10,document);
		return true;
	}

	function endDo(){
		Gwin.close("progress_id");
		var message = $("edit:msg").value;
		var type = "Y";

		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("warehouseWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		$("edit:whid").disabled = "";
		$("edit:pwid").disabled= "";
		showDiv("新增库位");
	}

	function clearText(){
		$("edit:whid").value="";
		$("edit:ewid").value="";
		$("edit:whna").value="";
		$("edit:pwid").value="";
		$("edit:orid").value="";
		$("edit:stat").value="1";
		$("edit:cofl").value="N";
		
		$("edit:whty").value="";
		$("edit:wogr").value="";
		
		$("edit:volu").value="";
		$("edit:bear").value="";
		
		$("edit:vole").value="";
		$("edit:vowi").value="";
		$("edit:vohe").value="";
		$("edit:leve").value="";
		
		$("edit:chie").value="";
		$("edit:addr").value="";
		$("edit:tele").value="";
		$("edit:rema").value="";
		$("edit:isar").value="0";
		$("edit:islk").value="0";
		
	}

//打印条码
function print()
{
	var msg = "";
	var whids = Gtable.getselcolvalues('gtable','whid');

	if(whids.length>0){
		startDo();
		$("list:sellist").value=whids;
	}else{
		Gwin.alert("系统提示","请选择需要进行条码打印的记录!","!",document);
		return false;
	}
	return true	
}
//查看打印条码
function lookPrint()
{	
	var mes =$("edit:msg").value;
	Gwin.close("progress_id");
	Gwin.alert("系统提示",mes,"!",document);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("edit:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
 }


	//显示层
	function showDiv(title){
		Gwin.open({
			id:"warehouseWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:450,
			height:340,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("warehouseWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("warehouseWin");
	}
	
	//隐藏层
	function hideDivs(){
		Gwin.close("warehouseWin");		
	}

	//编辑回调
	function Edit(id){
		showDiv("编辑库位资料");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value = "EDIT";
		$("edit:whid").disabled = "TRUE";
		$("edit:pwid").disabled= "TRUE";
		Gwin.setLoadok("warehouseWin");
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
	
	function doSearch(){
		$("list:sid").onclick();
	}
	
	function clearData(){
		if($('list:whid')!=null){
     		$('list:whid').value="";
     		$('list:whid').focus();
     	}
     	if($('list:ewid')!=null){
     		$('list:ewid').value="";
     		$('list:ewid').focus();
     	}
   		if($('list:whna')!=null){
   			$('list:whna').value="";
   		}
   		if($('list:stat')!=null){
   			$('list:stat').value="1";
   		}
   		if($('list:whtys')!=null){
   			$('list:whtys').value="";
   		}
   		if($('list:orid')!=null){
   			$('list:orid').value="";
   		}
   	
	}
	
	function setCode(){
		var pwid = $('edit:pwid');
		var whid = $('edit:whid');
		if(pwid && whid){
			if(pwid.value.Trim()=='ROOT'){
				whid.value= '';
			}else{
				whid.value=pwid.value;
			}
		}
	}
	
	function showMsg()
	{
		if($("edit:msg").value != null && $("edit:msg").value != '')
		{
			alert($("edit:msg").value);
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
