//������ҳ��ѯ����


	var retid="",retname="",retbar="";		//����ˢ�µ��ֶΣ����ޣ���ˢ��
	
    function selectThis(parm1,parm2,parm3){
    
    	retid = $('edit:retid').value;
	    retname = $('edit:retname').value;
	    retbar = $('edit:retbar').value;

    	if ( retid != "" && retid != null){
			window.dialogArguments.document.getElementById(retid).value=parm1;
		}

		if ( retname != "" && retname != null){
			window.dialogArguments.document.getElementById(retname).value=parm2;
		}
		
		if ( retbar != "" && retbar != null){
			window.dialogArguments.document.getElementById(retbar).value=parm3;
		}

		window.close();	
    }

//�Ƿ���ʾ
function initDisplay(){
	if($('edit:dety').value =='01')
	{
		$('initdisplay').style.display='block';	
	}else
	{
		$('initdisplay').style.display='none';
	}
}

function selectCheckuserid()
{
	showModal("../../common/user/user.jsf?&retid=edit:opna&retname=","580px","380px");
}

function cleartext(){
		var a = $("edit:id");
		var b = $("edit:name");
		var c = $("edit:bar");
		if(a!=null){
			a.value="";
			a.focus();
		}
		if(b!=null){
			b.value="";
		}  
		if(c!=null){
			c.value="";
		}
		if($("edit:colo")!=null){
	 		$("edit:colo").value = "";
	 	}
	 	if($("edit:asco")!=null){
	 		$("edit:asco").value="";
	 	}
	 	if($("edit:psco")){
	 		$("edit:psco").value="";
	 	}
	 	if($("edit:inst")!=null){
	 		$("edit:inst").value = "";
	 	}
	 	if($("edit:tyna")!=null){
	 		$("edit:tyna").value = "";
	 	}
	 	if($("edit:brde")!=null){
	 		$("edit:brde").value = "";
	 	}
	 	if($("edit:inpr")!=null){
	 		$("edit:inpr").value = "0";
	 	}
	 	
		var d = $("edit:sk_inco");
		if (a != null) {
			a.value = "";
			a.focus();
		}
		if (d != null) {
			d.value = "";
		}
	}


function clearData(){
	if($("edit:sk_start_date")!=null){
		$("edit:sk_start_date").value = "";
	}
	if($("edit:sk_end_date")!=null){
		$("edit:sk_end_date").value = "";
	}
	if($("edit:sk_biid")!=null){
		$("edit:sk_biid").value = "";
		$("edit:sk_biid").focus();
	}
	if($("edit:sk_soco")!=null){
		$("edit:sk_soco").value = "";
	}
	if($("edit:sk_flag")!=null){
		$("edit:sk_flag").value = "00";
	}
	
	if($("edit:orid")!=null){
		$("edit:orid").value = "";
	}
	if($("edit:crna")!=null){
		$("edit:crna").value = "";
	}
	if($("edit:buty")!=null){
		$("edit:buty").value = "";
	}
	
}
function printReport(){
	Gwallwin.winShowmask('TRUE');
}
function endPrintReport(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("��ӡ�ɹ�")!=-1){
		var filename=$("edit:filename").value;	
		window.open('../'+filename+'?time='+new Date().getTime());
	}
	Gwallwin.winShowmask('FALSE');
}

function startDo(){
	Gwallwin.winShowmask("TRUE");
}

function addNew(){
	window.location.href="otherin_add.jsf";
}

function doSearch(){
	Gwallwin.winShowmask("TRUE");
	$("edit:sid").click();
}
//��ʼ�����ҳ��
function initAdd(){
	if($("edit:biid")!=null){
		$("edit:biid").value="�Զ�����";
	}
	if($("edit:whna")!=null){
		$("edit:whid").value="";
	}
	/*
	if($("edit:orna")!=null){
		$("edit:orna").value="";
		$("edit:orid").value="";
	}
	
	if($("edit:suna")!=null){
		$("edit:suna").value="";
		$("edit:suid").value="";
	}
	*/
	if($("edit:dety")!=null){
		$("edit:dety").value="03";
	}
	
	if($("edit:opna")!=null){
		$("edit:opna").value="";
	}
	
	if($("edit:rema")!=null){
		$("edit:rema").value="";
	}
	
}

// �����ϸ
function addHead(){
	
	if($("edit:dety")!=null && $("edit:dety").value == '01')
	{
		if($("edit:srid")== null || $("edit:srid").value.Trim().length<=0){
			alert("�������ⶩ������Ϊ��!");
			$("edit:srid").focus();
			return false;
		}		
	}
	
	if($("edit:dety")==null || $("edit:dety").value.Trim().length<=0){
		alert("ҵ�����Ͳ��ܿ�!");
		$("edit:dety").focus();
		return false;
	}
	if($("edit:whid")==null || $("edit:whid").value.Trim().length<=0){
		alert("���ֿⲻ��Ϊ��!");
		//selectSoco();
		return false;
	}
	

	
	/*
	if($("edit:orna")==null || $("edit:orna").value.Trim().length<=0){
		alert("��֯�ܹ�����Ϊ��!");
		return false;
	}
	
	if($("edit:suna")==null || $("edit:suna").value.Trim().length<=0){
		alert("��Ӧ�̲���Ϊ��!");
		return false;
	}
	
	if($("edit:deus")==null || $("edit:deus").value.Trim().length<=0){
		alert("�ͻ��˲���Ϊ��!");
		$("edit:deus").focus();
		return false;
	}
	*/
	Gwallwin.winShowmask("TRUE");
	return true;
}

// ��������ϸ
function endAddHead(){
	alert($("edit:msg").value);
	if($("edit:msg")!=null && $("edit:msg").value.Trim().indexOf("��ӳɹ�")!=-1){
		window.location.href="otherin_edit.jsf";
	}
	Gwallwin.winShowmask("FALSE");
}

// ��ѡ��Ӧ��ҳ��
function selectSoco(){
	showModal('selectSoco.jsf');
	return false;
}

function selectSrid(){
	showModal('selectSrid.jsf?retid=edit:srid',560,550);
}

// ��ѡ��Ӧ��ҳ��
function selectSuin(){
	showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:suna');
	return false;
}

// ��ѡ����֯�ܹ�ҳ��
function selectOrga(){
	showModal('../../common/orga/orga.jsf?retid=edit:orid&retname=edit:orna');
	return false;
}

// ��ѡ��ֿ�ҳ��
function selectWaho(){
	showModal('../../common/waho/waho.jsf?type=1&pwid=all&retid=edit:whid&retname=edit:whna');
	return false;
}
// ��ѡ���λҳ��
function selectWahod(){
	//����OSA �������󣬽�&pwid="+$('edit:whid').value+"
	var pwid = $("edit:whid").value;
	showModal('../../common/waho/waho.jsf?whfl=P&type=4,5,6,7,9,13,99&retid=edit:dwhid&retname=&pwid='+pwid);
	showModal(url);
	return false;
}

// ��ѡ����Ʒ��Ϣҳ��
function selectInve(){
	showModal('inve.jsf?retid=edit:inco',700,500);
	return false;
}

//ѡ����Ʒ��Ϣ��������
function selectInveAdd(){
	selectInve();
	//$("edit:selInveBut").onclick();
	return true;
}

//�س�ʱ���� 
function clickInve(){
	if(event.keyCode==13){
		//$("edit:selInveBut").onclick();
		$("edit:qty").focus();
		return true;
	}
}

// ��ѯ��Ʒ��Ϣ
function selInveBut(){
	if($("edit:inco")==null || $("edit:inco").value.Trim().length<=0){
		alert("��Ʒ��Ϣ����Ϊ��!");
		$("edit:inco").focus();
		return false;
	}
	Gwallwin.winShowmask("TRUE");
	return true;
}
// ������ѯ��Ʒ��Ϣ
function endSelInveBut(){
	Gwallwin.winShowmask("FALSE");
	$("edit:qty").select();
}

// �����ϸ
function addDetail(){
	var num = /^[1-9][0-9]*$/
	if($("edit:baco")==null || $("edit:baco").value.Trim().length<=0){
		alert("���벻��Ϊ��!");
		$("edit:baco").focus();
		return false;
	}
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("��������Ϊ��!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("����ֻ����������!");
			$("edit:qty").select();
			return false;
		}
	}

	Gwallwin.winShowmask("TRUE");
	return true;
}

// ��������ϸ
function endAddDetail(){
	var msg = $("edit:msg").value
	if(msg.indexOf("��ӳɹ�")!=-1){
		initEdit();
	}else{
		alert(msg);
		initEdit();
	}
	Gwallwin.winShowmask("FALSE");
}

// ��������
function createBar(){
	var roids = Gtable.getselcolvalues('gtable','roid');
	if(roids.length<=0){
		if(confirm("�Ƿ�Ҫ����ȫ�����룿")){
			$("edit:roids").value = "ALL";
			Gwallwin.winShowmask("TRUE");
			return true;
		}else{
			return false;
		}
	}else{
		$("edit:roids").value = roids;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
}

// ������������
function endCreateBar(){
	var msg = $("edit:msg").value;
	alert(msg);
	Gwallwin.winShowmask("FALSE");
}

// �鿴����
function selectBar(roid){
	Gwallwin.winShowmask("TRUE");
	showModal('otherin_selbar.jsf?roid='+roid);
	Gwallwin.winShowmask("FALSE");
}

// �鿴ȫ������
function selAllBar(){
	Gwallwin.winShowmask("TRUE");
	showModal("otherin_selbar.jsf?roid=");
	Gwallwin.winShowmask("FALSE");
}


// �鿴����ҳ���ʼ��
function initselbar(){
	if($("edit:qty")!=null){
		$("edit:qty").value = "";
	}
}

//�������
function addBar(){
	var num = /^[1-9]\d*$/
	if($("edit:qty")==null || $("edit:qty").value.Trim().length<=0){
		alert("������������Ϊ��!");
		$("edit:qty").focus();
		return false;
	}else{
		if(!num.test($("edit:qty").value.Trim())){
			alert("��������ֻ��Ϊ������");
			$("edit:qty").select();
			return false;
		}
	}
	return true;
	Gwallwin.winShowmask("TRUE");
}

// �����������
function endAddBar(){
	alert($("edit:msg").value);
	$("edit:qty").value = "";
	Gwallwin.winShowmask("FALSE");
}

// ��ʼ��ѯ
function search(){
	var startDate =$("edit:sk_start_date").value;
	var enddate =$("edit:sk_end_date").value;
	if(startDate.Trim().length>0)
	{
		if(startDate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("��ʼ���ڸ�ʽ����!\n��ȷ��ʽ(YYYY-MM-DD)"+startDate);
	  		$("edit:sk_start_date").select();
	  		return false;
		}
	}
	if(enddate.Trim().length>0)
	{
		if(enddate.search("(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)")!=0){
	  		alert("�������ڸ�ʽ����!\n��ȷ��ʽ(YYYY-MM-DD)");
	  		$("edit:sk_end_date").select();
	  		return false;
		}
	}	
	return true;
}
//ɾ������(��ҳ)
function deleteHeadAll(){
	var biids = Gtable.getselcolvalues('gtable','biids');
	if(biids.Trim().length<=0){
		alert("��ѡ����Ҫɾ���ĵ���!");
		return false;
	}else{
		if(confirm("ȷ��Ҫɾ��ѡ�е�����?")){
			Gwallwin.winShowmask("TRUE");
			$("edit:sellist").value = biids;
			return true;
		}
	}
}

// ����ɾ������(��ҳ)
function endDeleteHeadAll(){
	if($("edit:msg").value.indexOf("ɾ���ɹ�")!=-1){
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

// ɾ����ǰ����
function deleteHead(){
	if(!confirm("ȷ��ɾ����ǰ������?")){
		return false;
	}
	$("edit:sellist").value = $("edit:biid").value;
	Gwallwin.winShowmask("TRUE");
	return true;
}
// ����ɾ����ǰ����
function endDeleteHead(){
	alert($("edit:msg").value);
	if($("edit:msg").value.indexOf("ɾ���ɹ�")!=-1){
		window.location.href = "otherin.jsf";
	}
}

//���浥��
function updateHead(){
	return addHead();
}
//�������浥��
function endUpdateHead(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//��˵���
function app(){
	//if($("edit:opna")==null || $("edit:opna").value.Trim().length<=0){
	//	alert("�����˲���Ϊ��!");
	//	$("edit:opna").focus();
	//	return false;
	//}
	//else 
	//var qtys = Gtable.getcolvalues('gtable','qty');
	//var qty = qtys.split("#@#");
	//var num = /^[1-9]\d*$/;
	//for(i=0;i<qty.length;i++){
		//if(!num.test(qty[i]) ){
			//alert("��"+(i+1)+"��������ʽ����!  \n");
			//return false;
		//}
	//}
	//
	Gwallwin.winShowmask("TRUE");
	return true;
}
//�������
function endApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
//���󵥾�
function unApp(){
	Gwallwin.winShowmask("TRUE");
}
//��������
function endUnApp(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}
// ɾ����ϸ
function delDetail(obj){
	var dids = Gtable.getselectid(obj);
	if(dids.length<=0){
		alert("��ѡ����Ҫɾ������!");
		return false;
	}else{
		if(!confirm("ȷ��ɾ��ѡ���У�")){
			return false;
		}else{
			$("edit:sellist").value = dids
			Gwallwin.winShowmask("TRUE");
			return true;
		}
	}
}
//����ɾ����ϸ
function endDelDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}

//�޸���ϸ
function updateDetail(){
	var msg = "";
	var num = /^[1-9]\d*$/;
	var qtys = Gtable.getcolvalues('gtable','qty');
	var qty = qtys.split("#@#");
	for(i=0;i<qty.length;i++){
		if(!num.test(qty[i]) ){
			msg += "��"+(i+1)+"��������ʽ����!  \n";
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
//���������ϸ
function endUpdateDetail(){
	alert($("edit:msg").value);
	Gwallwin.winShowmask("FALSE");
}


// �������Ҳ���ѯ����
function clearbar(){
	if($("edit:baco")!=null){
		$("edit:baco").value = "";
		$("edit:baco").focus();
	}
	if($("edit:inco")!=null){
		$("edit:inco").value = "";
	}
}

// �س�����
function formsubmit(){
	if (event.keyCode==13)
	{
		var obj=$("edit:sid");
		obj.onclick();
		return true;
	}
}
//��ʾ��������չ����

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

//��ӡ����
function print(obj)
{
	var arr=Gtable.getselectid(obj);
	if(arr.length>0){
		Gwallwin.winShowmask("TRUE");
		$("edit:sellist").value=arr;
	}else{
		alert("��ѡ����Ҫ���������ӡ�ļ�¼!");
		return false;
	}
	return true	
}
//�鿴��ӡ����
function lookPrint()
{
	var mes =$("edit:msg").value;
	alert(mes);
	if(mes.indexOf("��ӡ�ɹ�")!=-1){
 		var name=$("edit:filename").value;	  
 		alert(name); 	
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwallwin.winShowmask("FALSE");
 }

//��ӡȫ������
function printAll()
{
	Gwallwin.winShowmask("TRUE");
	return true	
}
//�鿴��ӡȫ������
function lookPrintAll()
{
	var mes =$("edit:msg").value;
	alert(mes);
	if(mes.indexOf("��ӡ�ɹ�")!=-1){
 		var name=$("edit:filename").value;	  
 		window.open('../'+name+'?time='+new Date().getTime());
 	}
	Gwallwin.winShowmask("FALSE");
 }
 
//��ʼ��edit
function initDetail(){
	t = new TailHandler('in');
	$('edit:batp:0').checked = true;
	$('edit:qty').value='1';
	$('edit:autoItem').value='0';
	
	if($('edit:dety').value =='01')
	{
		$('initdisplay').style.display='block';	
	}
}

//��ʼ��Editҳ��
function initEdit(){
	textClear('edit','baco,dwhid,qty','Y');
}

// ��ѡ������
function selectCode(){
	/*
    if(i==Obj.length){
    	alert("û��ѡ���������ͣ�");
    	return false;
    }
    */
    var batp = t.getBatp();//����������ͱ���
    if($('edit:dwhid')){
    	var dwhid = $('edit:dwhid').value;
    }
    if(batp == '04'){
    	showModal('../../common/inve/inve.jsf?retid=edit:baco',560,550);
    }else if(batp == '03'){
    	showModal("../../common/barcode_sel/barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'710px','550px');
    }else if(batp == '02'){
    	showModal("barcode_sel.jsf?retid=edit:baco&ctype="
    	+batp+"&whid="+$('edit:whid').value+"&dwhid="+dwhid,'680px','450px');
    }
	return true;
}

function endCode4DBean(){
	endLoad();
	if($('edit:msg').value != ''){
		alert($('edit:msg').value);
		$('edit:baco').value="";
		$('edit:baco').focus();
		$('edit:baco').select();
	}else{
		$('edit:qty').focus();
	}
}

function endLoad(){
	Gwallwin.winShowmask('FALSE');
}
	function showImport(){
		$("mes").innerHTML="";
		Gwallwin.winShow("import","ѡ�����ļ�");	
	}
	
	function doImport(){
		var flag=true;
		var file=$("file:upFile").value;
		var filelength = file.length;
		var filetype = file.indexOf('.xls');
		if(file==""){
			$("mes").innerHTML="<Font Color=\"red\"><B>��ѡ���ϴ����ļ�!<B></Font>";
			return false;
		}
		if(filetype==-1 || (filelength-filetype)!=4 ){
			$("mes").innerHTML="<Font Color=\"red\"><B>�ϴ����ļ�������xls����!<B></Font>";
			return false;
		}else{
			$("mes").innerHTML="���ݵ�����......";
		}
		$("file:import").disabled=true;
		startDo();
		$("file:importBut").click();
	return flag;
}
	
function hideDiv(){
	Gwallwin.winClose();		
}

/*
var isBlur = 0;//�����Ƿ���������
var batp = '03';//Ĭ����������
var batpid = 'edit:batp';//��������Ԫ��id
var batpno = '0';//��������Ĭ��checked
var qty = 'edit:qty';//��������id
var baco = 'edit:baco';//�������id
var dwhid = 'edit:dwhid';//��λ����id
var addButton = 'edit:addDBut';//��Ӱ�ťid
document.onkeydown = keyPressHandler;

// ��ϸԪ�ض�λ
function elementFocus(){
	if(objFocus($(baco))==0)return;
	if(objFocus($(qty))==0)return;
	if(objFocus($(dwhid))==0)return;
}

function objFocus(obj){
	if(obj){
		if(obj.value == ''){
			obj.focus();
			return 0;
		}
	}
	return 1;
}

function canFocus(obj){
	if(isBlur==1){
	
	}else{
		obj.blur();
	}
}

function batyClick(obj){
	batp = obj.value;
	if(obj.value == '04'){
		isBlur = 1;
	}else{
		isBlur = 0;
	}
}

function keyPressHandler(event){
	var e=window.event||event;
    var key=window.event?e.keyCode:e.which;
    if(key==120) {//���ΪF9�򴥷�
    	$(baco).focus();
    	batpno++;
    	if(batpno == '3'){
    		batpno = '0';
    	}
    	$(batpid+':'+batpno).checked = true;
    	//$(batpid+':'+batpno).onclick();
    	batyClick($(batpid+':'+batpno));
    }
}
*/

var retid = "", dwhid = "",retqty="";		//����ˢ�µ��ֶΣ����ޣ���ˢ��
function selectBaco(parm1, parm2) {
	retid = $("edit:retid").value;
	retqty = $('edit:retqty').value;
	var isGwin = Gwin && document.GwinID;//�Ƿ�Gwin��ʽ����.
	if(isGwin === false){
		is_IE = (navigator.appName == "Microsoft Internet Explorer");
		var callBack = null;  
		if(is_IE) {
			callBack = window.dialogArguments;
		}
		else {
			if (window.opener.callBack == undefined) {   
				window.opener.callBack = window.dialogArguments;   
			}   
			callBack = window.opener.callBack;   
		}
	}
	if ( retid != "" && retid != null){
 		isGwin ? parent.document.getElementById(retid).value = parm1 : callBack.document.getElementById(retid).value=parm1;
	}
	if (retqty != "" && retqty != null) {
		parm2 = parseInt(parm2);
		isGwin ? parent.document.getElementById(retqty).value = parm2 : callBack.document.getElementById(retqty).value = parm2;
	}
	if(callBack && callBack.document.getElementById('edit:setCode4DBean')){
		callBack.document.getElementById('edit:setCode4DBean').onclick();
	}else{
		if(parent.document.getElementById('edit:setCode4DBean')!=null){
			parent.document.getElementById('edit:setCode4DBean').onclick();
		}
		
		
	}
	isGwin ? Gwin.close(document.GwinID) : window.close();	
}

function formsubmit() {
	if (event.keyCode == 13) {
		var obj = $("edit:sid");
		obj.onclick();
		return true;
	}
}

