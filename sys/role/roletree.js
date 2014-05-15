var Tree = new function() {
    this._child = "_childrenbox";								//子节点容器后缀

    //初始化
    this.init = function() {
        var initNode = $('treeInit');   		//获取初始div
        var _node = document.createElement("div");              	//创建新div作为根节

        _node.id = "root";                                  		//根节点id
        _node.className = "root";                                  	//根节点样式
        initNode.appendChild(_node);                          		//将根节点加入初始div
        this.getChildren(_node.id,"R");
    }

    //获取给定节点的子节点
    this.getChildren = function(_parentId,_moduletype) {
        //获取页面子节点容器box
        var childBox = $(_parentId + this._child);	
        //如果子节点容器已存在则直接设置显示状态，否则从服务器获取子节点       	if (childBox) {
            var isHidden = (childBox.style.display == "none");      	//判断当前状是否隐藏
            childBox.style.display = isHidden?"block":"none";			//隐藏则显示，如果显示则变为隐藏
            //根据子节点的显示，修改父节点标识
            if (_moduletype == "F"){
            	var _parentNode = $(_parentId);           
            	_parentNode.firstChild.innerHTML = isHidden?"-":"+";       
            	_parentNode.firstChild.innerHTML = isHidden? '<img height="9" src="../../images/minus.png" width="9">': '<img height="9" src="../../images/plus.png" width="9">';
            }                  
        } else {
            var xmlHttp=this.createXmlHttp();                       	//创建XmlHttpRequest对象       
            
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                    //调用addChildren函数生成子节
                    Tree.addChildren(_parentId,_moduletype,xmlHttp.responseXML);
                }
            }
            
            //需要绑定角色
            var roleid;			if($("subform:roleid")){
            	roleid = $("subform:roleid").value;
            }
            var url = "roletree.jsp?parentId=" + _parentId + "&roleid=" + roleid + "&time="+new Date().getTime();
            xmlHttp.open("GET",url, false);
            xmlHttp.send(null);
        }
    }

    //根据获取的xmlTree信息，设置指定节点的子节点
    this.addChildren = function(_parentId,_moduletype, _data) {
		var _nodeBox;
        if (_moduletype == "F" ){										//非第一层（通过ID判断），增加新的BOX
	        _nodeBox = document.createElement("div");               	//创建一个容器，称为box，用于存放所有子节点
	    	_nodeBox.className = "box_detail";                          //父节点样式名称div.box，子节点时样式名称为box_detail，这里是父节点的子节点
        	_nodeBox.id = _parentId + this._child;                  	//容器的id规则为：在父节点id后加固定后缀
        	
			$(_parentId).appendChild(_nodeBox); 	//将子节点box放入父节点中 
			//通过 firstChild 定位，将"+"符号改为"-"符号
			$(_parentId).firstChild.innerHTML ='<img height="9" src="../../images/minus.png" width="9">';
		} else if (_moduletype =="M") {								//不同于普通的目录节点
	        _nodeBox = document.createElement("div");               	//创建一个容器，称为box，用于存放所有子节点
	    	_nodeBox.className = "operatelist";                        	//父节点样式名称div.box，子节点时样式名称为box_detail，这里是父节点的子节点
        	_nodeBox.id = _parentId + this._child;                  				//容器的id规则为：在父节点id后加固定后缀
        	
			$(_parentId).appendChild(_nodeBox); 	//将子节点box放入父节点中
		}else {															//第一层（通过_moduletype判断），取出已有的父节点
			_nodeBox = $(_parentId); 
		}

		if(_data.getElementsByTagName("tree").length!=0)
        {
	        var _children = _data.getElementsByTagName("tree")[0].childNodes;   //获取所有item节点
	        var _child = null;                                          		//声明_child变量用于保存每个子节点	        var _childType = null;                                      		//声明_childType变量用于保存每个子节点类型	        var nodeHTML = "";
	        //为M类型时产生权限显示图层
			if (_moduletype == "M") {
				_node = document.createElement("div");              			//每个节点对应一个新div
		        _node.className = "box_op"; 
		        _node.id = _parentId + "_op";	//_child.getAttribute("id");   	//节点的id值就是获取数据中的id属性
		        for(var i=0; i<_children.length; i++) {                 		//循环创建每个子节点		            _child = _children[i];
		            _childType = _child.getAttribute("moduletype")				//设置子节点类型
					var opid = _child.getAttribute("id");

		            //调用createItemHTML创建节点内容，除了OP（模块操作权限）类型外，其它都有下级
		            nodeHTML = nodeHTML + this.createItemHTML(opid, _childType, _child.firstChild.data,_child.getAttribute("flag"),_parentId);
		            if (i==4){ nodeHTML = nodeHTML + "<br>";}
		        }

		        _node.innerHTML = nodeHTML;
		        _nodeBox.appendChild(_node); 				                	//将创建好的节点加入子节点box
			} else {
		        for(var i=0; i<_children.length; i++) {                 		//循环创建每个子节点		            _child = _children[i];
		            _node = document.createElement("div");						//每个节点对应一个新div
		            _node.className = "box"; 
		            _node.id = _child.getAttribute("id");              				//节点的id值就是获取数据中的id属性
		            _childType = _child.getAttribute("moduletype")					//设置子节点类型	
		            //调用createItemHTML创建节点内容，除了OP（模块操作权限）类型外，其它都有下级
		            _node.innerHTML = this.createItemHTML(_node.id, _childType, _child.firstChild.data,_child.getAttribute("flag"),_parentId);
		            _nodeBox.appendChild(_node);                        //将创建好的节点加入子节点box
		        }
			}	        
	        // 处理CHECKBOX选定状态
            if (_moduletype != "R"){
	            this.setCheckbox(_parentId + this._child);
	        } else {
	        	this.setCheckbox('root');
	        }
		}
    }

 	String.prototype.Trim = function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	} 
	
    //创建节点的页面
    this.createItemHTML = function(itemId, itemType, itemData, itemflag,parentitemId) {
    	var retHTML;
    	//var checkHTML = "";
    	//if (itemflag == "2") {
    		//checkHTML = "checked='checked'";
    	//}
        //根据节点类型不同，返回不同的HTML片断
        if (itemType == "SF" || itemType == "UF" || itemType == "HF" ||itemType == "MF") {
			retHTML = '<span class="folderMark" onclick="Tree.getChildren(\'' + itemId + '\',\'F\')" ><img height="9" src="../../images/plus.png" width="9"></span>' +
				'<input type=checkbox id=' + itemId + '_checkbox itemid=\"' + itemId + '\" itemop=\"FM\" flag=\"' + itemflag + '\" onclick="Tree.ClickCheckBox(this,\'' + itemType + '\');" />' + 
				'<span class="folder" onclick="Tree.getChildren(\'' + itemId + '\',\'F\');" >' + itemData + '</span>';
        } else if (itemType == "SM" || itemType == "SV" || itemType == "UM" || itemType == "HM" || itemType == "MM") {
         	retHTML = '<span class="itemMark" onclick="Tree.getChildren(\'' + itemId + '\',\'M\')"><img height="9" src="../../images/page.png" width="9" ></span>' +
         		'<input type=checkbox id=' + itemId + '_checkbox itemid=\"' + itemId + '\" itemop=\"FM\" flag=\"' + itemflag + '\" onclick="Tree.ClickCheckBox(this,\'' + itemType + '\');" />' + 
				'<span class="item" onclick="Tree.getChildren(\'' + itemId + '\',\'M\');" >'+itemData+'</span>';
        } else if (itemType == "OP") {
        	if (itemflag == "2") {
        	 	retHTML = '<span id=' + itemId + '_span class="operatesel"><input type=checkbox id=' + itemId + '_checkbox checked="checked" itemid=\"' + parentitemId + '\" itemop=\"' + itemId + '\" flag=\"' + itemflag + '\" onclick="Tree.ClickCheckBox(this,\'' + itemType + '\');" />'+itemData+'</span>';
			} else {
				retHTML = '<span id=' + itemId + '_span class="operateunsel"><input type=checkbox id=' + itemId + '_checkbox itemid=\"' + parentitemId + '\" itemop=\"' + itemId + '\" flag=\"' + itemflag + '\" onclick="Tree.ClickCheckBox(this,\'' + itemType + '\');" />'+itemData+'</span>';
			}
        }
        return retHTML;
    }

    //用于创建XMLHttpRequest对象
    this.createXmlHttp=function() {
        var xmlHttp = null;
        //根据window.XMLHttpRequest对象是否存在使用不同的创建
        if (window.XMLHttpRequest) {          
           xmlHttp = new XMLHttpRequest();                  	//FireFox、Opera等浏览器支持的创建
        } else {         
           xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");	//IE浏览器支持的创建方式
        }
        return xmlHttp;
    }
    
	//用于onclick,所有点击CHECKBOX事件都触发，改变CHECKBOX的状态，需要一个自定义属性flag
	this.ClickCheckBox = function(obj,moduletype){
		
				
		if ($('subform:roleid').value == 0){
			alert('请先选择角色.');
			obj.checked=false;
			return
		}
		var _flag = obj.getAttribute("flag");
		
		switch(_flag){
			//当flag为0时,为未选中状态
			case '0':
				obj.checked=true;
				obj.indeterminate=false;
				obj.setAttribute("flag","2");
				this.ChangeCheckbox(obj,true);
				//为操作权限时，改变样式
				if (moduletype == "OP"){
					obj.parentElement.className = "operatesel";
				}
				break;
			//当flag为1时,为灰色未全选中状态			case '1':
				obj.checked=true;
				obj.indeterminate=false;
				obj.setAttribute("flag","2");
				this.ChangeCheckbox(obj,true);
				//为操作权限，改变样式
				if (moduletype == "OP"){
					obj.parentElement.className = "operatesel";
				}
				break;
			//当flag为2时,为全选中状态
			case '2':
				obj.checked=false;
				obj.indeterminate=false;
				obj.setAttribute("flag","0");
				this.ChangeCheckbox(obj,false);
				//为操作权限，改变样式
				if (moduletype == "OP"){
					obj.parentElement.className = "operateunsel";
				}
				break;
		}
		var rpvobj = $("subform:roleoperate");
		var roleid = $("subform:roleid").value;
		var itemid = obj.getAttribute("itemid");
		var itemop = obj.getAttribute("itemop");
		var flag = obj.getAttribute("flag");
		
		rpvobj.value = rpvobj.value + "\'\'" + roleid + "\'\',\'\'" + itemid + "\'\',\'\'" + itemop + "\'\',\'\'" + flag + "\'\'||";
		
		
		if($('ajaxbutton:saveoperate'))
			$('ajaxbutton:saveoperate').disabled=false;
	}

    //点击CHECKBOX后变换所属子节点的CHECKBOX状态
    this.ChangeCheckbox = function(obj,checked){
    	var el = obj.parentElement.id + this._child;
    	var elobj = $(el);
	    if(elobj == null){return false;}
	    
		var _checkboxchild = elobj.getElementsByTagName('input');
		
		for(var i = 0; i<_checkboxchild.length; i++){
			elobj.getElementsByTagName('input')[i].indeterminate = false;
			elobj.getElementsByTagName('input')[i].checked = checked;
			elobj.getElementsByTagName('input')[i].setAttribute("flag",checked? "2" : "0");
		}
	}
	
	//根据当前CHECKBOX的状态（非点击时），更改所属于当前CHECKBOX下的所有子CHECKBOX的状态
	this.setCheckbox =function(divobj){
	    var divobj = typeof(divobj)=="string"?$(divobj):divobj;
	    if(divobj == undefined){return false;}

		var pflag = 1;	//默认为1，即不干扰。一般只有ID为ROOT时才有效
		//在不是root节点的情况下，父节点中只有一个CHECKBOX，取出该CHECKBOX的属性就可以知道该级目录的应处于什么FLAG标志(即被点击过)	
		if (divobj.id != 'root') {
			//var temp = divobj.parentElement.getElementsByTagName('input');
			//肯定有一个			pflag = divobj.parentElement.getElementsByTagName('input')[0].getAttribute("flag");
		}
		
	    //相关DIV下的所有INPUT的TYPE为CHECKBOX，应该都是需处理的CHECKBOX
		var _checkbox = divobj.getElementsByTagName('input');
		for(var i = 0; i<_checkbox.length; i++){
			var el = divobj.getElementsByTagName('input')[i];
			var _flag = el.getAttribute("flag");
			if(_flag!=null)
			{
				if (pflag == 0 || pflag == 2) {
					_flag = pflag;
				}
				if(_flag=='0'){
					el.checked = false;
					el.indeterminate = false;
				} else  if (_flag=='1'){
					el.checked = true;
					el.indeterminate = true;
				} else if (_flag=='2'){
					el.checked = true;
					el.indeterminate = false;
				}
			}
		}
	}
}
