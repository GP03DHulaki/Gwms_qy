	<!--
		function doInit(){
			//$("list:userNo").value="${sessionScope.nc_userid}";
		}
		
		function startDo(msg){
	       Gwin.progress(msg,10,document);
	    }
		function endDo(){
	       Gwin.close("progress_id");
	    }
	    
		function endDel(){
	        endDo();
	     	var msg=$("list:msg").value;
	     	if(msg!="search"){
	     		Gwin.alert("系统提示",msg,(msg.indexOf("成功")!=-1 ? "Y" : "X"),document);
	     	}
	    }
		var delstate = false;
		function doDel(obj)	{	
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
							$("list:deleteButton").onclick();
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
	    
		function doSearch(){
			var start=$("list:startDate").value;
			var end=$("list:endDate").value;
			if(start==""||start.length<=0){
				if(end!=""||end.length>0){
					Gwin.alert("系统提示","请填写记录的开始时间!","!",document);
					$("list:startDate").focus();
					return false;
				}
			}else{
				if(end==""||end.length<=0){
					Gwin.alert("系统提示","请填写记录的结束时间!","!",document);
					$("list:endDate").focus();
					return false;
				}
			}
			startDo("正在查询...");
			return true;
		}
		function doClearData(){
			$("list:startDate").value="";
			$("list:endDate").value="";
			$("list:msg").value="";
			$("list:module").value="";
			$("list:eventLevel").value="100";
			if($("list:userId")!=null)
				$("list:userId").value="";
			$("list:computer").value="";
			$("list:eventDetail").value="";
			$("list:sk_loty").value="";
		}
	//-->
