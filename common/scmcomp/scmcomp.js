    function selectThis(parm1,parm2){
    	retid = $('list:retid').value;
		retname = $('list:retname').value;
		var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
		
		if ( retid != "" && retid != null){
			Gwin.getIframeObjById(document.GwinParentID,"iframeComp",retid).value=parm1;
		}
		if ( retname != "" && retname != null){
			Gwin.getIframeObjById(document.GwinParentID,"iframeComp",retname).value=parm2;
		}

		isGwin ? Gwin.close(document.GwinID) : window.close();	
    }