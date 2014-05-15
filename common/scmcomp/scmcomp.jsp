<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.gwall.view.base.CompMB"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
		CompMB ai = (CompMB) MBUtil.getManageBean("#{compMB}");
		if (request.getParameter("time") != null) {
			ai.initSK();
		}
		if (request.getParameter("retid") != null) {
			ai.setRetid(request.getParameter("retid"));
		}
		if (request.getParameter("retname") != null) {
			ai.setRetname(request.getParameter("retname"));
		}
 %>
<html>
	<head>
		<title></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="scmcomp.js"></script>
	</head>

	<body id=mmain_body >
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<h:panelGroup id="sp" rendered="#{compMB.LST}">
							<a4j:commandButton onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								id="sid" value="查询" type="button"
								action="#{compMB.search}" reRender="out_List"
								requestDelay="50" 
								onclick="startDo();" oncomplete="Gwin.close('progress_id');" />
							<a4j:commandButton value="重置"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
								onclick="clearData();" />
						</h:panelGroup>
					</div>
					<div id=mmain_cnd>
						名称:
						<h:inputText id="name" value="#{compMB.sk_obj.name}"
								styleClass="inputtextedit" />
					</div>
					<a4j:outputPanel id="out_List">
						<g:GTable gid="gtable" gtype="grid"
							gselectsql="Select id,name,eame,stat,rema From comp Where 1=1 #{compMB.searchSQL}"
							gpage="(pagesize = 20)" gversion="2" gdebug="false"
							growclick="selectThis('gcolumn[id]','gcolumn[name]')"
							gcolumn="gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
							 	gcid = id(headtext = id,name = id,width = 80,headtype = hidden,align = center,type = text,datatype=string);
							    gcid = name(headtext = 名称,name = szco,width = 80,headtype = sort,align = center,type = text,datatype=string);
							    gcid = eame(headtext = 英文名称,eame = szco,width = 80,headtype = sort,align = center,type = text,datatype=string);
						     	gcid = stat(headtext = 状态 ,name = stat,width = 60,headtype = sort, align = center , type = mask,typevalue={1:有效/0:注销} , datatype = string); 
						     	gcid = rema(headtext = 备注,name = rema,width = 120,headtype = sort,align = left , type = text , datatype = string);
						" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{compMB.sellist}"></h:inputHidden>
					<h:inputHidden id="retid" value="#{compMB.retid}" />
					<h:inputHidden id="retname" value="#{compMB.retname}" />
				</h:form>
			</f:view>
		</div>
	</body>
</html>