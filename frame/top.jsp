<%@page contentType="text/html;charset=GBK"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<html>
	<head>
		<script>parent.Gskin.setSkinCss(document);</script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/skin/skinButton.css">
	</head>

	<SCRIPT language=JavaScript>
			var JE_CURENTTIME = new Date();		
			function timeview(){
				timestr=JE_CURENTTIME.toLocaleString();
			  	timestr=timestr.substr(timestr.indexOf(" "));
			  	time_area.innerHTML = timestr;
			  	JE_CURENTTIME.setSeconds(JE_CURENTTIME.getSeconds()+1);
			  	window.setTimeout( "timeview()", 1000 );
			}
			today=new Date();
			function initArray(){
			this.length=initArray.arguments.length
			for(var i=0;i<this.length;i++)
			this[i+1]=initArray.arguments[i] }
			var d=new initArray(
			"������",
			"����һ",
			"���ڶ�",
			"������",
			"������",
			"������",
			"������");
			function edit(v) {
				parent.rightFrame.location.href=v;
			}		
			function Td_Over(Element1){
			    Element1.className = 'TdOver';
			}
			function Td_Out(Element1){
				Element1.className = 'TdOut';
			}
			function Td_Down(Element1){
			    Element1.className = 'TdDown';
			}
			//�л�Ƥ��
			function setSkin( obj ){
				var skin = obj.className;
				var skinName = "";
				if(skin.charAt(skin.length-1) == '2'){
					skin = skin.substring(0,skin.length-1);
				}
				skinName = skin.split("skin_")[1];
				var upskin = parent.Gskin.getCookie("GwallSkin");
				if(upskin){
					if(upskin == skin) return;
					document.getElementById("a"+upskin).className = upskin;
				}else{
					upskin = "skin_blue";
				}
				document.getElementById("skin").href = parent.Gskin.skinPath+"/skin/"+skinName+"/"+skin+".css";
				obj.className = skin+"2";
				parent.Gskin.upDateCookie("GwallSkin", skin, 365);
				parent.Gskin.updateSkin(upskin,skin);
			}
			function reloadContext(){
				var obj = parent.Gmdi.focusObj;
				var iframe = parent.document.getElementById(obj.id.split("_")[0]+"_frame");
				iframe.src = iframe.src;
			}
			function loadSkin(){
				parent.Gskin.addSkinBtn(document);
			}
	</SCRIPT>
	<body leftmargin="0" topmargin="0" onload="loadSkin();" onselectstart="return false" onclick="parent.closeShowMenu();">
		<f:view>
			<h:form id="edit">
				<div class="header_content">
					<div class="logo">&nbsp;<img src="../images/Logo.png" height="45" alt="����Ƽ�"/></div>
					<div style="border: 0px solid; float: left ;  height: 50px; line-height: 50px; font-size: 20px;margin-left: 50px;">
						<B><%=session.getAttribute("orna")%></B>
					</div>
	 				<div class="right_nav">
			    		<div class="text_left">
			    			&nbsp;&nbsp;
						      	<a href="javascript:history.go(-1)">
								<img src="../images/ctr-01.gif" border="0" alt="����"/></a>
								<a href="javascript:history.go(-1)"><font color="#FFFFFF">����</font></a>
								<a href="javascript:history.go(1)">
								<img src="../images/ctr-02.gif" border="0" alt="ǰ��"/></a>
								<a href="javascript:history.go(1)"><font color="#FFFFFF">ǰ��</font></a>
								<a href="javaScript:parent.document.location.reload()">
								<img src="../images/ctr-03.gif" border="0" alt="ˢ��"></a>
								<a href="javaScript:reloadContext();"><font color="#FFFFFF">ˢ��</font></a>
								<div id="skin_div" class="skin"></div>
		       			</div>
						<div class="text_right">
							<ul class="nav_return">
							  	<li class="change"><a href="../sys/changeUser.jsf"><font color="#FFFFFF">�����û�</font></a></li>
						        <li class="exit"><a href="../sys/exit.jsf" ><font color="#FFFFFF">�˳�</font></a></li>
						        <!-- 
						        <li class="b3"><a href="#">����</a></li>
						         -->
							</ul>
						</div>
						<div class="clear"></div>
	 				</div>
	 				<div class="clear"></div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>
