function $() {
	var elements = [];
	for (var i = 0; i < arguments.length; i++) {
		var element = arguments[i];
		if (typeof element == "string") {
			if (document.getElementById) {
				element = document.getElementById(element);
			} else {
				if (document.all) {
					element = document.all[element];
				}
			}
		}
		if (arguments.length == 1) {
			return element;
		}
		elements.push(element);
	}
	return elements;
}

/*
* 添加事件监听函数  
* elm 目标元素  
* evType 触发事件的种类  
* fn 监听函数  
* Capture 捕获阶段  
*/
function GaddEvent(elm, evType, fn, Capture) {
	if (elm.addEventListener) {
		elm.addEventListener(evType, fn, Capture);//DOM2.0 
		return true;
	} else {
		if (elm.attachEvent) {
			var r = elm.attachEvent("on" + evType, fn);//IE+ 
			return r;
		} else {
			elm["on" + evType] = fn;//DOM 0 
		}
	}
}

var GwallWHG = new function () {
	//this.is_IE = (navigator.appName=="Microsoft Internet Explorer"); 
	this.bMove = false;
	this.WHGObj = null;
	this.pX = 0;
	this.pY = 0;
	this.WinW = 0;
	this.WinH = 0;
	this.WHG = function (nodeobj) {
		this.WHGObj = nodeobj;
//		GaddEvent(this.WHGObj,"mousedown",this.MouseDown,false);
//		GaddEvent(this.WHGObj,"mousemove",this.MouseMove,false);
//		GaddEvent(this.WHGObj,"mouseup",this.MouseUp,false);
		return this.WHGObj;
	};
	this.MouseDown = function () {
var e = window.event || arguments.callee.caller.arguments[0];
var _element = e.srcElement ? e.srcElement : e.target;
		_element.setCapture();
		this.bMove = true;

		var item = event.srcElement;
		var totalLeft = 0;
		do {
			s = "item.offsetLeft";
			totalLeft += eval(s);
			item = item.offsetParent;
		} while (item != null);
		item = event.srcElement;
		var totalTop = 0;
		do {
			s = "item.offsetTop";
			totalTop += eval(s);
			item = item.offsetParent;
		} while (item != null);
		this.pX = event.x - totalLeft;
		this.pY = event.y - totalTop;
		
		//this.pX = event.x - event.srcElement.style.pixelLeft;
		//this.pY = event.y - event.srcElement.style.pixelTop;
		this.WinW =_element.clientWidth;
		this.WinH = _element.clientHeight;
		/*
		if (this.is_IE){ 
			event.srcElement.setCapture();
		}else{
			//event.preventDefault();
			document.addEventListener("mouseup",MouseUp,true);
			document.addEventListener("mousemove",MouseMove,true);
		}
		*/
	};
	this.MouseMove = function () {
		var height = document.body.clientHeight;
		var width = document.body.clientWidth;
var e = window.event || arguments.callee.caller.arguments[0];
var _element = e.srcElement ? e.srcElement : e.target;
		var mx, my;
		if (this.bMove) {
			movx = event.x;
			movy = event.y;
			if (movx > 0 && movx < width) {
				_element.style.left = movx - this.pX;
			}
			if (movy > 0 && movy < height) {
				_element.style.top = movy - this.pY;
			}
		}
	};
	this.MouseUp = function () {
var e = window.event || arguments.callee.caller.arguments[0];
var _element = e.srcElement ? e.srcElement : e.target;
		if (this.bMove) {
			_element.releaseCapture();
			this.bMove = false;
		}
	};
};

var GJSON = new function () {
	var gJSONobj;
	var gid;
	var gclass;
	this.initJSON = function (gid) {
		var s = $("Gjson_" + gid);
		var s1 = "(" + s.innerHTML + ")";
		this.gJSONobj = eval(s1);
		this.gid = gid;
		this.gclass = this.gJSONobj.gclass;
	
		//根据不同的类型生成HTML代码
		if (s.gtype == "GWHgraphic") {
			this.DrawgWHgraphic();
		} else {
			if (s.gtype == "GTable") {
			//this.drawTable();		
			}
		}
	};
	this.DrawgWHgraphic = function () {
		var parent = $(this.gid);
		parent.value = this.gJSONobj.gwhgid;
		var len = this.gJSONobj.GWHgraphic.length;
		//先清空
		var divnode = document.createElement("div");
		divnode.className = this.gclass + "_whg_head";
		if (this.gJSONobj.gwhgid == "") {
			divnode.innerHTML = "";
		} else {
			divnode.innerHTML = this.gJSONobj.gwhgid + "--\u5e93\u4f4d\u56fe";
		}
		parent.appendChild(divnode);
		var divmainnode = document.createElement("div");
		divmainnode.className = this.gclass + "_whg_main";
		parent.appendChild(divmainnode);
		var prerow = 0;
		var currrow;
		var tablenode = document.createElement("table");
		var tbody = document.createElement("tbody");
		var trnode;
		var tdnode;
//		var rowl = new Array();
//		var colw = new Array();
		if (len > 0) {
			var rowl = this.gJSONobj.GWHgraphic[1].in_rowl;
			var colw = this.gJSONobj.GWHgraphic[1].in_colw;
			trnode = document.createElement("tr");
			//先生成一行无内容的TR，避免COLSPAN不对齐
			for (var i = 0; i < rowl; i++) {
				tdnode = document.createElement("td");
				tdnode.id = i;
				trnode.appendChild(tdnode);
			}
			tbody.appendChild(trnode);
			for (var i = 0; i < len; i++) {
				currrow = this.gJSONobj.GWHgraphic[i].in_row;
				if (prerow != currrow) {
					prerow = currrow;
					//取得库位层
					tbody.appendChild(trnode);
					
					//再创建新的一行(tr)
					trnode = document.createElement("tr");
				}
				tdnode = document.createElement("td");
				tdnode.rowSpan = this.gJSONobj.GWHgraphic[i].in_rowspan;
				tdnode.colSpan = this.gJSONobj.GWHgraphic[i].in_colspan;
				
				//tdnode.innerHTML = "i:" + i;
				var divnode = this.createnode(this.gJSONobj.GWHgraphic[i]);
				tdnode.appendChild(divnode);
				trnode.appendChild(tdnode);
			}
			tbody.appendChild(trnode);
			tablenode.border = "0";
			tablenode.cellPadding = "0";
			tablenode.cellSpacing = "0";
		}
		tablenode.appendChild(tbody);
		divmainnode.appendChild(tablenode);
	};
	this.createnode = function (obj) {
		var WHID = obj.vc_warehouseid;
		var WHGtext = obj.nv_warehousename;
		var node = document.createElement("DIV");
		var zoom = obj.dc_zoom;
		node.style.width = (obj.in_length * zoom);
		node.style.height = (obj.in_width * zoom * 2);
		//分不同的层来表示不同的库位或分隔带
		if (WHID != "") {
			if (obj.ch_flag != "0") {			//系统库位
				node.id = WHID;
				var rate = (obj.dc_factvolume / obj.dc_volume * 100);
				//库位层
				WHGtext = WHGtext + "<br />";
				WHGtext = WHGtext + "\u4f7f\u7528\u7387:" + rate.toFixed(2) + "%";
				if (rate > 90) {
					node.className = this.gclass + "_whg_warn";
				} else {
					node.className = this.gclass + "_whg_normal";
				}
				node.innerHTML = WHGtext;
				node.setAttribute("whid", obj.vc_warehouseid);
				//用ADD EVENT的方式处理不了参数问题
				//addEvent(node, "click", new Function(this.gJSONobj.gclick), false);
	
				//var mygclick = this.gJSONobj.gclick;
				//var f2 = new Function("x", "y", "return x*y;"); //使用Function和new定义 
				var funclick = new Function((this.gJSONobj.gclick));//Function()构造函数
				node.onclick = funclick;
				node.onselectstart = new Function("return false");
				node = GwallWHG.WHG(node);
			} else {							//非系统库位			
				node.id = WHID;
				var tag = WHGtext.substring(0, 2);
				if (tag == "W:") {				//横标尺
					//库位层
					WHGtext = WHGtext.substring(2, WHGtext.length);
					node.className = this.gclass + "_whg_w";
					node.innerHTML = WHGtext;
				} else {
					if (tag == "H:") {		//竖标尺
					//库位层
						WHGtext = WHGtext.substring(2, WHGtext.length);
						node.className = this.gclass + "_whg_h";
						node.innerHTML = WHGtext;
					} else {
					//库位层
						WHGtext = WHGtext;
						node.className = this.gclass + "_whg_other";
						node.innerHTML = WHGtext;
					}
				}
				node.setAttribute("whid", obj.vc_warehouseid);
				//用ADD EVENT的方式处理不了参数问题
				//addEvent(node, "click", new Function(this.gJSONobj.gclick), false);

				//var mygclick = this.gJSONobj.gclick;
				//var f2 = new Function("x", "y", "return x*y;"); //使用Function和new定义

//				var funclick = new Function((this.gJSONobj.gclick));//Function()构造函数
//				node.onclick = funclick;
				node.onselectstart = new Function("return false");
				node = GwallWHG.WHG(node);
			}
		} else {
			node.id = WHID;
			node.className = this.gclass + "_whg_space";
			node.setAttribute("whid", obj.vc_warehouseid);
			node.innerHTML = "&nbsp";
			node.onselectstart = new Function("return false");
			node = GwallWHG.WHG(node);
		}
		return node;
	};

};


/***************************** 右键菜单 开始 *****************************/

function GMenu(_object, _menu) {
	this.IEventHander = null;
	this.IMenuHander = null;
	this.IContextMenuHander = null;
	this._GMenu = _menu
	
	// SHOW MENU
	this.Show = function (_menu) {
		var e = window.event || arguments.callee.caller.arguments[0];
		if (e.button == 2) {
			if (window.document.all) {
				this.IContextMenuHander = function () {
					return false;
				};
				document.attachEvent("oncontextmenu", this.IContextMenuHander);
			} else {
				this.IContextMenuHander = document.oncontextmenu;
				
				document.oncontextmenu = function () {
					return false;
				};
			}
			
			window.GMenu$Object = this;
			this.IEventHander = function () {
				window.GMenu$Object.Hide(_menu);	
			};
			
			if (window.document.all) {
				document.attachEvent("onmousedown", this.IEventHander);
			} else {
				document.addEventListener("mousedown", this.IEventHander, false);
			}
			
			_menu.style.left = e.clientX;
			_menu.style.top = e.clientY;
			_menu.style.display = "";

			if (this.IMenuHander) {
				var _iMenumain = $(this.IMenuHander);
				_iMenumain.style.left = e.clientX;
				_iMenumain.style.top = e.clientY;
				_iMenumain.style.height = _menu.offsetHeight;
				_iMenumain.style.width = _menu.offsetWidth;
				_iMenumain.style.display = "none";
			}
		}
	};
	
	// HIDE MENU
	this.Hide = function (_menu) {
		var e = window.event || arguments.callee.caller.arguments[0];
		var _element = e.srcElement ? e.srcElement : e.target;;
		do {
			if (_element == _menu) {
				return false;
			}
		} while ((_element = _element.offsetParent));
		
		if (window.document.all) {
			document.detachEvent("on" + e.type, this.IEventHander);
		} else {
			document.removeEventListener(e.type, this.IEventHander, false);
		}
		
		if (this.IMenuHander) {
			$(this.IMenuHander).style.display = "none";;
		}
		
		_menu.style.display = "none";
		if (window.document.all) {
			document.detachEvent("oncontextmenu", this.IContextMenuHander);
		} else {
			document.oncontextmenu = this.IContextMenuHander;
		}
	};
	
	// _object 要弹出右键的HTML对象,_menu 要显示的菜单
	this.initialize = function (_object, _menu) {
		window._GMenu$Object = this;
		var _eventHander = function () {
			window._GMenu$Object.Show(_menu);
		};

		_menu.style.position = "absolute";
		_menu.style.display = "none";
		_menu.style.zIndex = "1000000";
		
		if (window.document.all) {
			var _gmenumain = document.createElement("div");
			$(_object).appendChild(_gmenumain);
			//document.body.insertBefore(_gmenumain, document.body.firstChild);
			_gmenumain.id = _menu.id + "_main";
			
			this.IMenuHander = _gmenumain.id;
			
			_gmenumain.className = "default_gmenu_main";
			
			//GaddEvent(this.WHGObj,"mousedown",this.MouseDown,false);
			
			_object.attachEvent("onmouseup", _eventHander);
		} else {
			_object.addEventListener("mouseup", _eventHander, false);
		}
	};
	
	this.initialize(_object, _menu);
}

/***************************** 右键菜单 结束 *****************************/

/***************************** Gtable 开始 *****************************/
var Gtable = new function () {
	this.is_IE = (navigator.appName == "Microsoft Internet Explorer");
	this.x = 0;
	this.objw = 0;
	this.resizeable = false;
	this.resizebegin = false;
	this.newwidth = 0;
	this.spanid = "";
	this.GtableObj = {tabID:'',columnN:-1,GtableCD:null};
	
	/* Init 
	** Set main div and table width
	** init right click menu
	*/
	this.inittable = function (gtableid, gwidth) {
		//设置当前窗口的名称,保证点击是在本窗口打开
        window.name = "__self";
        
		$(gtableid).style.width = gwidth;
		var tab = $(gtableid + "_table");
		tab.style.width = gwidth;
		tab.oncontextmenu = function(e){return Gtable.getColumn(e);};

		//冻结列,性能太差,暂不用
		//this.Gfreeze(gtableid);
		
		/*
		var masterobj = $(gtableid);//就是需要显示菜单的区域控件.
		
		var gmenu = document.createElement("div");// 菜单
		gmenu.id = "gmenu";
		gmenu.innerHTML = "<a href='#'>新增</a><br>"
		gmenu.innerHTML = gmenu.innerHTML + "<a href='#'>编辑</a><br>"
		gmenu.innerHTML = gmenu.innerHTML + "<a href='#'>删除</a>"
		
		gmenu.className = "default_gmenu_menu";
		
		$(gtableid).appendChild(gmenu);
		
		var Mymenu = new GMenu(masterobj,gmenu);
		*/
	};
	/**
	 * a标签的点击事件,头部排序,尾部翻页
	 * 处理在chrome中的bug:A,B选项卡,在B中点击排序,内容跑到A去了.MB...奇怪
	 */
	this.aClick = function(obj){
		window.event.returnValue = false;
		document.location.href = obj.getAttribute("href");
	};
	
	/**
	 * 得到要操作的列存放于GtableObj中.
	 */
	this.getColumn = function(e){
		if(e);else{e = event;}
		var obj = e.srcElement ? e.srcElement : e.target;
		if(obj){
			while(obj && obj.tagName != "TD"){
				obj = obj.parentNode;
			}
			if(obj){
				if(obj.id.length == 0 )return false;	//没有ID编号的就是个空的,或者尾部
			}else return false;
			var cellIndex = obj.cellIndex;
			if(!+ [ 1, ]){	//IE下会计算当前列的方式有点问题.隐藏的也得算进去.不然操作错误.
				var tr = obj.parentNode,tds=tr.cells,hideN=0;
				for(var i=0,j=tds.length;i<j;i++){
					if(obj.id === tds[i].id)break;
					if(tds[i].style.display === "none"){
						hideN++;
					}
				}
				cellIndex+=hideN;
			}
			var GtableObj = Gtable.GtableObj;
			GtableObj.tabID = obj.id.split("_")[0]; //这里有问题
			if(GtableObj.GtableCD == null){
				Gtable.createDiv();
			}
			GtableObj.GtableCD.style.top = e.clientY;
			GtableObj.GtableCD.style.left = e.clientX;
			GtableObj.GtableCD.style.display = "";
			if(GtableObj.copyObj == null)Gtable.initCopyJS();	//初始化复制对象
			GtableObj.copyObj.show();
			Gtable.initCopyText(); //准备要复制的数据
			GtableObj.columnN = cellIndex;
		}
		return false;
	};
	/**
	 * 创建菜单
	 */
	this.createDiv = function(){
		var div = document.createElement("div");
		div.id = Gtable.GtableObj.tabID+"_menu";
		div.style.zIndex = 1001;
		div.style.backgroundColor = "#E6F0FC";
		div.style.textAlign = "left";   //对齐方式
		div.style.border = "#73D1F7 2px solid";	//边框颜色
		div.style.position = "absolute";
		div.style.display = "none";
		div.innerHTML = '<button onclick="Gtable.GtableCDtd(\'SX\')">将此列升序</button><br>'
			+'<button onclick="Gtable.GtableCDtd(\'JX\')">将此列降序</button><br>'
			+'<button id="'+Gtable.GtableObj.tabID+'_copyBtn">复制选中值</button><br>'
			+'<button onclick="Gtable.GtableCDtd(\'hide\')">隐藏当前列</button><br>'
			+'<button onclick="Gtable.GtableCDtd(\'show\')">显示附近列</button><br>'
			+'<button onclick="Gtable.GtableCDtd(\'showAll\')">显示所有列</button>';
		div.onmouseover = function(){
			Gtable.GtableObj.menuHide = false;
			Gtable.GtableObj.copyObj.div.style.display = this.style.display = "";
		}
		div.onmouseout = function(e){
			if(e);else{e = event;}
			var obj = e.srcElement ? e.srcElement : e.target;
			if(obj.name != "copyBtnDiv"){
				this.style.display = "none";
				Gtable.GtableObj.menuHide = true;
				setTimeout(function(){
					if(Gtable.GtableObj.menuHide){
						var obj = $(Gtable.GtableObj.tabID+"_menu");
						Gtable.GtableObj.copyObj.div.style.display = obj.style.display = "none";
					}
				},500);
			}
		}
		Gtable.GtableObj.GtableCD = div;
		document.body.appendChild(div);
	};
	/**
	 * 准备移动选中,鼠标按下的时候触发
	 */
	this.initCBselected = function(id,obj,row,e){
		var obj = e.srcElement || e.target;
		if(obj.tagName === "TD" || obj.tagName === "SPAN"){
			Gtable.isMoveSelect = true;
			Gtable.isSelectYvalue = e.clientY;
			var cb = $("checkbox"+row);
			if(cb){
				cb.checked = !cb.checked;
				document.onmouseup = function(){
					Gtable.isMoveSelect = false;
					document.onmouseup = null;
					document.body.focus();
				};
				obj.focus();
			}
		}
	};
	/**
	 * 准备复制的内容到一个地方.等待触发
	 */
	this.initCopyText = function(){
		var sv;
		if(document.selection){
			sv = document.selection.createRange().text;
		}else{
			var selecter = window.getSelection();
	        var data = selecter.anchorNode.data;
	        sv = data.substring(selecter.anchorOffset,selecter.focusOffset);
		}
		if(sv.length > 0){
			Gtable.GtableObj.copyText = sv;
			Gtable.GtableObj.copyObj.setText(sv);
		}
	};
	/**
	 * 初始化复制组件
	 */
	this.initCopyJS = function(){
		var GtableObj = Gtable.GtableObj;
		ZeroClipboard.setMoviePath(GtableObj.URL+"/js/copy/ZeroClipboard.swf");
		GtableObj.copyObj = new ZeroClipboard.Client();
		GtableObj.copyObj.glue(GtableObj.tabID+"_copyBtn");
		GtableObj.copyObj.addEventListener( "complete", function(){
			var obj = $(Gtable.GtableObj.tabID+"_menu");
			obj.style.display = Gtable.GtableObj.copyObj.div.style.display = "none";
		    alert("已复制["+Gtable.GtableObj.copyText+"]到剪贴板!");
		});
		GtableObj.copyObj.addEventListener( "mouseOver", function(client) {
			Gtable.GtableObj.menuHide = false;
			var obj = $(Gtable.GtableObj.tabID+"_menu");
			obj.style.display = "";
		});
		GtableObj.copyObj.addEventListener( "mouseOut", function(client) {
			Gtable.GtableObj.menuHide = false;
			var obj = $(Gtable.GtableObj.tabID+"_menu");
			if(obj.style.display === "none"){
				Gtable.GtableObj.copyObj.div.style.display = "none";
			}
		});
		GtableObj.copyObj.div.name = "copyBtnDiv";
	};
	/**
	 * 加载复制所需的组件
	 */
	this.loadCopyJS = function(){
		var lt = window.location;
		var name = lt.pathname;
		var url = lt.protocol+"//"+lt.host+"/"+name.split("/")[1];
		Gtable.GtableObj.URL = url;
		Gtable.GtableObj.copyObj = null;
		if($("copyJS") == null){
			var js = document.createElement("script");
			js.type = "text/javascript";
			js.id = "copyJS"
			js.src = url+"/js/copy/ZeroClipboard.js";
			document.getElementsByTagName("HEAD").item(0).appendChild(js);
		}
	};
	/**
	 * 菜单中的操作
	 */
	this.GtableCDtd = function(type){
		var GtableObj = Gtable.GtableObj;
		if(type === "showAll"){
			var cells = $(GtableObj.tabID+"_table").rows[0].cells;
			for(var i=0;i<cells.length;i++){
				Gtable.Gfilter(GtableObj.tabID,i,false);
			}
		}else
		if(type === "show"){
			Gtable.Gfilter(GtableObj.tabID,GtableObj.columnN-1,false);
			Gtable.Gfilter(GtableObj.tabID,GtableObj.columnN+1,false);
		}else
		if(type === "hide"){
			Gtable.Gfilter(GtableObj.tabID,GtableObj.columnN,true);
		}else
		if(type === "JX"){
			Gtable.Gsort(GtableObj.tabID,GtableObj.columnN,false);
		}else
		if(type === "SX"){
			Gtable.Gsort(GtableObj.tabID,GtableObj.columnN,true);
		}
		GtableObj.GtableCD.style.top = -200;//隐藏和鼠标进入事件冲突.用这个.
	};
	/**
	 * 过滤
	 * tabID = Gtable的ID
	 * columnN = 第几列
	 */
	this.Gfilter = function( tabID, columnN, type ){
		var rows = $(tabID+"_table").rows;
		var td = rows[0].cells[columnN];
		if(columnN < 0 && rows[0].cells.length <= columnN)return;
		if(td.style.display == "none"){
			if(type)return;
		}else{
			if(!type)return;
		}
		if(td.getAttribute("type") == "HIDDEN"){
			return;//这是Gtable生成的要求隐藏的.
		}
		for(var i=0,j=rows.length-1;i<j;i++){
			rows[i].cells[columnN].style.display = type ? "none" : "";
		}
	};
	/**
	 * 排序 	
	 * tabID = Gtable的ID
	 * columnN = 第几列
	 * type = false降序 | true升序
	 */
	this.Gsort = function( tabID, columnN, type ){
		var tabObj = $(tabID+"_table");
		if(tabObj);else return;
		var trs = tabObj.rows;
		var length = trs.length-1,index;
		var ilh = length - 1,v1,v2;
		columnN*=1;
		if(columnN < 0 && rows[0].cells.length <= columnN)return;
		for(var i=1;i<ilh;i++){
			index = i;
			for(var j=i+1;j<length;j++){
				if(trs[index].id.length == 0 || trs[j].id.length == 0)break;
				v1 = trs[index].cells[columnN].children[0].getAttribute("value");
				v2 = trs[j].cells[columnN].children[0].getAttribute("value");
				if(Gtable.sortCheck(v1,v2,type,columnN) < 0){	//如果返回是个负数就说明要求更换位置
					index = j;	//只到最后一个再来交换.
				}
			}
			if(index != i){	//是否要交换TR
				Gtable.moveRow(tabObj,i,index);
			}
		}
	};
	/**
	 * 判断
	 * type = false降序 | true升序
	 */
	this.sortCheck = function(a,b,type,columnN){
		if(columnN < 2){ //0,1  为什么不转换数字,0大多是多选框也有可能是其他数据,1一样.
			if(a.length == b.length){
				//去执行下面的for
			}else if(a.length > b.length){
				return type ? -1 : 1;
			}else{
				return type ? 1 : -1;
			}
		}
		if(a == b) return 0;
		for(var i=0,j=a.length; i<j; i++){   
			 if(a.charCodeAt(i) > b.charCodeAt(i)){
				 return type ? -1 : 1;
			 }else if(a.charCodeAt(i) < b.charCodeAt(i)){
				 return type ? 1 : -1;
			 }
		}
		return 0;
	};
	/**
	 * TR行替换位置
	 * table对象,行,目标行
	 */
	this.moveRow = function(pNode, sri, tri) {
		if(sri == tri)return;
	    var temp,sr,tr,trnr;
	    if (pNode.tagName == 'TABLE') pNode = pNode.getElementsByTagName('tbody')[0];
	    for(var i=0;i<2;i++){
	    	if(i > 0){
	    		temp = sri;
	    		sri = tri + (sri<tri ? -1 : 1);
	    		tri = temp;
	    	}
		    sr = pNode.rows[sri];
		    tr = pNode.rows[tri];
		    if (sr == null || tr == null) return false;
		    trnr = sri > tri ? false : Gtable.getTRNode(tr, 'nextSibling');
		    if (trnr === false) pNode.insertBefore(sr, tr); //后面行移动到前面，直接insertBefore即可
		    else {//移动到当前行的后面位置，则需要判断要移动到的行的后面是否还有行，有则insertBefore，否则appendChild
		        if (trnr == null) pNode.appendChild(sr);
		        else pNode.insertBefore(sr, trnr);
		    }
	    }
	};
	this.getTRNode = function(nowTR, sibling) { 
		while (nowTR = nowTR[sibling]) if (nowTR.tagName == 'TR') break; return nowTR; 
	};
	
	
	this.Gfreeze = function (gtableid){
        var gtableobj = $(gtableid)
        var freezerow = gtableobj.freezerow;
        var freezecol = gtableobj.freezecol;
        
        var records = $(gtableid + "_records").value;

        if (freezerow != undefined && freezecol != undefined && records > 0){
//        	if (freezerow != ""){
//        		gtableobj.style.overflowY = "auto";
//        		var h = gtableobj.offsetParent.offsetHeight 
//        		h = h < 400 ? 400:h - 100;
//        		gtableobj.style.height = h;
//				var gtab = $(gtableid + "_table");
//				
//				//锁定第一行(表头)
//				for(var j=0;j<gtab.rows[i].cells.length;j++){   
//					var tdobj = gtab.rows[0].cells[j];
//					tdobj.style.cssText = "POSITION: relative;TOP: expression(document.getElementById('" + gtableid + "').scrollTop );background:#b3d4ff;z-index:999;";
//				}
//        	}
        	
//			if (freezecol != ""){
//	        	gtableobj.style.overflowX = "auto";
//	        	gtableobj.style.width = gtableobj.offsetParent.offsetWidth;
//				var gtab = $(gtableid + "_table");
//				//原CSS 对TR定义的 .default_body和。default_head 样式表的 overflow:hidden 会影响冻列,已取消
//				//循环处理冻结列
//				for(var i=0;i<gtab.rows.length-1;i++) {  
//					for(var j=0;j<gtab.rows[i].cells.length;j++){   
//						var tdobj = gtab.rows[i].cells[j];
//						
//						tdobj.style.cssText = "POSITION: relative;LEFT: expression(document.getElementById('" + gtableid + "').scrollLeft );background:#b3d4ff;z-index:999;";
//						if ( tdobj.id.indexOf(freezecol) > 0){
//							break;
//						}
//					}
//				}
//			}
        }
	};
	
	
	//************************* start Resize *************************
	this.startResize = function (gtableid, obj, evt) {
		var e = evt;
		if (this.resizebegin) {
			if (this.is_IE) {
				obj.setCapture();
			} else {
				e.preventDefault();
				document.addEventListener("mouseup", stopResize, true);
				document.addEventListener("mousemove", Resizing, true);
			}
			var span = $(obj.id.substring(0, obj.id.indexOf("_td")) + "_s");
			this.x = e.screenX;//clientX; 
			this.objw = parseInt(span.style.width);
			this.showline(gtableid, true);
			this.resizeable = true;
		}
	};
	//************************* start Resize *************************
	
	//************************* stop Resize & resize the table *************************
	this.stopResize = function (gtableid, obj, evt) {
		if (this.resizeable) {
			if (this.is_IE) {
				obj.releaseCapture();
			} else {
				document.removeEventListener("mouseup", stopResize, true);
				document.removeEventListener("mousemove", Resizing, true);
			}
			var i = 0;
			var span = $(this.spanid);

			// set td width
			// if width less than 10 pixls,then width equal 10
			this.newwidth = Math.max(10, this.newwidth);
			if (typeof (span) == "object" && span != null) {
				span.style.width = this.newwidth;
			}
			
			// before change table's td width ,save the table's old width			
			var tablewidth = parseInt($(gtableid).style.width);

			// set span and span's child width
			var spanpre = this.spanid.substring(0, this.spanid.indexOf("0_td"));
			var diffwidth = 0;
			span = $(spanpre + i + "_s");
			while (typeof (span) == "object" && span != null) {
			 	// use parseInt function get width value with no 'px' end
				diffwidth = parseInt(this.newwidth) - parseInt(span.style.width);		
				// set span's width		
				span.style.width = this.newwidth;
				// set span's child node width (only one node) (i must lager than 1)
				if (i > 0) {
					span.childNodes[0].style.width = this.newwidth;
				}
				i = i + 1;
				span = $(spanpre + i + "_s");
			}
			
			//summary column
			span = $(spanpre + "summary");
			if (typeof (span) == "object" && span != null) {
				// use parseInt function get width value with no 'px' end
				diffwidth = parseInt(this.newwidth) - parseInt(span.style.width);		
				// set span's width		
				span.style.width = this.newwidth;
			}
			
			//comupter new width
			tablewidth = tablewidth + diffwidth;
			// risize finish,hide line and set flag 
			this.showline(gtableid, false);
			this.resizeable = false;
			$(gtableid).style.width = tablewidth;
			$(gtableid + "_table").style.width = tablewidth;
		}
	};
	//************************* stop Resize *************************
	
	//************************* Resizing(just moveline move)  *************************
	this.Resizing = function (gtableid, obj, evt) {
		var e = evt ? evt : window.event;
		this.checkedge(obj);
		if (this.resizeable) {
			this.newwidth = this.objw + e.screenX - this.x;
			this.spanid = obj.id;
			var divlive = $(gtableid + "_line");
			divlive.style.left = window.event.x + window.document.body.scrollLeft;
			//gsdiv.innerHTML = obj.id;
			window.document.body.style.cursor = "e-resize";
		}
	};
	//************************* Resizing *************************
	
	//************************* showline *************************
	this.showline = function (gtableid, visibled) {
		var divlive = $(gtableid + "_line");
		if (visibled) {
			divlive.style.left = window.event.x + window.document.body.scrollLeft;
			divlive.style.height = divlive.parentNode.offsetHeight - 2;
			divlive.style.display = "";
		} else {
			divlive.style.display = "none";
		}
	};
	//************************* showline *************************
	
	//************************* calculateOffset *************************
	this.calculateOffset = function (item, offsetName) {
		var s;
		var totalOffset = 0;
		do {
			s = "item.offset" + offsetName;
			totalOffset += eval(s);
			item = item.offsetParent;
		} while (item != null);
		return totalOffset;
	}; 
	//************************* calculateOffset *************************
	
	//************************* checkedge *************************
	this.checkedge = function (obj) {
		var e = window.event || arguments.callee.caller.arguments[0];
		var mousex =e.x + window.document.body.scrollLeft;
		var calx = this.calculateOffset(obj, "Left") + obj.offsetWidth;
		if (mousex > calx - 3 && mousex < calx + 3) {
			this.resizebegin = true;
			window.document.body.style.cursor = "e-resize";
		} else {
			this.resizebegin = false;
			window.document.body.style.cursor = "default";
		}
	};
	//************************* checkedge *************************

	//************************* get SQL info *************************
	this.getSQL = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var gsobj = $(divobj.id + "_gsql");
		
		return gsobj.getAttribute("GSQL");
	}; 
	//************************* get SQL info *************************

	//************************* get COLDATATYPE info *************************
	this.getCOLDATATYPE = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var gsobj = $(divobj.id + "_gsql");
		
		return gsobj.getAttribute("GCOLDATATYPE");
	}; 
	//************************* get COLDATATYPE info *************************
	
	//************************* get COLHEADTEXT info *************************
	this.getCOLHEADTEXT = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var gsobj = $(divobj.id + "_gsql");
		
		return gsobj.getAttribute("GCOLHEADTEXT");
	}; 
	//************************* get COLHEADTEXT info *************************
	
	//************************* get COLNAME info *************************
	this.getCOLNAME = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var gsobj = $(divobj.id + "_gsql");
		
		return gsobj.getAttribute("GCOLNAME");
	}; 
	//************************* get COLNAME info *************************
	
//Programs Programs Programs
	//************************* get Updateinfo info *************************
	this.getUpdateinfo = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var records = $(divobj.id + "_records").value;
		var trobj = $(divobj.id + "_g@r0");
		
		var tdarr = trobj.getElementsByTagName("td")
		
		var sjson = "";
		var sfiled = "";
		
		//取得要更新列的值
		for (var i = 0;i < tdarr.length;i++){
			//typeof(tdarr[i].update) != "undefined" 
			if (typeof(tdarr[i].getAttribute('update')) != "undefined" && tdarr[i].getAttribute('update') == "edit"){
				
				var sret = "";
				var itemvalue = "";

				var obj = null;
				
				//只有表头有colname属性				
				var colname = tdarr[i].getAttribute('colname');
				var coldatatype = tdarr[i].getAttribute('coldatatype');
				
				//更新字段列
				sfiled = sfiled + "" + colname + ",";
				
				for (var j = 1; j <= records; j++) {
					obj = $(divobj.getAttribute('id') + "_" + colname + "_" + j);
					
					if (obj == null) {
						//获取主键列数据，主要是checkbox列，临时处理方式:如果没有值，则再向上一层的SPAN取
						obj = $(divobj.getAttribute('id') + "_" + colname + "_" + j + "_s");
						if (obj == null) {
							alert("no exists column name:" + colname);
							sret = "";
							//break;
						} else {
							if (coldatatype == "number"){		//数字类型时才替换
								itemvalue = obj.getAttribute('value').replace(/,/g,"");
							} else {
								itemvalue = obj.getAttribute('value');
							}
							sret = sret + "\"" + itemvalue + "\",";
						}
					} else {
						if (coldatatype == "number"){			//数字类型时才替换
							itemvalue = obj.getAttribute('value').replace(/,/g,"");
						} else {
							itemvalue = obj.getAttribute('value');
						}
						sret = sret + "\"" + itemvalue + "\",";
					}
				}
				sjson = sjson + "\"" + colname + "\":[" + sret.substring(0, sret.length - 1) + "],";
			}
		}
		
		//取得主键列的值
		var pkey = divobj.getAttribute('tablepk').split(",");
		
		for (var i = 0;i < pkey.length;i++){
			sret = "";
			for (var j = 1; j <= records; j++) {
				//获取主键列数据
				obj = $(divobj.getAttribute('id') + "_" + pkey[i] + "_" + j);
				
				if (obj == null) {
					//获取主键列数据，主要是checkbox列，临时处理方式:如果没有值，则再向上一层的SPAN取
					obj = $(divobj.getAttribute('id') + "_" + pkey[i] + "_" + j + "_s");
					if (obj == null) {
						alert("no exists column name");
						sret = "";
						//break;
					} else {
						itemvalue = obj.getAttribute('value');
						sret = sret + "\"" + itemvalue + "\",";
					}
				} else {
					itemvalue = obj.getAttribute('value');
					sret = sret + "\"" + itemvalue + "\",";
				}
			}
			sjson = sjson + "\"" + pkey[i] + "\":[" + sret.substring(0, sret.length - 1) + "],";
		}
		
		sfiled = sfiled.substring(0, sfiled.length - 1)
		sfiled = "\"fields\":\"" + sfiled + "\"";
				
		sjson = sjson.substring(0, sjson.length - 1);

		//js json ,for evel
		//sjson = "(\{" + "\"table\":\"" + divobj.table + "\",\"tablepk\":\"" + divobj.tablepk + "\"," + sfiled + "," + sjson + "\})";
		//myjson = eval(sjson);
				
		
		//java json
		sjson = "\{" + "\"table\":\"" + divobj.getAttribute('table') + "\",\"tablepk\":\"" + divobj.getAttribute('tablepk') + "\","
			+ "\"records\":\"" + records + "\"," + sfiled + "," + sjson + "\}";
		
		return sjson;
	}; 
	//************************* get Updateinfo info *************************
	
	
	//************************* selcheckbox *************************
	this.selcheckbox = function selcheckbox(gtableid) {
		var myReg = /checkbox([0-9]+)/;
		var divobj = typeof (gtableid) == "string" ? $(gtableid) : gtableid;
		var cvalue = false;
		var inputobj = divobj.getElementsByTagName("input");
		for (var i = 0; i < inputobj.length; i++) {
			if (inputobj[i].id == "checkboxall") {
				if (inputobj[i].checked) {
					cvalue = true;
				}
			} else {
				if (myReg.test(inputobj[i].id)) {
					inputobj[i].checked = cvalue;
				}
			}
		}
	}; 
	//************************* selcheckbox *************************

	//************************* getselectid *************************
	this.getselectid = function (gtable) {
		var myReg = /checkbox([0-9]+)/;
		var sret = "";
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var inputobj = divobj.getElementsByTagName("input");
		for (var i = 0; i < inputobj.length; i++) {
			if (myReg.test(inputobj[i].id)) {
				if (inputobj[i].checked) {
					sret = sret + inputobj[i].value + ",";
				}
			}
		}
		return sret.substring(0, sret.length - 1);
	}; 
	//************************* getselectid *************************

	//************************* get column values *************************
	this.getcolvalues = function (gtable, colname) {
		if (colname != "CHECKID") {
			var sret = "";
			var itemvalue = "";
			var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
			var records = $(divobj.id + "_records").value;
			var obj = null;
			for (var i = 1; i <= records; i++) {
				obj = $(divobj.id + "_" + colname + "_" + i);
				
				if (obj == null) {
					alert("no exists column name");
					sret = "";
					break;
				} else {
					itemvalue = obj.value;
					sret = sret + itemvalue + "#@#";
				}
			}
			sret = sret.substring(0, sret.length - 3);
		} else {
			var myReg = /checkbox([0-9]+)/;
			var sret = "";
			var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
			var inputobj = divobj.getElementsByTagName("input");
			for (var i = 0; i < inputobj.length; i++) {
				if (myReg.test(inputobj[i].id)) {
					sret = sret + inputobj[i].value + ",";
				}
			}
			sret = sret.substring(0, sret.length - 1);
		}
		return sret;
	}; 
	//************************* get column values *************************
	
	//************************* get single column value *************************
	this.getsinglevalue = function (gtable, colname, row) {
		if (colname != "CHECKID") {
			var sret = "";
			var itemvalue = "";
			var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
			//var inputobj = divobj.getElementsByTagName('input');		
			var obj = null;
			obj = $(divobj.id + "_" + colname + "_" + row );
			if (obj == null) {
				alert("no exists column name");
				sret = "";
			} else {
				sret = obj.value;
			}
		} else {
			sret = "no support yet";
		}
		return sret;
	}; 
	//************************* get single column value *************************
	
	//************************* set single column value *************************
	this.setsinglevalue = function (gtable, colname, row, value) {
		if (colname != "CHECKID") {
			var sret = "";
			var itemvalue = "";
			var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
			//var inputobj = divobj.getElementsByTagName('input');		
			var obj = null;
			obj = $(divobj.id + "_" + colname + "_" + row);
			if (obj == null) {
				alert("no exists column name");
			} else {
				if (obj.nodeName == "INPUT") {
					obj.value = value;
				} else {
					if (obj.nodeName == "SPAN") {
						obj.innerHTML = value;
					}
				}
			}
		} else {
			sret = "no support yet";
		}
		return "";
	}; 
	//************************* set single column value *************************
	
	//************************* getselcolvalues *************************
	this.getselcolvalues = function (gtable, colname) {
		var myReg = /checkbox([0-9]+)/;
		var sret = "";
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var inputobj = divobj.getElementsByTagName("input");
		for (var i = 0; i < inputobj.length; i++) {
			if (myReg.test(inputobj[i].id)) {
				if (inputobj[i].checked) {
					var obj = null;
					var rowid=null;
					
					if(inputobj[i].rowid!=null) {
					rowid = inputobj[i].rowid;
					}
					else {
						rowid = inputobj[i].attributes['rowid'].nodeValue;
					}

					obj = $(divobj.id + "_" + colname + "_" + rowid);
					if (obj == null) {
						alert("no exists column name");
						sret = "";
						break;
					} else {
						if(obj.value!=null)
						itemvalue = obj.value;
						else{
							itemvalue = obj.attributes['value'].nodeValue;
						}
						sret = sret + itemvalue + "#@#";
					}
				}
			}
		}
		//alert(sret);
		return sret.substring(0, sret.length - 3);
	}; 
	//************************* getselcolvalues *************************
	
	//************************* rowover *************************
	this.rowover = function (gtableid, obj,row,e) {
		//id gtable
		//ie浏览器兼容
		var divobj = $(gtableid);
		if(divobj.myclass!=null) {
			obj.className = divobj.myclass + "_over";
		}
		//其他（firefox）浏览器兼容
		else {
			obj.className = divobj.attributes['myclass'].nodeValue  + "_over";
		}
		if(Gtable.isMoveSelect){
			var cb = $("checkbox"+row);
			if(cb){
				cb.focus();
				cb.checked = Gtable.isSelectYvalue < e.clientY ? true : false;
				Gtable.isSelectYvalue = e.clientY;
			}
		}
	}; 
	//************************* rowover *************************
	
	//************************* rowout *************************
	this.rowout = function (gtableid, obj) {
		//兼容ie浏览器
		if(obj.oldclass!=null)
			obj.className = obj.oldclass;
		//其他（firefox）浏览器兼容
		else{
			obj.className = obj.attributes['oldclass'].nodeValue;
		}
		if(Gtable.isMoveSelect){
			document.onmouseup = function(){
				Gtable.isMoveSelect = false;
				document.onmouseup = null;
				document.body.focus();
			};
		}
	}; 
	//************************* rowout *************************
	
	//************************* rowsel *************************
	this.rowsel = function (gtableid, checkobj, trid) {
		var divobj = $(gtableid);
		var trobj = $(trid);
		if (trobj != null) {
			if (checkobj.checked) {
				trobj.className = divobj.myclass + "_sel";
				trobj.oldclass = divobj.myclass + "_sel";
			} else {
				trobj.className = divobj.myclass + "_body";
				trobj.oldclass = divobj.myclass + "_body";
			}
		}
	}; 
	//************************* rowsel *************************
	
	//************************* onRowclick *************************
	this.onclick = function (gtableid, trobj) {
		var divobj = $(gtableid);
		var myReg = /checkbox([0-9]+)/;
		var e = window.event || arguments.callee.caller.arguments[0];
		var _element = e.srcElement ? e.srcElement : e.target;
		with (e) {
			if (!myReg.test(_element.id)) {
				var divobj = typeof (gtableid) == "string" ? $(gtableid) : gtableid;
				var inputobj = divobj.getElementsByTagName("input");
				var pre = gtableid + "_g@r";
				var rowid = trobj.id.substring(pre.length, trobj.id.length);
				for (var i = 0; i < inputobj.length; i++) {
					if (myReg.test(inputobj[i].id)) {
						if (inputobj[i].id == "checkbox" + rowid) {
							inputobj[i].checked = true;
						} else {
							inputobj[i].checked = false;
						}
					}
				}
			}
		}
	};
	//************************* onRowclick *************************
	
//	//************************* onRowdblclick *************************
//	this.ondoubleclick = function (gtableid, obj) {
//		//alert('double click:' + obj.id);
//	};
//	//************************* onRowdblclick *************************
	
	//************************* Go Button Event *************************
	this.goClick = function (gtableid, goURL) {
		var url = "";
		var showpage = gtableid + "_showpage";
		var pagesize = gtableid + "_pagesize";
		if ($(showpage).value.length == 0 || $(pagesize).value.length == 0) {
			alert("请输入正确的页大小或页码!");
			return false;
		}
		
		var sp = $(showpage).value;
		var ps = $(pagesize).value;
		
		var reg =  /^[0-9]*[1-9][0-9]*$/;
				
		if ( !reg.test(sp) || !reg.test(ps)){
			alert("请输入正确的页大小或页码(01)!");
			return false;
		}
		//window.self.location.href = goURL;
		goURL = "?page=" + $(showpage).value + "&pagesize=" + $(pagesize).value + "&" + goURL;
		
		is_IE = (navigator.appName == "Microsoft Internet Explorer");
		if(is_IE) {
		window.name = "__self";
		window.open(goURL, "__self");
		} else{
			window.location.target= "_self"; 
			window.location.href = goURL;
		}
	}; 
	//************************* Go Button Event *************************
	
	//************************* create XmlHttp *************************
	this.createXmlHttp = function () {
		var xmlHttp = null;
        //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
		if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
		} else {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IE浏览器支持的创建方式
		}
		return xmlHttp;
	};
    //************************* create XmlHttp *************************
    
	//************************* Go Button Event *************************
	this.refreshtable = function (gtableid) {
		var url = "";
		var sRet = "";
		var postdate = "a=1&b=22&a=333";
		var xmlHttp = this.createXmlHttp();                       //创建XmlHttpRequest对象   
		xmlHttp.onreadystatechange = function () {
			if (xmlHttp.readyState == 4) {
		        //调用addChildren函数生成子节点
				if (xmlHttp.status == 200) {
					sRet = xmlHttp.responseText;
				}
			}
		};
		xmlHttp.open("POST", "test.gs", false); 	//?time=" + new Date().getTime() 
		xmlHttp.setRequestHeader("content-length", postdate.length);//post提交设置项
		xmlHttp.setRequestHeader("content-type", "application/x-www-form-urlencoded");//post提交设置项          
		xmlHttp.send(postdate);
		return sRet;
	}; 
	//************************* Go Button Event *************************
	
	//************************* get getGtableJSON *************************
	this.getGtableJSON = function (gtable) {
		var divobj = typeof (gtable) == "string" ? $(gtable) : gtable;
		var records = $(divobj.id + "_records").value;
		var trobj = $(divobj.id + "_g@r0");
		
		var tdarr = trobj.getElementsByTagName("td")
		
		var sjson = "";
		var sfiled = "";
		
		//取得要更新列的值
		for (var i = 0;i < tdarr.length;i++){
			var sret = "";
			var itemvalue = "";

			var obj = null;
			
			//只有表头有colname属性				
			var colname = tdarr[i].colname;
			var coldatatype = tdarr[i].coldatatype;
			
			//更新字段列
			sfiled = sfiled + "" + colname + ",";
			
			for (var j = 1; j <= records; j++) {
				obj = $(divobj.id + "_" + colname + "_" + j);
				
				if (obj == null) {
					//获取主键列数据，主要是checkbox列，临时处理方式:如果没有值，则再向上一层的SPAN取
					obj = $(divobj.id + "_" + colname + "_" + j + "_s");
					if (obj == null) {
						alert("no exists column name:" + colname);
						sret = "";
						//break;
					} else {
						if ( coldatatype == "number"){		//数字类型时才替换
							itemvalue = obj.value.replace(/,/g,"");
						} else {
							itemvalue = obj.value;
						}
						sret = sret + "\"" + itemvalue + "\",";
					}
				} else {
					if ( coldatatype == "number"){			//数字类型时才替换
						itemvalue = obj.value.replace(/,/g,"");
					} else {
						itemvalue = obj.value;
					}
					sret = sret + "\"" + itemvalue + "\",";
				}
			}
			sjson = sjson + "\"" + colname + "\":[" + sret.substring(0, sret.length - 1) + "],";
		}
		
		sfiled = sfiled.substring(0, sfiled.length - 1)
		sfiled = "\"fields\":\"" + sfiled + "\"";
				
		sjson = sjson.substring(0, sjson.length - 1);

		//js json ,for evel
		//sjson = "(\{" + "\"table\":\"" + divobj.table + "\",\"tablepk\":\"" + divobj.tablepk + "\"," + sfiled + "," + sjson + "\})";
		//myjson = eval(sjson);

		//java json
		sjson = "\{" + "\"table\":\"" + divobj.table + "\",\"tablepk\":\"" + divobj.tablepk + "\","
			+ "\"records\":\"" + records + "\"," + sfiled + "," + sjson + "\}";
		
		return sjson;
	}; 
	//************************* get getGtableJSON *************************
};
Gtable.loadCopyJS(); //初始化复制组件
/***************************** Gtable 结束 *****************************/