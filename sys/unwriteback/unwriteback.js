
		function doInit(){
			//$("list:userNo").value="${sessionScope.nc_userid}";
		}
		
		function startDo(){
	        Gwallwin.winShowmask("TRUE");
	    }
		function endDo(){
	        Gwallwin.winShowmask("FALSE");
	    }
	    
		function endDel(){
	        endDo();
	     	var msg=$("list:msg").value;
	     	if(msg!="search"){
	     		alert(msg);
	     	}
	    }
	    
	    
	    //删除单据(首页)
function deleteHeadAll(obj){
	var ids = Gtable.getselectid(obj);
	var biids = Gtable.getselcolvalues('gtable','biid');
	var biid = biids.split("#@#");
	var remas = Gtable.getselcolvalues('gtable','rema');
	var rema = remas.split("#@#");
	if(ids.Trim().length<=0){
		alert("请选择需要删除的任务!");
		return false;
	}else{
		for(i=0;i<biid.length;i++){
			if(rema[i].indexOf(':单据号码重复')==-1){
				alert("单号["+biid[i]+"]回写任务不允许删除!");
				return false;
			}
		}
		if(confirm("确定要删除选中任务吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = ids;
			return true;
		}
	}
}

// 结束删除单据(首页)
function endDeleteHeadAll(){
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		alert($("edit:msg").value);
	}else if($("edit:msg").value.indexOf("<br>")!=-1){
		var msgs = $("edit:msg").value.split('<br>');
		var msg = "";
		for(i = 0;i < msgs.length;i++){
			msg += msgs[i] + "\n";
		}
		alert(msg);
	}else{
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}
function backMin(obj){
	var ids = Gtable.getselectid(obj);
	if(ids.Trim().length<=0){
		var rytis = Gtable.getcolvalues('gtable','ryti');
		var ryti = rytis.split("#@#");
		for(i=0;i<ryti.length;i++){
			if(ryti[i]==0){
				alert("回写次数为1的数据将不减少回写的次数!");break;
			}
		}
		if(confirm("确定要减少所有回写失败次数吗?")){
			return true;
		}
		else{return false;}
	}else{
		var rytis = Gtable.getselcolvalues('gtable','ryti');
		var ryti = rytis.split("#@#");
		if(confirm("确定要减少选定回写失败次数吗(次数为1的数据将不会减少)?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = ids;
			return true;
		}
		else{return false;}
	}
}
function endbackMin(){
	if($("edit:msg").value.indexOf("减少回写失败次数成功")!=-1){
		alert($("edit:msg").value);
	}else if($("edit:msg").value.indexOf("<br>")!=-1){
		var msgs = $("edit:msg").value.split('<br>');
		var msg = "";
		for(i = 0;i < msgs.length;i++){
			msg += msgs[i] + "\n";
		}
		alert(msg);
	}else{
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}	    
	    
	function clearBiid(){
		alert("本功能专门处理错误信息为“单据正在回写中”并且错误次数超过6次的单据。每次只循序处理一张单据！");
		var biid = Gtable.getselcolvalues('gtable','biid');
		var ryti = Gtable.getselcolvalues('gtable','ryti');
		var rema = Gtable.getselcolvalues('gtable','rema');
		if(biid.Trim().length<=0){
			alert("请选择需要处理的一张单据!");
			return false;
		}
		if(biid.indexOf("#@#")!=-1){
			alert("每次只能处理一张单据!");
			return false;
		}
		if(ryti<=6){
			alert("只能处理失败6次以上的单据!");
			return false;
		}

		if(rema.indexOf("该单据正在回写中")==-1){
			alert("只能处理错误信息为“正在回写中”的单据!");
			return false;
		}
		if(!confirm("确定处理当前单据?")){
			return false;
		}
		
		Gwallwin.winShowmask("TRUE");
		$("edit:sellist").value = biid;	
		return true
	}
	function endClearBiid(){
		
		alert($("edit:msg").value);
		
		Gwallwin.winShowmask("FALSE");
	}	

	   function doSearch(){
	   		$("edit:searchButton").click();
	   		startDo();
	   } 
		function doDel(obj){
			var arrVal=Gtable.getselectid(obj);
    		if(arrVal.length>0){		    	
	    		if(confirm('确定删除当前记录吗?')){
					$("list:sellist").value=arrVal;
					startDo();
					return true;
				}else
					return false;
		   }
		   else{
			   	alert("请选择要删除的记录!");
			   	return false;
		   }
		}
		function search(){
			var start=$("edit:sk_start_date").value;
			var end=$("edit:sk_end_date").value;
			if(start==""||start.length<=0){
				if(end!=""||end.length>0){
					alert("请填写记录的开始时间!");
					$("edit:sk_start_date").focus();
					mydiv.style.display="none";
					return false;
				}else
					return true;
			}else{
				if(end==""||end.length<=0){
					alert("请填写记录的结束时间!");
					$("edit:sk_end_date").focus();
					mydiv.style.display="none";
					return false;
				}else
					return true;
			}
			Gwallwin.winShowmask("TRUE");
			return true;
		}
		function doClearData(){
			$("edit:sk_start_date").value="";
			$("edit:sk_end_date").value="";
			$("edit:moid").value="";
			$("edit:biid").value="";
			$("edit:orid").value="";
		}
	//-->
