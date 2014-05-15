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



	function showImport(){
		$("mes").innerHTML="";
		Gwallwin.winShow("import","选择导入文件");	
	}

	
	function startDo( msg ){  
		Gwin.progress(msg,10,document);
	}
	function endDo(id){	
		Gwin.close("progress_id");
		var message = $("list:msg").value;
		var type = "Y";
		if(message.indexOf("成功!")!=-1){
			clearText();
			Gwin.close("inventoryWin");
		}else{ 
			type = "X";
		}
		Gwin.alert("系统提示",message,type,document);
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
		clearText();
		$("edit:inco").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		$("edit:selflag").value = "Add";
		$("edit:ywei").value = "";
		showDiv("新增商品");
	}
	//显示层
	function showDiv(title){
		Gwin.open({
			id:"inventoryWin",	
			title:title,
			contextType:"ID",
			context:"Gtab01",
			dom:document,
			width:710,
			height:450,
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
		if(title.indexOf("新增")!=-1){Gwin.setLoadok("inventoryWin");}
	}
	
	//隐藏层
function hideDiv(){
	Gwallwin.winClose();		
}
	function clearText(){
		textClear('edit','inco,inna,inba,inst,tyco,sfle,sfrq,dosd,sapr,past,inun,inty,asco,cpfl,cpty,cpri,bran,ceve,cecu,volu,vole,vowi,vohe,grwe,newe,tawe,colo,inse,vers,inpa,oupa,baty,baru,inpr,inpr,stat,rema,psco,tyna,brde,gsco','N');
	}
	//编辑回调
	function Edit(id,inpr){
		showDiv("编辑商品信息");
		$("edit:selid").value = id;
		$("edit:selinpr").value = inpr;
		$("edit:selflag").value = 'Edit';
		$("edit:editbut").click();
	}

	//点击编辑按钮
	function edit_show(){
		$("edit:updateflag").value="EDIT";
		$("edit:inco").disabled = "true";
		Gwin.setLoadok("inventoryWin");
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
		var inco = document.getElementById("edit:inco"); // 商品编码
		var a = /^[0-9]\d*$/;
		var b = /^\d+(\.\d+)?$/;
		var c = /^[1-9]\d*[.]?\d*$/;
		var inpr = $("edit:inpr").value;
		var exinpr = $("edit:selinpr").value;		
		
		if(inco==null || inco.value.Trim().length<=0){
			Gwin.alert("系统提示","商品编码不能为空！","!",document);
			$("edit:inco").focus();
			return false;
		}
		
		var tyco  = $("edit:tyco").value;
		if(tyco == null || tyco == ''){
			Gwin.alert("系统提示","商品货号不能为空!","!",document);
			$("edit:tyco").focus();
			return false;
		}
		
		var inna = document.getElementById("edit:inna");
			if(inna==null || inna.value.Trim().length<=0){
				Gwin.alert("系统提示","商品名称不能为空！","!",document);
				$("edit:inna").focus();
				return false;
			}
		var inty = document.getElementById("edit:inty");
			if(inty==null || inty.value.Trim().length<=0){
				Gwin.alert("系统提示","商品类型不能为空！","!",document);
			return false;
		}
			
	   
	   
		/*
		var asco = document.getElementById("edit:asco");
			if(asco==null || asco.value.Trim().length<=0){
				Gwin.alert("系统提示","辅助编码不能为空！","!",document);
			$("edit:asco").focus();
			return false;
		}*/
		var cpfl = document.getElementById("edit:cpfl");
			if(cpfl==null || cpfl.value.Trim().length<=0){
				Gwin.alert("系统提示","保质期控制不能为空！","!",document);
			$("edit:cpfl").focus();
			return false;
		}
		notnull();
		//体积
		// 内包装数量
		if(!c.test(document.getElementById("edit:inpa").value.Trim())){
			Gwin.alert("系统提示","内包装数量值只能为非0数字！","!",document);
			$("edit:inpa").focus();
			return false;
		}
		//长	
		var vole = document.getElementById("edit:vole");
			
		
		if(!b.test(vole.value.Trim())){
			Gwin.alert("系统提示","长只能为非负数！","!",document);
			$("edit:vole").focus();
			return false;
		}
			//宽	
		var vowi = document.getElementById("edit:vowi");
			
		
		if(!b.test(vowi.value.Trim())){
			Gwin.alert("系统提示","宽只能为非负数！","!",document);
			$("edit:vowi").focus();
			return false;
		}
			//高
		var vohe = document.getElementById("edit:vohe");
			
		
		if(!b.test(vohe.value.Trim())){
			Gwin.alert("系统提示","高只能为非负数！","!",document);
			$("edit:vohe").focus();
			return false;
		}
			//毛重
		var grwe = document.getElementById("edit:grwe");
			
		
		if(!b.test(grwe.value.Trim())){
			Gwin.alert("系统提示","毛重只能为非负数！","!",document);
			$("edit:grwe").focus();
			return false;
		}
			//净重
		var newe = document.getElementById("edit:newe");
			
		
		if(!b.test(newe.value.Trim())){
			Gwin.alert("系统提示","净重只能为非负数！","!",document);
			$("edit:newe").focus();
			return false;
		}
		//皮重
		var tawe = document.getElementById("edit:tawe");
			
		
		if(!b.test(tawe.value.Trim())){
			Gwin.alert("系统提示","皮重只能为非负数！","!",document);
			$("edit:tawe").focus();
			return false;
		}
		
		var gwf1 = document.getElementById("edit1:gwf1");
		if(gwf1.value.length>1){
			Gwin.alert("系统提示","大类内容长度过长！","!",document);
			$("edit1:inna").focus();
			return false;
		}
		var gwf2 = document.getElementById("edit1:gwf2");
		if(gwf2.value.length>10){
			Gwin.alert("系统提示","大类描述数据长度过长！","!",document);
			$("edit1:gwf2").focus();
			return false;
		}
		var gwf3 = document.getElementById("edit1:gwf3");
		if(gwf3.value.length>2){
			Gwin.alert("系统提示","商品类别数据长度过长！","!",document);
			$("edit1:gwf3").focus();
			return false;
		}
		var gwf4 = document.getElementById("edit1:gwf4");
		if(gwf4.value.length>20){
			Gwin.alert("系统提示","商品类别描述数据长度过长！","!",document);
			$("edit1:gwf4").focus();
			return false;
		}
		var gwf5 = document.getElementById("edit1:gwf5");
		if(gwf5.value.length>1){
			Gwin.alert("系统提示","分类数据长度过长！","!",document);
			$("edit1:gwf5").focus();
			return false;
		}
		var gwf6 = document.getElementById("edit1:gwf6");
		if(gwf6.value.length>4){
			Gwin.alert("系统提示","分类描述数据长度过长！","!",document);
			$("edit1:gwf6").focus();
			return false;
		}
		var gwf7 = document.getElementById("edit1:gwf7");
		if(gwf7.value.length>1){
			Gwin.alert("系统提示","规格范围数据长度过长！","!",document);
			$("edit1:gwf7").focus();
			return false;
		}
		var gwf8 = document.getElementById("edit1:gwf8");
		if(gwf8.value.length>20){
			Gwin.alert("系统提示","规格范围描述数据长度过长！","!",document);
			$("edit1:gwf8").focus();
			return false;
		}
		var gwf9 = document.getElementById("edit1:gwf9");
		if(gwf9.value.length>3){
			Gwin.alert("系统提示","分析类别数据长度过长！","!",document);
			$("edit1:gwf9").focus();
			return false;
		}
		var gwf10 = document.getElementById("edit1:gwf10");
		if(gwf10.value.length>14){
			Gwin.alert("系统提示","分析类别描述数据长度过长！","!",document);
			$("edit1:gwf10").focus();
			return false;
		}
		var gwf11 = document.getElementById("edit1:gwf11");
		if(gwf11.value.length>1){
			Gwin.alert("系统提示","季节数据长度过长！","!",document);
			$("edit1:gwf11").focus();
			return false;
		}
		var gwf12 = document.getElementById("edit1:gwf12");
		if(gwf12.value.length>2){
			Gwin.alert("系统提示","季节描述数据长度过长！","!",document);
			$("edit1:gwf12").focus();
			return false;
		}
		var gwf13 = document.getElementById("edit1:gwf13");
		if(gwf13.value.length>1){
			Gwin.alert("系统提示","性别数据长度过长！","!",document);
			$("edit1:gwf13").focus();
			return false;
		}
		var gwf14 = document.getElementById("edit1:gwf14");
		if(gwf1.value.length>10){
			Gwin.alert("系统提示","性别描述数据长度过长！","!",document);
			$("edit1:gwf14").focus();
			return false;
		}
		var gwf15 = document.getElementById("edit1:gwf15");
		if(gwf15.value.length>1){
			Gwin.alert("系统提示","商品属性数据长度过长！","!",document);
			$("edit1:gwf15").focus();
			return false;
		}
		var gwf16 = document.getElementById("edit1:gwf16");
		if(gwf16.value.length>10){
			Gwin.alert("系统提示","商品属性描述数据长度过长！","!",document);
			$("edit1:gwf16").focus();
			return false;
		}
		var gwf17 = document.getElementById("edit1:gwf17");
		if(gwf17.value.length>4){
			Gwin.alert("系统提示","年份数据长度过长！","!",document);
			$("edit1:gwf17").focus();
			return false;
		}
		var gwf18 = document.getElementById("edit1:gwf18");
		if(gwf18.value.length>2){
			Gwin.alert("系统提示","波段数据长度过长！","!",document);
			$("edit1:gwf18").focus();
			return false;
		}
		var gwf19 = document.getElementById("edit1:gwf19");
		if(gwf19.value.length>4){
			Gwin.alert("系统提示","波段描述数据长度过长！","!",document);
			$("edit1:gwf19").focus();
			return false;
		}
		var gwf20 = document.getElementById("edit1:gwf20");
		if(gwf20.value.length>5){
			Gwin.alert("系统提示","设计风格数据长度过长！","!",document);
			$("edit1:gwf20").focus();
			return false;
		}
		var gwf21 = document.getElementById("edit1:gwf21");
		if(gwf21.value.length>10){
			Gwin.alert("系统提示","设计风格描述数据长度过长！","!",document);
			$("edit1:gwf21").focus();
			return false;
		}
		//预包装重量
		var ywei = document.getElementById("edit:ywei");
			
		if(!b.test(ywei.value.Trim())){
			Gwin.alert("系统提示","预包装重量只能为非负数！","!",document);
			$("edit:ywei").focus();
			
		}
		
		Gwin.progress("正在保存...",10,document);
		return true;	
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
		   $("edit:inpa").value="1";
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
   		if($('list:sk_owid')!=null){
   			$('list:sk_owid').value="";
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
		var message =$('list:msg').value;
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
  	
// 打开商品类型页面
function selectInty(){
	showModal('../../common/invclass_sel/invclass_sel.jsf?retid=edit:inty&retname=edit:tyna');
	return false;
} 	
// 打开查询商品类型页面
function selectSK_Inty(){
	showModal('../../common/invclass_sel/invclass_sel.jsf?retname=list:sk_tyna&retid=');
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
	
