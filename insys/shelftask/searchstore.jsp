<%@ page contentType="text/html; charset=UTF-8"%><%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>仓库档案管理</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="仓库档案管理">
		<script src="<%=request.getContextPath()%>/js/Gwalldate.js"></script>
<script type="text/javascript">
	function selectThis(parm1){
	is_IE = (navigator.appName == "Microsoft Internet Explorer");
	var callBack = null;  
	if(is_IE) {
		 callBack = window.dialogArguments;   
	}
	else {
	if (window.opener.callBack == undefined) {   
	    window.opener.callBack = window.dialogArguments;   
	}   
	callBack = window.opener.callBack;   
	}
		var vc_storehouseid = callBack.document.getElementById("edit:vc_storehouseid");
		if(vc_storehouseid!=null){
			vc_storehouseid.value=parm1;
		}
		window.close();	
    }
</script>
	</head>
	<body  id=mmain_body>
		<f:view>
			<div id=mmain>
				<h:form id="list">
					<a4j:outputPanel >
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
									gselectsql="SELECT id_id,ch_outid,vc_storehouseid,nv_storehousename,vc_factory,vc_area,vc_contact,vc_tel,vc_email,vc_address,ch_status,nv_remark,ch_flag,ch_ispda FROM gt_storehouse where ch_flag='1' "
									gpage="(pagesize = -1)" growclick="selectThis('gcolumn[3]')"
									gcolumn = "gcid = id_id(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = hidden,datatype=string);
										gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
										gcid = vc_storehouseid(headtext = 仓库编码,name = vc_storehouseid,width = 120,headtype = sort,align = left,type = text,datatype=string);								
										gcid = nv_storehousename(headtext = 仓库名称,name = nv_storehousename,width = 120,headtype = sort,align = left,type = text,datatype=string);
										gcid = vc_factory(headtext = 工厂,name = vc_factory,width = 120,headtype = sort,align = left,type = text,datatype=string);
										gcid = vc_area(headtext = 面积,name = vc_area,width = 120,headtype = sort,align = left,type = text,datatype=string);
										" />
					</a4j:outputPanel>
				</h:form>
			</div>
		</f:view>
	</body>
</html>