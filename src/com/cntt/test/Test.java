package com.cntt.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Test {

	public static void main(String[] args) {
		
		String str = "";
		String str2 = str.replace("전화주세요!", "문앞콜").replace("일회용 수저", "일회용X");
		String word = new String (str2.getBytes(), 0, 100);
		String aa = subStringBytes(str2, 100, 2);
		String bb = getMaxByteString(aa, 100);
		
		System.out.println(str.replace("전화주세요!", "문앞콜"));
		System.out.println(aa);
		System.out.println(aa.charAt(32));
		System.out.println(bb);
		//System.out.println(str.getBytes().length);
		
	}
	
	public static String subStringBytes(String str, int byteLength, int sizePerLetter) {
		  int retLength = 0;
		  int tempSize = 0;
		  int asc;
		  if (str == null || "".equals(str) || "null".equals(str)) {
		    str = "";
		  }
		 
		  int length = str.length();
		 
		  for (int i = 1; i <= length; i++) {
			  System.out.println(i);
		    asc = (int) str.charAt(i - 1);
		    
		    if (asc > 127) {
		      if (byteLength > tempSize + sizePerLetter) {
		        tempSize += sizePerLetter;
		        retLength++;
		        System.out.println("asc = "+asc +" | "+str.charAt(i - 1) +" | "+(i - 1) +" | "+tempSize +" | "+retLength);
		      }
		      else {
		    	  return str.substring(0, retLength);
		      }
		    } else {
		    	
		      if (byteLength > tempSize) {
		        tempSize++;
		        retLength++;
		        System.out.println("asc2 = "+asc +" | "+str.charAt(i - 1) +" | "+(i - 1) +" | "+tempSize +" | "+retLength);
		      }
		      else {
		    	  return str.substring(0, retLength);
		      }
		    }
		  }
		 
		  return str.substring(0, retLength);
		}
	
    public static String getMaxByteString(String str, int maxLen)
    {
         StringBuilder sb = new StringBuilder();
         int curLen = 0;
         String curChar;
        
         for (int i = 0; i < str.length(); i++)
         {
              curChar = str.substring(i, i + 1);
              curLen += curChar.getBytes().length;
              if (curLen > maxLen)
                   break;
              else
                   sb.append(curChar);
         }
         return sb.toString();
    }



	public static boolean isFinished(String end_date) {
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHH");

		Date product_end = null;

		try {
			product_end = date.parse(end_date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date current = new Date();
		return current.after(product_end);
	}
}
