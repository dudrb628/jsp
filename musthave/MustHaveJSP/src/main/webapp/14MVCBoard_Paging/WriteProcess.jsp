<%@ page import = "model2.mvcboard.MVCBoardDAO" %>
<%@ page import = "model2.mvcboard.MVCBoardDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");

// 폼값을 DTO 객체에 저장
MVCBoardDTO dto = new MVCBoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setIdx(session.getAttribute("UserId").toString());


// DAO 객체를 통해 DB에 DTO 저장
MVCBoardDAO dao = new MVCBoardDAO();
//int iResult = dao.insertWrite(dto);	// 원래 코드
int iResult = 0;
for (int i = 1; i <= 100; i++){
	dto.setTitle(title + "-" + i);
	iResult = dao.insertWrite(dto);
}
dao.close();

if (iResult == 1) {
	response.sendRedirect("List.jsp");
} else{
	utils.JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>