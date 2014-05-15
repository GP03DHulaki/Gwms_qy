<!--
	function startDo(msg){
		Gwin.progress(msg,10,document);
	}

	function endDo(){
		var msg = $("edit:msg").value;
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close("patClassWin");
		}
		Gwin.close("progress_id");
		alert(msg)
	}
	function endDelete(){
		var msg = $("list:msg").value;
		if(msg.indexOf("成功")!=-1){
			clearText();
			Gwin.close("patClassWin");
		}
		Gwin.close("progress_id");
		alert(msg)
	}

	var delstate = false;
	function deleteAll(obj,id){
		$('list:saveType').value=id;
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
function endDeleteAll(){
	Gwin.close("progress_id");
	if($("list:msg").value!=""){
		alert($("list:msg").value);
	}
}

	//验证id="edit"的form表单				
	function formCheck(){	
		if($("edit:dname").value==""){
			alert("名称不能为空！");
			$("edit:dname").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}
	function savePrice() {
		if($("edit:prics").value==""){
			alert("起始价格不能为空！");
			$("edit:prics").focus();
			return false;
		}
		if($("edit:price").value==""){
			alert("起始价格不能为空！");
			$("edit:price").focus();
			return false;
		}
		Gwin.progress("正在保存...",10,document);
		return true;
	}
	function endSave() {
		Gwin.close("progress_id");
		if($("edit:msg").value.indexOf("成功")!=-1){
			$("list:refBut").click();
		}
		if($("edit:msg").value!=""){
			alert($("edit:msg").value)
		}
		
	}
	function addDiv(op){
		var title="";
		clearText();
		if($("edit:updateflag"))
		$("edit:updateflag").value = "ADD";
		if($("editdg:updateflag"))
		$("editdg:updateflag").value = "ADD";
		if(op=='1') {
			$("edit:saveType").value='1';showDiv("添加");
		}
		else if(op=='2') {
			$("edit:saveType").value='2';showDiv("添加");
		}
		else if(op=='3') {
			$("edit:saveType").value='3';showDiv("添加");
		}
		else if(op=='4') {
			$("edit:saveType").value='4';
			showDivdg('添加组别');
		}
		else if(op=='5') {
			$("edit:saveType").value='5';
			showDiv('添加');
		}
		else if(op=='6') {
			$("edit:saveType").value='6';
			showDiv('添加');
		}
		else if(op=='7') {
			$("edit:saveType").value='7';
			showDiv('添加');
		}
		
		//showdiv是有缓存？
	}

	function clearText(){
		if($("edit:dname"))
		$("edit:dname").value="";
		if($("edit:drema"))
		$("edit:drema").value="";
		if($("editdg:dname"))
		$("editdg:dname").value="";
		if($("editdg:drema"))
		$("editdg:drema").value="";
		if($("editdg:code"))
		$("editdg:code").value="";

		if($("edit:prics"))
		$("edit:prics").value="";
		if($("edit:price"))
		$("edit:price").value="";
	}
	
	//编辑
	function Edit(id,type){
		
		if(type=='4'){
			showDivdg("编辑组信息");
			$("edit:updateflag").value="EDIT"
			$("edit:saveType").value = type;
			$("edit:selid").value = id;
			$("edit:editbut").click();
		}
		else {
		showDiv("编辑");
		$("edit:updateflag").value="EDIT"
		$("edit:saveType").value = type;
		$("edit:selid").value = id;
		$("edit:editbut").click();
		}
	}
	
	//点击修改角色按钮时调用的方法
	function edit_show(){
		Gwin.setLoadok("patClassWin");
	}
	function edit_show1(){
		Gwin.setLoadok("patClassWin1");
	}

	//显示层	function showDiv(title){
		Gwin.open({
			id:"patClassWin",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:450,
			height:130,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("patClassWin");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("patClassWin");	
	}
	//显示层
	function showDivdg(title){
		Gwin.open({
			id:"patClassWin1",	
			title:title,
			contextType:"ID",
			context:"edit",
			dom:document,
			width:450,
			height:130,
			autoLoad:false,
			showbt:false,
			lock:true
		}).show("patClassWin1");
		if(title.indexOf("添加")!=-1)Gwin.setLoadok("patClassWin1");	
	}
	
	//隐藏层	function hideDiv(){
		Gwin.close("patClassWin");
	}
	function hidedgDiv(){
		Gwin.close("patClassWin1");
	}
	function addGroup() {
		if($("edit:code").value==""){
			alert("编码不能为空！");
			$("editdg:code").focus();
			return false;
		}
		if($("edit:dname").value==""){
			alert("名称不能为空！");
			$("edit:dname").focus();
			return false;
		}
		return true;
	}
	function endAddGroup(){
		var msg = $("edit:msg").value;
		if(msg.indexOf("成功")!=-1){
			$("list:refBut").click();
			clearText();
			Gwin.close("patClassWin1");
		}
		Gwin.close("progress_id");
		alert(msg)
	}
	function clearData(){
		if($('list:dcode')!=null){
     		$('list:dcode').value="";
     	}
   		if($('list:name')!=null){
   			$('list:name').value="";
   			$('list:name').focus();
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
//-->	