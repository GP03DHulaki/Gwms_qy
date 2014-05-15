// 跳转添加
function addNew(){
	window.location.href = "shelf_add.jsf";
}
function clearText(){
	if($("edit:vc_voucherid")!=null){
		$("edit:vc_voucherid").value = "自动生成";
	}
	if($("edit:vc_warehouseid")!=null){
		$("edit:vc_warehouseid").value = "";
	}	
	if($("edit:nv_remark")!=null){
		$("edit:nv_remark").value = "";
	}
	if($("edit:whid")!=null ){
		$("edit:whid").value = "";
	}
	if($("edit:whna")!=null ){
		$("edit:whna").value = "";
	}
}

//添加单据
function headAdd(){
	if($("edit:whid")==null || $("edit:whid").value=="0"){
		alert("请选择库位编码！");
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加单据完成
function endHeadAdd(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value;
	if(msg.indexOf("添加成功")!=-1){
		window.location.href="shelf_edit.jsf";
	}else{
		if($("edit:vc_voucherid")!=null){
			$("edit:vc_voucherid").value = "自动生成";
		}
		if($("edit:whid")!=null){
			$("edit:whid").value = "";
		}
		alert(msg);
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

//删除单据	
function doDel()
{	 
	if(!confirm('确定要删除记录吗?')){
		return false;
	}
	$("edit:sellist").value = $("edit:biid").value;
	Gwallwin.winShowmask("TRUE");
	return true;
}
//完成删除
function endDoDel(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
	if($("edit:msg").value.indexOf("删除成功")!=-1){
		window.location.href="shelf.jsf";
	}
}
//批量删除
function doDeleteAll(obj){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.Trim().length<=0){
		alert("请选择需要删除的单据!");
		return false;
	}else{
		if(confirm("确定要删除选中单据吗?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}
//结束批量删除
function endDoDeleteAll(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//添加明细
function addDetail(){
	if($("edit:baco")==null || $("edit:baco").value.Trim().length==0){
		alert("未扫描商品！");
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length==0){
		alert("数量不能为空！");
		$("edit:qty").focus();
		return false;
	}else{
		var num = /^[1-9]\d*$/ ;
		if(!num.test($("edit:qty").value.Trim())){
			alert("数量只能输入非0数字！");
			$("edit:qty").value = "";
			$("edit:qty").focus();
			return false;
		}
	}
	if($("edit:dwhid")==null || $("edit:dwhid").value.Trim().length==0){
		alert("未扫描货位！");
		
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//完成明细添加
function endAddDetail(){
	if($("edit:msg").value.indexOf("添加成功")!=-1){
		$("edit:baco").value = "";
		$("edit:qty").value = "1";
		$("edit:baco").focus();
	}else{
		alert($("edit:msg").value);
		$("edit:baco").value = "";
		$("edit:baco").focus();
	}
	if($("edit:msg").value.indexOf("货位")!=-1){
		$("edit:dwhid").value = "";
	}else if($("edit:msg").value.indexOf("数量")!=-1){
		$("edit:qty").value="";
		$("edit:qty").focus();
	}else if($("edit:msg").value.indexOf("商品")!=-1){
		$("edit:baco").value="";
		$("edit:baco").focus();
	}
	setTable();
	Gwallwin.winShowmask("FALSE");
}
//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i])){
			msg += "第"+(i+1)+"行数量格式错误!  \n";
		}
	}
	if(msg.length<=0){
		Gwallwin.winShowmask("TRUE");
		var updatedate = Gtable.getUpdateinfo('gtable');
	   	$("edit:updatedata").value = updatedate;
	   	return true;
	}else{
		alert(msg);
		return false;
	}
	return true;
}
//完成明细修改
function endUpdateDetail(){
	alert($("edit:msg").value);
	setTable();
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
			var roids = Gtable.getselcolvalues('gtable','roid');
			$("edit:sellist").value=roids.split("#@#").join(",");
		}
    }else{
	   	alert("请选择要删除的记录!");
	   	return false;
    }
	
	return true;
}
//完成删除明细
function endDelDetail(){
	alert("删除成功！");
	setTable();
	Gwallwin.winShowmask("FALSE");
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
//重置查询条件
function clearData(){
	clearAllData();
	if($("edit:startDate")!=null){
		$("edit:startDate").value="";
	}
	if($("edit:endDate")!=null){
		$("edit:endDate").value="";
	}
	if($("edit:sk_biid")!=null){
		$("edit:sk_biid").value="";
	}
	if($("edit:inco")!=null){
		$("edit:inco").value="";
	}
	if($("edit:crna")!=null){
		$("edit:crna").value="";
	}
	if($("edit:sk_flag")!=null){
		$("edit:sk_flag").value="";
	}
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
	if($("edit:biid")!=null){
		$("edit:biid").value="";
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

// 初始化编辑页面
function showMes(){
	if($("edit:baco")!=null){
		$("edit:baco").value = "";
	}
	if($("edit:qty")!=null){
		$("edit:qty").value = "1";
	}
	if($("edit:dwhid")!=null){
		$("edit:dwhid").value = "";
	}
	
	//设置false
	setTable();
	
	//初始化edit
	t = new TailHandler('out');
	if($('edit:batp:0'))
	$('edit:batp:0').checked = true;
	if($('edit:qty'))
	$('edit:qty').value='1';
	if($('edit:autoItem'))
	$('edit:autoItem').value='0';
}
//初始化Edit页面
function initEdit(){
	textClear('edit','baco,dwhid,whna,qty','Y');
}
//添加商品
function addbarcode(){
	var e = window.event || arguments.callee.caller.arguments[0];
	if (e.keyCode==13)
	{	
		if($("edit:addbarcode")!=null){
			$("edit:addbarcode").onclick();
		}
		return true;
	}
}
//扫描商品
function onkeybacode(){
	var e = window.event || arguments.callee.caller.arguments[0];
	if (e.keyCode==13){
		if($("edit:baco")==null || $("edit:baco").value.Trim().length==0){
			alert("未扫描商品！");
			$("edit:baco").focus();
		}else{
			if($("edit:selectQy")!=null){
				$("edit:selectQy").onclick();
			}
			$("edit:qty").focus();
		}
	}
}
//扫描商品
function onkeyqty(event){
	if (event.keyCode==13){
		if($("edit:qty")==null || $("edit:qty").value.Trim().length==0){
			alert("数量不能为空！");
			$("edit:qty").focus();
		}else{
			$("edit:vc_warehouseid").focus();
		}
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
function endShenHe(){setTable();
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//显示和隐藏扩展功能
function JS_ExtraFunction(){
	var extraFunction = document.getElementById("ExtraFunction");
	var detail_ctrl = document.getElementById("detail_ctrl");
	if(extraFunction.style.display=='none'){
		extraFunction.style.display="";
		detail_ctrl.className="ctrl_hide";
	}else{
		extraFunction.style.display="none";
		detail_ctrl.className="ctrl_show";
	}
}
// 查询上架区域
function selectQy(){
	
	Gwallwin.winShowmask("TRUE");
}
// 结束提示
function endSelectQy(){
	Gwallwin.winShowmask("FLASE");
}
function startDo(){
	Gwallwin.winShowmask("TRUE");
}
function endDo(){
	Gwallwin.winShowmask("FLASE");
}
function Edit(vc_voucherid){	
	if($("edit:biid")!=null){
		$("edit:biid").value=vc_voucherid;
	}
	$("edit:editbut").click();
}
// 打开选择库位页面
function selectWaho(){
	var url = "../../common/waho/waho.jsf?type=4,5,6,7&retid=edit:dwhid&retname=";
	showModal(url);
	return false;
}
function selectWaid(){
	var url = "../../common/waho/waho.jsf?type=9,10&pwid=all&retid=edit:whid&retname=edit:whna";
	showModal(url);
	return false;
}
/*function radioChange(){
	var radios = document.getElementsByName("edit:ispaco");
	var value = '03';
	for (i=0;i<radios.length;i++){
    if(radios[i].checked){
    	value= radios[i].value;
    }
    if(value=='02') {
    	$("db_num").style.display='';
    }
    else if(value='03') {
    	$("db_num").style.display='none';
    }
  }
}*/
function setTable() {
	var ls = $("gtable_table").getElementsByTagName("td");
	for(var i=0;i<ls.length;i++) {
		if($("gtable_chfl_"+i)!=null&&$("gtable_chfl_"+i).innerHTML=="03"){
			$("gtable_qty_"+i).disabled='disabled';
		}
	}
}
// 打开选择条码
function selectCode(){
    var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value,'710px','550px');
    }else if(batp == '02'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'500px','450px');
    }
	return true;
}
function endCode4DBean(){
	Gwallwin.winShowmask('FALSE');
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
}