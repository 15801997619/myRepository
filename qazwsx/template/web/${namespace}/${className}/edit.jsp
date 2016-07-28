<#include "/macro.include"/> 
<#include "/custom.include"/> 
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#assign actionExtension = "do"> 
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/commons/taglibs.jsp" %>

<rapid:override name="head">
	<title><%=${className}.TABLE_ALIAS%>编辑</title>
</rapid:override>

<rapid:override name="content">
	<s:form action="${actionBasePath}/update.${actionExtension}" method="post">
		<table class="formTable">
		<tr><td colspan="4"  class="tdLabel"><label  ><%=${className}.TABLE_ALIAS%>管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label></td></tr>
		<%@ include file="form_include.jsp" %>
		</table>
		<div class="handleControlEdit">
		<input id="submitButton" name="submitButton" type="submit" value="提交"  class="form-btn"/>
		<input type="button" value="返回列表" onclick="window.location='<@jspEl 'ctx'/>${actionBasePath}/list.${actionExtension}'"  class="form-btn"/>
		<input type="button" value="后退" onclick="history.back();"  class="form-btn"/>
		</div>
	</s:form>
	
	<script>
		
		new Validation(document.forms[0],{onSubmit:true,onFormValidate : function(result,form) {
			var finalResult = result;
			
			//在这里添加自定义验证
			
			return disableSubmit(finalResult,'submitButton');
		}});
	</script>
</rapid:override>

<%@ include file="base.jsp" %>