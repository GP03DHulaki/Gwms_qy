		function check(){		
			var vc_idrule=$("edit:vc_idrule");			
			var in_id = $("edit:in_id");
			
			if(vc_idrule.value=="" && vc_idrule.value.length==0){
				Gwin.alert("系统提示","单据规则不可为空!","!",document);
				vc_idrule.focus();
				return false;
			}
			if(in_id.value=="" && in_id.value.length==0){
				Gwin.alert("系统提示","当前流水号不可为空!","!",document);
				in_id.focus();
				return false;
			}
			if(existzh_CN(vc_idrule.value))
		    {
				Gwin.alert("系统提示",'单据规则不能有中文字符！',"!",document);
		        vc_idrule.focus();
		        vc_idrule.select();
		        return false;
		    }
		    if(existzh_CN(in_id.value))
		    {
		    	Gwin.alert("系统提示",'当前流水号不能有中文字符！',"!",document);
		        in_id.focus();
		        in_id.select();
		        return false;
		    }
		     if(in_id.value.search("^\\d+(\\.\\d+)?$")!=0){
		    	 Gwin.alert("系统提示","非法数字，请填写正确的当前流水","!",document);
		        in_id.focus();
		        in_id.select();
		        return false;
  			  }
  			Gwin.progress("正在保存...",10,document);
			return true;
		}
// 打开选择商品信息页面
function selectInve(){
	showModal("../../common/inve/inve.jsf?retid=edit:inco&retname=edit:inna",'560px');
	return false;
}

function clearText(){
	textClear('edit','inco,inna,whid,rema','N');
}
function addDiv(){
	clearText();
	$("edit:inco").disabled = "true";
	$("invcode_img").style.display = "";
	$("edit:updateflag").value = "ADD";
	showDiv("新增配置商品",1);
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
		
		function startDo(msg){
			 Gwin.progress(msg,10,document);
	    }
		function endDo(){
	        Gwin.close("progress_id");
	       	var mes=$('list:msg').value;
	       	var type = "X";
	       	if(type.indexOf("成功")!=-1){
	       		type = "Y";
	       		hideDiv();
	       	}
	        Gwin.alert("系统提示",mes,type,document);
	    }
	
		String.prototype.Trim=function(){
			return this.replace(/(^\s*)|(\s*$)/g, "");
		}
		
		function Edit(id){
			$("edit:selid").value = id;	
			showDiv("编辑单据规则");
			$("edit:editbut").click();
		}
		
		function Edit_show(){
			Gwin.setLoadok("vouchersetWin");
		}
//		//点击修改时调用的方法
//		function editDiv(rbean)	{
//			if($("edit:updateBut"))
//				$("edit:updateBut").style.display="inline";//显示更新按钮
//			$("edit:id_id").value=rbean.id_id;
//			$("edit:mona").value=rbean.mona;//给编辑页面元素赋值
//			$("edit:vc_idrule").value=rbean.vc_idrule;
//			$("edit:in_id").value=rbean.in_id;
//			$("edit:mona").disabled=true;//模块名称不可修改
//			
//			
//		}
		//清除查询条件
		function doClear(){
			$("list:nv_modulename").value = "";
		}
	   
	    String.prototype.Trim=function(){
			return this.replace(/(^\s*)|(\s*$)/g, "");
		}
		function doSubmit()
		{
			if(event.keyCode==13)
			{
				$("list:sid").click;
				return true;
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
	Gwin.progress("正在保存...",10,document);
	return true;
}
function endDo(id){	
	var msgid = "edit:msg";
	Gwin.close("progress_id");
	var message = $(msgid).value;
	var type = "Y";
	if(message.indexOf("成功")!=-1){
		clearText();
		Gwin.close("inwhWin1");
	}else{ 
		type = "X";
	}
	Gwin.alert("系统提示",message,type,document);
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
					$("list:h").onclick();
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
function hideIMP(){
	Gwin.close("import");	
}