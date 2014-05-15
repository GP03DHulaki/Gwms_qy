<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script>
			window.name='search';
	    </script>
		<base target="search" />
		<title>其他出库订单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">		
	</head>
	
		<script type="text/javascript">
		
		    function selectThis(parm1){				
				var isGwin = Gwin && document.GwinID;//是否Gwin方式弹出.
				isGwin ? parent.document.getElementById("edit:soco").value = parm1 : callBack.document.getElementById("edit:soco").value=parm1;
				isGwin ? Gwin.close(document.GwinID) : window.close();	
			 }

			function cleartext(){
				var a = $("list:socoid");
				if(a!=null){
					a.value="";
					a.focus();
				}
			}
		</script>
	
	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1"
							id="sid" value="查询" type="button" action="#{returnPutawayMB.searchSoco}"
							reRender="output" requestDelay="50" />
						<a4j:commandButton type="button" value="重置" onclick="cleartext();"
							onmouseover="this.className='a4j_over1'"
							onmouseout="this.className='a4j_buton1'" styleClass="a4j_but1" />
					</div>
					<div id=mmain_cnd>
						<h:outputText value="销售退货上架单:">
						</h:outputText>
						<h:inputText id="socoid" styleClass="inputtextedit" size="15"
							value="#{returnPutawayMB.mbean.soco}"/>
					</div>
					<div id=mmain_free>
						<a4j:outputPanel id="output">
							<g:GTable gid="gtable" gtype="grid" gversion="2"
								gselectsql="SELECT a.biid,a.crdt FROM rrma a 
								where 1=1 #{returnPutawayMB.searchSQL}"
								gwidth="550" gpage="(pagesize = 20)" gdebug="false"
								growclick="selectThis('gcolumn[biid]')"
								gcolumn="gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = text,align = center,type = text,datatype=string);									
									gcid = biid(headtext = 销售订单,name = biid,width = 200,headtype = sort,align = left,type = text,datatype=string);
									gcid = crdt(headtext = 创建时间,name = crdt,width = 110,align = left,type = text,headtype = sort,datatype=datetime,dataformat=yyyy-MM-dd HH:mm);
							" />
						</a4j:outputPanel>
					</div>
				</h:form>
			</f:view>
		</div>
	</body>
</html>