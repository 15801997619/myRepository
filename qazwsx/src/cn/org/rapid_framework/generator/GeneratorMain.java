package cn.org.rapid_framework.generator;


/**
 * 
 * @author badqiu
 * @email badqiu(a)gmail.com
 */

public class GeneratorMain {
	/**
	 * 请直接修改以下代码调用不同的方法以执行相关生成任务.
	 */
	public static void main(String[] args) throws Exception {
		GeneratorFacade g = new GeneratorFacade();
//		g.printAllTableNames();				//打印数据库中的表名称
		
//		g.deleteOutRootDir();							//删除生成器的输出目录
//		g.generateByTable("car4sinfo","template");	//通过数据库表生成文件,template为模板的根目录
//		g.generateByTable("t_tag_library","template");
//		g.generateByTable("t_third_account","template");
//		g.generateByTable("t_orders","template");
//		g.generateByTable("t_rfid_scanner","template");
//		g.generateByTable("t_pitch_det","template");
//		g.generateByTable("t_myt98_data","template");
//		g.generateByTable("t_trans_flow","template");
//		g.generateByTable("t_orders_refund","template");
//		g.generateByTable("t_ball_suit","template");
//		g.generateByTable("t_ball_detail","template");
//		g.generateByTable("t_ball_settlement","template");
//		g.generateByTable("t_app_user","template");
//		g.generateByTable("t_teams","template");
//		g.generateByAllTable("template");	//自动搜索数据库中的所有表并生成文件,template为模板的根目录
//		g.generateByClass(Blog.class,"template_clazz");
		 
//		g.deleteByTable("table_name", "template"); //删除生成的文件
		//打开文件夹
//		Runtime.getRuntime().exec("cmd.exe /c start "+GeneratorProperties.getRequiredProperty("outRoot"));
		String str = " 15 80199  7619 ";   
		String str2 = str.replaceAll(" ", "");   
		System.out.println(str2);   
	
	}
}
