// 编辑页面初始化
function showMes(){
	if($("edit:vc_barcode")!=null){
		$('edit:vc_barcode').value = "";
		$('edit:vc_barcode').focus();
	}
	if($("edit:dc_qty")!=null){
		$('edit:dc_qty').value = "1";
	}
	if($("edit:vc_storehouseareaname")!=null){
		$('edit:vc_storehouseareaname').value = "";
	}
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
}


// 跳转添加
function addNew(){
	window.location.href = "iqc_add.jsf";
}
// 清空入库单
function onclose(){
	if($("edit:nv_fromvoucherid")!=null){
		$("edit:nv_fromvoucherid").value = "";
		$("edit:nv_fromvoucherid").focus();
	}
}
// 跳转到条码
function tobarcode(){
	if($("edit:vc_barcode")!=null){
		$("edit:vc_barcode").select();
	}
}
// 提交单据
function tijiao(){
	Gwallwin.winShowmask("TRUE");
}
// 结束提交
function endTijiao(){
	if($("edit:msg")!=null){
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}
// 回退单据
function huitui(){
	Gwallwin.winShowmask("TRUE");
}
// 结束回退
function endHuitui(){
	if($("edit:msg")!=null){
		alert($("edit:msg").value);
	}
	Gwallwin.winShowmask("FALSE");
}


//添加单据
function headAdd(){
	Gwallwin.winShowmask("TRUE");
	return true;
	
	if($("edit:nv_fromvoucherid")==null || $("edit:nv_fromvoucherid").value.Trim().length==0){
		alert("预约单号不能为空！");
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加单据完成
function endHeadAdd(){
	alert("添加成功!");
	window.location.href="iqc_edit.jsf";
	return true;
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("添加成功")!=-1){
		window.location.href="iqc_edit.jsf";
	}else{
		if($("edit:vc_voucherid")!=null){
			$("edit:vc_voucherid").value="";
		}
		if($("edit:nv_fromvoucherid")!=null){
			$("edit:nv_fromvoucherid").value="";
		}
	}
}
//添加页面初始化
function clearText(){
	if($("edit:vc_voucherid")!=null){
		$("edit:vc_voucherid").value="自动生成";
	}
	if($("edit:nv_fromvoucherid")!=null){
		$("edit:nv_fromvoucherid").value="";
	}
	if($("edit:vc_operatetype")!=null){
		$("edit:vc_operatetype").value="01";
	}
	if($("edit:nv_remark")!=null){
		$("edit:nv_remark").value="";
	}
}

//修改表头
function headCheck(){
	Gwallwin.winShowmask("TRUE");
	return true;
}
//修改完成
function endHeadCheck(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//打开指定页面
function selectObj(url){
	url = url + "?time=" + new Date().getTime();
	window.showModalDialog(url,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
	return false;
}
//打开指定页面
function selectObj1(url){
	var type ;
	if($("edit:vc_operatetype")==null){
		type = 1;
	}else{
		if($("edit:vc_operatetype").value==2){
			type = 2;
		}else{
			type = 1;
		}
	}
	url = url + "?time=" + new Date().getTime()+"&type=" + type;
	window.showModalDialog(url,window,'dialogHeight:550px;dialogWidth:600px;status:no;resizable:no;');
	return false;
}
//删除单据	
function doDel()
{	 
	if(!confirm('确定要删除记录吗?')){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;		     
}
//完成删除
function endDoDel(){
	alert($('edit:msg').value);
	Gwallwin.winShowmask("FALSE");
	if($('edit:msg').value.indexOf("删除成功！")!=-1){
		window.location.href="iqc.jsf";
	}
}
//批量删除
function doDeleteAll(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:deleteItem").value=arr;
		}
	}else{
	   	alert("请选择要删除的记录!");
	   	return false;
	}
	return true;		
}
//结束批量删除
function endDoDeleteAll(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//添加明细
function addDetail(){
	
	if($("edit:dc_qty")==null || $("edit:dc_qty").value.Trim().length==0){
		alert("上架数量不能为空！")
		$("edit:vc_barcode").value = "";
		$("edit:dc_qty").focus();
		return false;
	}else{
		var num = /^[1-9]\d*$/;
		if(!num.test($("edit:dc_qty").value.Trim())){
			alert("上架数量只能是非0数字！");
			$("edit:dc_qty").value = "";
			$("edit:vc_barcode").value = "";
			$("edit:dc_qty").focus();
			return false;
		}
	}
	if($("edit:vc_barcode")==null || $("edit:vc_barcode").value.Trim().length==0){
		alert("商品条码不能为空！");
		$("edit:vc_barcode").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//完成明细添加
function endAddDetail(){
	if($("edit:msg").value.indexOf("OK")!=-1){
		$("edit:vc_barcode").focus();
		$("edit:dc_qty").value = "1";
	}else{  
		alert($("edit:msg").value);
	}	
	if($("edit:msg").value.indexOf("上架车")!=-1){
	
	}else{
		$("edit:vc_barcode").focus();
	}
	$("edit:vc_barcode").value = "";
	Gwallwin.winShowmask("FALSE");
}
//修改明细
function updateDetail(){
	
	var strdc_qtys= Gtable.getcolvalues("gtable","dc_qty");
	var strdc_fqtys= Gtable.getcolvalues("gtable","dc_fqty");
    var strId_dids= Gtable.getcolvalues("gtable","CHECKID");
    var dc_qtys= strdc_qtys.split('#@#');
    var dc_fqtys= strdc_fqtys.split('#@#');
    var id_dids= strId_dids.split(',');
    if(id_dids.length>0&&id_dids[0].Trim().length>0)
    {
   		for(var i=0;i<dc_qtys.length;i++)
   		{
   			var numValidate=/^[0-9]*$/;
			if(!numValidate.test(dc_qtys[i])){
				alert("第"+(i+1)+"行正品数量应为整数!");
				return false;
			}
			if(!numValidate.test(dc_fqtys[i])){
				alert("第"+(i+1)+"行次品数量应为整数!");
				return false;
			}
   		}
   		Gwallwin.winShowmask("TRUE");
        $("edit:strid_did").value=strId_dids;
        $("edit:strdc_qty").value=strdc_qtys;
        $("edit:strdc_fqty").value=strdc_fqtys;
		return true;
   	}
   	else
   	{
   		alert("没有保存的明细!");
   		return false;
   	}

	return true;
}
//完成明细修改
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//删除明细
function delDetail(obj){
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){		    	
		if(!confirm('确定删除当前记录吗?')){
			return false;
		}else{
			Gwallwin.winShowmask("TRUE");
			$("edit:item").value=arr;
		}
    }else{
	   	alert("请选择要删除的记录!");
	   	return false;
    }
	return true;
}
//完成删除明细
function endDelDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//指定商品不良品
function doBad(){
	if(!confirm('确定刚刚扫入的商品为不良品?')){
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//完成指定商品为不良品
function endDoBad(){
	alert("已将刚刚扫入的商品指定为不良品。");
	Gwallwin.winShowmask("FALSE");
}
//重置查询条件
function clearData(){
	clearAllData();
	$("edit:sk_voucherid").focus();
}
//进入页面时
function showMesList(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			clearAllData();
		}
	}else{
		clearAllData();
	}
}

//清空数据
function clearAllData(){
	if($("edit:sk_start_date")!=null){
		$("edit:sk_start_date").value="";
	}
	if($("edit:sk_end_date")!=null){
		$("edit:sk_end_date").value="";
	}
	if($("edit:sk_supplierid")!=null){
		$("edit:sk_supplierid").value="";
	}
	if($("edit:sk_suppliername")!=null){
		$("edit:sk_suppliername").value="";
	}
	if($("edit:sk_voucherid")!=null){
		$("edit:sk_voucherid").value="";
	}
	if($("edit:sk_fromvoucherid")!=null){
		$("edit:sk_fromvoucherid").value="";
	}
	if($("edit:sk_frompovoucherid")!=null){
		$("edit:sk_frompovoucherid").value="";
	}
	if($("edit:vc_barcode")!=null){
		$("edit:vc_barcode").value="";
	}
}

//回车监听
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}

//查询
function checkList()
{
	var startDate =$("edit:sk_start_date").value;
	var enddate =$("edit:sk_end_date").value;
	if(startDate.Trim().length>0)
	{
		if(startDate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("开始日期格式错误!\n正确格式(YYYY-MM-DD)"+startDate);
	  		
	  		$("edit:sk_start_date").value="";
	  		return false;
		}
	}
	if(enddate.Trim().length>0)
	{
		if(enddate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("结束日期格式错误!\n正确格式(YYYY-MM-DD)");
	  		$("edit:sk_end_date").value="";
	  		return false;
		}
	}	
	if(startDate.Trim().length>0&&enddate.Trim().length>0)
	{
		if(enddate<startDate)
		{
			alert("结束日期应大于开始日期!!");
			$("edit:sk_start_date").value="";
			$("edit:sk_end_date").value="";
			$("edit:sk_start_date").focus();
			return false;
		}
	}
	return true;
}

// 添加商品
function addbarcode(){
	if (event.keyCode==13)
	{	
		if($("edit:addbarcode")!=null){
			$("edit:addbarcode").onclick();
		}
		return true;
	}
}
/*
 * 审核
 */
function shenHe(){	
	Gwallwin.winShowmask("TRUE");
}
/*
 * 完成审核
 */
function endShenHe(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
// 监听扫描商品
function onkeybarcode(){
	if (event.keyCode==13)
	{	
		if($("edit:dc_qty")!=null){
			$("edit:dc_qty").select();
		}
		return true;
	}
}

