package com.cntt.test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

public class FileUtils {

	public void FileFindLineText(String filePath, String destnationFILE, String findText) throws IOException {
		// Open the file
		FileInputStream fstream;
		BufferedReader br;
		BufferedWriter bw;
		PrintWriter printWriter;
		try {

			bw = new BufferedWriter(new FileWriter(destnationFILE, true));
			printWriter = new PrintWriter(bw, true);
			fstream = new FileInputStream(filePath);
			br = new BufferedReader(new InputStreamReader(fstream));
			String strLine;

			// Read File Line By Line
			while ((strLine = br.readLine()) != null) {
				// Print the content on the console

				if (strLine.contains(findText)) {
					System.out.println(strLine);
					printWriter.println(strLine);
				}

			}

			printWriter.close();
			bw.close();
			// Close the input stream
			br.close();

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getFileText(String filePath) {
		String reulstString = "";
		FileInputStream fstream;
		BufferedReader br;
		try {
			fstream = new FileInputStream(filePath);
			br = new BufferedReader(new InputStreamReader(fstream));
			String strLine;
			while ((strLine = br.readLine()) != null) {
				reulstString = reulstString + strLine;
			}
			// Close the input stream
			br.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reulstString;
	}
}
