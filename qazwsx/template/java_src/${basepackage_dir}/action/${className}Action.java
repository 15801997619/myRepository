<#include "/custom.include">
<#include "/java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>
<#assign actionExtension = "do">
package ${basepackage}.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.org.rapid_framework.beanutils.BeanUtils;
import cn.org.rapid_framework.web.scope.Flash;

import com.opensymphony.xwork2.Preparable;
import com.opensymphony.xwork2.ModelDriven;

import org.apache.log4j.Logger;

<#include "/java_imports.include">

public class ${className}Action extends BaseStruts2Action implements Preparable,ModelDriven{
	public Logger logger = Logger.getLogger(${className}.class);
	
	//默认多列排序,example: username desc,createTime asc
	protected static final String DEFAULT_SORT_COLUMNS = null; 
	
	//forward paths
	protected static final String QUERY_JSP = "${jspFileBasePath}/query.jsp";
	protected static final String LIST_JSP= "${jspFileBasePath}/list.jsp";
	protected static final String CREATE_JSP = "${jspFileBasePath}/create.jsp";
	protected static final String EDIT_JSP = "${jspFileBasePath}/edit.jsp";
	protected static final String SHOW_JSP = "${jspFileBasePath}/show.jsp";
	protected static final String QUERYLIST_JSP= "${jspFileBasePath}/querylist.jsp";
	protected static final String SHOWQUERY_JSP = "${jspFileBasePath}/showquery.jsp";
	//redirect paths,startWith: !
	protected static final String LIST_ACTION = "!${actionBasePath}/list.${actionExtension}";
	protected static final String QUERYLIST_ACTION = "!${actionBasePath}/querylist.${actionExtension}";
	
	private ${className}Manager ${classNameLower}Manager;
	
	private ${className} ${classNameLower};
	<#list table.compositeIdColumns as column>
	${column.javaType} id = null;
	</#list>
	private String[] items;

	public void prepare() throws Exception {
		if (isNullOrEmptyString(id)) {
			${classNameLower} = new ${className}();
		} else {
			${classNameLower} = (${className})${classNameLower}Manager.getById(id);
		}
	}
	
	/** 增加setXXXX()方法,spring就可以通过autowire自动设置对象属性,注意大小写 */
	public void set${className}Manager(${className}Manager manager) {
		this.${classNameLower}Manager = manager;
	}	
	
	public Object getModel() {
		return ${classNameLower};
	}
	
	<#list table.compositeIdColumns as column>
	public void set${column.columnName}(${column.javaType} val) {
		this.id = val;
	}
	</#list>	

	public void setItems(String[] items) {
		this.items = items;
	}
	
	/** 执行搜索 */
	public String list() {
		try{
			${className}Query query = newQuery(${className}Query.class,DEFAULT_SORT_COLUMNS);
			
			Page page = ${classNameLower}Manager.findPage(query);
			savePage(page,query);
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return LIST_JSP;
	}
	/** 执行搜索 */
	public String querylist() {
		try{
			${className}Query query = newQuery(${className}Query.class,DEFAULT_SORT_COLUMNS);
			
			Page page = ${classNameLower}Manager.findPage(query);
			savePage(page,query);
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return QUERYLIST_JSP;
	}
	
	/** 查看对象*/
	public String show() {
		return SHOW_JSP;
	}
	/** 查看对象*/
	public String showquery() {
		return SHOWQUERY_JSP;
	}
	
	/** 进入新增页面*/
	public String create() {
		return CREATE_JSP;
	}
	
	/** 保存新增对象 */
	public String save() {
		try{
			${classNameLower}Manager.save(${classNameLower});
			Flash.current().success(CREATED_SUCCESS); //存放在Flash中的数据,在下一次http请求中仍然可以读取数据,error()用于显示错误消息
		}catch (Exception e) {
			logger.error(e.getMessage());
		}	
		return LIST_ACTION;
	}
	
	/**进入更新页面*/
	public String edit() {
		return EDIT_JSP;
	}
	
	/**保存更新对象*/
	public String update() {
		try{
			${classNameLower}Manager.update(this.${classNameLower});
			Flash.current().success(UPDATE_SUCCESS);
		}catch (Exception e) {
			logger.error(e.getMessage());
		}	
		return LIST_ACTION;
	}
	
	/**删除对象*/
	public String delete() {
		try{
			for(int i = 0; i < items.length; i++) {
				Hashtable params = HttpUtils.parseQueryString(items[i]);
				<#if table.compositeId>
				${className}Id id = (${className}Id)copyProperties(${className}Id.class,params);
				<#else>
					<#list table.compositeIdColumns as column>
				${column.javaType} id = new ${column.javaType}((String)params.get("${column.columnNameLower}"));
					</#list>
				</#if>
				${classNameLower}Manager.removeById(id);
			}
			Flash.current().success(DELETE_SUCCESS);
		}catch (Exception e) {
			logger.error(e.getMessage());
		}
		return LIST_ACTION;
	}

}
