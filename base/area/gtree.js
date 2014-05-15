var GTree = new function() {
    this._url = "gtree.jsp";            						//用于请求数据的服务器页面地址			
  	this._itemMark = "·";             							//非目录节点标		
    this._initId = "treeInit";         							//树形目录初始div标识
    this._boxSuffix = "_childrenBox";  							//子节点容器后	
	
    //初始化根节点
    this.init = function() {
        var initNode = document.getElementById(this._initId);   //获取初始div
        //隐藏文本框，用来保存选定的节点
    	initNode.innerHTML = "<input id=\"selecteditem\" type=\"hidden\" itemvalue=\"\" \>";
        var _node = document.createElement("div");              //创建新div作为根节
        _node.id = "ROOT";                                  	//根节点id
        _node.style.width="auto";
        
		var varhtml = '<span id=\'root_span_img\'class="folderMark" onclick="GTree.getChildren(\'root\');" ><img height="9" src="../../images/minus.png" width="9"></span>';    	
		varhtml = varhtml + '<span id=\'root_span\' class="folder" itemtype = "F" onclick="GTree.clickItem(\'#\',\'root\')" >地区分类</span>';
		_node.innerHTML = varhtml;

        initNode.appendChild(_node);                            //将根节点加入初始div
        this.getChildren(_node.id);
    }
			
	//获取给定节点的子节点
	this.getChildren = function(_parentId) {
	    //获取页面子节点容器box
	    var childBox = document.getElementById(_parentId + this._boxSuffix);
	    //如果子节点容器已存在则直接设置显示状态，否则从服务器获取子节点信息
		if (childBox) {
			var isHidden = (childBox.style.display == "none");      //
	        childBox.style.display = isHidden?"":"none";            //
	        //根据子节点的显示状态修改父节点标识
	        var _parentNode = document.getElementById(_parentId);       
	        _parentNode.firstChild.innerHTML = isHidden ?'<img height="9" src="../../images/minus.png" width="9">'
															:'<img height="9" src="../../images/plus.png" width="9">';
		} else {
			this.refreshItems(_parentId,"");
		}
	}

	//从数据库获取数据源
	this.getItemsFromDB = function(_parentId,_childId){
		var xmlHttp=this.createXmlHttp();                   //创建XmlHttpRequest对象
//		xmlHttp.onreadystatechange = function() {
//			if (xmlHttp.readyState == 4) {
//				_data = xmlHttp.responseXML.getElementsByTagName("tree")[0].childNodes; //获取所有子节点
//
//				GTree.refreshItems(_parentId,_data);
//			}
//		}

		//异步方式，可以做一些优化处理，现不用
		//xmlHttp.open("GET", this._url + "?parentId=" + _parentId+"&childId=" + _childId+"&time="+new Date().getTime(), true);

		// 同步方式
		xmlHttp.open("GET", this._url + "?parentId=" + _parentId+"&childId=" + _childId+"&time="+new Date().getTime(), false);
		xmlHttp.send(null);

		var _data = null;
		//状态正确才处理
		if (xmlHttp.readyState==4 && xmlHttp.status == 200){
			_data = xmlHttp.responseXML.getElementsByTagName("tree")[0].childNodes; //获取所有子节点
		}

		return _data;
	}

	//根据获取的xmlTree信息，设置指定节点的子节点
	this.refreshItems = function(_parentId,_childId) {
		var parentNode = document.getElementById(_parentId);					//先获取父节点,肯定有

		//从数据库取出相关的值
		if (_parentId != _childId) {					//不相等，必定是有父节点和子节点，是读取、或增加
			_childrenData = this.getItemsFromDB(_parentId,"");
			var childBox = document.getElementById(_parentId + this._boxSuffix);	//检查是否有父节点的子容器

			if (!childBox){								//如没有，需生成
				childBox = document.createElement("div");           			//创建容器，称为box，用于存放所有子节点
				childBox.id = _parentId + this._boxSuffix;              		//容器的id规则为：在父节点id后加固定后缀
				childBox.className = "box";                             		//样式名称为box，div.box样式会对此节点生效
				//parentNode.appendChild(childBox);                      			//将子节点box放入父节点中
			}else{										//如有，清掉（临时处理方案）
				childBox.innerHTML = ""
				parentNode.removeChild(childBox);
			}
			
			var tmp = document.getElementById(_childId);
			if (tmp){
				var pnode = tmp.parentNode;
				pnode.removeChild(tmp);
			}
			//根节点，需先加上
			if (_parentId.toUpperCase() == "ROOT"){
				parentNode.appendChild(childBox); 
			}
		}else{									//相等，编辑某个节点
			_childrenData = this.getItemsFromDB(_parentId,_childId);
		}

		var child = _childrenData[0];
	    var child = null;										//声明child变量用于保存每个子节点
	    var itemid = null;										//声明itemid变量用于保存节点ID
	    var childType = null;                                  	//声明childType变量用于保存每个子节点类型
		var link = null;
		
	    for(var i=0; i<_childrenData.length; i++){ 				//循环创建每个子节点
	        child = _childrenData[i];
	        itemid = child.getAttribute("orid") ;
	        childType = child.getAttribute("itemtype");
			link = child.getAttribute("id");					//用link 来记录id_id
			
	        if (itemid == _parentId){									//父节点
		    	parentNode.removeChild(document.getElementById(_parentId + '_span_img'));
		    	parentNode.removeChild(document.getElementById(_parentId + '_span'));

		    	parentNode = GTree.createChildItem(parentNode , itemid , child.firstChild.data , childType , link);
		    	if (childType == "F"){							//目录时才需要改图标　和（重要）将子节点挂上去
		    		if (_parentId != _childId){
		    			parentNode.appendChild(childBox);						//将子节点重新附加上去
		    		}
		    		if (childBox){
		    			document.getElementById(_parentId + '_span_img').innerHTML = '<img height="9" src="../../images/minus.png" width="9">';
		    			childBox.style.display ="";
		    		}
		    	}else if(childType == "S"){						//注销时，中断循环，不需要挂子节点了
		    		i = _childrenData.length;
		    		//有子节点时才移除.
					if(document.getElementById(_parentId + this._boxSuffix)!=null){
			    		parentNode.removeChild(document.getElementById(_parentId + this._boxSuffix));
			    	}
		    	}
	        }else{														//子节点
	        	var node = document.createElement("div");				//每个节点对应一个新div
				node.id = itemid;										//节点的id值就是获取数据中的id
	        	node = GTree.createChildItem(node , itemid , child.firstChild.data , childType , link);
	        	
	        	childBox.appendChild(node);								//将子节点box放入父节点的子容器中
	        }
		}
	}

	String.prototype.Trim = function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	}

	//创建节点的页面
	this.createChildItem = function(itemobj , itemId , itemValue, itemType, itemLink) {
		var tempitem = null;
		var tmpHTML = itemobj.innerHTML;
		
		if (itemType == "M" ) {
			tempitem = document.createElement( "<span id=\'" + itemId + "_span_img\' class=\'itemMark\'></span>" );
			tempitem.innerHTML = "<img height=9 src=\'../../images/page.png\' width=9>";
			itemobj.appendChild(tempitem);
			tempitem = document.createElement( "<span id=\'" + itemId + "_span\' class=\'item\' itemtype=\'" + itemType + "\' onclick=\"GTree.clickItem(\'" + itemLink + "\',\'" +itemId + "\');\" ondblclick=\"GTree.dblclickItem(\'" + itemLink + "\',\'" +itemId + "\');\"></span>" )
			tempitem.innerHTML = itemValue;
			itemobj.appendChild(tempitem);
		}
		else if (itemType == "S") {
			tempitem = document.createElement( "<span id=\'" + itemId + "_span_img\' class=\'stopMark\'></span>" );
			tempitem.innerHTML = "<img height=9 src=\'../../images/stop.png\' width=9>";
			itemobj.appendChild(tempitem);
			tempitem = document.createElement( "<span id=\'" + itemId + "_span\' class=\'stop\' itemtype=\'" + itemType + "\' onclick=\"GTree.clickItem(\'" + itemLink + "\',\'" +itemId + "\');\" ondblclick=\"GTree.dblclickItem(\'" + itemLink + "\',\'" +itemId + "\');\"></span>" )
			tempitem.innerHTML = itemValue;
			itemobj.appendChild(tempitem);
		}
		else if (itemType == "F") {
			itemobj.innerHTML = '';
			tempitem = document.createElement( "<span id=\'" + itemId + "_span_img\' class=\'folderMark\' onclick=\"GTree.getChildren(\'" + itemId + "\');\"></span>" );
			if (tmpHTML != ''){
				tempitem.innerHTML = "<img height=9 src=\'../../images/minus.png\' width=9>";
			}else{
				tempitem.innerHTML = "<img height=9 src=\'../../images/plus.png\' width=9>";
			}
			itemobj.appendChild(tempitem);
			tempitem = document.createElement( "<span id=\'" + itemId + "_span\' class=\'folder\' itemtype=\'" + itemType + "\' onclick=\"GTree.clickItem(\'" + itemLink + "\',\'" +itemId + "\');\" ondblclick=\"GTree.dblclickItem(\'" + itemLink + "\',\'" +itemId + "\');\"></span>" )
			tempitem.innerHTML = itemValue;
			itemobj.appendChild(tempitem);
			itemobj.innerHTML = itemobj.innerHTML + tmpHTML;
		}
		//alert("test:" + itemId);
		//锚点,用于跳转
		var anchornode = document.createElement("<a name='"  + itemId + "'></a>");//" + itemId + "
		//anchornode.name = itemid;
		itemobj.appendChild(anchornode);
    	
		return itemobj;
	}

	//未用
	var GTreeClick = function(){
		var oEvent = arguments[0];
		var oTarget = oEvent.target || oEvent.srcElement;
		//alert(oTarget.id);
		
	}

	//点击叶子节点后的动作，//目前只是弹出对话框，可修改为链接到具体的页面
	this.clickItem = function(link,itemId) {
		var sel = document.getElementById("selecteditem");
		var olditem = sel.itemvalue;
		if (olditem != '') {		//不为空时表示存在上次点击的节点，需处理，否则不用
			var oldobj = document.getElementById(olditem + '_span');
			if(oldobj != null){
				if (oldobj.itemtype == 'F'){
					document.getElementById(olditem + '_span').className = "folder";
				}else if (oldobj.itemtype == 'M'){
					document.getElementById(olditem + '_span').className = "item";
				}else if(oldobj.itemtype == 'S'){
					document.getElementById(olditem + '_span').className = "stop";
				}
			}
		}
		//借用 sel 变量
		sel = document.getElementById(itemId + '_span');
		sel.className = "clickitem";
		document.getElementById("selecteditem").itemvalue = itemId;
	}
	
	//双击叶子节点后的动作,编辑
	this.dblclickItem = function(link,itemId) {
		showTab('tabs1','tabContent1');
		Edit(link);

//		var sel = document.getElementById("selecteditem");
//		var olditem = sel.itemvalue;
	}
	
	//用于创建XMLHttpRequest对象
	this.createXmlHttp=function() {
	    var xmlHttp = null;
	    //根据window.XMLHttpRequest对象是否存在使用不同的创建方式
	    if (window.XMLHttpRequest) {    
			xmlHttp = new XMLHttpRequest();                  //FireFox、Opera等浏览器支持的创建方式
	    } else {     
	       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); //IE浏览器支持的创建方式
	    }
	    return xmlHttp;
	}
}
	