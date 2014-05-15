is_IE = (navigator.appName == "Microsoft Internet Explorer");
function init() {
	var temp = document.getElementById("gtable_table").getElementsByTagName("input");
	/*
	for(i=0;i<temp.length;i++){
		if(temp[i].getAttribute("type")=="text"){var rqty=0 //可预约数
		if(is_IE){
			temp[i].attachEvent("onchange", function(event){
			var element = event.srcElement;
			var index = event.srcElement.id.charAt(event.srcElement.id.length-1);
			try{document.getElementById("checkbox"+index).checked="check";
			rqty = parseInt(document.getElementById("gtable_avai_"+index).innerHTML);
			if( parseInt(event.srcElement.value)>rqty){
				alert('您输入的数字大于可预约数');
				event.srcElement.value='0';
				document.getElementById("checkbox"+index).checked="";
				}
			}catch(e){}
			});
		}
		else{
			temp[i].addEventListener("change", function(){
			var index = this.id.charAt(this.id.length-1);
			try{document.getElementById("checkbox"+index).checked="check";
			rqty = parseInt(document.getElementById("gtable_avai_"+index).innerHTML);
			if( parseInt(this.value)>rqty){
				alert('您输入的数字大于可预约数');
				this.value='0'
				document.getElementById("checkbox"+index).checked="";}
			}catch(e){}
			}, false);
		}
		}
	}
	*/
	
}
	var retid="",retname="";		//返回刷新的字段，如无，则不刷新
	
    function selectThis(parm1,parm2){
    	retid = $('edit:retid').value;
	retname = $('edit:retname').value;
	var callBack = null;  
	if(is_IE) {
		 callBack = window.dialogArguments;   
	}
	else {
	callBack = window.opener;   
	}

    	if ( retid != "" && retid != null){
			callBack.document.getElementById(retid).value=parm1;
		}
		
		if ( retname != "" && retname != null){
			callBack.document.getElementById(retname).value=parm2;
		}

		window.close();	
    }
    
	function formsubmit(){
		if (event.keyCode==13){
			var obj=$("edit:sid");
			obj.onclick();
			return true;
		}
	}
	
	function cleartext(){
		var a = $("edit:pubdid");
		if(a!=null){
			a.value="";
			a.focus();
		}
	}
	function purchaseData() {
	var data="";
	var inputobj = document.getElementsByTagName("input");
	var num=0; 
	for(var i=0;i<inputobj.length;i++){ 
		if(inputobj[i].checked ) 
		num+=1; 
	} 
	if(num<=0){
		alert('没有选中更新的列');
		$("edit:dbdata").value="";
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	for(var i=0;i<inputobj.length;i++){
		
		if($("gtable_nowqty_"+i)!=null&&$("gtable_nowqty_"+i).value.Trim()!="") {
			//数量：采购订单编码：商品编码
			if ($("checkbox"+i).checked) {
			data+=$("gtable_nowqty_"+i).value+":"+$("gtable_biid_"+i).innerHTML+":"+$("gtable_inco_"+i).innerHTML+"##";
			}
		}
	}
	if(data==""){
		Gwallwin.winShowmask("FALSE");
		alert('没有数据更新');
		return false;
	}
	$("edit:dbdata").value = data;
	parent.document.getElementById("edit:refBut").onclick();
	return true;
	}
	
	function closeDiag(){init();
		Gwallwin.winShowmask("FALSE");
		var msg = $("edit:msg").value;
		if(msg!=""){
			alert(msg);
			parent.window.document.getElementById("edit:refBut").onclick();
		}
		
	}
function startDo(){
    Gwallwin.winShowmask("TRUE");
}
function complete() {
	Gwallwin.winShowmask("FALSE");
}

//选择输入数量后的明细 wonderful
function selectCheckBox(obj)
{
	var str = obj.id.split('_');
	var id = "checkbox"+str[2];
	
	document.getElementById(id).checked = true;
	return true;
}
	
