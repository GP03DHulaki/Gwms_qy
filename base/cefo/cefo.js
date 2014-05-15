<!--
	var Obj=''; 
	
	function doSubmit(){
		if(event.keyCode==13)
		{
			document.forms[0].submit();
		}
	}
	
	function startDo(msg){
		Gwin.progress(msg,10,document);
	}

	function endDo(win){
		var msg = "保存成功!";
		if(win=='CefoPnWin'){
			msg = $("editPn:msg").value;
		}else if(win=='CefoMdWin') {
			msg = $("editMd:msg").value;
		}else if(win=='CefoEsWin') {
			msg = $("editEs:msg").value;
		}else if(win=='CefoScWin') {
			msg = $("editSc:msg").value;
		}else if(win=='CefoFcWin') {
			msg = $("editFc:msg").value;
		}else if(win=='CefoPlWin') {
			msg = $("editPl:msg").value;
		}else if(win=='CefoWaWin') {
			msg = $("editWa:msg").value;
		}
		Gwallwin.winShowmask("FALSE");
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close(win);
		}
		Gwin.close("progress_id");
		alert(msg)
	}

	var delstate = false;
	function deleteAll(obj,type){	
		$('list:saveType').value=type;
		if(delstate){
			delstate = false;
			return true;
		}else{
			var arr = Gtable.getselectid(obj);
			if(arr.length>0){
				Gwin.confirm("showMsg2","系统提示","确定要删除选中的数据吗?","?",document,
					[{lable:'确定',click:function(){
						$("list:sellist").value = arr;
						startDo("正在删除...");
						delstate = true;
						if(type=="pn"){
							$("list:pnDelButton").onclick();
						}else if(type=="md"){
							$("list:mdDelButton").onclick();
						}else if(type=="es"){
							$("list:esDelButton").onclick();
						}else if(type=="sc"){
							$("list:scDelButton").onclick();
						}else if(type=="fc"){
							$("list:fcDelButton").onclick();
						}else if(type=="pl"){
							$("list:plDelButton").onclick();
						}else if(type=="ws"){
							$("list:waDelButton").onclick();
						}		
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


	//验证id="edit"的form表单				
	function formCheck(type){
		if(type=='pn'){
//			$("editPn:saveType").value=="pn";
			if($("editPn:pdna").value==""){
				alert("品名不能为空！");
				return false;
			}
			if($("editPn:brde").value==""){
				alert("品牌不能为空！");
				return false;
			}
		}else if(type=='md') {
//			$("editMd:saveType").value=="md";
			if($("editMd:mdno").value==""){
				alert("号型不能为空！");
				return false;
			}
		}else if(type=='es') {
//			$("editEs:saveType").value=="es";
			if($("editEs:esno").value==""){
				alert("执行标准编号不能为空！");
				return false;
			}
		}else if(type=='sc') {
//		$("editSc:saveType").value=="sc";
			if($("editSc:scno").value==""){
				alert("安全类别编号不能为空！");
				return false;
			}
			if($("editSc:scna").value==""){
				alert("安全类型名称不能为空！");
				return false;
			}
		}else if(type=='fc') {
//			$("editFc:saveType").value=="fc";
			if($("editFc:fcno").value==""){
				alert("工厂编号不能为空！");
				return false;
			}
			if($("editFc:fcna").value==""){
				alert("工厂名称不能为空！");
				return false;
			}
		}else if(type=='pl') {
//			$("editPl:saveType").value=="pl";
			if($("editPl:leve").value=="" || $("editPl:leve").value.Trim().length>5){
				alert("等级编号不能为空或不能大于五个字符！");
				return false;
			}
			if($("editPl:lena").value==""){
				alert("等级名称不能为空！");
				return false;
			}
		}else if(type=='ws') {
//			$("editWa:saveType").value=="ws";
			if($("editWa:wsna").value==""){
				alert("洗涤名称不能为空！");
				return false;
			}
			if($("editWa:wsty").value==""){
				alert("洗涤类型不能为空！");
				return false;
			}
		}
		startDo("正在保存...");
		return true;
	}

	function addDiv(type,w,h){
		var title="";
		clearText();
		if(type=='pn') {
			$("editPn:updateflag").value = "ADD";
			$("editPn:saveType").value=type;
			showDiv("添加","CefoPnWin","editPn",w,h);
		}else if(type=='md') {
			$("editMd:updateflag").value = "ADD";
			$("editMd:saveType").value=type;
			showDiv("添加","CefoMdWin","editMd",w,h);
		}else if(type=='es') {
			$("editEs:updateflag").value = "ADD";
			$("editEs:saveType").value=type;
			showDiv("添加","CefoEsWin","editEs",w,h);
		}else if(type=='sc') {
			$("editSc:updateflag").value = "ADD";
			$("editSc:saveType").value=type;
			showDiv("添加","CefoScWin","editSc",w,h);
		}else if(type=='fc') {
			$("editFc:updateflag").value = "ADD";
			$("editFc:saveType").value=type;
			showDiv("添加","CefoFcWin","editFc",w,h);
		}else if(type=='pl') {
			$("editPl:updateflag").value = "ADD";
			$("editPl:saveType").value=type;
			showDiv("添加","CefoPlWin","editPl",w,h);
		}else if(type=='ws') {
			$("editWa:updateflag").value = "ADD";
			$("editWa:saveType").value=type;
			showDiv("添加","CefoWaWin","editWa",w,h);
		}
	}

	function clearText(type){
		if(type=='pn') {
			$("editPn:pdna").value="";
			$("editPn:brde").value="";
			$("editPn:pdma").value="";
		}else if(type=='md') {
			$("editMd:mdno").value="";
			$("editMd:mdma").value="";
		}else if(type=='es') {
			$("editEs:esno").value="";
			$("editEs:esma").value="";
		}else if(type=='sc') {
			$("editSc:scno").value="";
			$("editSc:scna").value="";
			$("editSc:scma").value="";
		}else if(type=='fc') {
			$("editFc:fcno").value="";
			$("editFc:fcna").value="";
			$("editFc:comy").value="";	
			$("editFc:iflc").value="0";
			$("editFc:stat").value="1";
			$("editFc:fcma").value="";
		}else if(type=='pl') {
			$("editPl:leve").value="";
			$("editPl:lena").value="";
		}else if(type=='ws') {
			$("editWa:wsna").value="";
			$("editWa:wsty").value="";
			$("editWa:wsat").value="1";
			$("editWa:wsma").value="";
		}	
	}

	//编辑
	function Edit(id,type,parm1,parm2,parm3,parm4,parm5,parm6,w,h){
		var title="";
		clearText();
		if(type=='pn') {
			$("editPn:updateflag").value = "MOD";
			$("editPn:saveType").value=type;
			$("editPn:pnid").value=id;
			$("editPn:pdna").value=parm1;
			$("editPn:bran").value=parm2;
			$("editPn:pdma").value=parm3;
			$("editPn:brde").value=parm4;
			showDiv("编辑","CefoPnWin","editPn",w,h);
		}else if(type=='md') {
			$("editMd:updateflag").value = "MOD";
			$("editMd:saveType").value=type;
			$("editMd:mdid").value=id;
			$("editMd:mdno").value=parm1;
			$("editMd:mdma").value=parm2;
			showDiv("编辑","CefoMdWin","editMd",w,h);
		}else if(type=='es') {
			$("editEs:updateflag").value = "MOD";
			$("editEs:saveType").value=type;
			$("editEs:esid").value=id;
			$("editEs:esno").value=parm1;
			$("editEs:esma").value=parm2;
			showDiv("编辑","CefoEsWin","editEs",w,h);
		}else if(type=='sc') {
			$("editSc:updateflag").value = "MOD";
			$("editSc:saveType").value=type;
			$("editSc:scid").value=id;
			$("editSc:scno").value=parm1;
			$("editSc:scna").value=parm2;
			$("editSc:scma").value=parm3;
			showDiv("编辑","CefoScWin","editSc",w,h);
		}else if(type=='fc') {
			$("editFc:updateflag").value = "MOD";
			$("editFc:saveType").value=type;
			$("editFc:fcid").value=id;
			$("editFc:fcno").value=parm1;
			$("editFc:fcna").value=parm2;
			$("editFc:comy").value=parm3;
			$("editFc:iflc").value=parm4;
			$("editFc:stat").value=parm5;
			$("editFc:fcma").value=parm6;
			showDiv("编辑","CefoFcWin","editFc",w,h);
		}else if(type=='pl') {
			$("editPl:updateflag").value = "MOD";
			$("editPl:saveType").value=type;
			$("editPl:plid").value=id;
			$("editPl:leve").value=parm1;
			$("editPl:lena").value=parm2;
			showDiv("编辑","CefoPlWin","editPl",w,h);
		}else if(type=='ws') {
			$("editWa:updateflag").value = "MOD";
			$("editWa:saveType").value=type;
			$("editWa:wsid").value=id;
			$("editWa:wsna").value=parm1;
			$("editWa:wsty").value=parm2;
			$("editWa:wsat").value=parm3;
			$("editWa:wsma").value=parm4;
			showDiv("编辑","CefoWaWin","editWa",w,h);
		}
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){
		Gwin.setLoadok("patClassWin");
	}
	function edit_show1(){
		Gwin.setLoadok("patClassWin1");
	}

	//显示品名层	function showDiv(title,idWin,contextWin,w,h){
		Gwin.open({
			id:idWin,	
			title:title,
			contextType:"ID",
			context:contextWin,
			dom:document,
			width:w,
			height:h,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show(idWin);
		Gwin.setLoadok(idWin);	
	}
	//显示号型层
//	function showDivMd(title){
//		Gwin.open({
//			id:"CefoMdWin",	
//			title:title,
//			contextType:"ID",
//			context:"editMd",
//			dom:document,
//			width:450,
//			height:130,
//			autoLoad:false,
//			showbt:false,
//			lock:true
//		}).show("CefoMdWin");
//		if(title.indexOf("添加")!=-1)Gwin.setLoadok("CefoMdWin");	
//	}
	
	//隐藏层	function hideDiv(win){
		Gwin.close(win);
	}
	function addGroup() {
		if($("editdg:code").value==""){
			alert("编码不能为空！");
			$("editdg:code").focus();
			return false;
		}
		if($("editdg:dname").value==""){
			alert("名称不能为空！");
			$("editdg:dname").focus();
			return false;
		}
		return true;
	}
	function endAddGroup(){
		var msg = $("editdg:msg").value;
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close("patClassWin1");
		}
		Gwin.close("progress_id");
		alert(msg)
	}
	function clearData(type){
		if(type=='pn') {
			$("list:pdna").value='';
			$("list:brad").value='';
		}else if(type=='md') {
			$("list:mdno").value='';
		}else if(type=='es') {
			$("list:esno").value='';
		}else if(type=='sc') {
			$("list:scno").value='';
			$("list:scna").value='';
		}else if(type=='fc') {
			$("list:fcno").value='';
			$("list:fcna").value='';
		}else if(type=='pl') {
			$("list:leve").value='';
			$("list:lena").value='';
		}else if(type=='ws') {
			$("list:wsty").value='';
		}
	}
	// 打开品牌页面
	function selectBran(){
		showModal('../../common/brand_sel/brand_sel.jsf?retid=editPn:bran&retname=editPn:brde');
	return false;
	} 
	// 删除成功
	function endDelDo(){
		var msg = $("list:msg").value;
		Gwin.close("progress_id");
		alert(msg)
	}
//-->	