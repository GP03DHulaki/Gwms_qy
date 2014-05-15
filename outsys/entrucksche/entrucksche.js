<!--
function startDo(){
    Gwin.progress("",10,parent.document);
}

function endSave(id){
	Gwin.close("progress_id");
	var message = $("edit:msg").value;
	var type = "X";
	id = id ? id : "";
	var winid = "billWin";
	if(id.indexOf("tran")!=-1) winid = "billtranWin";
	if(message.indexOf('成功')!=-1){
		type = "Y";
		var iframe = parent.document.getElementById(id);
		iframe ?　iframe.contentWindow.document.getElementById("edit:refBut").onclick() : null;
	}
	Gwin.alert("系统提示",message,type,parent.document);
	if(type === "Y")Gwin.close(winid);
}

function endDo(){
	var message = $("edit:msg").value;
	Gwin.close("progress_id");
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	Gwin.alert("系统提示",message,"Y",parent.document);
    	window.location.href="outorder_edit.jsf";
    }else{
    	Gwin.alert("系统提示",message,"X",parent.document);
    }
}

function endLoad(){
	Gwin.close("progress_id");
}

function getVouch(){
	if($('edit:getvouch')){
		startDo();
		$('edit:getvouch').click();
	}
}

function doSearch(){
	startDo();
	$("edit:sid").click();
}

/**回车监听*/
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}

function clearSearchKey(type){
	if(type==1){
		var param = Request.QueryString('isAll');
		if(param=="0"){
			textClear('list','sk_voucherid,start_date,end_date,sk_expressname,sk_invcode,sk_districtname,sk_customername,b_date,e_date');
			if($('edit:sk_flag')){
				$('edit:sk_flag').value="01";
			}
			//doSearch();
		}
	}else{
		textClear('edit','sk_biid,sk_cuin,sk_lpin,sk_lnco,sk_gead,start_date,end_date');
	}
}

function hideDiv(){
	Gwallwin.winClose();		
}


function EditBill(biid){	
	showBill(biid);
}

function showBill(biid){
	Gwin.open({
		id:"billWin",
		title:"编辑",
			contextType:"URL",
			context:"billmodal.jsf?biid="+biid,
			width:700,
			height:350,
			showbt:false,
			lock:true,
			dom:parent.document
   	}).show("billWin");		   
}
function showBill_tran(biid){
	Gwin.open({
		id:"billtranWin",
		title:"编辑",
			contextType:"URL",
			context:"billmodal_tran.jsf?biid="+biid,
			width:700,
			height:350,
			showbt:false,
			lock:true,
			dom:parent.document
   	}).show("billtranWin");		
}

function showBill_pobo(biid){
	Gwin.open({
		id:"billpoboWin",
		title:"编辑",
			contextType:"URL",
			context:"billmodal_tran.jsf?biid="+biid,
			width:700,
			height:350,
			showbt:false,
			lock:true,
			dom:parent.document
   	}).show("billpoboWin");		
}


function checkSel(){
	var biids = Gtable.getselcolvalues('gtable','biid');
	if(biids.length<=0){
		Gwin.alert("系统提示",'请勾选单据!',"!",parent.document);
		return false;
	}
	startDo();
	$('edit:sellist').value = biids;
	return true;
}

function endCrePlan(){
	Gwin.close("progress_id");
	var msg = $('edit:msg').value;
	//Gwin.alert("系统提示",msg.replaceAll('<p>','\n') );
	Gwin.alert("系统提示",msg,"!",parent.document);
	//var obj = $('gcloseico');
	//obj.attachEvent('onclick',clickClose);
	//window.dialogArguments.document.getElementById('edit:refBut').onclick();
}
function showPanel(){
	Gwin.open({
		id:"showPanelWin",
		title:"按条件筛选订单",
		lock:true,
		showbt:false,
		dom:document,
		contextType:"ID",
		context:"editPanel",
		autoLoad:false,
		width:300,
		height:90
	}).show("showPanelWin");
	//Gwallwin.winShow('editPanel','按条件筛选订单',350);
}

function endSift(){
	Gwin.close("progress_id");
	window.parent.location.href="entrucksche_merge.jsf?isAll=0";
}

function searchBill(cuid,lico,lpco){
	$('edit:cuid').value=cuid;
	$('edit:lico').value=lico;
	$('edit:lpco').value=lpco;
	$('edit:listBut').onclick();
}

function gotoList(){
	//window.location.href="billlist.jsf";
	Gwin.close("progress_id");
	showModal('billlist.jsf','850','500');
	//Gwallwin.winShowmask("FALSE");
}
function clickClose(){
	Gwallwin.winClose();
	if(Gtable.getcolvalues('gtable','biid')==''){
		Gwin.close(document.GwinID);
	}
}

// 打开选择商品信息页面
function selectInve(){
	showModal('../../common/inve/inve.jsf?retid=edit:sk_inco&retname=');
	return false;
}

function initFrame(){
	$('tabContent2').className = 'hidetab_body';
	Gwin.close("progress_id");
}