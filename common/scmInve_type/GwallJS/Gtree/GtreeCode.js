var Gtree = {
	imagePath:'GwallJS/Gtree/images/',			//图片路径
	fninitend:null,					//全部加载完成
	config:{
		id:null,					//treeID          必须
		checkbox:false,				//是否要复选框    默认:false
		edit:false,					//是否允许编辑    默认:false
		autoclose:true,				//是否自动关闭(点击文件夹时候,不在同一级就关闭上次打开的文件夹.)  默认:true
		data:null,					//数据            必须,第一种:http://www.gwall.cn/Gwall/xxx.jsp    第二种:[{data:[{数据1},{数据2}]}]
	//data子集属性 {id:唯一标识,lable:显示名称,value:值,select:是否选中,open:是否载入就打开,children:[带此属性表示该节点是文件夹]}
		clickfiles:'',				//记录载入完成后,要调用选中的ID (节点中select:true时候,会记录并调用点击函数.)
		loadall:false,				//判断数据是否一次性载入
		openPath:'',				//记录上次打开路径,用于实现自动关闭.
		selectedID:'',				//记录上次选中ID,用于修改背景色,单选ID
		selectedList:'',			//复选框选中的ID
		selectIds:'',				//全部载入时候,存放要求载入完成就选中(会调用点击事件)ID集合.
		openIds:'',					//全部载入时候,存放要求载入完成就打开文件夹的ID集合.
		filesList:'',				//已经载入的文件夹ID.用于全部打开,全部关闭操作.
		//////////////////////////////////////////////////////////////////事件
		fndelstart:null,			//删除节点前	    参数: treeId, id   操作树,删除ID
		fndelend:null,				//删除节点后	    参数: treeId, ids  操作树,要删除的ID集合以,分隔
		fnloadnode:null,			//载入节点后      参数: treeId, id, children    操作树,当前ID,文件夹子集集合.
		fnclicknode:null,			//点击节点	    参数: treeId, bool, obj   操作树,是否文件夹,节点对象
		fnaddnode:null,				//添加节点后     参数: treeId, bool, obj   操作树,是否文件夹,节点对象
		fneditend:null				//编辑节点后     参数: treeId, obj	操作树,编辑后对象.
	},
	treeList:{},					//存放tree对象.   用法:Gtree.treeList[树ID].上面的配置属性        (ajax方式的数据没有存储,data=url地址)
	
	/**
	 * 获取界面中树div的ID
	 *
	 */
	init: function(){
		var trees = document.getElementsByTagName("div");//获取到div type = Gtree 的对象集合
		var obj = {},type;		
		for(var i=0;i<trees.length;i++){	
			type = trees[i].getAttribute("type");
			if(type && type == "Gtree"){
				obj = this.getDefault( trees[i] );
				if(obj == null)continue;
				if(obj.data.substring(0,2) == "[{"){	
					this.treeList[obj.id].loadall = true;
					var data = eval( obj.data )[0];
					//this.treeList[obj.id].data = data.data;
					//this.treeList[obj.id].data = this.config.data;
					this.treeList[obj.id].data = data.data;
					this.load( this.treeList[obj.id] );
				}else{					
					this.ajax("get",obj.data,obj,
						function(xmlHttp,obj){
							var json = eval( xmlHttp.responseText )[0];
							obj.data = json.data;
							obj.loadall = false;
							Gtree.load( obj );//转换为对象后在初始化
						},function(error){
							alert("ajax获取数据错误:"+error);
						}
					);
				}
			}			
		}
		this.createMenuDiv();   //菜单
		this.createUpdateDiv(); //新增,编辑
		if(this.fninitend && typeof  this.fninitend === 'function'){				
			this.fninitend();	//所有树载入完成.
		}
	},
	/**
	 * 创建菜单
	 */
	createMenuDiv: function (){
		//创建弹出div来控制增删改
		var div = document.createElement("div");
		div.id = "Gtree_zsg";  //zsg  ==  增删改
		div.style.zIndex = 1001;
		div.style.backgroundColor = "#E6F0FC";
		div.style.textAlign = "left";   //对齐方式
		div.style.border = "#73D1F7 2px solid";	//边框颜色
		div.style.position = "absolute";
		div.style.display = "none";
		div.className = "Gtree";
		var lihtml = '<li class="liclass" onMouseOut="this.className=\'liout\'" onMouseOver="this.className=\'liin\'" onClick="';
		div.innerHTML =
		lihtml+'Gtree.menuClickItem(\'add\');"><img src="'+this.imagePath+'page_add.png"/>新增</li>'+
		lihtml+'Gtree.menuClickItem(\'edit\');"><img src="'+this.imagePath+'edit.gif"/>编辑</li>'+
		lihtml+'Gtree.menuClickItem(\'refresh\');"><img src="'+this.imagePath+'refresh.png"/>刷新</li>'+
		//lihtml+'Gtree.menuClickItem(\'moveup\');"><img src="'+this.imagePath+'moveup.png" width="13"/>上移</li>'+
		//lihtml+'Gtree.menuClickItem(\'movedown\');"><img src="'+this.imagePath+'movedown.png" width="13"/>下移</li>'+
		lihtml+'Gtree.menuClickItem(\'del\');"><img src="'+this.imagePath+'del.png"/>删除</li>';
		document.body.appendChild(div);
		document.body.onclick = function(){
			var divObj = $("Gtree_zsg");
			if(divObj.style.display != "none"){
				divObj.style.display = "none";
			}
		}
	},
	createUpdateDiv: function (){
		//创建弹出div来增改
		var div = document.createElement("div");
		div.id = "Gtree_zg";  //zsg  ==  增删改
		div.style.zIndex = 1001;
		div.style.backgroundColor = "#E6F0FC";
		div.style.textAlign = "left";   //对齐方式
		div.style.border = "#73D1F7 2px solid";	//边框颜色
		div.style.position = "absolute";
		div.style.display = "none";
		div.className = "Gtree";
		div.innerHTML = '<table>'
		+'<tr><td align="center" colspan="2"><span id="update_title"><b>编辑</b></span></td></tr>'
		+'<tr><td align="right">编号:</td><td><input type="text" id="Gtree_zg_id"/></td></tr>'
		+'<tr><td align="right">名称:</td><td><input type="text" id="Gtree_zg_lable"/></td></tr>'
		+'<tr id="tr_type"><td align="right">类型:</td><td><input type="radio" id="Gtree_zg_type1" name="Gtree_zg_type1"/>'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_type1\')">文件夹 </lable>'
		+'<input type="radio" id="Gtree_zg_type2" name="Gtree_zg_type1" checked=true />'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_type2\')">节点</lable></td></tr>'
		+'<tr id="tr_link"><td align="right">链接:</td><td><input type="radio" onclick="Gtree.ridioSelect(\'Gtree_zg_link1\')" name="Gtree_zg_link" id="Gtree_zg_link1"/>'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_link1\')">是</lable>'
		+'<input type="radio" name="Gtree_zg_link" id="Gtree_zg_link2" onclick="Gtree.ridioSelect(\'Gtree_zg_link2\')" checked=true />'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_link2\')">否</lable></td></tr>'
		+'<tr id="tr_state"><td align="right">状态:</td><td><input type="radio" name="Gtree_zg_state" id="Gtree_zg_state1"/>'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_state1\')">打开</lable>'
		+'<input type="radio" name="Gtree_zg_state" id="Gtree_zg_state2"/>'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_state2\')">选中</lable>'
		+'<input type="radio" name="Gtree_zg_state" id="Gtree_zg_state3" checked=true />'
		+'<lable onclick="javascript:Gtree.ridioSelect(\'Gtree_zg_state3\')">无</lable></td></tr>'
		+'<tr id="tr_url" style="display:none"><td align="right">地址:</td><td><input type="text" id="Gtree_zg_url"/></td></tr>'
		+'<tr><td align="center" colspan="2">'
		+'<input type="button" class="buttons" value="确定" onmouseover="this.className=\'button_over\'" onmouseout="this.className=\'button_out\'" onclick="Gtree.updatebuttonYES()"/><input type="button" class="buttons" value="取消" onmouseover="this.className=\'button_over\'" onmouseout="this.className=\'button_out\'" onclick="Gtree.updatebuttonNO()"/></td></tr>'
		+'</table>';
		document.body.appendChild(div);
	},
	ridioSelect: function ( id ){
		$(id).checked=true;	
		if( id.indexOf("link") != -1){  //是链接
			if($("Gtree_zg_link1").checked){
				$("tr_url").style.display = "";	
			}else{
				$("tr_url").style.display = "none";
			}
		}
	},
	/**
	 * 新增,修改层确定按钮事件
	 */
	updatebuttonYES: function(){
		var dobj = $("Gtree_zg");	
		var obj = this.updateValue( true ); //取值
		var type = dobj.getAttribute("update_type");
		if(type == "edit"){
			this.editNode( obj );
		}else{
			var fobj = $("fl_"+obj.id);
			if(fobj != null){
				alert("ID:"+obj.id+" 已经存在!");
				return;
			}else{
				fobj = $("div_"+obj.id);
				if(fobj != null){
					alert("ID:"+obj.id+" 已经存在!");
					return;
				}
			}
			if(type == "add"){
				var type = $("Gtree_zg_type1").checked ? "files" : "file";
				this.addFiles( type, obj );
			}
		}
		dobj.style.display = "none";				
	},
	/**
	 * 新增,编辑层的 取消按钮事件
	 */
	updatebuttonNO: function(){
		var obj = $("Gtree_zg");	
		obj.style.display = "none";
	},
	/**
	 *  设置值,或取对象
	 */
	updateValue: function ( bool, obj ){
		if(bool){
			var obj = {};
			obj.id = $("Gtree_zg_id").value;
			obj.lable = $("Gtree_zg_lable").value;
			obj.url = $("Gtree_zg_url").value;
			obj.select = $("Gtree_zg_state2").checked;
			obj.open = $("Gtree_zg_state1").checked;
			obj.link = $("Gtree_zg_link1").checked;
			return obj;
		}else{
			$("Gtree_zg_id").value = obj.id;
			$("Gtree_zg_lable").value = obj.lable;
			$("Gtree_zg_url").value = obj.url;
			$("Gtree_zg_state2").checked = obj.select;
			$("Gtree_zg_state1").checked = obj.open;
			$("Gtree_zg_link1").checked = obj.link;
		}
	},
	/**
	 * 菜单单击事件
	 */
	menuClickItem: function ( str ){
		var divObj = $("Gtree_zsg");
		var treeId = divObj.getAttribute("treeId");
		if(treeId == null)return;
		var id = this.treeList[treeId].selectedID;
		switch( str ){
			case "del": { var ids = this.delNode( id ); alert("删除后返回的ID:"+ids); break;}
			case "edit": { this.updateItem( str ); break; }
			case "add": { this.updateItem( str ); break; }
			case "moveup": { break; }
			case "movedown": { break; }
			case "refresh": { this.loadFiles( id,"update" ); break; }
		}
		divObj.style.display = "none";
	},
	/**
	 * 更新选中项
	 */
	updateItem: function ( type ){
		var divObj = $("Gtree_zsg");
		var treeId = divObj.getAttribute("treeId");
		var obj = $("Gtree_zg");
		obj.style.top = divObj.offsetTop;
		obj.style.left = divObj.offsetLeft;
		obj.setAttribute("update_type",type);
		obj.setAttribute("treeId",treeId);
		if(type == "edit"){//设置值
			var itemobj = this.getSelectedObj( treeId );
			if(itemobj == null){
				return;
			}
			for( var i in itemobj ){
				if( itemobj[i] == "undefined" ) itemobj[i] = "";
			};
			$("Gtree_zg_id").disabled = true;
			$("tr_type").style.display = 
			$("tr_state").style.display = "none";
			if(itemobj.link.length > 0){
				this.ridioSelect("Gtree_zg_link1");
			}else{
				this.ridioSelect("Gtree_zg_link2");
			}			
			this.updateValue( false, itemobj );
			$("update_title").innerHTML = "<b>编辑</b>";
		}else{
			this.ridioSelect("Gtree_zg_link2");  //自动选中不是链接
			if(type == "add"){
				var zgid = $("Gtree_zg_id");
				zgid.disabled = false;
				zgid.value = "";
				$("Gtree_zg_lable").value = "";
				$("update_title").innerHTML = "<b>新增</b>";
				this.ridioSelect("Gtree_zg_type2");  //节点
				this.ridioSelect('Gtree_zg_state3'); //状态无
			}
			$("tr_type").style.display = 
			$("tr_state").style.display = "";		
		}
		obj.style.display = "";
	},
	/**
	 * 右击事件
	 */
	contextMenu: function ( treeId, obj ){
		var id = obj.id.split("af_")[1];
		if(obj.parentNode.parentNode.tagName == "DIV"){
			this.clickFiles( id );
		}else{
			this.clickFile( id );
		}
		if(this.treeList[treeId].edit){
			var divObj = $("Gtree_zsg");
			divObj.style.display = "";
			divObj.style.left = (this.getObjxy(obj,"left")+obj.offsetWidth+1)+"px";
			divObj.style.top = this.getObjxy(obj,"")+"px";
			divObj.setAttribute("treeId",treeId);	//当前菜单是那颗树在操作.	
		}
		return false;
	},
	/**
	 * 取控件的位置
	 * obj:要获取位置的对象
	 * str:left  表示获取left位置;其他表示获取top
	 */
	getObjxy: function(obj,str){
		var xy=0;
		if(str == "left"){
			xy = obj.offsetLeft; 
			while(obj = obj.offsetParent){ //如果在某个对象中,那就要加上
				xy += obj.offsetLeft; 
			}			
		}else{
			xy = obj.offsetTop; 
			while(obj = obj.offsetParent){ 
				xy += obj.offsetTop; 
			}
		}
		return xy;
	},	
	/**
	 * 设置默认参数
	 */
	getDefault: function ( obj ){
		var config = {};
		config.checkbox = obj.getAttribute("checkbox");
		config.edit = obj.getAttribute("edit");
		config.data = obj.getAttribute("data");
		config.autoclose = obj.getAttribute("autoclose");
		config.id = obj.id;
		if(config.checkbox == null) config.checkbox = false;
		else config.checkbox = config.checkbox == "false" ? false : true;			
		if(config.autoclose == null) config.autoclose = true;
		else config.autoclose = config.autoclose == "false" ? false : true;
		if(config.edit == null) config.edit = false;
		else config.edit = config.edit == "false" ? false : true;
		if(config.data == null) {alert(obj.id+":缺少数据(data属性).");return null;}
		if(config.id == null) {alert("缺少ID!");return null;}		
		var setting = this.config;
		for( var i in setting ){
			if( config[i] === undefined ) config[i] = setting[i];
		};
		this.treeList[config.id] = config;
		return config;
	},
	/**
	 * 载入生成的树
	 *
	 */
	load: function ( config ){
			this.setHTML( config.id, this.getChildrenHTML( config.id, config.data, "", 0 ) );
			if(config.loadall){
				this.loadAll( config.data );  //载入全部				
				this.loadOpenFiles( config.id );  //打开设置为open=true的文件夹
				this.loadSelected( config.id ); //选中select=true的文件
			}
	},
	/**
	 * 载入全部.
	 */
	loadAll: function( list ){
		for(var i=0;i<list.length;i++){
			if(list[i].children){
				this.loadFiles( list[i].id, "loadall", list[i].children);
				this.loadAll( list[i].children );
			}
		}		
	},
	/**
     * 当数据是全部传递过来后,生成的时候要找出来.
	 * id:要查找的id
	 * list:在什么数据中查找
	 * data:初始值null,因为是递归,函数用与保存值,返回的也是这个值.
	 */
	getChildren: function ( id, list, data ){
			for(var i=0;i<list.length;i++){
				if(list[i].id == id){				
					return list[i].children;	
				}else{
					if(list[i].children){
						data = this.getChildren( id, list[i].children, data );
					}
				}
			}
			return data;
	},
	/**
	 * ajax
	 * 参数:
	        type:post|get
			url:http://www.baidu.com/getdata?id=1001&value1=100&value2=100
			para:给返回函数传递的参数
			succes(data)成功后函数.
	 *
	 */
	ajax: function(type,url,para,succes,error){
		if(url.indexOf("?") != -1){
			url = url + "&time="+new Date().getTime();
		}else{
			url = url + "?time="+new Date().getTime();
		}		
		var xmlHttp;
		if(window.XMLHttpRequest){
			xmlHttp = new XMLHttpRequest();                     //FireFox、Opera等浏览器支持的创建方式
		}else{
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");   //IE浏览器支持的创建方式
		}
		xmlHttp.open(type, url, true);
		xmlHttp.onreadystatechange = function(){				
			if(xmlHttp.readyState == 4 && xmlHttp.status == 200){  
				succes(xmlHttp,para);
			}else{
				if(xmlHttp.readyState == 4 && xmlHttp.status != 200){
					if(error != null)
						error(xmlHttp.status,para);
				}
			}
		};
		xmlHttp.send(null);
	},
	/**
	 *  根据一个节点生成对应的HTML
	 *  
	 */
	getChildrenHTML: function ( treeId, children, line, rank){
			var html = "";
			var isfater = false, isrootf = false, bool = false;
			if(children && children.constructor == Array){
				for(var i=0;i<children.length;i++){	
					bool = (i+1 == children.length);
					if(children[i].children){					
						if(bool){							
							isfater = true;
							if(rank == 0)isrootf = true;
						}else{
							isfater = false;
						}
						html += this.getFiles( treeId, children[i], line, bool , rank, isfater, isrootf );
					}else{
						html += this.getFile( treeId, children[i], line, bool , rank, isfater, isrootf );
					}
				}
			}else{
				if(children == undefined)return "";
				html += this.getFile( treeId, children , bool , rank, isfater, isrootf );
			}
			return html;
	},
	/**
     * 将html放入指定id中.
	 */
	setHTML: function ( id , html){	
			$(id).innerHTML = html;
	},
	/**
	 * 点击文件夹的时候生成下一节点html
	 *
	 *  type:   undefined|loading|loadok|loadall|
	 *  		undefined:在生成的html的事件中没有加入该参数,不需要管此参数.
	 * 			loading:用于判断是否第一次载入时候,open=true方式打开的,是的话就不进行自动关闭操作.
	 * 			loadok:载入完成后,也就是经过了laoding的处理.
	 * 			loadall: 当要求一次性生成tree的时候.
	 * 			open: 载入完成后有效.
	 * 			close:载入完成后有效.
	 * 	children:  只有type=loadall时候才有用,用于载入全部的时候 ,提供数据.		
	 */
	loadFiles: function ( id, type, children ){
			var obj = $("fs_"+id);
			if(obj == null)return;
			var str = obj.style.display == 'none' ? '' : 'none';
			var isload = obj.getAttribute("isload") == "false" ? false : true;
			if(isload && type == "open"){  //载入完成后才有效
				obj.style.display = "";
				if(str == '')this.setIcon( id, "files", true );  //要求设置图标时候,按要求打开
				return ;
			}else
			if(type == "close"){ //把已经打开的关闭就行了.没有载入的不管了.
				obj.style.display = "none";
				if(str == 'none')this.setIcon( id, "files", false ); //要求设置图标时候,按要求关闭
				return ;
			}else
			if(type == "loadall"){
				obj.style.display = "none";		//要求一次性载入,默认全部关闭.数据照样加载.(下面有判断str变量)
			}else{
				if(type == "loading"){
					obj.style.display = "";		//是一次性全部载入,并且有open=treu属性,防止重复路径下的时候关闭问题.
				}else{
					if(type == "update"){
						//更新后不动
					}else
						obj.style.display = str;
				}
			}
			var treeId = obj.parentNode.getAttribute("treeId");		
			
			if(type == undefined) type = "loadok";  //说明是用户主动点击传过来的参数.
			if(this.treeList[treeId].autoclose && type == "loadok"){  //是打开时候,如果要求自动关闭就执行.
				if(this.treeList[treeId].openPath == undefined){
					this.treeList[treeId].openPath = id;
				}
				this.autoCloseFiles( treeId, id );
			}
			if(type == "update" || (str != "none" && isload == false)){		//isload为div中自定义属性.
				var html = this.getOutHtml( treeId, id );			
				obj.setAttribute("isload",true);
				obj = $("div_"+id);
				var rank = obj.getAttribute("rank") * 1;				
				var url = obj.getAttribute("url");
				url=url+"&value="+obj.value+"&names="+obj.names;
				if(type != "loadall" && url != 'undefined' && url.length > 5){  //如果有url就取url中的数据
					this.ajax("get",url,id,
						function(xmlHttp,id){	
							var children = eval(xmlHttp.responseText);//转换为对象
							if(children){
								Gtree.setHTML("fs_"+id , Gtree.getChildrenHTML( treeId, children, html, rank+1 ) );	
							}
							if(treeId != null){
								if(Gtree.treeList[treeId].fnloadnode && typeof  Gtree.treeList[treeId].fnloadnode === 'function'){				
									Gtree.treeList[treeId].fnloadnode( treeId, id, children );	//添加后函数
								}
							}
						},function(error){
							alert("ajax获取子节点错误:"+error);
						}
					);
				}else{
					if(this.treeList[treeId].loadall){
						var data = null;
						if(type == "loadall"){
							data = children;
						}else{
							data = this.getChildren( id, this.treeList[treeId].data, null );
						}
						this.setHTML("fs_"+id , this.getChildrenHTML( treeId, data, html, rank+1 ) );
					}else{
						this.setHTML("fs_"+id , '');//点击了文件夹,该文件夹是个空的.也要设置值,因为有个ajaxload图片在转!
					}
				}
			}
			if(type != "loadall" && type != "update"){	//是载入全部就不需要设置图标了.只要把数据加载进去就行了.  更新的话也不需要设置图标.
				var bool = false;
				if(type == "loading"){  //是载入的时候要求自动打开.
					bool = true;
				}else{					
					if(str == "none"){
						bool = false;
					}else{
						bool = true;
					}
				}				
				this.setIcon( id, "files", bool );
			}
			$("div_"+id).setAttribute("open",str != "none" ? "true":"false");	
					
	},
	/**
	 * 设置/更新 图标
	 * ps_  文件夹前控制图标
	 * fr_  文件夹的图标
	 * cb_  复选框
	 * div_ 文件夹对象
	 * fs_  文件夹子集显隐控制对象, isload=false  表示需要载入更新,其他值表示已经载入过
	 * fl_  文件对象
	 * af_  文件(a标签)
	 * 
	 * id:要设置的对象编号
	 * click:点击的是什么?文件夹,文件
	 * bool:用在当是文件夹的选中的时候,全部设置为bool选中方式.
	 */
	setIcon: function ( id, click, bool ){
		if(click == "files"){
			var fr = $("fr_"+id);
			var ps = $("ps_"+id);
			var list = this.gerImgSrcPath(fr);
			var isopen = true;
			if(list != null){
				if(bool != undefined){
					isopen = bool;
					cname = bool ? "filesopen.gif" : "files.gif";	//true 打开,false 关闭
				}else{
					cname = (list[1] == "files.gif" ? "filesopen.gif" : "files.gif");	//按照当前设置
					isopen = cname == "filesopen.gif";
				}
				fr.src = list[0] + Gtree.imagePath + cname;				
			}
			list = this.gerImgSrcPath(ps);
			if(list != null){
				var cname = "";
				var icon = true;   //标识是什么类型图标
				if(list[1] == "plus.gif") cname = "minus.gif"; // is +  to -
				if(list[1] == "minus.gif") cname = "plus.gif"; 
				if(list[1] == "plusbottom.gif"){ cname = "minusbottom.gif"; icon = false;}  
				if(list[1] == "minusbottom.gif"){ cname = "plusbottom.gif"; icon = false;}
				if(bool != undefined){
					if(icon){
						cname = bool ? "minus.gif" : "plus.gif";
					}else{
						cname = bool ? "minusbottom.gif" : "plusbottom.gif";
					}
				}
				ps.src = list[0] + Gtree.imagePath + cname;
			}
		}else
		if(click == "checkbox"){			
			var cb = $("cb_"+id);
			var list = this.gerImgSrcPath(cb);
			if(list != null ){
				var cname = "checkbox_off.jpg";
				cname = list[1] == "checkbox_off.jpg" ? "checkbox_on.jpg" : cname;
				if(bool != undefined){
					if(bool){
						cname = "checkbox_on.jpg";
					}else{
						cname = "checkbox_off.jpg";
					}
				}
				cb.src = list[0] + Gtree.imagePath + cname;				
				if(cname == "checkbox_on.jpg"){
					return true;
				}else{
					return false;
				}
			}
		}
	},
	/**
	 * 用于更新图标时候的路径问题.
	 * 对象的src=http://www.gwall.cn/Gtree/images/plus.gif
	 * 返回:[1] http://www.gwall.cn/Gtree/images/ [2] plus.gif
	 */
	gerImgSrcPath: function ( obj ){
		if(obj != null){
			var path = obj.src;			
			var list = path.split(Gtree.imagePath);
			return list;
		}
		return null;
	},
	/**
	 *	选中(点击复选框图标的事件)
	 *  id
	 *  isfiles: true | false   是否为文件夹,是的话还要进行设置子集
	 */
	clickCheckBox: function( treeId, id, isfiles ){
		if(isfiles){
			var obj = $("div_"+id);
			if(obj){
				var bool = this.setIcon( id, "checkbox" ); //这里省略了一个参数,表示按照当前图标自行改变并返回结果.(如:+改变成- 返回 false)
				obj.setAttribute("select",bool);
				obj = $("fs_"+id);  //子集span
				this.setSelectListID( treeId, id, bool );	//加上自己文件夹ID
				var temp = this.getObjChildNodeIDS( obj, "fl_", '', false );  //收集子节点,没有收集子集中的文件夹,到时要加入的话就从这里下手.
				if(temp.length > 0){
					temp = temp.substring(1,temp.length); //取到第一个,
					var list = temp.split(",");
					for(var i in list){
						this.setIcon( list[i], "checkbox", bool ); //强制要求设置为bool方式图标
					}
					this.setSelectListID( treeId, temp, bool );		//temp == ids == 1,2,3,4					
				}
			}
		}else{	
			this.setSelectListID( treeId, id, this.setIcon( id, "checkbox" ) );
		}
	},
	/**
	 * 获取文件夹下所有 str前缀的ID,包括子文件夹中的.
	 * 返回已,分隔的字符串.
	 * 文件夹对象obj
	 * 按什么前缀str
	 * ids调用传个''过来
	 * bool 是否子集文件夹的id也要?
	 * 需要去掉第一个,
	 */
	getObjChildNodeIDS: function ( obj, str, ids, bool){
		if(obj == null)return;
		if(obj.id.indexOf("div_") != -1){
			obj = $("fs_"+obj.id.split("_")[1]);
		}
		var list = obj.childNodes;		
		for(var i=0;i<list.length;i++){
			if(list[i].id && list[i].id.length > 0){
				if(str != null){
					if(list[i].id.indexOf(str) == -1) continue;
				}				
				ids += ","+ list[i].id.split("_")[1];
				if(bool && list[i].id.indexOf("div_") != -1){  
					ids = this.getObjChildNodeIDS( list[i], str, ids, bool );
				}
			}
		}
		return ids;
	},
	/**
	 * 多选时候的赋值操作.
	 * bool=true加入ID,
	 * bool=flase删除ID
	 * 是已截取方式,如果是多个ID,可以看作是一个ID传过来同样可以.
	 * 
	 */
	setSelectListID: function( treeId, id , bool ){
		var listid = this.treeList[treeId].selectedList;				
		if(bool){
			if(listid && listid.length > 0){
				this.treeList[treeId].selectedList += ","+id;
			}else{
				this.treeList[treeId].selectedList = id;
			}
		}else{
			var index = listid.indexOf(id);
			if( index != -1 ){
				if( index != 0 ){
					var a = listid.substring(0,index);
					var b = listid.substring(index+id.length,listid.length);
					if(a.charAt(a.length-1) == ','){
						a = a.substring(0,a.length-1);
					}
					listid = a+b;
				}else{
					listid = listid.substring(id.length,listid.length);
					if(listid.charAt(0) == ','){
						listid = listid.substring(1,listid.length);
					}
				}
				this.treeList[treeId].selectedList = listid;
			}
		}
		var list = id.split(",");
		var obj;
		for(var id in list){
			obj = $("fl_"+list[id]);			//节点
			if(obj == null){		
				obj = $("div_"+list[id]);		//是文件夹		
			}	
			obj.setAttribute("select",bool);  //设置选择项select=true | false
		}
	},
    /**
	 * 节点中设置了select=true时候,会收集ID,然后再调用.
	 *
	 */
	loadSelected: function( treeId ){
		var ids = this.treeList[treeId].selectIds;
		if(ids && ids.length > 0){
			var list = ids.split("@");
			for(var i=1;i<list.length;i++){
				this.clickFile( list[i] );
			}			
		}		
	},
	/**
	 * 全部载入完成后,打开有open:true的标识的文件夹.
	 *
	 */
	loadOpenFiles: function( treeId ){
		var ids = this.treeList[treeId].openIds;
		if(ids && ids.length > 0){
			var list = ids.split("@");
			var bool = false;
			if(list.length > 1 && this.treeList[treeId].autoclose){
				bool = true;
			}
			var path, pathList;;
			for(var i=1;i<list.length;i++){
				if(i > 1 && bool){
					return;		//因为存在多个open=true,有设置了自动关闭,所以只要打开一个就行了.
				}
				path = this.getPath( treeId, list[i], true );
				pathList = path.split("/");
				if(pathList && pathList.length > 0){
					for(var j=pathList.length -1; j>=0;j--){
						this.loadFiles( pathList[j], "loading" );
					}
				}
			}			
		}
	},
    /**
	 * 当设置为每次只打开一个的时候,就调用此方法进行关闭之前打开的文件夹.
	 *
	 */
	autoCloseFiles: function ( treeId, id ){
		var temp = this.treeList[treeId].openPath;
		if(temp && temp.length > 0){
			this.treeList[treeId].openPath = "";
			var list = temp.split("/");  //得到之前打开的路径
			var temp1 = this.getPath( treeId, id, true );
			var newlist = temp1.split("/");
			var i = list.length - 1;
			var j = newlist.length - 1;			
			while( i != -1 && j != -1 ){
				if(list[i] == newlist[j]){   //根目录开始向下,如果一样就不关闭
					i--;
					j--;
				}else{
					while( i != -1 ){
						this.loadFiles( list[i--], "loading" );
					}			
					break;
				}
			}
			this.treeList[treeId].openPath = temp1;
		}
	},
    /** 
	 * 文件夹的html
	 * 之前用的class控制,现在更改为img模式,以下是更改和用到的图标.
	 * checkbox_off.gif  empty.gif line.gif ajax_loader.gif plusbottom.gif plus.gif files.gif--forder joinbottom.gif  join.gif file.gif--page
	 * 具体参数看下面有解释(getFile)
	 * isfater:是否最后一个文件夹,会作为参数放在标签中,运行中会用到.
	 */
	getFiles: function ( treeId, obj, line, bool, rank, isfater, isrootf){
			var path = Gtree.imagePath;
			var cb = '';
			if(this.treeList[treeId].checkbox){
				var par = "'"+treeId+"','"+obj.id+"',true";
				cb = '<img id="cb_'+obj.id+'" onclick="Gtree.clickCheckBox('+par+')" src="'+path+'checkbox_off.jpg"/>';
			}	
			this.treeList[treeId].filesList += obj.id+','; //收集文件夹ID
			var cname = bool ? "plusbottom" : "plus";
			var ajaxLoad = line+'<img src="'+path+(isfater ? 'empty' : 'line' )+'.gif"/><img src="'+path+'ajax_loader.gif"/>';
			var html = '<div id="div_'+obj.id+'" url="'+obj.url+'" value="'+obj.value+'" names="'+obj.names+'" bsul="'+obj.bsul+'" select="'+obj.select+'" link="'+obj.link+'" lable="'+obj.lable+'"'
			+'treeId="'+treeId+'" isfater="'+isfater+'" isrootf="'+isrootf+'" rank="'+rank+'"><span><span id="line_'+obj.id+'">'+line+'</span>'
			+'<img id="ps_'+obj.id+'" onclick="Gtree.loadFiles(\''+obj.id+'\')" src="'+path+cname+'.gif"/>'
			+cb+'<a id="af_'+obj.id+'" oncontextmenu="return Gtree.contextMenu(\''+treeId+'\',this);" href="javascript:Gtree.clickFiles(\''+obj.id+'\');" ondblclick="Gtree.loadFiles(\''+obj.id+'\')"><img id="fr_'+obj.id+'" src="'+path+'files.gif"/><span id="lb_'+obj.id+'">'+obj.lable+'</span></a></span><br>'
			+'<span id="fs_'+obj.id+'" style="display:none;" isload="false">'+ajaxLoad+'</span></div>';	
			if(this.treeList[treeId].loadall){
				if(obj.open){
					this.treeList[treeId].openIds += "@"+obj.id;
				}
			}
			// <div id="div_ID">...</div>   //一个节点
			return html;
	},
	/**
	 * 文件的html 
	 * treeId:	树编号
	 * obj:  	节点对象
	 * line:	每个节点都有个前面的线.  html
	 * bool:	是否最后一个节点
	 * rank:  当前层次
	 * isfater:	是否最后一个文件夹...这里暂时没有用.
	 * isrootf: 是否第一层中最后一个文件夹,是的话,所有子节点的第一个是空格
	 */
	getFile: function ( treeId, obj, line, bool, rank, isfater, isrootf ){
			var path = Gtree.imagePath;
			var cb = '';
			if(this.treeList[treeId].checkbox){
				var par = "'"+treeId+"','"+obj.id+"',false";
				cb = '<img id="cb_'+obj.id+'" onclick="Gtree.clickCheckBox('+par+')" src="'+path+'checkbox_off.jpg"/>';
			}	
			var cname = bool ? "joinbottom" : "join";		
			var file = '<span id="fl_'+obj.id+'" treeId="'+treeId+'" url="'+obj.url+'" value="'+obj.value+'" names="'+obj.names+'" bsul="'+obj.bsul+'" select="'+obj.select+'" link="'+obj.link+'" lable="'+obj.lable+'">';
			if(this.treeList[treeId].loadall){
				if(obj.select){
					this.treeList[treeId].selectIds += "@"+obj.id;
				}	
			}
			// <span id="fl_ID">...</span>   //一个节点
			return file+'<span id="line_'+obj.id+'">'+line+'</span><img id="img_'+obj.id+'" isfater="'+bool+'" src="'+path+cname+'.gif"/>'+cb+'<a id="af_'+obj.id+'" oncontextmenu="return Gtree.contextMenu(\''+treeId+'\',this);" href="javascript:Gtree.clickFile(\''+obj.id+'\')"><img src="'+path+'file.gif"/><span id="lb_'+obj.id+'">'+obj.lable+'</span></a><br></span>';			
	},
	/**
	 * 新增文件夹
	 * type: file | files  文件|文件夹
	 * obj: id,lable,open,select,link,value,url数据
	 */
	addFiles: function ( type, obj ){
		var zgobj = $("Gtree_zg");
		var treeId = zgobj.getAttribute("treeId");
		var id = this.treeList[treeId].selectedID;
		var selectObj = $("fl_"+id);		
		if(selectObj == null)
			selectObj = $("div_"+id);
		if(selectObj == null)return;
		var upobj = selectObj.parentNode;   //span  在文件夹中.
		if(upobj.getAttribute("isload")== null){
			return;
		}		
		var line = $("line_"+id).innerHTML;
		var rank = selectObj.getAttribute("rank")*1;
		var isfater = selectObj.getAttribute("isfater") == "false" ? false : true;
		var isrootf = selectObj.getAttribute("isrootf") == "false" ? false : true;
		var html,bool = false,upnodeimg=null,isfiles=true,open = false;
		upnodeimg = $("ps_"+id);
		if(upnodeimg == null){
			isfiles = false;
			upnodeimg = $("img_"+id);
		}
		if(isfiles){  //选中的是个文件夹就看是否打开了文件夹
			open = selectObj.getAttribute("open") == "false" ? false :true;
		}
		if(open){  //新增目标:打开了就是子集,没有就是兄弟!
			upobj = $("fs_"+id);  //选中的文件夹中.
			var list = upobj.childNodes;
			if(list.length > 0){
				var id = list[list.length-1].id.split("_")[1];
				upnodeimg = $("ps_"+id);
				if(upnodeimg == null){
					upnodeimg = $("img_"+id);
				}
				var upimgsrc = upnodeimg.src;
				line = $("line_"+id).innerHTML;
				bool = upimgsrc.indexOf("bottom") != -1 ? true : false;
				if(bool){//选择了最后一个节点来新增节点的,要把选中的节点的图标该了.
					var listt = this.gerImgSrcPath( upnodeimg );
					upnodeimg.src = listt[0]+Gtree.imagePath+listt[1].substring(0,listt[1].indexOf("bottom"))+".gif";
				}
				var fs = $("fs_"+id);
				if(upimgsrc.indexOf("plusbottom") != -1){//最后一个是文件夹 没有打开
					$("div_"+id).setAttribute("isfater",false); 
					fs.setAttribute("isload","false");	//让它重新载入一次.
				}else{
					if(upimgsrc.indexOf("minusbottom") != -1){  //最后一个是文件夹 已经打开
						this.closeFiles( id );	//关闭文件夹
						$("div_"+id).setAttribute("isfater",false); 
						fs.setAttribute("isload","false");	//让它重新载入一次.
					}
				}
			}else{
				var id = upobj.parentNode.id.split("_")[1];
				var listt = this.gerImgSrcPath( $("ps_"+id) );
				if(upobj.parentNode.getAttribute("isfater") == "false"){
					line+='<img src="'+listt[0]+Gtree.imagePath+'line.gif"/>';
				}else{
					line+='<img src="'+listt[0]+Gtree.imagePath+'empty.gif"/>';	
				}				
			}
			bool = true;	
			rank++;
			isfater = true;
		}else{
			bool = upnodeimg.src.indexOf("bottom") != -1 ? true : false;
			if(bool){//选择了最后一个节点来新增节点的,要把选中的节点的图标该了.
				var list = this.gerImgSrcPath( upnodeimg );
				upnodeimg.src = list[0]+Gtree.imagePath+list[1].substring(0,list[1].indexOf("bottom"))+".gif";
			}				
		}
		if(type == "files"){ //文件夹
			html = this.getFiles( treeId, obj, line, bool, rank, isfater, isrootf);
		}else{
			html = this.getFile( treeId, obj, line, bool, rank, isfater, isrootf);
		}
		if(open){
			upobj.innerHTML += html;
		}else{
			var list = upobj.childNodes;
			if(list == null)upobj.innerHTML += html;
			else{
				for(var i=0;i<list.length;i++){
					if(list[i].id == selectObj.id){
						var temp1,temp=null,nowobj=html;
						for(var j=i+1;j<list.length;j++){
							if(nowobj != null){
								temp = list[j].innerHTML;
								list[j].innerHTML = nowobj;
								nowobj = null;	
							}else{
								temp1 = list[j].innerHTML;
								list[j].innerHTM = temp;
								temp = temp1;
							}
						}
						temp = temp == null ? nowobj : temp;
						upobj.innerHTML += temp;
						break;
					}
				}
			}
			if(isfiles){ //最后个是文件夹,要设置并更新文件夹   以下重新获取对象,是因为前面的innerHTML操作更新了.不重新获取,对象设置值不起作用.
			var selectObj = $("fl_"+id);
			if(selectObj == null)
				selectObj = $("div_"+id);
			selectObj.setAttribute("isfater","false");
			selectObj.setAttribute("isload","false"); //比较的地方用的是"false"
			this.loadFiles(id,"update");
		}	
		}
		if(treeId != null){
			if(this.treeList[treeId].fnaddnode && typeof  this.treeList[treeId].fnaddnode === 'function'){				
				this.treeList[treeId].fnaddnode( treeId, type == "files", obj );	//添加后函数
			}
		}		
		return obj;
	},
	/**
	 * 删除节点 
	 * 文件夹,文件  都可以删除
	 * 文件夹的子集也相应的删除!
	 * 返回删除的ID(以,分隔)
	 */
	delNode: function ( id ){
		var node = $("div_"+id);  //文件夹
		var parentNode = null,treeId = null;
		var ids = id,isfater = false,isfiles = false;   //删除的ID集合,是否最后一个,是否文件夹
		if(node != null){
			isfater = node.getAttribute("isfater") == "false" ? false : true;
			parentNode = node.parentNode;
			isfiles = true;
			treeId = node.getAttribute("treeId");
		}else{
			node = $("fl_"+id);	//文件
			if(node != null){
				isfater = node.getAttribute("isfater") == "false" ? false : true;
				parentNode = node.parentNode;
				treeId = node.parentNode.parentNode.getAttribute("treeId"); //节点,文件夹,文件夹对象
			}else{
				ids = null;
			}
		}
		if(treeId != null){
			if(this.treeList[treeId].fndelnodestart && typeof  this.treeList[treeId].fndelnodestart === 'function'){				
				var bool = this.treeList[treeId].fndelnodestart( treeId, id );//删除前函数
				if(bool == false)return;
			}
		}
		if(parentNode != null){
			if(isfater){	//要删除的节点是最后一个节点,那么就要设置上一个节点的图标了.
				var temp = this.getObjChildNodeIDS( parentNode, null, '', false );  //获得ID大于0的所有集合
				if(temp.length > 0){
					temp = temp.substring(1,temp.length); //取到第一个,
					var list = temp.split(",");
					var upid = null;
					if(list.length > 1){
						upid = list[list.length-2];  // 取到上一个ID
					}
					if(upid != null){
						var isfs = $("div_"+upid) == null ? false : true;
						var obj = $(isfs ? "ps_"+upid : "img_"+upid);
						if(isfs){  //更新文件夹
							var files = $("div_"+upid);
							files.setAttribute("isfater","true");  //判断的地方用的是=="true"纠结.不能改,要改就要改一批.
							this.loadFiles( upid, "update" );
						}						
						if(obj != null){
							var list = this.gerImgSrcPath( obj );  //取路径和名称.
							if(list != null){
								if(isfs){
									list[1] = list[1] == "plus.gif" ? "plusbottom.gif" : "minusbottom.gif";	
								}else{
									list[1] = "joinbottom.gif"; 
								}
								obj.src = list[0] +this.imagePath+ list[1];  //url+文件名
							}
						}
					}
				}
			}
			if(isfiles){
				var temp = this.getObjChildNodeIDS( node, null, '', true );//获取子集ID,包括子集文件夹下的子集.
				if(temp.length > 0){
					ids += temp;
				}	
			}
			parentNode.removeChild( node );
		}
		if(treeId != null){
			if(this.treeList[treeId].fndelnodeend && typeof  this.treeList[treeId].fndelnodeend === 'function'){				
				this.treeList[treeId].fndelnodeend( treeId, ids );	//删除后函数
			}
		}
		return ids;
	},	
	/**
	 * 编辑节点
	 * 返回修改后的对象.
	 */
	editNode: function ( obj ){
		//id,url,link,open,select,lable,
		var itemObj = $("fl_"+obj.id);
		var treeId = null;
		if(itemObj == null){
			itemObj = $("div_"+obj.id);
			if(itemObj == null)return;
			treeId = itemObj.getAttribute("treeId");
		}
		treeId = itemObj.parentNode.parentNode.getAttribute("treeId"); //节点,文件夹,文件夹对象
		for( var i in obj ){
			if( i != "id" && obj[i].length > 0 ) itemObj.setAttribute(i,obj[i]);
		};
		$("lb_"+obj.id).innerHTML = obj.lable;
		
		if(treeId != null){
			if(this.treeList[treeId].fneditend && typeof  this.treeList[treeId].fneditend === 'function'){				
				this.treeList[treeId].fneditend( treeId, obj );	//编辑后函数
			}
		}
		return obj;
	},
	/**
	 * 移动文件夹
	 */
	moveFiles: function ( id ){
		
	},
	/**
	 * 点击文件夹事件
	 */
	clickFiles: function ( id ){
		var frobj = $("div_"+id);
		var obj = this.getFilesObj(id);
		var treeId = frobj.getAttribute("treeId");
		this.setSelectedID( id );
		if(treeId != null){//点击节点事件回调函数
			if(this.treeList[treeId].fnclicknode && typeof  this.treeList[treeId].fnclicknode === 'function'){				
				this.treeList[treeId].fnclicknode( treeId, true, obj );	//点击节点函数
			}
		}
	},
	/**
	 * 点击文件事件
	 *
	 */
	clickFile: function ( id ){
		var frobj = $("fl_"+id);
		var obj = this.getFileObj(id);
		var treeId = frobj.getAttribute("treeId");
		this.setSelectedID( id );
		if(treeId != null){//点击节点事件回调函数
			if(this.treeList[treeId].fnclicknode && typeof  this.treeList[treeId].fnclicknode === 'function'){				
				this.treeList[treeId].fnclicknode( treeId, false, obj );	//点击节点函数
			}
		}
	},
	/**
	 * 设置选中项
	 * 点击事件,设置背景,清除上次点击节点背景.
	 * 单选时候的应用.
	 *
	 */
	setSelectedID: function( id ){
		var frobj = $("fl_"+id);
		var treeId;
		if(frobj == null){  //不是文件节点
			frobj = $("div_"+id);
			if(frobj == null){ //不是文件夹节点.
				return;	  //是个烂ID
			}else{
				treeId = frobj.getAttribute("treeId");
			}
		}else{
			treeId = frobj.parentNode.parentNode.getAttribute("treeId");  //  当前文件节点(span).文件夹(span).文件夹(div)
			if(treeId==null) treeId = frobj.getAttribute("treeId");
		}
		var af = $("af_"+id);
		if(af){
			var idf = this.treeList[treeId].selectedID;
			if(idf && idf.length > 0){
				var aff = $("af_"+idf);
				if(aff){
					aff.style.backgroundColor = '' ;
				}
			}
			af.style.backgroundColor = '#9BE0FF';
			this.treeList[treeId].selectedID = id;
		}
	},
	/**
	 * 设置选中多选,只能在带有复选框的状态下才有效.
	 * ids: 以,分隔
	 */
	setSelectedList: function ( ids ){
		var list = ids.split(",");
		if(list && list.length > 0){
			var obj = $("div_"+list[0]);
			var treeId = null;
			if(obj){
				treeId = obj.getAttribute("treeId");
			}else{
				obj = $("fl_"+list[0]);
				if(obj){
					treeId = obj.parentNode.parentNode.getAttribute("treeId");
				}else{
					return ;
				}
			}
			if(treeId != null){
				if(this.treeList[treeId].checkbox){
					for(var id in list){
						obj = $("div_"+list[id]);
						if(obj){
							this.clickCheckBox( treeId, list[id], true );	
						}else{
							this.clickCheckBox( treeId, list[id], false );
						}
					}
				}
			}
			return ;			
		}
	},
	/**
	 * 获取选中项对象
	 */
	getSelectedObj: function ( treeId ){
		var selectid = this.treeList[treeId].selectedID;
		var obj = this.getFileObj( selectid );
		if(obj == null){  //如果获取节点返回null,再获取文件夹试试.
			obj = this.getFilesObj( selectid ); 
		}
		return obj;
	},
	/**
	 * 获取文件对象
	 */
	getFileObj: function ( id ){
		var frobj = $("fl_"+id);
		if(frobj == null)return null;
		var obj = {};
		obj.id = frobj.getAttribute("id").split("fl_")[1];
		obj.url = frobj.getAttribute("url");
		obj.value = frobj.getAttribute("value");
		obj.names = frobj.getAttribute("names");
		obj.select = frobj.getAttribute("select");
		obj.link = frobj.getAttribute("link");
		obj.lable = frobj.getAttribute("lable");
		obj.bsul = frobj.getAttribute("bsul");
		return obj;
	},
	/**
	 * 获取文件夹对象
	 */
	getFilesObj: function ( id ){
		var divobj = $("div_"+id);
		if(divobj == null)return null;
		var obj = {};
		obj.id = divobj.getAttribute("id").split("div_")[1];
		obj.url = divobj.getAttribute("url");
		obj.value = divobj.getAttribute("value");
		obj.names = frobj.getAttribute("names");
		obj.open = divobj.getAttribute("open");
		obj.select = divobj.getAttribute("select");
		obj.link = divobj.getAttribute("link");
		obj.lable = divobj.getAttribute("lable");
		obj.bsul = divobj.getAttribute("bsul");
		return obj;
	},
	/**
	 * 打开全部文件夹
	 */
	openAll: function ( treeId ){
		this.openOrclosefiles( treeId, "open");
	},
	/**
	 * 关闭全部文件夹
	 */
	closeAll: function ( treeId ){
		this.openOrclosefiles( treeId, "close");
	},
	/**
	 * str:  open  | close
	 */
	openOrclosefiles: function ( treeId, str ){
		try{
			var ids = this.treeList[treeId].filesList;
			var list = ids.split(",");
			for(var i=0;i<list.length-1;i++){ 		 //-1是因为最后一个是个空(如:1,2,3,)
				this.loadFiles( list[i], str );
			}
		}catch(e){
			//treeId参数不对
		}		
	},
	/**
	 * 打开指定文件夹
	 */
	openFiles: function ( id ){
		this.loadFiles( id, "open" );
	},
	/**
	 * 关闭指定文件夹
	 */
	closeFiles: function ( id ){
		this.loadFiles( id, "close" );
	},
	/**
	 *  获取点击节点的完整路径
	 *	isfiles: true | false  如果是false就要特殊处理下,因为file中没有div_ID
	 */
	getPath: function ( treeId, id, isfiles ){
			var path = id;
			var obj;
			if(isfiles){
				obj = $("div_"+id).parentNode;
			}else{
				obj = $("fl_"+id).parentNode.parentNode.parentNode; //得到span位置,所在文件夹div,目标.
			}
			while( obj.id != treeId ){
				if(obj.tagName != "SPAN"){
					path += "/"+obj.id.split("div_")[1];
				}
				obj = obj.parentNode;
			}			
			return path;
	},
	/**
	 * 根据完整路径得到节点前面输出 线,空格的样式.
	 *
	 */
	getOutHtml: function ( treeId, id ){
			var path = this.getPath( treeId, id, true );
			var list = path.split("/");
			var obj;			
			var line = "";
			for(var i=list.length-1;i>=0;i--){
				obj = $("div_"+list[i]);
				if(line.length > 0 && obj != null){				
					var isfater = obj.getAttribute("isfater");
					if(isfater == "true"){						
						line+='<img src="'+Gtree.imagePath+'empty.gif"/>';
					}else{						
						line+='<img src="'+Gtree.imagePath+'line.gif"/>';
					}
				}else{
					if(obj.getAttribute("isrootf") == "true"){  						
						line+='<img src="'+Gtree.imagePath+'empty.gif"/>';
					}else{						
						line+='<img src="'+Gtree.imagePath+'line.gif"/>';
					}
				}			
			}
			return line;
	}
};
window.onload = function(){
	Gtree.init();
};
function $(id) {
	return document.getElementById(id);
};
Gtree.config.data = [
		{id:'2001',lable:'开发部',value:'开发部值',
			children:[
				{id:'200101',lable:'200101',value:'test1',
					children:[
						{id:'20010101',lable:'20010101',value:'test1'},
						{id:'20010102',lable:'20010102',value:'test2',
							children:[
								{id:'200201',lable:'test1',value:'test1',children:[
									{id:'200201123',lable:'test1',value:'test1'},
									{id:'2002031',lable:'test1',value:'test1',children:[
										{id:'200123201',lable:'test1',value:'test1'},
										{id:'2001232021',lable:'test1',value:'test1'},
										{id:'2001232011',lable:'test1',value:'test1',children:[
											{id:'2001232301',lable:'test1',value:'test1'}
										]}										
									]}
								]},
								{id:'200202',lable:'test2',value:'test2',children:[
									{id:'200212302',lable:'test2',value:'test2'}
								]},
								{id:'200203',lable:'test3',value:'test3'},
								{id:'200204',lable:'自动打开',value:'test4',open:true,children:[
									{id:'200201121123',lable:'自动选中',value:'test4',select:true},
									{id:'20020123',lable:'test4',value:'test4',children:[
										{id:'20020112123',lable:'test4',value:'test4'}
									]}
								]}
							]
						},
						{id:'20010103',lable:'20010103',value:'test3'},
						{id:'20010104',lable:'自动',value:'test4',open:true,
							children:[
								{id:'2002011',lable:'test1',value:'test1'},
								{id:'2002012',lable:'test2',value:'test2',children:[
									{id:'200201111',lable:'test1',value:'test1'}
								]},
								{id:'2002013',lable:'test3',value:'test3'},
								{id:'2002014',lable:'test4',value:'test4',children:[
									{id:'20020141111',lable:'test1',value:'test1',children:[
										{id:'200201231111',lable:'test1',value:'test1'}
									]}
								]}
							]	
						}
					]
				},
				{id:'200102',lable:'200102',value:'test2'},
				{id:'200103',lable:'200103',value:'test3'},
				{id:'200104',lable:'最后文件夹',value:'test4',children:[
					{id:'2002011141',lable:'最后的家伙1',value:'test4'},
					{id:'200201114',lable:'最后的家伙1',value:'test4',children:[
						{id:'2002011114',lable:'最后',value:'test4'}
					]},
					{id:'200201115',lable:'最后的家伙2',value:'test4'},
					{id:'200201116',lable:'最后的家伙3',value:'test4',children:[
						{id:'20020111611',lable:'最后的家伙0',value:'test4'},
						{id:'20020111612',lable:'最后的家伙0',value:'test4'},
						{id:'20020111613',lable:'最后的家伙0',value:'test4',children:[]},
						{id:'20020111614',lable:'最后的家伙0',value:'test4'},
						{id:'20020111615',lable:'最后的家伙0',value:'test4'},
						{id:'20020111616',lable:'最后的家伙0',value:'test4'},
						{id:'20020111617',lable:'最后的家伙0',value:'test4'},
						{id:'20020111618',lable:'最后的家伙0',value:'test4'},
						{id:'20020111619',lable:'最后的家伙0',value:'test4'}
					]}
				]}
			]
		},		
		{id:'2003',lable:'测试部',value:'测试部值',
			children:[
				{id:'200301',lable:'人马',value:'test1',
					children:[
						{id:'20030121',lable:'流浪剑客',value:'test1',children:[
							{id:'200301111223',lable:'恶魔巫师',value:'test1',open:true,children:[
								{id:'20030166111223',lable:'',value:'test1'}
							]}
						]},
						{id:'2003013',lable:'200303',value:'test3'},
						{id:'200302',lable:'混沌骑士',value:'test2',children:[
							{id:'2003011223',lable:'MB',value:'test1'}
						]},
						{id:'200303',lable:'200303',value:'test3'},
						{id:'200304',lable:'最后文件夹',value:'test4',children:[
							{id:'200303123',lable:'200303',value:'test3'}
						]}
					]
				},				
				{id:'200312123',lable:'200312',value:'test3'},
				{id:'200312',lable:'200312',value:'test3'},
				{id:'200323',lable:'测试',value:'测试',
					children:[
						{id:'2003231',lable:'2003231',value:'test1'},
						{id:'2003232',lable:'2003232',value:'test2',
							children:[
								{id:'20032321',lable:'20032321',value:'test1'},
								{id:'20032322',lable:'20032322',value:'test2',children:[
									{id:'207032323',lable:'20032323',value:'test3'}
								]},
								{id:'20032323',lable:'20032323',value:'test3'},
								{id:'20032324',lable:'20032324',value:'test4',children:[
									{id:'200632323',lable:'20032323',value:'test3'}
								]}
							]
						},
						{id:'2003233',lable:'2003233',value:'test3',children:[
							{id:'200323211',lable:'20032321',value:'test1'},
							{id:'200323212',lable:'20032322',value:'test2'}
						]}						
					]
				}
			]
		}	
	];