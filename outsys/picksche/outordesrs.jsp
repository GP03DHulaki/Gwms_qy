<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>出库订单列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="出库订单列表">
		<script type="text/javascript" src="entruckplan.js"></script>
	</head>
	<body>
		<f:view>
			<h:form id="edit">
				<div id=mmain_opt>
					<a4j:outputPanel id="mainBut" rendered="true">
						<a4j:commandButton value="添加订单" 
							onclick="selOutOrder('#{pickscheMB.mbean.orid}','#{pickscheMB.mbean.soty}');" 
							oncomplete="parent.document.getElementById('edit:refBut').onclick();"
							reRender="outorder" styleClass="a4j_but1"
							rendered="#{pickscheMB.MOD && pickscheMB.commitStatus}"
							onmouseover="this.className='a4j_over1'" 
							onmouseout="this.className='a4j_buton1'"  />
							
						<a4j:commandButton value="删除订单" 
							onclick="if(!selectFromId('gtable2')){return false};" action="#{pickscheMB.deleteDetail}"
							reRender="renderArea,outorder" 
							rendered="#{pickscheMB.MOD && pickscheMB.commitStatus}"
							onmouseover="this.className='a4j_over1'" oncomplete="endDelOrder();"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />	
					</a4j:outputPanel>	
				</div>	
				<a4j:outputPanel id="outorder">
					<g:GTable gid="gtable2" gtype="grid" gversion="2"
						gdebug="false"
						gselectsql="
							SELECT DISTINCT a.id,a.biid,a.cuid,a.flag,a.crus,a.crna,a.chus,a.chna,a.crdt,a.chdt,a.tavo,a.orid,a.tanu,
							a.tawe,a.orad,a.rema,b.cuna FROM obma a LEFT JOIN cuin b ON a.cuid=b.cuid 
							Join ltde c on a.biid=c.oubi WHERE c.biid= '#{pickscheMB.mbean.biid}' "
						gpage="(pagesize = -1)"
						gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = #{pickscheMB.commitStatus ? 'checkbox' : 'hidden'},align = center,type = checkbox,datatype=string);
							gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
							gcid = biid(headtext = 出库订单,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
							gcid = cuna(headtext = 客户名称,name = cuna,width = 120,headtype = sort,align = left,type = text,datatype=string);
							gcid = chdt(headtext = 审核时间,name = chdt,width = 105,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							gcid = tavo(headtext = 总体积,name = tavo,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tawe(headtext = 总重量,name = tawe,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = tanu(headtext = 总数量,name = tanu,width = 60,headtype = sort,align = left,type = text,datatype=number,dataformat={0.######});
							gcid = orad(headtext = 详细地址,name = orad,width = 180,headtype = sort,align = left,type = text,datatype=string);
							gcid = rema(headtext = 备注,name = rema,width = 130,headtype = sort,align = left,type = text,datatype=string);
					" />
				</a4j:outputPanel>
				
				<div style="display: none;">
					<a4j:outputPanel id="renderArea">
						<h:inputHidden id="msg" value="#{pickscheMB.msg}" />
						<h:inputHidden id="sellist" value="#{pickscheMB.sellist}" />
					</a4j:outputPanel>
				</div>
			</h:form>
			
			<div id="errmsg" style="display: none">
				<div id=mmain_cnd align="left">
					<span id="mes" style="color: red;"></span>
					<div align="center">
						<button type="button" onclick="Gwallwin.winClose();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" class="a4j_but">
							关闭
						</button>
					</div>
				</div>
			</div>
		</f:view>
	</body>
</html>