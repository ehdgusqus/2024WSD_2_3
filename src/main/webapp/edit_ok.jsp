<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.hw4.bean.BoardVO" %>
<%@ page import="org.example.hw4.dao.BoardDAO" %>
<%@ page import="org.example.hw4.file.FileUpload" %>
<%@ page import="java.util.Map" %>
<%
    try {
        // 파일 업로드 및 폼 데이터 처리
        Map<String, String> formData = FileUpload.uploadFile(request);

        // 기존 파일 경로 가져오기
        String existingFile = request.getParameter("existing_file");
        System.out.println("Existing file: " + existingFile);

        // 새 파일 경로 가져오기
        String newFilePath = formData.get("filePath");
        System.out.println("New file: " + newFilePath);

        // 최종 파일 경로 설정
        String finalFilePath = (newFilePath != null) ? newFilePath : existingFile;
        System.out.println("Final file path: " + finalFilePath);

        // 폼 데이터 가져오기
        int id = Integer.parseInt(request.getParameter("id"));
        String title = formData.get("title");
        String writer = formData.get("writer");
        String content = formData.get("content");
        int score = Integer.parseInt(formData.get("score"));

        System.out.println("Title: " + title);
        System.out.println("Writer: " + writer);

        // VO 객체 생성 및 데이터 설정
        BoardVO vo = new BoardVO();
        vo.setId(id);
        vo.setTitle(title);
        vo.setWriter(writer);
        vo.setContent(content);
        vo.setScore(score);
        vo.setFile_path(finalFilePath);
        System.out.println("ID: " + request.getParameter("id"));
        System.out.println("Title: " + formData.get("title"));
        System.out.println("Writer: " + formData.get("writer"));
        System.out.println("Content: " + formData.get("content"));
        System.out.println("Score: " + formData.get("score"));
        System.out.println("Existing File: " + existingFile);
        System.out.println("New File: " + newFilePath);
        System.out.println("Final File Path: " + finalFilePath);


        // DAO를 통해 업데이트 실행
        BoardDAO dao = new BoardDAO();
        boolean success = dao.updateBoard(vo, id);

        if (success) {
            response.sendRedirect("view.jsp?id=" + id);
        } else {
            out.println("<div class='alert alert-danger'>Failed to update the post.</div>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    }
%>
<%@ include file="inc/bottom.jsp" %>
