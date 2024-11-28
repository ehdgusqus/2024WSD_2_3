<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.WSD2_3.bean.BoardVO" %>
<%@ page import="org.example.WSD2_3.dao.BoardDAO" %>
<%@ page import="org.example.WSD2_3.file.FileUpload" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.io.File" %>
<%
    int id = -1; // ID 초기화
    try {
        // 파일 업로드 및 폼 데이터 처리
        Map<String, String> formData = FileUpload.uploadFile(request);

        // "id" 값 가져오기
        String idParam = formData.get("id");
        if (idParam == null || idParam.isEmpty()) {
            throw new IllegalArgumentException("Invalid ID parameter");
        }
        id = Integer.parseInt(idParam);

        // 기존 파일 경로 가져오기
        String existingFile = formData.get("existing_file");

        // 새 파일 경로 가져오기
        String newFilePath = formData.get("filePath");

        // 최종 파일 경로 설정
        String finalFilePath = (newFilePath != null && !newFilePath.isEmpty()) ? newFilePath : existingFile;

        // 기존 파일 삭제 처리 (새 파일 업로드된 경우)
        if (newFilePath != null && !newFilePath.isEmpty() && existingFile != null && !existingFile.isEmpty()) {
            String fullExistingPath = request.getServletContext().getRealPath("/") + existingFile;
            File fileToDelete = new File(fullExistingPath);
            if (fileToDelete.exists()) {
                boolean deleted = fileToDelete.delete();
                System.out.println("Deleted existing file: " + fullExistingPath + " -> " + deleted);
            }
        }

        // 폼 데이터 가져오기
        String title = formData.getOrDefault("title", "").trim();
        String writer = formData.getOrDefault("writer", "").trim();
        String content = formData.getOrDefault("content", "").trim();
        int score = Integer.parseInt(formData.getOrDefault("score", "0"));

        // VO 객체 생성 및 데이터 설정
        BoardVO vo = new BoardVO();
        vo.setId(id);
        vo.setTitle(title);
        vo.setWriter(writer);
        vo.setContent(content);
        vo.setScore(score);
        vo.setFile_path(finalFilePath); // 최종 파일 경로 설정

        // DAO를 통해 업데이트 실행
        BoardDAO dao = new BoardDAO();
        boolean success = dao.updateBoard(vo, id);

        if (success) {
            response.sendRedirect("view.jsp?id=" + id);
        } else {
            response.sendRedirect("edit.jsp?id=" + id + "&error=update_failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        if (id > 0) {
            response.sendRedirect("edit.jsp?id=" + id + "&error=" + e.getMessage());
        } else {
            response.sendRedirect("list.jsp?error=Invalid ID parameter");
        }
    }
%>
<%@ include file="inc/bottom.jsp" %>
