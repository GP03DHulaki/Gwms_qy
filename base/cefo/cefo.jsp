<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>合格证档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="合格证档案">
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id="tabDiv">
						<div id="tabsHead">
							<a class="curtab" id="tabs1"
								href="javascript:showTab('tabs1','tabContent1')" title="品名">品名</a>
							<a class="tabs" id="tabs2"
								href="javascript:showTab('tabs2','tabContent2');" title="号型">号型</a>
							<a class="tabs" id="tabs3"
								href="javascript:showTab('tabs3','tabContent3');" title="执行标准">执行标准</a>
							<a class="tabs" id="tabs4"
								href="javascript:showTab('tabs4','tabContent4');" title="安全符合类别">安全符合类别</a>
							<a class="tabs" id="tabs5"
								href="javascript:showTab('tabs5','tabContent5');" title="工厂">工厂</a>
							<a class="tabs" id="tabs6"
								href="javascript:showTab('tabs6','tabContent6');" title="等级">等级</a>
							<a class="tabs" id="tabs7"
								href="javascript:showTab('tabs7','tabContent7');" title="洗涤说明">洗涤说明</a>	
						</div>
						<div id="tabsBody">
							<div id="tabContent1" class="curtab_body">
								<iframe src="pnin.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent2" class="hidetab_body">
								<iframe src="mdin.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent3" class="hidetab_body">
								<iframe src="esin.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent4" class="hidetab_body">
								<iframe src="scti.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent5" class="hidetab_body">
								<iframe src="fcin.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent6" class="hidetab_body">
								<iframe src="plin.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
							<div id="tabContent7" class="hidetab_body">
								<iframe src="wain.jsf" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
							</div>
						</div>
					</div>
				</h:form>
			</f:view>
		</div>	
	</body>
</html>