<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<script>
       window.name='search';
    </script>
		<base target="search" />

		<title>采购交货单号</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="<%=request.getContextPath()%>/css/style.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src='<%=path%>/js/Gbase.js'></script>
		<script>
  <!--
    function selectThis(posendno,vendorname,deptid,deptname){	
   // alert(posendno+vendorname+deptid+deptname);
    	//来源采购交货单
	is_IE = (navigator.appName == "Microsoft Internet Explorer");
	var callBack = null;  
	if(is_IE) {
		 callBack = window.dialogArguments;   
	}
	else {
	if (window.opener.callBack == undefined) {   
	    window.opener.callBack = window.dialogArguments;   
	}   
	callBack= window.opener.callBack;   
	}
    	if(callBack.document.getElementById("list:nv_fromvoucherid")!=null){
    		callBack.document.getElementById("list:nv_fromvoucherid").value=posendno; 
    	}
    	//供应商名称

    	if(callBack.document.getElementById("list:nv_vendorname")!=null){
    		callBack.document.getElementById("list:nv_vendorname").value=vendorname;
    	}
    	//部门编码
    	if(callBack.document.getElementById("list:vc_deptid")!=null){
    		callBack.document.getElementById("list:vc_deptid").value=deptid; 
    	}
		//部门名称
		if(callBack.document.getElementById("list:nv_deptname")!=null){
    		callBack.document.getElementById("list:nv_deptname").value=deptname; 
    	}
    	
		window.close();
    } 
    function formsubmit()
	{
		if (event.keyCode==13)
		{
			var obj=$("list:sid");
			obj.onclick();
			return true;
		}
	}
  -->
  </script>
	</head>
	<body>
		<f:view>
			<h:form id="edit">
				<table align="center" width=100%>
					<tr>
						<td align="right">

						</td>
					</tr>
					<tr>
						<td align="center">
							<a4j:outputPanel id="output">
								<g:GTable gid="gtable" gversion="2" gtype="grid"
									gselectsql="
									SELECT a.vc_voucherid,a.nv_fromvoucherid,a.vc_vendorid,c.nv_vendorname,isnull(b.vc_deptid,'') as vc_deptid,isnull(d.nv_deptname,'') as nv_deptname
									FROM gt_posendmain a 
									INNER JOIN gt_pomain b ON a.nv_fromvoucherid=b.vc_voucherid 
									INNER JOIN gt_vendor c ON a.vc_vendorid=c.vc_vendorid
									LEFT JOIN gt_dept d ON b.vc_deptid=d.vc_deptid  
									WHERE 1=1 and a.ch_flag<>'04'"
									gpage="(pagesize = 20)"
									growclick="selectThis('gcolumn[1]','gcolumn[4]','gcolumn[5]','gcolumn[6]')"
									gcolumn="
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
										gcid = vc_voucherid(headtext = 采购交货单,name = vc_voucherid,width = 100,headtype = sort,align = center,type = text,datatype=string);
										gcid = nv_fromvoucherid(headtext = 采购订单,name = nv_fromvoucherid,width = 100,headtype = sort,align = center,type = text,datatype=string);
										gcid = vc_vendorid(headtext = 供应商编码,name = vc_vendorid,width = 100,headtype = sort,align = center,type = text,datatype=string);
										gcid = nv_vendorname(headtext = 供应商名称,name = nv_vendorname,width = 150,headtype = sort,align = center,type = text,datatype=string);
										gcid = nv_deptname(headtext = 部门名称,name = nv_deptname,width = 80,headtype = sort,align = center,type = text,datatype=string);
									" />
							</a4j:outputPanel>
						</td>
					</tr>
					<tr>
						<td align=center>
							<input type=button class='a4j_over' value='返回'
								onclick='window.close()' />
							<input type=button class='a4j_over' value='取消'
								onclick='selectThis("","","","");' />
						</td>
					</tr>
				</table>
			</h:form>
		</f:view>
	</body>
</html>
