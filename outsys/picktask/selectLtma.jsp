<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.view.PickTaskMB"%>
<%@ include file="../../include/include_imp.jsp"%>
<%
	PickTaskMB ai = (PickTaskMB) MBUtil.getManageBean("#{pickTaskMB}");
	if (request.getParameter("time") != null) {
		ai.setSql("");

	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>备货计划</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src='picktask.js'></script>
		<script type="text/javascript">
	
		    function selectThis(parm1,parm2,parm3){
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				if(isGwin === false){
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
				}else{
					callBack = parent;
				} 	
		    	if ( callBack.document.getElementById("edit:soco") != null){
					callBack.document.getElementById("edit:soco").value=parm1;
				}
				if ( callBack.document.getElementById("edit:orid") != null){
					callBack.document.getElementById("edit:orid").value=parm2;
				}
				if ( callBack.document.getElementById("edit:whid") != null){
					callBack.document.getElementById("edit:whid").value=parm3;
				}
				if ( callBack.document.getElementById("edit:getWaho") != null){
					callBack.document.getElementById("edit:getWaho").onclick();
				}
				isGwin ? Gwin.close(document.GwinID) : window.close();
		    }
		    
			function formsubmit(){
				if (event.keyCode==13){
					var obj=$("edit:sid");
					obj.onclick();
					return true;
				}
			}
			
			function cleartext1(){
				var a = $("edit:id");
				var b = $("edit:oubi")
				if(a!=null){
					a.value="";
					a.focus();
				}
				if(b!=null){
					b.value=""
					b.focus();
				}
			}
		</script>


	</head>

	<body id=mmain_body onload="cleartext1()">
		<div id=mmain>
			<f:view>
				<h:form id="edit">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{pickTaskMB.seasql}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置"
							onclick="cleartext1();" onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="备货计划单:">
						</h:outputText>
						<h:inputText id="id" styleClass="inputtextedit" size="15"
							value="#{pickTaskMB.socoid}" onkeypress="formsubmit(event);" />
						<h:outputText value="出库订单:">
						</h:outputText>
						<h:inputText id="oubi" styleClass="inputtextedit" size="15"
							value="#{pickTaskMB.oubi}" onkeypress="formsubmit(event);" />
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="
											Select distinct v1.biid, v1.oubi ,v1.orid,V1.orna,V1.cuna,V1.whid,V1.soty, sum(IsNull(kykc,0)) as Total from 
											(Select distinct h.biid, b.oubi,b.baco,h.orid,o.orna,m.cuna,h.whid,h.soty   
												From ltde b inner join ltma h 
												on b.biid = h.biid 
												join orga o on h.orid = o.orid 
												left join obma m on b.oubi = m.biid 
												left join cuin i on m.cuid = i.cuid 
												left join obbm j on m.biid = j.biid
												where (b.qty-b.tqty) > 0 and h.flag >=11 and h.flag < 31 and j.biid is null and h.flag<>'100'
												and h.#{pickTaskMB.gorgaSql}  #{pickTaskMB.sql} 
											) V1
											left join (SELECT baco,Sum(uqty) as kykc FROM stnu WHERE whid IN (SELECT w.whid FROM waho w inner join ltma l on w.orid = l.orid
											where flag >=11 and flag < 31 and l.#{pickTaskMB.gorgaSql}  )
											Group by baco) V on V1.baco = v.baco
											group by V1.biid, V1.oubi, V1.Orid,V1.orna, V1.whid, V1.soty,V1.cuna 
											"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]','gcolumn[orid]','gcolumn[whid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);
									gcid = biid(headtext = 备货计划单,name = biid,width = 100,headtype = sort,align = left,type = text,datatype=string);
									gcid = oubi(headtext = 出库订单,name = oubi,width = 150,headtype = sort,align = left,type = text,datatype=string);
									gcid = orna(headtext = 组织架构,name = orna,width = 80,headtype = sort,align = left,type = text,datatype=string);
									gcid = cuna(headtext = 客户名称,name = cuna,width = 120,headtype = sort,align = left,type = text,datatype=string);
									gcid = soty(headtext = 来源类型,name = soty,width = 50,headtype = hidden,align = left,type = mask,typevalue=OUTORDER:出库订单/PURCHASERETURNPLAN:采购退货/TRANPLAN:调拨计划,datatype=string);
									gcid = Total(headtext = 可用库存数量,name = Total,width = 80,align = right,type = text,headtype= sort, datatype =number,dataformat=0.##,bgcolor={gcolumn[Total]>0:#FFFF33});
							" />
						</a4j:outputPanel>
					</div>
					<div id="hiddenDiv" style="display: none;">
						<h:inputHidden id="retid" value="#{pickTaskMB.retid}" />
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>