<%@page import="${basepackage}.model.*" %>
<#include "/macro.include"/> 
<#include "/custom.include"/> 
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#assign actionExtension = "do"> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>

<rapid:override name="head">
	<title><%=${className}.TABLE_ALIAS%>信息</title>
</rapid:override>

<rapid:override name="content">
	<s:form action="${actionBasePath}/list.${actionExtension}" method="post" theme="simple">
		
	<#list table.columns as column>
	<#if column.pk>
		<s:hidden name="${column.columnNameLower}" id="${column.columnNameLower}" value="%{model.${column.columnNameLower}}"/>
	</#if>
	</#list>
		<br/>
		<div class="serchHead"><b><%=${className}.TABLE_ALIAS%>管理</b></div>
		<table class="formTable">
		<#list table.notPkColumns?chunk(2) as row>
		<tr>
		<#list row as column>	
		<#if !column.htmlHidden>
				
				<td class="tdLabel"><%=${className}.ALIAS_${column.constantName}%></td>	
				<td><#rt>
				<#compress>
				<#if column.isDateTimeColumn>
				<s:property value="%{model.${column.columnNameLower}String}" />
				<#else>
				<s:property value="%{model.${column.columnNameLower}}" />
				</#if>
				</#compress>
				<#lt></td>
		</#if>
		</#list>
		<#if table.notPkColumns?size%2 != 0 && row_index+1 == (table.notPkColumns?size+1)/2 >
			<td class="tdLabel"></td><td></td>
		</#if>
		</tr>
		</#list>
		</table>
		<div class="handleControlEdit">
			<input type="button" value="返回列表" onclick="window.location='<@jspEl 'ctx'/>${actionBasePath}/querylist.${actionExtension}'" class="form-btn"/>
			<input type="button" value="后退" onclick="history.back();" class="form-btn"/>
		</div>
	</s:form>
</rapid:override>

<%@ include file="base.jsp" %>