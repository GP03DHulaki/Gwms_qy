<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../include/include_imp.jsp" %>

<html>
	<head>
		<title>模块参数配置</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="模块参数配置">
		<link href="<%=request.getContextPath()%>/gwall/all.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="moduleset.js"></script>
		<script type="text/javascript"
			src='<%=request.getContextPath()%>/gwall/all.js'></script>
	</head>

	<body id=mmain_body>
		<div id=mmain>
			<f:view>
				<h:form id="list">
					<div id=mmain_opt>
						<a4j:commandButton id="saveButton" value="增加" onclick="addDiv();"
							onmouseover="this.className='a4j_over'"
							onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
							tabindex="5" />
					</div>
					<a4j:outputPanel id="outTable">
						<g:GTable gid="gtable2" gtype="grid" gversion="2"
							gselectsql="select a.moid , a.mona ,a.para, a.mdes,f.mona As pmmona,
									Case a.moty When 'SV' then '单据' else '模块' end As  moty
									From modu a
									Join mole b on a.moid = b.moid And b.mlty = 'S'
									left Join ( select m.moid , m.mona From modu m 
											Join mole l on m.moid = l.moid And m.moty in ('SF','UF','HF','MF')
											) f 
										On b.pmid = f.moid 
								Where a.moty in ('SM','SV','UM','HM','MM') "
							gpage="(pagesize = 50)"
							gcolumn="gcid = moid(headtext = selcheckbox,name = selcheckbox,width = 30,headtype = checkbox,align = center,type = checkbox,datatype=string);
								gcid = 0(headtext = 序号,name = rowid,width = 30,headtype = sort,align = center,type = text,datatype=string);
								gcid = -1(headtext = 操作,name = opt,width = 30,headtype = sort,align = center,type = link,linktype = script,typevalue = javascript:Edit('gcolumn[moid]'),value = 编辑);
								gcid = moid(headtext = 模块代码,name = moid,width = 80,headtype = sort,align = left,type = text);
								gcid = mona(headtext = 模块名称,name = mona,width = 120,headtype = sort,align = left,type = text);
								gcid = moty(headtext = 类型,name = moty,width = 40,headtype = sort,align = center,type = text);
								gcid = para(headtext = 运行参数,name = para,width = 100,headtype = sort,align = left,type = text);
								gcid = mdes(headtext = 模块描述,name = mdes,width = 250,headtype = sort,align = left,type = text);
								gcid = pmmona(headtext = 所属目录,name = pmmona,width = 100,headtype = sort,align = left,type = text);
								" />
					</a4j:outputPanel>
					<h:inputHidden id="sellist" value="#{moduMB.sellist}"></h:inputHidden>
				</h:form>

				<div id="editdiv" style="display: none">
					<h:form id="edit">
						<h:inputHidden id="selid" value="#{moduMB.selid}" />
						<div id=mmain_hide>
							<a4j:commandButton id="editbut" value="编辑"
								action="#{moduMB.getModuleinfo}"
								reRender="outTable,msg,editarea" oncomplete="edit_show();"
								requestDelay="50" />
						</div>
						<a4j:outputPanel id="editarea">
							<table align="center">
								<tr>
									<td bgcolor="#efefef">
										模块代码:
									</td>
									<td>
										<h:inputText id="moid"
											value="#{moduMB.bean.moid}"
											styleClass="inputtext"></h:inputText>
									</td>
									<td bgcolor="#efefef">
										所属目录:
									</td>
									<td>
										<h:selectOneMenu id="pmmo" 
											value="#{moduMB.bean.pmmoid}" styleClass="selectItem" >
											<f:selectItems value="#{moduMB.flist}" />
										</h:selectOneMenu>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										模块名称:
									</td>
									<td>
										<h:inputText id="mona"
											value="#{moduMB.bean.mona}"
											styleClass="inputtextedit"></h:inputText>
									</td>

									<td bgcolor="#efefef">
										运行参数:
									</td>
									<td>
										<h:inputText id="para"
											value="#{moduMB.bean.para}"
											styleClass="inputtextedit"></h:inputText>
									</td>
								</tr>
								<tr>
									<td bgcolor="#efefef">
										模块描述:
									</td>
									<td colspan=3>
										<h:inputTextarea id="mdes" styleClass="inputtextedit"
											value="#{moduMB.bean.mdes}" cols="65" />
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<h:inputHidden id="updateflag" value="#{moduMB.updateflag}" />
										<a4j:commandButton id="s" action="#{moduMB.save}"
											value="保存" reRender="outTable,msg"
											onclick="if(!formCheck()){return false};"
											oncomplete="endDo();" onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but" />
										<a4j:commandButton onmouseover="this.className='a4j_over'"
											onmouseout="this.className='a4j_buton'" styleClass="a4j_but"
											value="返回" onclick="hideDiv();" />

										<h:inputHidden id="msg" value="#{moduMB.msg}"></h:inputHidden>
									</td>
								</tr>
								<tr>

								</tr>
							</table>
						</a4j:outputPanel>
					</h:form>
				</div>
			</f:view>
		</div>
	</body>
</html>