package com.cntt.test;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;

public class FolderUtil {
	ArrayList<String> strFileList = null;
	
	public FolderUtil() {
		// TODO Auto-generated constructor stub
	}
	
	public void FileFindLineText(String filePath ,String destnationFILE ,String findText) throws IOException{
		// Open the file
		FileInputStream fstream;
		BufferedReader br;
		BufferedWriter bw;
		PrintWriter printWriter;
		try {
			fstream = new FileInputStream(filePath);
			bw = new BufferedWriter(new FileWriter(destnationFILE, true));
			printWriter = new PrintWriter(bw, true);
			br = new BufferedReader(new InputStreamReader(fstream));
				String strLine;

				//Read File Line By Line
				while ((strLine = br.readLine()) != null)   {
				  // Print the content on the console
				  
				  if(strLine.contains(findText)){
					  System.out.println (strLine);
					  printWriter.println(strLine);
				  }
				  
				}

				printWriter.close();
				bw.close();
				//Close the input stream
				br.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			}
	
	public void FileFindLineText2(String filePath ,String destnationFILE ,String findText) throws IOException{
		// Open the file
		FileInputStream fstream;
		BufferedReader br;
		BufferedWriter bw;
		PrintWriter printWriter;
		try {
			fstream = new FileInputStream(filePath);
			bw = new BufferedWriter(new FileWriter(destnationFILE, true));
			printWriter = new PrintWriter(bw, true);
			br = new BufferedReader(new InputStreamReader(fstream));
				String strLine;

				//Read File Line By Line
				while ((strLine = br.readLine()) != null)   {
				  // Print the content on the console
				  
				  if(strLine.contains(findText)){
					  System.out.println (strLine);
					  String thisText = strLine.substring(strLine.indexOf("cartid=")+7,strLine.indexOf("cartid=")+13);
					  System.out.println (thisText);
					  printWriter.println(","+thisText);
				  }
				  
				}

				printWriter.close();
				bw.close();
				//Close the input stream
				br.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			}
	
	public ArrayList<String> getFileIList(String filePath) {
		ArrayList<String> strFileList = new ArrayList<String>();
		File dir = new File(filePath);
		if (dir.exists()) {
			File[] fileList = dir.listFiles();
			try {
				for (int i = 0; i < fileList.length; i++) {
					File file = fileList[i];
					if (file.isFile()) {
						strFileList.add(file.getName());
						System.out.println(file.getName());
					} else if (file.isDirectory()) {

					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		}
		return strFileList;
	}

	public ArrayList<String> getDirList(String filePath) {
		ArrayList<String> strFileList = new ArrayList<String>();
		File dir = new File(filePath);
		if (dir.exists()) {
			File[] fileList = dir.listFiles();
			try {
				for (int i = 0; i < fileList.length; i++) {
					File file = fileList[i];
					if (file.isFile()) {
					} else if (file.isDirectory()) {
						strFileList.add(file.getName());
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("!File Not Exists! ");
		}
		return strFileList;
	}
	
	public ArrayList<String> getResult(){
		return this.strFileList;
	}
	
	public void getExtensionList(String filePath, String strEXE,
			boolean includeEXE, String regText, String replaceText) {
		//System.out.println("find=" +filePath);
		if (strFileList == null){
			strFileList = new ArrayList<String>();
		}
		File dir = new File(filePath);
		if (dir.exists()) {
			File[] fileList = dir.listFiles();
			try {
				for (int i = 0; i < fileList.length; i++) {
					File file = fileList[i];
					if (file.isFile()) {
						if (file.getName().toLowerCase()
								.endsWith(strEXE.toLowerCase())) {
							if (includeEXE) {
								//strFileList.add(file.getName());
								String thisPath = file.getCanonicalPath().toString();
								thisPath =  thisPath.replaceAll(regText, replaceText);
								strFileList.add(thisPath);
							} else {
								strFileList.add(file.getName().substring(0,
										file.getName().lastIndexOf(".")));
							}
						}
					} else if (file.isDirectory()) {
							getExtensionList(file.getCanonicalPath().toString(), strEXE, includeEXE,regText, replaceText);
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("!File Not Exists! ");
		}
		//return strFileList;
	}
	
	public void getListAll(String filePath , String regText) {
		//System.out.println("find=" +filePath);
		if (strFileList == null){
			strFileList = new ArrayList<String>();
		}
		File dir = new File(filePath);
		if (dir.exists()) {
			File[] fileList = dir.listFiles();
			try {
				for (int i = 0; i < fileList.length; i++) {
					File file = fileList[i];
					if (file.isFile()) {
							String thisPath = file.getCanonicalPath().toString();
							String shotPath =  thisPath.replaceAll(regText, "");
							strFileList.add(shotPath);
					} else if (file.isDirectory()) {
							getListAll(file.getCanonicalPath().toString(), regText);
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("!File Not Exists! ");
		}
		//return strFileList;
	}
	
    public void splitFile(String nFilePath, String nFileName, InputStream fi){
        try {
        	int maxFileSize = 1024*1024*1;
			int readCnt = 0;
			int totCnt = 0;
			int fileIdx = 0;
			BufferedInputStream bfi = new BufferedInputStream(fi);
			byte[] readBuffer = new byte[4096];
			File nFile = new File(nFilePath + nFileName);
			FileOutputStream fo = new FileOutputStream(nFile);

			do {
                      readCnt = bfi.read(readBuffer);
                      if(readCnt == -1){
                            break;
                      }

                      fo.write(readBuffer,0,readCnt);
                      totCnt += readCnt;
                      if(totCnt%maxFileSize==0){
						fo.flush();
						fo.close();
						File nfile = new File(nFilePath+ nFileName+(++fileIdx)+"._tmp");
						fo = new FileOutputStream(nfile);

                      }

               } while (true);
               fi.close();
               fo.flush();
               fo.close();
        } catch (Exception e) {
        	e.printStackTrace();
        }
        System.out.println("##########분할완료##########");

  }	
	
}
