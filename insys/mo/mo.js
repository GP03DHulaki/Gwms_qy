<!--
	//------------------------------------------------------------------
	//					生产订单主页面
	//------------------------------------------------------------------
	//初始化主页面
	function initMain(){
		//无查询权限时，相关元素将不存在
		//为了避免js错误所以需要判断
		if($("edit:sk_start_date")!=null){
			//元素集
			var elements = "sk_start_date,sk_end_date,biid,stat,ceve,prco";
			//元素值集
			var values=",,,0,,";
			textClearOrCheck("edit",elements,values,"Y",null);
		}
	}
	
	
	//删除单据 前
	function dodVoucher(){
		var biids = Gtable.getselcolvalues('gtable','biids');
		var stats = Gtable.getselcolvalues('gtable','stat');
		if(biids.Trim().length<=0){
			alert("请选择需要删除的单据!");
			return false;
		}else{
			if(confirm("确定要删除选中单据吗?")){
				Gwallwin.winShowmask("TRUE");
				$("edit:sellist").value = biids;
				$("edit:stats").value=stats;
				return true;
			}
		}
	}
	
	//删除单据 后
	function enddVoucher(){
		var msgs = $("edit:msg").value.split('n');
		var msg = "";
		for(i = 0;i < msgs.length-1;i++){
			msg += msgs[i] + "\n";
		}
		alert(msg);
		Gwallwin.winShowmask("FALSE");
	}
	
	//Enter事件
	function dosubmit(event){
		if(event.keyCode==13){
			$("edit:sid").onclick();
		}
	}
	
	
	
	//------------------------------------------------------------------
	//					添加生产订单页面
	//------------------------------------------------------------------
	
	//初始化添加
	function initAdd(){
		var elements="biid,flag,ceve,hceve,suid,whid,hwhid,prco,hprco,prnu,pddt,indt,rema";
		var values="自动生成,0,,,,,,,,,,,";
		textClearOrCheck("edit",elements,values,"Y","prnu");
	}
	
	
	//供应商名称
	function selectSuin(){
		showModal('../../common/suin/suin.jsf?retid=edit:suid&retname=edit:ceve',480,440);
	}
	
	//库位号
	function selectWaho(){
		showModal('../../common/waho/waho.jsf?retid=edit:whid',480,440);
	}
	
	//产品编码
	function selectInve(){
		showModal('../../common/inve/inve.jsf?retid=edit:prco',480,440);
	}
	
	//添加验证
	function checkAdd(){
		var elements="ceve,whid,prco,prnu,pddt,indt";
		var values="供应商名称,库位号,产品编码,投产数量,生产时间,到货时间";
		
		if(textClearOrCheck("edit",elements,values,"N",null)){
			var tprnu = $("edit:prnu");
			var tstr =/^[+]?[1-9]\d*$/;
			if(!tstr.test(tprnu.value)){
				alert("请输入正确的投产数量！");
				tprnu.select();
				return false;
			}
			if($("edit:pddt").value>$("edit:indt").value){
				alert("生产时间应小于到货时间！");
				return false;
			}
		}else{
			return false;
		}
		//为隐藏域赋值
		$("edit:hceve").value = $("edit:ceve").value;
		$("edit:hwhid").value = $("edit:whid").value;
		$("edit:hprco").value = $("edit:prco").value;
		Gwallwin.winShowmask("TRUE");
		return true;
	}
	
	//保存结束事件
	function saveEnd(){
		alert($("edit:mes").value);
		Gwallwin.winShowmask("FALSE");
		window.location.href="mo_edit.jsf";
	}
	
	
	//------------------------------------------------------------------
	//					编辑生产订单页面
	//------------------------------------------------------------------
	//修改验证
	function checkEdit(){
		var tprnu = $("edit:prnu");
		var tstr =/^[+]?[1-9]\d*$/;
		if(!tstr.test(tprnu.value)){
			alert("请输入正确的投产数量！");
			tprnu.select();
			return false;
		}
		if($("edit:pddt").value>$("edit:indt").value){
			alert("生产时间应小于到货时间！");
			return false;
		}
		//为隐藏域赋值
		$("edit:hceve").value = $("edit:ceve").value;
		$("edit:hwhid").value = $("edit:whid").value;
		$("edit:hprco").value = $("edit:prco").value;
		return true;
	}
	
	//删除前
	function startDelete(){
		if(confirm("确定要删除本单据吗？")){
			Gwallwin.winShowmask("TRUE");
		}
	}
	
	//删除后
	function endDelete(){
		alert($("edit:msg").value);
		Gwallwin.winShowmask("FALSE");
		window.location.href="mo.jsf";
	}
	

-->