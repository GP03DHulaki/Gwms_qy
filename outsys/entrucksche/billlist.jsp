<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>备货调度</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="备货调度">
		<script type="text/javascript" src="entrucksche.js"></script>
	</head>

	<body id='mmain_body'>
		<div id='mmain_nav'>
			<font color="#000000">出库处理&gt;&gt;</font>
			<font color="#000000">装车处理&gt;&gt;</font>
			<b>订单筛选列表</b>
			<br>
		</div>
		<div id='mmain'>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<a4j:outputPanel id="queryButs" rendered="#{entruckScheMB.LST}">
							<gw:GAjaxButton theme="b_theme" id="creBut" value="生成备货计划"
								type="button" onclick="if(!checkSel()){return false};"
								oncomplete="endCrePlan();" reRender="output,renderArea"
								action="#{entruckScheMB.createPlan}" />
							<gw:GAjaxButton value="返回" theme="a_theme"
								onclick="window.close();" />	
						</a4j:outputPanel>
					</div>

				
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT a.id,a.biid,a.chdt,a.orid,e.orna,a.orad,a.tawe,a.tavo,a.tanu,a.gead,a.lico,
											a.lpco,a.cuid,b.cuna,c.gena,d.lina FROM obma a LEFT JOIN cuin b 
											ON a.cuid=b.cuid LEFT JOIN gein c ON a.gead=c.geid
											LEFT JOIN liin d on a.lico=d.lico 
											LEFT JOIN orga e on a.orid = e.orid 
											WHERE a.flag in ('11') AND a.cuid like '#{entruckScheMB.cuid}'
											AND a.lico like '#{entruckScheMB.lico}' AND a.lpco like '#{entruckScheMB.lpco}'
											#{entruckScheMB.searchSQL}"
										gpage="(pagesize = -1)"
										gcolumn="gcid = id(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = biid(headtext = 出库订单,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = lpco(headtext = 承运商,name = lpco,width = 80,headtype = sort,align = left,type = text,datatype=string);
											gcid = cuna(headtext = 客户名称,name = cuna,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = lina(headtext = 线路,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = tavo(headtext = 总体积,name = tavo,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = tawe(headtext = 总重量,name = tawe,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = tanu(headtext = 总数量,name = tanu,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0},summary=this);
											gcid = chdt(headtext = 审核日期,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<%--
					--%>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{entruckScheMB.sellist}" />
							<h:inputHidden id="msg" value="#{entruckScheMB.msg}" />
						</a4j:outputPanel>
					</div>
				</h:form>

				<div id="errmsg" style="display: none">
					<div id=mmain_cnd align="left">
						<span id="mes" style="color: red;"></span>
						<div align="center">
							<button type="button" onclick="clickClose();"
								onmouseover="this.className='a4j_over'"
								onmouseout="this.className='a4j_buton'" class="a4j_but">
								关闭
							</button>
						</div>
					</div>
				</div>

			</f:view>
		</div>
	</body>
</html>