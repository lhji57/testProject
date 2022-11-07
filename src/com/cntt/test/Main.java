package com.cntt.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Main {
public static void main(String[] args) {

	FolderUtil fUtil = new FolderUtil();
	
	//File path = new File("C:/Users/Helen/workspace_java/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/CNTT_PJI_RENEW/WEB-INF/classes/com/cntt/util");
	//File[] fileList = path.listFiles();
	/*
	if(fileList.length > 0){
		for(int i = 0; i < fileList.length; i++){
			File file = fileList[i]; 
			System.out.println(file.getName());

		}
	}*/
	
	/**	
	fUtil.getListAll("D:/UPDATE/20150924/mobile","D:\\\\UPDATE\\\\20150924\\\\mobile" );
	ArrayList<String> fileList = fUtil.getResult();
	for (int i = 0; i < fileList.size(); i++) {
		//System.out.println();
		System.out.println(fileList.get(i).replace("D:\\UPDATE\\20150924\\mobile", ""));
	}
	**/
	
	try {
		//fUtil.FileFindLineText("D:/2016-03-12.log","D:/ios.log" , "ac=completeorder");
		
		
		//fUtil.FileFindLineText("D:/2016-03-11.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/2016-03-12.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/2016-03-13.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/2016-03-14.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/2016-03-15.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/2016-03-16.log","D:/ios.log" , "iPhone");
		//fUtil.FileFindLineText("D:/ios.log","D:/iosresult.log" , "ac=completeorder");
		
		//fUtil.FileFindLineText("C:/Users/Helen/Desktop/tomcat/20191224/2019-12-13.log","C:/Users/Helen/Desktop/tomcat/20191224/1.log" , "7242584");
		fUtil.FileFindLineText("C:/Users/Helen/Desktop/log/20200820/2020-08-19.log","C:/Users/Helen/Desktop/log/20200820/19.log" , "java.sql.SQLSyntaxErrorException");
		
		
		/*
		String filePath = "C:/Users/Helen/Desktop/tomcat/미피 주문오류/";
        String fileName = "tomcat.log_2019_07_31";
        File file = new File(filePath + fileName);
        FileInputStream fi = new FileInputStream(file);
        
		String nFilePath = "C:/Users/Helen/Desktop/tomcat";
        String nFileName = "newlog";
        */
        //파일을 분할하여 저장한다
       // fUtil.splitFile(nFilePath, nFileName, fi);
		
		
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

}
}
