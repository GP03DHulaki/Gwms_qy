<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../include/include_imp.jsp"%>
<html>
	<head>
		<title>调拨计划明细</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="调拨计划明细">
		<script type="text/javascript" src="tran.js"></script>
		<script type="text/javascript">
			function init(){
				if(parent.Gskin){
					parent.Gskin.setSkinCss(document);
				}
			}
		</script>
		<style type="text/css">
			.gcolstyle {
				cursor: pointer;
				color: #0000FF;
			}
		</style>
	</head>
	<body id="mmain_body" onload="init();initEdit();initDetail();">
		<f:view>
			<h:form id="edit">
				<div id="mmain_opt">
					<a4j:outputPanel id="detailButton">
						<div id="mmain_opt">
							<a4j:commandButton id="addDButs" value="添加明細"
								onclick="showAddDetail();window.reload;"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" reRender="renderArea,outdetail"
								rendered="#{tranPlanMB.ADD && tranPlanMB.commitStatus}"
								requestDelay="50" />
							<a4j:commandButton id="saveDBut" value="保存明细"
								onmouseover="this.className='a4j_over1'"
								rendered="#{tranPlanMB.MOD && tranPlanMB.commitStatus}"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								onclick="if(!updateDetail()){return false};" type="button"
								action="#{tranPlanMB.updateDetail}"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								oncomplete="endUpdateDetail();" requestDelay="50" />
							<a4j:commandButton id="deleteDBut" value="刪除明細"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" action="#{tranPlanMB.deleteDetail}"
								onclick="if(!delDetail(gtable)){return false};"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								rendered="#{tranPlanMB.DEL && tranPlanMB.commitStatus}"
								oncomplete="endDelDetail();" requestDelay="50" />
							<a4j:commandButton id="impBut" value="唯品明细导入"
								onmouseover="this.className='a4j_over1'"
								onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
								type="button" requestDelay="50" onclick="showImport()"
								reRender="msg,headButton,detailButton,headmain,outdetail"
								rendered="#{tranPlanMB.IMP && tranPlanMB.commitStatus}" />
							<%-- 
								<a4j:commandButton id="delete0row" value="清除0数据行"
									onmouseover="this.className='a4j_over1'"
									onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
									type="button" action="#{tranPlanMB.clearDetail}"
									onclick="if(!clearDetail()){return false};"
									reRender="renderArea,outdetail,tableid"
									rendered="#{tranPlanMB.MOD && tranPlanMB.commitStatus}"
									oncomplete="endClearDetail();" requestDelay="50" />
								<gw:GAjaxButton id="impDBut" value="导入明细" theme="b_theme" 
									rendered="#{tranPlanMB.IMP && tranPlanMB.commitStatus}"
									onclick="showImport()" type="button" />
								Select a.roid,a.did,a.inco,a.qty,isnull(a.pric,0) as pric,a.oqty,a.iqty,a.gqty,b.inna,b.inty,b.inse,b.volu,b.newe,b.inpr,b.colo
										,ISNULL(s.uqty,0) AS uqty         
										From ppde a left join inve b On a.inco = b.inco  
										LEFT JOIN (SELECT inco,SUM(uqty) AS uqty FROM f_getstocknumbers('#{tranPlanMB.mbean.orid}') GROUP BY inco
											) s ON a.inco=s.inco
										Where a.biid = '#{tranPlanMB.mbean.biid}'	
								 --%>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td valign="top" id="td_outdetail">
								<a4j:outputPanel id="outdetail">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="true"
									gselectsql="
											Select a.roid,a.did,a.inco,a.qty,isnull(a.pric,0) as pric,a.oqty,a.iqty,a.gqty,
											b.inna,b.inse,b.colo,a.tqty
											From ppde a left join inve b On a.inco = b.inco  
											Where a.biid = '#{tranPlanMB.mbean.biid}'"
										gpage="(pagesize = -1)"
										gupdate="(table = {ppde},tablepk = {did})"
										gcolumn="gcid = did(headtext = selall,name = did,width = 35,align = center,type = checkbox ,headtype = #{tranPlanMB.commitStatus ? 'checkbox' : 'hidden'});
										gcid = 0(headtext = 行号,name = rowid,width = 40,align = center,type = text,headtype = string);
										gcid = roid(headtext = 行项目,name = roid,width = 0,align = left,type = text,headtype = hidden ,datatype = string);
										gcid = inco(headtext = 商品编码,name = inco,width = 130,align = left,type = text,headtype = sort ,datatype = string ,gscript={onclick=setBoxInco('gcolumn[inco]')&setlsDetailCol('gtable_inco',this.id)&iflocksubdetail.startDo()},gstyle=gcolstyle);
										gcid = inna(headtext = 商品名称,name = inna,width = 100,align = left,type = text,headtype = sort ,datatype = string);
										gcid = colo(headtext = 规格,name = colo,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = inse(headtext = 规格码,name = inse,width = 70,align = left,type = text,headtype = sort ,datatype = string);
										gcid = qty(headtext =  计划数量,name = qty,width = 65,align = right,type = #{tranPlanMB.commitStatus ? 'input' : 'text' },headtype= sort, datatype =number,dataformat=0.##,update=edit,summary=this,gscript={onkeypress=return isInteger(event)&&onchange=textChange(this)&&onkeydown=keyhandleupdown(this)});
										gcid = oqty(headtext = 已出库数,name = oqty,width = 65,align = right,type = text,headtype = sort ,datatype = number,dataformat=0);
										gcid = iqty(headtext = 已入库数,name = iqty,width = 65,align = right,type = text,headtype = sort ,datatype = number,dataformat=0);
										gcid = gqty(headtext = 已备数量,name = gqty,width = 65,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,bgcolor={gcolumn[qty]>gcolumn[gqty]:#FFFF00},summary=this);
										"/>
								</a4j:outputPanel>
							</td>
							<td valign="top" >
								<a4j:outputPanel id="oppifsd" >
									<iframe frameborder="0" marginwidth="100" onload="javascript:this.style.height=body.scrollHeight-10;this.startDo();"
										src="locksubdetail.jsf" width="400"
										id="iflocksubdetail" name="iflocksubdetail">
									</iframe>
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
							
						<div style="display: none;">
						<a4j:commandButton id="refBut" value="刷新列表" style="display:none;"
							reRender="outdetail" />
						<a4j:commandButton id="showRe" value="刷新全部" style="display:none;"
							reRender="msg,headButton,detailButton,headmain,outdetail,ifplandetail" />
						</div>
					<a4j:jsFunction name="setBoxInco" reRender="oppifsd" requestDelay="500" >
						<a4j:actionparam name="inco" assignTo="#{tranPlanMB.boxInco}" />
					</a4j:jsFunction>
					<a4j:jsFunction name="renderTable" reRender="outdetail" oncomplete="Gwallwin.winShowmask('FALSE');" />
					<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{tranPlanMB.msg}" />
							<h:inputHidden id="sellist" value="#{tranPlanMB.sellist}" />
							<h:inputHidden id="updatedata" value="#{tranPlanMB.updatedata}" />
							<h:inputHidden id="filename" value="#{tranPlanMB.fileName}" />
						</a4j:outputPanel>
					</div>
				</div>
			</h:form>
		</f:view>
	</body>
</html>