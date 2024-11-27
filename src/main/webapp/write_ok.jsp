<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.hw4.bean.BoardVO" %>
<%@ page import="org.example.hw4.dao.BoardDAO" %>
<%@ page import="org.example.hw4.file.FileUpload" %>
<%@ page import="java.util.Map" %>
<%
    try {
        // FileUpload 클래스를 통해 파일 및 데이터 처리
        Map<String, String> formData = FileUpload.uploadFile(request);

        // 데이터 추출
        String title = formData.get("title");
        String writer = formData.get("writer");
        String content = formData.get("content");
        int score = Integer.parseInt(formData.get("score"));
        String filePath = formData.get("filePath");

        // VO 객체 설정
        BoardVO vo = new BoardVO();
        vo.setTitle(title);
        vo.setWriter(writer);
        vo.setContent(content);
        vo.setScore(score);
        vo.setFile_path(filePath);

        // 데이터베이스 저장
        BoardDAO dao = new BoardDAO();
        boolean success = dao.insertBoard(vo);

        if (success) {
            response.sendRedirect("list.jsp");
        } else {
            response.getWriter().println("Error: Failed to save the post.");
        }
    } catch (Exception e) {
        e.printStackTrace(response.getWriter());
    }
%>
<%@ include file="inc/bottom.jsp" %>
