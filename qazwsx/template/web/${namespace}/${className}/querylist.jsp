<%@page import="${basepackage}.model.*" %>
<#include "/macro.include"/> 
<#include "/custom.include"/> 
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags/simpletable" prefix="simpletable"%>
<%@ include file="/commons/taglibs.jsp" %>

<rapid:override name="head">
	<title><%=${className}.TABLE_ALIAS%> 查询</title>
	
	<link href="<c:url value="/widgets/simpletable/simpletable.css"/>" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="<c:url value="/widgets/simpletable/simpletable.js"/>"></script>
	
	<script type="text/javascript" >
		$(document).ready(function() {
			// 分页需要依赖的初始化动作
			window.simpleTable = new SimpleTable('queryForm','<@jspEl 'page.thisPageNumber'/>','<@jspEl 'page.pageSize'/>','<@jspEl 'pageRequest.sortColumns'/>');
		});
	</script>
</rapid:override>

<rapid:override name="content">
	<form id="queryForm" name="queryForm" action="<c:url value="${actionBasePath}/querylist.do"/>" method="post" style="display: inline;">
	<div class="queryPanel">
			<div class="serchHead"><b><%=${className}.TABLE_ALIAS%>搜索</b></div>
			<table class="querytable">
				<#list table.notPkColumns?chunk(4) as row>
				<tr>	
					<#list row as column>
					<#if !column.htmlHidden>	
					<td class="tdLabel"><%=${className}.ALIAS_${column.constantName}%></td>		
					<td>
						<#if column.isDateTimeColumn>
						<input  class="queryInput" value="<fmt:formatDate value='<@jspEl "query."+column.columnNameLower+'Begin'/>' pattern='<%=${className}.FORMAT_${column.constantName}%>'/>" onclick="WdatePicker({dateFmt:'<%=${className}.FORMAT_${column.constantName}%>'})" id="${column.columnNameLower}Begin" name="${column.columnNameLower}Begin"   />
						<input  class="queryInput" value="<fmt:formatDate value='<@jspEl "query."+column.columnNameLower+'End'/>' pattern='<%=${className}.FORMAT_${column.constantName}%>'/>" onclick="WdatePicker({dateFmt:'<%=${className}.FORMAT_${column.constantName}%>'})" id="${column.columnNameLower}End" name="${column.columnNameLower}End"   />
						<#else>
						<input  class="queryInput" value="<@jspEl "query."+column.columnNameLower/>" id="${column.columnNameLower}" name="${column.columnNameLower}" maxlength="${column.size}"  class="${column.noRequiredValidateString}"/>
						</#if>
					</td>
					</#if>
					</#list>
				
					<#if table.notPkColumns?size%4 == 3 && row_index+1 == (table.notPkColumns?size+1)/4 >
						<td class="tdLabel">&nbsp;</td><td>&nbsp;</td>
					</#if>
					<#if table.notPkColumns?size%4 == 2 && row_index+1 == (table.notPkColumns?size+2)/4 >
						<td class="tdLabel">&nbsp;</td><td>&nbsp;</td><td class="tdLabel">&nbsp;</td><td>&nbsp;</td>
					</#if>
					<#if table.notPkColumns?size%4 == 1 && row_index+1 == (table.notPkColumns?size+3)/4 >
						<td class="tdLabel">&nbsp;</td><td>&nbsp;</td><td class="tdLabel">&nbsp;</td><td>&nbsp;</td><td class="tdLabel">&nbsp;</td><td>&nbsp;</td>
					</#if>
				</tr>	
				</#list>			
			</table>
		<div class="handleControl">
			<input type="submit" class="form-btn" style="width:80px" value="查询" onclick="getReferenceForm(this).action='<@jspEl 'ctx'/>${actionBasePath}/querylist.do'"/>
		</div>
	</div>
	
	<div class="gridTable">
	
		<table width="100%"  border="0" cellspacing="0" class="gridBody">
		  <thead>
			  
			  <tr>
				<th style="width:1px;"> </th>
				<th style="width:1px;"><input type="checkbox" onclick="setAllCheckboxState('items',this.checked)"></th>
				
				<!-- 排序时为th增加sortColumn即可,new SimpleTable('sortColumns')会为tableHeader自动增加排序功能; -->
				<#list table.columns as column>
				<#if !column.htmlHidden>
				<th sortColumn="${column.sqlName}" ><%=${className}.ALIAS_${column.constantName}%></th>
				</#if>
				</#list>
	
				<th>操作</th>
			  </tr>
			  
		  </thead>
		  <tbody>
		  	  <c:forEach items="<@jspEl 'page.result'/>" var="item" varStatus="status">
		  	  
			  <tr class="<@jspEl "status.count % 2 == 0 ? 'odd' : 'even'"/>">
				<td><@jspEl 'page.thisPageFirstElementNumber + status.index'/></td>
				<td>
				<#list table.columns as column>
				<#if column.pk>
				<input type="checkbox" name="items" value="${column.columnNameLower}=<@jspEl "item['${column.sqlName}']"/>&">
				</#if>
				</#list>
				</td>
				
				<#list table.columns as column>
				<#if !column.htmlHidden>
				<td><#rt>
					<#compress>
					<#if column.isDateTimeColumn>
					<@jspEl "item['${column.sqlName}']"/>&nbsp;
					<#else>
					<@jspEl "item['${column.sqlName}']"/>&nbsp;
					</#if>
					</#compress>
				<#lt></td>
				</#if>
				</#list>
				<#list table.columns as column>
				<#if column.pk>
				<td>
					<a href="<@jspEl 'ctx'/>${actionBasePath}/showquery.do?${column.columnNameLower}=<@jspEl "item['${column.sqlName}']"/>">查看</a>&nbsp;&nbsp;&nbsp;
				</td>
				</#if>
				</#list>
			  </tr>
			  
		  	  </c:forEach>
		  </tbody>
		</table>
	
		<simpletable:pageToolbar page="<@jspEl 'page'/>">
		</simpletable:pageToolbar>
	</div>
	</form>
</rapid:override>

<%@ include file="base.jsp" %>

<#macro generateIdQueryString>
	<#if table.compositeId>
		<#assign itemPrefix = 'item.id.'>
	<#else>
		<#assign itemPrefix = 'item.'>
	</#if>
<#compress>
		<#list table.compositeIdColumns as column>
			<#t>${column.columnNameLower}=<@jspEl itemPrefix + column.columnNameLower/>&
		</#list>				
</#compress>
</#macro>