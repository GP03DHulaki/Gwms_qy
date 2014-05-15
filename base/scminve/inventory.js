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
	
	function startDo( msg ){  
		Gwin.progress(msg,10,document);
	}
	function endDo(msg){
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		if(message!=""){
			alert(message);
		}
	}
	function endSave(){
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		var type = "Y";
		if(message.indexOf("成功")!=-1){
			clearText();
			Gwin.close("inventoryWin");
		}else{ 
			type = "X";
		}
		alert(message);
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
	
	function selWorkgroup(){
		showModal('../../common/workgroup/selectworkgroup.jsf?&time='+new Date().getTime() + '&retid=edit:vc_workgroupid&retname=edit:nv_workgroupname');
	}
	
	function addDiv(){
		//showModal("addinve.jsf","750px","220px");
		//return false;
		clearText();
		$("edit:inco").value="自动生成";
		$("edit:inun").value="物料类别带入";
		$("edit:colorlist").value="";
		$("edit:updateflag").value = "ADD";
		$("inty_img").style.display="";
		showDiv("新增物料");
		
	}
	//显示层
	function showDiv(title){
		Gwin.open({
			id:"inventoryWin",	
			title:title,
			contextType:"ID",
			context:"Gtab01",
			dom:document,
			width:850,
			height:500,
			autoLoad:false,
			showbt:false,
			closeafter:function(){ //窗口关闭之后,
				Gtab.setSelectID("edit");//把选项卡重新设置选中第一个.
			},
			maxafter:function( obj ){ //最大化后
				var iframeimg = document.getElementById("iframeImg");
				iframeimg.setAttribute("W_H",iframeimg.width+"_"+iframeimg.height)
				iframeimg.width = obj.offsetWidth - 50;
				iframeimg.height = obj.offsetHeight - 50;
			},
			maxRese:function(){
				var iframeimg = document.getElementById("iframeImg");
				var wh = iframeimg.getAttribute("W_H").split("_");
				iframeimg.width = wh[0];
				iframeimg.height = wh[1];
			},
			lock:true
		}).show("inventoryWin");
		Gwin.setLoadok("inventoryWin");
	}
	
	//隐藏层
	function hideDiv(){
		Gwin.close("inventoryWin");
		
	}
	function clearText(){
		textClear('edit','inna,bupr,dfus,nstv,stat,colorlist,sizelist,rema,tyna,inty,prefix','N');
	}
	//编辑回调
	function Edit(id){
		showDiv("编辑物料信息");
		$("edit:selid").value = id;
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		Gwin.close("progress_id");
		$("edit:updateflag").value="EDIT";
		$("edit:inco").disabled = "true";
		$("inty_img").style.display="none";
		Gwin.setLoadok("inventoryWin");
	}
	function editDo() {
		Gwin.progress("载入中...",10,document);
	}
	
	function selectWhouse(form,id,sid){
		var newurl="gselectWhouse.jsp?form="+form+"&id="+id+"&sid="+sid;
		window.showModalDialog(newurl,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
	}

	/**
	 * 注意删除时候的,弹出询问对话框,
	 * @param obj
	 * @return
	 */
	var delstate = false;
	function deleteAll(obj)	{
		if(delstate){
			delstate = false;
			return true;
		}else{
			var arr = Gtable.getselectid($(obj.id));
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
		$("edit:inpr").value="M";
		var inco = document.getElementById("edit:inco"); // 物料编码
		var a = /^[0-9]\d*$/;
		var b = /^\d+(\.\d+)?$/;
		var c = /^[1-9]\d*[.]?\d*$/;
		
		if(inco==null || inco.value.Trim().length<=0){
			Gwin.alert("系统提示","物料编码不能为空！","!",document);
			$("edit:inco").focus();
			return false;
		}
		
		var inna = document.getElementById("edit:inna");
		if(inna==null || inna.value.Trim().length<=0){
			Gwin.alert("系统提示","物料名称不能为空！","!",document);
			$("edit:inna").focus();
			return false;
		}
		var inty = document.getElementById("edit:inty");
			if(inty==null || inty.value.Trim().length<=0){
				Gwin.alert("系统提示","物料类别不能为空！","!",document);
			return false;
		}
		
		Gwin.progress("正在保存...",10,document);
		return true;	
	}
	function clearData(){
		if($('list:sk_inco')!=null){
			$('list:sk_inco').value="";
			$('list:sk_inco').focus();
		}
		if($('list:sk_inna')!=null){
   			$('list:sk_inna').value="";
   		}
   		if($('list:sk_colo')!=null){
   			$('list:sk_colo').value="";
   		}
   		if($('list:sk_inst')!=null){
   			$('list:sk_inst').value="";
   		}
   		if($('list:sk_asco')!=null){
   			$('list:sk_asco').value="";
   		}
   		if($('list:sk_psco')!=null){
   			$('list:sk_psco').value="";
   		}
   		if($('list:sk_tyna')!=null){
   			$('list:sk_tyna').value="";
   		}
   		if($('list:sk_brde')!=null){
   			$('list:sk_brde').value="";
   		}
   		if($('list:sk_inpr')!=null){
   			$('list:sk_inpr').value="0";
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
		
		startDo( '正在导出...' );
	}
	
	function excelstock_end(){
		var message =$('edit:msg').value;
		Gwin.close("progress01");
		Gwin.alert("系统提示",message,"!",document,
			[{lable:'确定',click:function(){
				Gwin.close("showMsg4");
				if(message.indexOf('导出成功')!=-1){
					window.open('../../'+$("list:outPutFileName").value);
				}
			}}]);
  	}
  	
  	//打印条码
function print()
{
	var incos = Gtable.getselcolvalues('gtable2','inco');
	if(incos.length>0){
		startDo("正在打印条码...");
		$("list:sellist").value=incos;
	}else{
		Gwin.alert("系统提示",message,"!",document);	
		return false;
	}
	return true	
}
//查看打印条码
function lookPrint()
{
	Gwin.close("progress01");
	var mes =$("list:msg").value;
	Gwin.alert("系统提示",mes,"!",document,
			[{lable:'确定',click:function(){
				Gwin.close("showMsg5");
				if(mes.indexOf("打印成功")!=-1){
			 		var name=$("list:filename").value;	  
			 		window.open('../'+name+'?time='+new Date().getTime());
			 	}
			}}]);
 }
  	
// 打开物料类型页面
function selectInty(){
	showModal('../../common/scmInve_type/style_type.jsf?retid=edit:inty&retname=edit:tyna&retbsul=edit:inun');
	return false;
}
function colorlist(){
	showModal('addcolorlist.jsf?color='+$("edit:colorlist").value);
	$("edit:colorbtn").blur();
	return false;
}
function sizelist(){
	showModal('addsizelist.jsf?size='+$("edit:sizelist").value);
	$("edit:sizebtn").blur();
	return false;
}
// 打开查询物料类型页面
function selectSK_Inty(){
	showModal('../../common/invclass_sel/invclass_sel.jsf?retname=list:sk_tyna&type=0');
	return false;
}
 
// 打开品牌页面
function selectBran(){
	showModal('../../common/brand_sel/brand_sel.jsf?retid=edit:bran&retname=edit:brde');
	return false;
} 	  

// 打开查询品牌页面
function selectSK_Bran(){
	showModal('../../common/brand_sel/brand_sel.jsf?retname=list:sk_brde&retid=');
	return false;
}
function selectInve(){
	showModal('../../common/inve/inve.jsf?inpr=M&retid=edit:upco');
	return false;
}
//-->