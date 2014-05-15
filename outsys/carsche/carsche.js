<!--
function startDo(){
    Gwallwin.winShowmask("TRUE");
}

function endWinShow(){
    Gwallwin.winShowmask("FALSE");
}


function endSave(){
	var message = $("edit:msg").value;
	if(message.indexOf('成功')!=-1){
		Gwallwin.winShowmask('true');
	}
	Gwallwin.winShowmask('FALSE');
	alert(message);
}

function endDo(){
	var message = $("edit:msg").value;
	if(message.indexOf('打印成功')!=-1){
     	window.open('../../pdf/'+$("edit:outPutFileName").value);
    }else if(message.indexOf("单据添加成功")!=-1){
    	alert(message);
    	window.location.href="outorder_edit.jsf";
    }else{
    	alert(message);
    }
    Gwallwin.winShowmask('FALSE');
}

function endLoad(){
	Gwallwin.winShowmask('FALSE');
}

function getVouch(){
	if($('edit:getvouch')){
		startDo();
		$('edit:getvouch').click();
	}
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
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

function clearSearchKey(){
	textClear('edit','start_date,end_date,sk_lnco,sk_soty_order,sk_soty,sk_soco,biid','N');
}

function hideDiv(){
	Gwallwin.winClose();		
}


function showBill(lico,lina,soty){	
	$('edit:param').value="2";
	$('edit:carlico').value=lico;
	$('edit:carlina').value=lico;
	$('edit:isoty').value=soty;
	//alert($('edit:isoty').value);
	$('edit:refBut').click();
	//parent.window.location.href="billlist.jsf?lico="+lico+"&lina="+lina;
}

function showBil_bid(biid,soty){	
	$('edit:param').value="1";
	$('edit:sellist').value=biid;
	$('edit:isoty').value=soty;
	$('edit:refBut').click();
	//parent.window.location.href="billlist.jsf?lico="+lico+"&lina="+lina;
}

function listBill(){
	parent.window.location.href="billlist.jsf";
}

function checkSel(){
	var biids = Gtable.getselcolvalues('gtable','biid');
	if(biids.length<=0){
		alert('请勾选单据!');
		return false;
	}
	//Gwallwin.winShowmask("TRUE");
	parent.startDo();
	$('edit:sellist').value = biids;
	return true;
}

function endCrePlan(msg){
	Gwallwin.winShowmask("FALSE");
	if(msg.indexOf('装车单创建成功!')!=-1){
		if(confirm('装车单创建成功,是否跳转到装车单编辑页面?')){
			$('edit:gotoBut').click();
		}
	}else{
		//alert(msg.replaceAll('<p>','\n') );
		mes.innerHTML = msg;
		Gwallwin.winShow('errmsg','信息提示',350);
	}
}

function gotoEdit(){
	var navinfo = window.navigator.userAgent;
	if (navinfo.indexOf("MSIE 6.0") != -1||navinfo.indexOf("MSIE 7.0") != -1||navinfo.indexOf("MSIE 8.0") != -1){
			parent.openmodule('TRUCKORDER','../../truckorder/truckorder_edit.jsf');
	}
	else{
		parent.openmodule('TRUCKORDER','../truckorder/truckorder_edit.jsf');
	}
}

function showPanel(){
	Gwallwin.winShow('editPanel','按条件筛选订单',350);
}

function endSift(){
	window.location.href="carsche_merge.jsf";
	Gwallwin.winShowmask("FALSE");
}

function searchBill(cuid,lico,lpco){
	$('edit:cuid').value=cuid;
	$('edit:lico').value=lico;
	$('edit:lpco').value=lpco;
	$('edit:listBut').onclick();
}

function gotoList(){
	window.location.href="billlist.jsf";
	//Gwallwin.winShowmask("FALSE");
}

function EditBill(biid,buty){	
	if(buty=="OUTORDER"){
		showModal('billmodal.jsf?biid='+biid,'680','500',0,-100);
	}else if(buty=="TRANPLAN"){
		showModal('billmodal_tran.jsf?biid='+biid,'680','500');
	}else if(buty=="PURCHASERETURNPLAN"){
		showModal('billmodal_pobo.jsf?biid='+biid,'680','500');
	}
}

//显示层
function showDiv(title,width){
	Gwallwin.winShow("edit",title,width);	
}

//隐藏层
function hideDiv(){
	Gwallwin.winClose();		
}

function initFrame(){
	//$('tabContent2').className = 'hidetab_body';
	endWinShow();
}
function initFrame1(){
	$('tabContent1').className = 'hidetab_body';
	endWinShow();
}