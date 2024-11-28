<%@ page import="org.example.WSD2_3.dao.BoardDAO" %>
<%@ page import="org.example.WSD2_3.bean.BoardVO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    BoardDAO dao = new BoardDAO();
    BoardVO board = dao.getBoard(id); // 게시물 정보 가져오기

    if (board != null && board.getFile_path() != null) {
        String uploadPath = application.getRealPath("/"); // 서버의 실제 경로
        String filePath = uploadPath + board.getFile_path(); // 파일 전체 경로

        // 파일 삭제
        java.io.File file = new java.io.File(filePath);
        if (file.exists()) {
            boolean deleted = file.delete();
            if (deleted) {
                System.out.println("File deleted successfully: " + filePath);
            } else {
                System.out.println("Failed to delete file: " + filePath);
            }
        } else {
            System.out.println("File does not exist: " + filePath);
        }
    }

    // 데이터베이스에서 게시물 삭제
    boolean success = dao.deleteBoard(id);

    if (success) {
        response.sendRedirect("list.jsp");
    } else {
        System.out.println("<h2>Error deleting post</h2>");
    }
%>
