<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.gwall.util.MBUtil"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<%@ taglib uri="/WEB-INF/GWallTag" prefix="g"%>
<%@ taglib uri="https://ajax4jsf.dev.java.net/ajax" prefix="a4j"%>
<%@ taglib uri="http://www.gwall.cn" prefix="gw"%>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%
    String srcPath = request.getContextPath();
%>
<script type='text/javascript' src='<%=srcPath%>/gwall/all.js'></script>
<link rel="stylesheet" type="text/css" href="<%=srcPath%>/gwall/all.css">
<script type="text/javascript" src="<%=srcPath%>/js/TailHandler.js"></script>
<script type="text/javascript" src="<%=srcPath%>/js/GtableJs.js"></script>
<script type="text/javascript" src="<%=srcPath%>/js/checkboxsel.js"></script>


<script type="text/javascript">
// 导出数据
function showOutput(tableid){
	var curTbl = $(tableid);
	var oXL = new ActiveXObject("Excel.Application");
	//创建AX对象excel
	var oWB = oXL.Workbooks.Add();
	//获取workbook对象
	var oSheet = oWB.ActiveSheet;
	//激活当前sheet
	var sel = document.body.createTextRange();
	sel.moveToElementText(curTbl);
	//把表格中的内容移到TextRange中
	sel.select();
	//全选TextRange中内容
	sel.execCommand("Copy");
	//复制TextRange中内容 
	oSheet.Paste();
	//粘贴到活动的EXCEL中
	oXL.Visible = true;
	//设置excel可见属性
}

// 导出excel数据
function reportExcel(tableid){

	create_auto_excel_form();
	var curTbl = $(tableid+"_table");
	
	
	//获得form
	var form = document.getElementById('auto_lord_excel');
	//alert(curTbl.innerHTML);
	remove_hidden_cell(curTbl);
	//excel_filter_base('<TABLE>'+curTbl.innerHTML);
	document.getElementById('lord_hidden_content_auto').value='<TABLE>'+curTbl.innerHTML;	
	
	form.submit();
}

//创建一个form
function create_auto_excel_form()
{
	var form = document.createElement('FORM');
	form.target = '_blank';
	form.action = '/Gwms_new/common/common_excel/common_excel.jsf';
	form.id = 'auto_lord_excel';
	form.method = 'post';
	form.name = 'form_excel';
	document.body.appendChild(form);
	var hidden1 = document.createElement('INPUT');
	hidden1.type = 'HIDDEN';
	hidden1.name = 'excelContent';
	hidden1.id = "lord_hidden_content_auto";
	form.appendChild(hidden1);
}

//过滤table信息
function excel_filter_base(obj)
{	
	var start = obj.indexOf('上页');
	while(true)
	{
		var temp = obj.indexOf('上页',start);
		if(temp != -1 && temp >start)
		{
			start = temp;
		}else
		{
			break;
		}		
	}
	if(start != -1)
	{
		obj = obj.substring(0,start-15) + '</tr></table>';
		obj = obj.replace('formsubmit(event);','#');
	}

	document.getElementById('lord_hidden_content_auto').value= obj;
}
//过滤隐藏单元格和CHECKBOX
function remove_hidden_cell(curTbl){
	//var gtable = document.getElementById(tableid+"_table");
	var gtable = curTbl;
	var rows = gtable.rows;
	//var cells = gtable.rows.item(0).cells.length;
	var tds = new Array();
	tds.push(rows[rows.length-1]);
	for(var i = 0;i<rows.length-1;i++){
		//alert(i+':'+rows[i].cells.length);
		for(var j=0;j<rows[i].cells.length;j++){
			var cell = rows[i].cells[j];
			if(cell.getAttribute('type')){
				if(cell.getAttribute("type").toUpperCase() == "HIDDEN" ||cell.getAttribute("type").toUpperCase() == "CHECKBOX"){
					//rows[i].deleteCell[j];
					tds.push(cell);
					//td.innerHTML = "";
					//td.parentNode.removeChild(td);  
				}
			}
		}
	}
	for(var i=0;i<tds.length;i++){
		tds[i].parentNode.removeChild(tds[i]);
	}
}
</script>