<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>已完成订单明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="已完成订单明细">
		<script type="text/javascript" src="carsche.js"></script>
		<script type="text/javascript">
			function setSkin(){
				parent.parent.Gskin.setSkinCss(document);
			}
		</script>
	</head>
	<body id=mmain_body onload="setSkin();" scroll="no">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id='mmain_opt'>
						<gw:GAjaxButton theme="b_theme" id="creBut" value="生成装车单"
							type="button" onclick="if(!checkSel()){return false};"
							oncomplete="parent.endCrePlan($('edit:msg').value);"
							reRender="output,renderArea" action="#{carScheMB.createPlan}"
							rendered="#{carScheMB.ADD}" />
						<a4j:commandButton id="sid" value="查询"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							action="#{carScheMB.searchEx}" type="button" reRender="output"
							rendered="#{carScheMB.LST}" requestDelay="50" />
						<a4j:commandButton value="重置"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							onclick="clearSearchKey();" rendered="#{carScheMB.LST}" />					
						<gw:GAjaxButton value="返回" theme="a_theme"
							onclick="parent.window.location.href='carsche.jsf';return false" />
					</div>
					<div id=mmain_cnd>
						<div>
							是否取消:
							<h:selectOneMenu id="iscancle" style="width:60px;"
								value="#{carScheMB.sk_iscancle}">
								<f:selectItem itemLabel="全部" itemValue="" />
								<f:selectItem itemLabel="是" itemValue="1" />
								<f:selectItem itemLabel="否" itemValue="0" />
							</h:selectOneMenu>
							到货地区:
							<h:selectOneMenu id="lico" style="width:130px;"
								value="#{carScheMB.sk_lico}">
								<f:selectItems value="#{lineMB.itemlist}" />
							</h:selectOneMenu>
						</div>
					</div>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
										gsort="progress"
										gselectsql="
											SELECT c.biid,c.chdt,c.orid,isnull(d.lina,'') AS lina#{carScheMB.grouparm} AS rece,c.buty,
											SUM(a.qty) AS qty,SUM(a.gqty) AS gqty,f.orna,c.rema,CONVERT(INT,(SUM(a.gqty))/(SUM(a.qty))*100) AS progress,
											SUM(ISNULL(b.volu,0)*a.qty) AS tavo,SUM(ISNULL(b.newe,0)*a.qty) AS tawe,c.stat,
											r.chdt as fhdt
											,CASE WHEN g.biid IS NOT NULL THEN '已取消' ELSE '' END AS iscancel,c.loco
											FROM #{carScheMB.mtable} c JOIN #{carScheMB.dtable} a ON c.biid=a.biid
											LEFT JOIN inve b ON b.inco=a.inco
											LEFT JOIN liin d on c.lico=d.lico
											join orga f on f.orid=c.orid
											left join v_so_cancel g on a.biid=g.biid
											left join rema r on r.soco=c.biid
											#{carScheMB.sqlPart} 
											WHERE c.#{carScheMB.gorgaSql} AND c.flag IN ('17','16') #{carScheMB.listKey} 
											AND c.biid NOT IN (SELECT obid FROM lobd) #{carScheMB.searchSQLEx}
											GROUP BY c.biid,c.chdt,c.orid,c.loco,isnull(d.lina,''),c.rema,c.buty,c.stat,r.chdt,g.biid,f.orna#{carScheMB.grouparm}
										"
										gpage="(pagesize = 200)"
										gcolumn="gcid = biid(headtext = selall,name = selall,width = 20,headtype = checkbox,align = center,type = checkbox,datatype=string);
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = progress(headtext =完成进度,name = percent,width = 90,headtype = sort,align = left,type = gprogress);
											gcid = -1(headtext = 操作,value= 查看,name = opt,width = 30,headtype = text,align = center,type = link,linktype = script,typevalue = javascript:EditBill('gcolumn[biid]','gcolumn[buty]'),datatype=string);
											gcid = orna(headtext = 组织架构,name = orna,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = biid(headtext = 出库计划,name = biid,width = 160,headtype = sort,align = left,type = text,datatype=string);
											gcid = loco(headtext = 快递单号,name = loco,width = 160,headtype = sort,align = left,type = text,datatype=string);
											gcid = iscancel(headtext = 是否取消,name = iscancel,width = 60,headtype = sort,align = center,type = text,datatype=string,bgcolor={gcolumn[iscancel]=已取消:red});
											gcid = stat(headtext = 是否复核,name = stat,width = 60,headtype = sort,align = left,type = mask,datatype=string,bgcolor={gcolumn[stat]=20:#66FF00},typevalue=0:未复核/10:全部复核异常/11:部分复核异常/20:复核通过/21:部分复核通过/31:已调整差异/61:已打包);
											gcid = -1(headtext = 是否称重,name = 8,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = lina(headtext = 路线,name = lina,width = 60,headtype = sort,align = left,type = text,datatype=string);
											gcid = rece(headtext = 收货方,name = rece,width = 150,headtype = sort,align = left,type = text,datatype=string);
											gcid = qty(headtext = 计划数量,name = qty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = gqty(headtext = 完成数量,name = gqty,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = tawe(headtext = 总重量,name = tawe,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = tavo(headtext = 总体积,name = tavo,width = 50,headtype = sort,align = right,type = text,datatype=number,dataformat={0.##},summary=this);
											gcid = chdt(headtext = 审核日期,name = chdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = fhdt(headtext = 复核日期,name = fhdt,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
											gcid = -1(headtext = 称重日期,name = 9,width = 110,headtype = sort,align = left,type = text,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
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