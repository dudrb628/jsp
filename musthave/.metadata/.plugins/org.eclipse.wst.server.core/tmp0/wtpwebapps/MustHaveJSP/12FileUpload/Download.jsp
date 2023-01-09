<%@ page import = "utils.JSFunction" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String saveDirectory = application.getRealPath("/Uploads");
String saveFilename = request.getParameter("sName");
String originalFilename = request.getParameter("oName");

System.out.println(saveDirectory + "\n" + saveFilename + " \n" + originalFilename);
System.out.println("gd");
try{

	System.out.println("위치0");
	// 파일을 찾아 입력 스트림 생성
	File file = new File(saveDirectory, saveFilename);
	System.out.println("위치0.5"+file);
	InputStream inStream = new FileInputStream(file);
	
	System.out.println("위치1");
	
	// 한글 파일명 깨짐 방지
	String client = request.getHeader("User-Agent");
	System.out.println("위치2");
	
	if (client.indexOf("WOW64") == -1) {
		originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
		System.out.println("위치3");
	}
	else {
		originalFilename = new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");
		System.out.println("위치4");
	}
	// 파일 다운로드용 응답 헤더 설정
	
	System.out.println("위치5");
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=\""+ originalFilename + "\"");
	response.setHeader("Content-Length", "" + file.length() );
	System.out.println("위치6");
	// 출력 스트림 초기화
	out.clear();
	System.out.println("위치7");
	// response 내장 객체로부터 새로운 출력 스트림 생성
	OutputStream outStream = response.getOutputStream();
	System.out.println("위치8");
	// 출력 스트림에 파일 내용 출력
	byte b[] = new byte[(int)file.length()];
	int readBuffer = 0;
	while ( (readBuffer = inStream.read(b)) > 0) {
		outStream.write(b,0,readBuffer);
	}
	System.out.println("위치9");
	// 입/출력 스트림 닫음
	inStream.close();
	outStream.close();
	System.out.println("위치10");
}
catch (FileNotFoundException e) {
	JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
}
catch (Exception e) {
	JSFunction.alertBack("예외가 발생하였습니다.", out);
}
%>