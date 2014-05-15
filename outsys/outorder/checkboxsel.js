	var focusObj;
	var divobj;
	document.onclick = function onclick(e){
		if(!e)e = event;
		var obj = e.target || e.srcElement;
		if(obj != focusObj && divobj != null){
			var tmpobj = obj;
			var b = 0;
			while (tmpobj = tmpobj.offsetParent){
				if (tmpobj.id == divobj.id){
					b = 1;
					break;
				}
			}
			if ( b == 0) {
				divobj.style.display = "none";
			} 
		}
	}

	function showsel(obj,divid){
		if (divobj != null){
			divobj.style.display = "none";
			//alert(focusObj.id);
		}
		
		//注册
		focusObj = obj;
		
		divobj = $(divid);
		
		var ttop  = obj.offsetTop;
		var thei  = obj.clientHeight;
		var tleft = obj.offsetLeft;
		var ttype  = obj.type;
		var tmpobj = obj
		while (tmpobj = tmpobj.offsetParent){
			ttop += tmpobj.offsetTop;
			tleft += tmpobj.offsetLeft;
		}
		divobj.style.top  = (ttype=="image") ? ttop+thei : ttop+thei+1;
		divobj.style.left = tleft;
		
		divobj.style.display = "";
		
		//event.returnValue=false;
	}
	
	function selectAllItems(name,bcheck) {
		var ManyCheckbox = document.getElementsByName(name);
		if (ManyCheckbox == null) return true;
		for ( var i = 0; i < ManyCheckbox.length; i++) {
			if (ManyCheckbox[i].type != "checkbox") {
				continue;
			}
			ManyCheckbox[i].checked = bcheck;
	  	}
	  	return false;
	}