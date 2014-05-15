<!--
	var Obj=''; 
	
	function doSubmit(){
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
	
	function startDo(){
		Gwallwin.winShowmask("TRUE");
	}

	function endDo(){
		Gwallwin.winShowmask("FALSE");
		var message = $("edit:msg").value;
		if(message.indexOf("成功!")!=-1){
			//clearText();
			hideDiv();			
		}			
		alert(message);			
	}
	//选择		
	function selectObj(url){	
		window.showModalDialog(url,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
		return false;
	}

    function deleteAll(obj){		
		var arr=Gtable.getselectid(obj);
	    	if(arr.length>0){		    	
	    		if(!confirm('确定删除当前记录吗?')){
					return false;
				}else{
					$("list:sellist").value=arr;
					startDo();
				}
		   }else{
			   	alert("请选择要删除的记录!");
			   	return false;
		   }
		   return true;		
	}


	//验证id="edit"的form表单				
	function formCheck(){	
//		if($("edit:ruid").value==null ||$("edit:ruid").value.length<=0){
//			alert("模板编码不能为空!");
//			$("edit:ruid").focus();
//			return false;
//		}
//		if($("edit:baru").value==null ||$("edit:baru").value.length<=0){
//			alert("规则不能为空!");
//			$("edit:baru").focus();
//			return false;
//		}
		return true;
	}

	function addDiv(){
		clearText();
		$("edit:ruid").disabled="";//"禁用".
		$("edit:updateflag").value = "ADD";
		
		showDiv("添加系统参数");
	}

	function clearText(){
		$("edit:ruid").value="";
		$("edit:baru").value="";
		$("edit:rema").value="";	
	}
	
	//编辑
	function Edit(id){
		$("edit:selid").value = id;
		$("edit:updateflag").value = "EDIT";
		
		Gwallwin.winShowmask("TRUE");
		$("edit:edit").click();	
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){	
		Gwallwin.winShowmask("FALSE");
		//显示层	
		$("edit:ruid").disabled = "true";
		showDiv("编辑系统参数");
	}

	//显示层	function showDiv(title){
		Gwallwin.winShow("edit",title);		
	}
	
	//隐藏层	function hideDiv(){
		Gwallwin.winClose();		
	}

//-->	