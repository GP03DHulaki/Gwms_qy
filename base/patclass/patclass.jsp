<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>款式档案</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="款式类别">
		<link href="<%=request.getContextPath()%>/css/gtab.css"	rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			function clickTab(tab,content,iframeid){
				if($(iframeid).src=="about:blank")
				$(iframeid).src=iframeid+'.jsf';
				showTab(tab,content)
			}
		</script>
	</head>
	<body id=mmain_body>
<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id="tabDiv">
					<div id="tabsHead">
						<a class="curtab" id="tabs1"
							href="javascript:clickTab('tabs1','tabContent1','theme')" title="系列主题">系列主题</a>
						<a class="tabs" id="tabs2"
							href="javascript:clickTab('tabs2','tabContent2','position');" title="款式定位">款式定位</a>
						<a class="tabs" id="tabs3"
							href="javascript:clickTab('tabs3','tabContent3','acttype');" title="活动类型">活动类型</a>
						<a class="tabs" id="tabs4"
							href="javascript:clickTab('tabs4','tabContent4','designgroup');" title="设计组">设计组</a>
						<a class="tabs" id="tabs5"
							href="javascript:clickTab('tabs5','tabContent5','season');" title="季节">季节</a>
						<a class="tabs" id="tabs6"
							href="javascript:clickTab('tabs6','tabContent6','price');" title="价格区间">价格区间</a>
						<a class="tabs" id="tabs7"
							href="javascript:clickTab('tabs7','tabContent7','prodmode');" title="生产方式">生产方式</a>
					</div>
					<div id="tabsBody">
						<div id="tabContent1" class="curtab_body">
							<iframe src="theme.jsf" id="theme" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent2" class="hidetab_body">
							<iframe id="position" src="about:blank" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent3" class="hidetab_body">
							<iframe id="acttype" src="about:blank" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent4" class="hidetab_body">
							<iframe id="designgroup" src="about:blank" width="100%" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent5" class="hidetab_body">
							<iframe width="100%" src="about:blank" id="season" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent6" class="hidetab_body">
							<iframe width="100%" src="about:blank" id="price" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
						<div id="tabContent7" class="hidetab_body">
							<iframe width="100%" src="about:blank" id="prodmode" height="100%" frameborder="0" padding="0" frameborder="0" onload="parent.Gskin.setSkinCss(null,this);"></iframe>
						</div>
					</div>
					</div>
				</h:form>
		</f:view>
		</div>	
	</body>
</html>