
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
		
	function selWorkgroup(){
		showModal('../../common/workgroup/selectworkgroup.jsf?&time='+new Date().getTime() + '&retid=edit:vc_workgroupid&retname=edit:nv_workgroupname');
	}
	
	function addDiv(){
		clearText();
		$("edit:updateflag").value = "ADD";
		showDiv("新增计划");
	}

	function clearText(){
		textClear('edit','ids,prid,dpid,inco,betm,eddt,rema,isva','N');
		//$('edit:isym').value='0';
		//$('conatd').style.display = "none";
		//$('coritd').style.display = "none";
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"salesplanWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:550,
			height:290,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("salesplanWin");
		if(title.indexOf("新增")!=-1)Gwin.setLoadok("salesplanWin");
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("salesplanWin");	
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
		//$("edit:cuid").disabled = "true";
		Gwin.setLoadok("salesplanWin");
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
		var inco = document.getElementById("edit:inco");
		if(inco==null || inco.value.Trim().length<=0){
			Gwin.alert("系统提示","物料编码不能为空！","!",document);
			$("edit:inco").focus();
			return false;
		}
		var prid = document.getElementById("edit:prid");
		if(prid==null || prid.value.Trim().length<=0){
			Gwin.alert("系统提示","预售ID不能为空！","!",document);
			$("edit:inco").focus();
			return false;
		}
		var dpid = document.getElementById("edit:dpid");
		if(dpid==null || dpid.value.Trim().length<=0){
			Gwin.alert("系统提示","店铺编码不能为空！","!",document);
			$("edit:dpid").focus();
			return false;
		}else{
			if(existzh_CN(dpid.value)){
				Gwin.alert("系统提示","客户编码不能为中文!","!",document);
				dpid.value="";
				dpid.focus();
				return false;
			}
		}
		var betm = document.getElementById("edit:betm");
		if(betm==null || betm.value.Trim().length<=0){
			Gwin.alert("系统提示","物料编码不能为空！","!",document);
			$("edit:betm").focus();
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
			Gwin.close("customerWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
	}
	//填入数字的列 如果为空自动补0


function clearData(){
	if($('list:prids')!=null){
   			$('list:prids').value="";
  	}
   	if($('list:dpids')!=null){
		$('list:dpids').value="";
	}
   	if($('list:incos')!=null){
		$('list:incos').value="";
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
		
		Gwin.alert("系统提示",message,document);
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
	Gwin.alert("系统提示",mes,document);
	if(mes.indexOf("打印成功")!=-1){
 		var name=$("list:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwin.close("progress_id");
 }
  	
//选择物料编码
function selectInco(){
	showModal('../../common/inve/inve.jsf?retid=edit:inco&retname=');
	return false;
}	
//选择物流商编码
function selectLpco(){
	showModal('carrier.jsf?retid=edit:lpco');
	return false;
}
//选择店铺编码
function selectDpid(){
	showModal('store.jsf?retid=edit:dpid');
}
function selectCategory(){
	showModal('../../common/cuty/cuty.jsf?retid=edit:ctco&retname=edit:tyna');
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