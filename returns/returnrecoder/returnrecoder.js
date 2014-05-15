//跳转到添加表头页面
function addNew(){
	 window.location.href='returnrecoder_add.jsf';
	 if($("edit:infl")!=null){
		$("edit:infl").value="";
	 }
}

//添加表头清空
function initAdd(){   
   	textClear("edit","stdt,orid,orna,rema,msg");
   	if($("edit:biid")!=null){
		$("edit:biid").value="自动生成";
	}
}	

//选择组织架构
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}


//保存单据
function addHead(){

	if($("edit:buty").value.Trim().length==0 || $("edit:buty").value==""){
		alert("请选择业务类型");
		$("edit:buty").focus();
		return false;
	}
	if($("edit:orid").value.Trim().length==0 || $("edit:orid").value==""){
		alert("请选择组织架构");
		$("edit:buty").focus();
		return false;
	}
	if($("edit:stdt").value.Trim().length==0 || $("edit:stdt").value.Trim()==""){
		alert("请选择退货时间!");
		$("edit:stdt").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//保存单据
function endAddHead(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
	if(msg.indexOf("单据添加成功")!=-1){
		window.location.href="returnrecoder_edit.jsf";
	}
	if(msg.indexOf("单据保存成功")!=-1){
		Gwallwin.winShowmask("FALSE");
		return true;
	}
	Gwallwin.winShowmask("FALSE");
}

//加载编辑界面
function initEdit(){
	textClear("edit","baco,qty,whid,msg");
}


//选择商品
function selectInveAdd(){
	 var batp = t.getBatp();//获得条码类型编码
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }

    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco','580','520');
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?stat=1&retid=edit:baco&ctype="
    	+batp+"&whid=&dwhid=&soco=",'730px','520px');
    }
    
	return false;
}
//选择货位
function selectWahod(){
	var url="../../common/waho/waho.jsf?type=8&pwid=&orid="+$('edit:orid').value+"&retid=edit:whid&retname=";
	showModal(url,"500px","500px");
	return false;
}


//初始化edit
function initDetail(){
	if($('edit:qty')){
	t = new TailHandler('out');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	}
}

function startDo(){
	Gwallwin.winShowmask("TRUE");
}

function endCode4DBean(){
	Gwallwin.winShowmask('FALSE');
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
	}
}

//添加明细
function addDetail(){
	if($("edit:baco").value.Trim().length<=0 || $("edit:baco").value==""){
		alert("请输入条码");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:whid").value.Trim().length<=0 || $("edit:whid").value==""){
		alert("请输入货位");
		$("edit:whid").focus();
		return false;
	}
	if($("edit:qty").value.Trim().length<=0 || $("edit:qty").value==""){
		alert("请输入数量");
		$("edit:qty").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
//添加明细后
function endAddDetail(){
	Gwallwin.winShowmask("FALSE");
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
	$("edit:baco").value="";
	$("edit:baco").focus();
	}else{$("edit:baco").value="";}
}


//删除明细
function delDetail(obj){
	var roids = Gtable.getselcolvalues('gtable','roid');
	if(roids.length>0){	
		if(confirm("确定要删除你当前选中的记录吗？")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = roids.split("#@#").join(",");
			return true;
		}
	}else{
		alert("请选择你要删除的记录");
		return false;
	}
}
//删除明细后
function endDelDetail(){
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

//保存单据
function updateHead(){
	Gwallwin.winShowmask("TRUE");
	return true;
}
//结束保存单据
function endUpdateHead(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


//编辑页面删除单据
function doDel(){
	if(confirm("确定要删除单据吗？")){
		$("edit:sellist").value = $("edit:biid").value;
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
//编辑页面删除单据后
function endDele(){
	var msg = $("edit:msg").value;
	alert(msg);
	if(msg.indexOf("成功")!=-1){
		window.location.href="returnrecoder.jsf";
	}
	Gwallwin.winShowmask("FALSE");
	return true;
}
//修改明细
function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i]) ){
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
}
//修改明细后
function endUpdateDetail(){
	if($("edit:msg").value.indexOf("修改成功")!=-1){
		alert($("edit:msg").value);
		
	}
	Gwallwin.winShowmask("FALSE");
}

//审核前
function app(){
	if(confirm("确定要审核单据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
//审核后
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


//首页删除
function deleteHeadAll(obj){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.length<=0){
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

//跳转到差异界面
function goToErr(param){
	var biid = $("edit:biid").value;
	if(param==1){
		window.location.href='seardiff.jsf?pid='+biid;
	}else if(param==0){
		window.location.href='returnrecoder.jsf?isAll=0';
	}
}

//开始调整库存
function startDiff(){
	if(confirm("确定要调整差异数据吗？")){
		Gwallwin.winShowmask("TRUE");
		return true;
	}else{
		return false;
	}
}
//结束调整库存
function endDiff(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

