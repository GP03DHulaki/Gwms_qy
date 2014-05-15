<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>未完成订单明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="未完成订单明细">
		<script type="text/javascript" src="carsche.js"></script>
	</head>
	<body id='mmain_body'>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<gw:GAjaxButton theme="b_theme" id="creBut" value="生成装车单"
							type="button" onclick="if(!checkSel()){return false};"
							oncomplete="parent.endCrePlan($('edit:msg').value);"
							reRender="output,renderArea" action="#{carScheMB.createPlan}"
							rendered="#{carScheMB.ADD}" />
						<gw:GAjaxButton value="返回" theme="a_theme"
							onclick="parent.window.location.href='carsche.jsf'" />
					</div>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="
											SELECT c.biid,c.chdt,c.orid,d.lina#{carScheMB.grouparm} AS rece,c.buty,
											SUM(a.qty) AS qty,SUM(a.gqty) AS gqty,f.orna,
											SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe,c.rema 
											FROM #{carScheMB.mtable} c JOIN #{carScheMB.dtable} a ON c.biid=a.biid
											LEFT JOIN inve b ON b.inco=a.inco
											LEFT JOIN liin d on c.lico=d.lico
											join orga f on f.orid=c.orid
											#{carScheMB.sqlPart} 
											WHERE c.#{carScheMB.gorgaSql} AND c.flag ='16' #{carScheMB.listKey} 
											GROUP BY c.biid,c.chdt,c.orid,c.rema,d.lina,c.buty,f.orna#{carScheMB.grouparm}
										"
										gpage="(pagesize = -1)"
										gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
										gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
										gcid = -1(headtext = 操作,value= 查看,name = opt,width = 30,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:EditBill('gcolumn[biid]','gcolumn[buty]'),datatype=string);
										gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
										gcid = biid(headtext = 计划单号,name = biid,width = 120,headtype = sort,align = left,type = text,datatype=string);
										gcid = lina(headtext = 路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
										gcid = rece(headtext = 收货方,name = rece,width = 150,headtype = sort,align = left,type = text,datatype=string);
										gcid = qty(headtext = 计划数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
										gcid = gqty(headtext = 完成数量,name = gqty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
										gcid = tawe(headtext = 总重量,name = tawe,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
										gcid = tavo(headtext = 总体积,name = tavo,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
										gcid = chdt(headtext = 审核日期,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
										gcid = rema(headtext = 备注,name = rema,width = 206,headtype = sort,align = left,type = text,datatype=string);
									" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="sellist" value="#{carScheMB.sellist}" />
							<h:inputHidden id="msg" value="#{carScheMB.msg}" />
							<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
								reRender="output" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>