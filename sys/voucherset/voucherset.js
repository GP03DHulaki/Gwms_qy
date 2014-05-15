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

		//显示层
		function showDiv(title){
			Gwin.open({
				id:"vouchersetWin",	
				title:title,
				contextType:"ID",
				context:"editdiv",
				dom:document,
				width:480,
				height:120,
				autoLoad:false,
				showbt:false,
				lock:true
			}).show("vouchersetWin");
			if(title.indexOf("添加")!=-1)Gwin.setLoadok("vouchersetWin");
		}
		
		//隐藏层
		function hideDiv(){
			Gwin.close("vouchersetWin");	
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