<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>总任务界面</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="总任务界面">
		<script type="text/javascript" src="totalTaskList.js"></script>
	</head>
	<body id=mmain_body>
		<div id=mmain_nav>
			<font color="#000000">统计报表&gt;&gt;</font>
			<b>总任务界面</b>
			<br>
		</div>
		<div id=mmain>
			<f:view>
				<h:form id="edit">
				<div style="display: none;">
						<a4j:outputPanel id="renderArea">
							<h:inputHidden id="msg" value="#{totalTaskMB.msg}" />
							<h:inputHidden id="gsql" value="#{totalTaskMB.gsql}" />
							<h:inputHidden id="outPutFileName"
								value="#{totalTaskMB.outPutFileName}" />
						</a4j:outputPanel>
				   </div>
					<div id=mmain_opt>
						<a4j:outputPanel id="queryButs">
							<gw:GAjaxButton theme="a_theme" id="sid" value="查询" type="button"
								onclick="startDo();" oncomplete="Gwallwin.winShowmask('FALSE');"
								reRender="output" action="#{totalTaskMB.search}" />
							<gw:GAjaxButton value="重置" theme="a_theme"
								onclick="textClear('edit','biid,type');" />
								<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="excel" value="导出EXCEL" type="button"
							action="#{totalTaskMB.export}"
							reRender="msg,outPutFileName" onclick="excelios_begin('gtable');"
							oncomplete="excelios_end();" requestDelay="50" />
						</a4j:outputPanel>
					</div>
					<a4j:outputPanel id="queryForm">
						<div id="mmain_cnd">
							任务批次号:
							<h:inputText id="biid" styleClass="datetime" size="10"
								value="#{totalTaskMB.biid}"/>
							任务类型:
							<h:selectOneMenu id="type" value="#{totalTaskMB.type}">
								<f:selectItem itemLabel="" itemValue="" />
								<f:selectItem itemLabel="拣货任务" itemValue="PICKTASK" />
								<f:selectItem itemLabel="补货任务" itemValue="shelftask" />
							</h:selectOneMenu>
						</div>
					</a4j:outputPanel>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<a4j:outputPanel id="output">
									<g:GTable gid="gtable" gtype="grid" gversion="2" gdebug="false"
										gselectsql="select a.moid,a.biid,a.flag,a.usid,a.usna,a.whid,a.tale,a.crdt,a.shdt,ISNULL(b.rate,c.rate) as rate from dbo.F_GetTaskInfo() a
												left join (
												SELECT SUM(a.fqty) as fqty,ISNULL(b.qty,0) as qty,a.biid,(ISNULL(b.qty,0)/SUM(a.qty))*100 AS rate 
												FROM ptde a LEFT JOIN 
												(
												SELECT SUM(b.qty) AS qty,a.soco FROM pkma a JOIN pkde b ON a.biid=b.biid
												GROUP BY a.soco) b ON a.biid=b.soco
												GROUP BY ISNULL(b.qty,0),a.biid
												) b on a.biid=b.biid and a.moid='PICKTASK'
												left join(
												select a.biid ,sum(b.fqty)/sum(b.qty)*100 as rate from stma a left join stde b on a.biid=b.biid group by a.biid
												) c on c.biid= a.biid and a.moid='shelftask'
										WHERE 1=1 #{totalTaskMB.searchSQL}"
										gpage="(pagesize = 30)"
										gcolumn="
											gcid = 0(headtext = 行号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
											gcid = moid(headtext = 任务类型,name = moid,width = 70,headtype = sort,align = left,type = mask,datatype=string,typevalue=PICKTASK:拣货/shelftask:补货);
											gcid = biid(headtext = 任务批次号,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
											gcid = crdt(headtext = 生成日期,name = crdt,width = 70,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd);
											gcid = tale(headtext = 优先级别,name = tale,width = 70,headtype = sort,align = left,type = text,datatype=string);
											gcid = flag(headtext = 是否分配,name = flag,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = usna(headtext = 操作人员,name = usna,width = 120,headtype = sort,align = left,type = text,datatype=string);
											gcid = shdt(headtext = 分配时间,name = shdt,width = 120,headtype = sort,align = left,type = text,datatype=string,dataformat=yyyy-MM-dd);
											gcid = rate(headtext = 分拣完成进度,name = rate,width = 120,headtype = sort,align = left,type = gprogress,datatype=number,dataformat=0.##);
											" />
								</a4j:outputPanel>
							</td>
						</tr>
					</table>
				</h:form>
			</f:view>
		</div>
	</body>
</html>
