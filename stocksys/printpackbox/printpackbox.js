<!-- 
function listPageLoad(){
	textClear('list','qty,sk_inco,sk_qty','Y');	//	,sk_printFlag,sk_flag
	clearData();
	//document.getElementById("sk_printFlag").selectedIndex=1;
	//document.getElementById("list:sk_flag").selectedIndex=1;
}

function listBarLoad(){
	var str=window.location.search;
	if(str!="?type=1"){
		clearBarData();
		//$("list:barSearch").click();
	}
}
//打印箱子码
function print(obj){
   	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		document.getElementById("list:item").value=arr;
		//Gwallwin.winShowmask("TRUE");
		return true;	
	}else{
		alert("请选择需要进行打印的条码!");
		return false;
	}
}

//生成物料条码
function generate(){
	if($("list:sk_inco").value=="" || $("list:sk_inco").value.Trim().length==0)
	{
		alert("请选择物料编码!");
		$("list:sk_inco").focus();
		return false;
	}
	if($("list:sk_qty").value=="" || $("list:sk_qty").value.Trim().length==0){
		alert("请输入你要生成条码个数量");
		$("list:sk_qty").focus();
		return false;
	}
	//Gwallwin.winShowmask("TRUE");
	return true;
}


function Endgenerate(){
	alert($("list:msg").value);
	//Gwallwin.winShowmask("FALSE");
}

// 打开选择物料信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=list:sk_inco','600px','460px');
	return false;
}
	  

	
function lookPrint(){
	Gwallwin.winShowmask("FALSE");
	var mes =document.getElementById("list:msg").value;
	
	if(mes.indexOf("无法打印")!=-1){
		alert(mes);
		document.getElementById("list:msg").value="";
 	}else{
 		var name=document.getElementById("list:outPutFileName").value;
 		window.open('../'+name + "?time=" + new Date().getTime());
 	}
} 


	
//生成箱子条码	   
function checkList(){
	if($("list:qty").value=="" || $("list:qty").value.length==0 ){
		alert("请输入生成 箱码个数");
		$("list:qty").value="";
		$("list:qty").focus();
		return false;
	}
	if(document.getElementById("list:qty").value.search("^\\d+(\\.\\d+)?$") !=0 )
	{
		alert("数量格式不正确");
		document.getElementById("list:qty").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//生成箱子条码	完成  
function endcheckList(){
	Gwallwin.winShowmask("FALSE");
	var mes =document.getElementById("list:msg").value;
	alert(mes);
}   


function initFrame(){
	$('tabContent1').className = 'hidetab_body';
	endWinShow();
}

function endWinShow(){
    Gwallwin.winShowmask("FALSE");
}
//重置首页查询条件
function clearData(){
	if($("list:start_date")!=null){
		$("list:start_date").value = "";
	}
	if($("list:end_date")!=null){
		$("list:end_date").value = "";
	}
	if($("list:query_inco")!=null){
		$("list:query_inco").value = "";
	}
	if($("list:query_crna")!=null){
		$("list:query_crna").value = "";
	}
	if($("list:sk_flag")!=null){
		$("list:sk_flag").value = "";
	}
	
}


function clearBarData(){
	if($("list:query_baco")!=null){
		$("list:query_baco").value = "";
	}
	if($("list:query_inco")!=null){
		$("list:query_inco").value = "";
	}
	if($("list:query_inna")!=null){
		$("list:query_inna").value = "";
	}
	if($("list:sk_flag")!=null){
		$("list:sk_flag").value = "";
	}
	if($("list:sk_inco")!=null){
		$("list:sk_inco").value = "";
	}
	if($("list:sk_qty")!=null){
		$("list:sk_qty").value = "";
	}
}
function search(){
	window.location.href = "printbarcode.jsf?type=1"
	//Gwallwin.winShowmask('FALSE');
}
-->