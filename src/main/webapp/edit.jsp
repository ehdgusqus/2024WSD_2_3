<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.WSD2_3.bean.BoardVO" %>
<%@ page import="org.example.WSD2_3.dao.BoardDAO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    BoardDAO dao = new BoardDAO();
    BoardVO board = dao.getBoard(id);
%>
<div class="container my-5">
    <h2 class="text-center">Edit Post</h2>
    <form action="edit_ok.jsp" method="post" enctype="multipart/form-data" class="mt-4">
        <!-- Hidden ID 및 기존 파일 정보 -->
        <input type="hidden" name="id" value="<%= board.getId() %>">
        <input type="hidden" name="existing_file" value="<%= board.getFile_path() %>">

        <!-- Title -->
        <div class="mb-3">
            <label for="title" class="form-label">Title</label>
            <input type="text" id="title" name="title" class="form-control" value="<%= board.getTitle() %>" required>
        </div>

        <!-- Writer -->
        <div class="mb-3">
            <label for="writer" class="form-label">Writer</label>
            <input type="text" id="writer" name="writer" class="form-control" value="<%= board.getWriter() %>" required>
        </div>

        <!-- Content -->
        <div class="mb-3">
            <label for="content" class="form-label">Content</label>
            <textarea id="content" name="content" class="form-control" rows="5" required><%= board.getContent() %></textarea>
        </div>

        <!-- Score -->
        <div class="mb-3">
            <label for="score" class="form-label">Score</label>
            <input type="number" id="score" name="score" class="form-control" value="<%= board.getScore() %>" required>
        </div>

        <!-- 기존 파일 상태 -->
        <div class="mb-3">
            <label class="form-label">Existing File:</label>
            <% if (board.getFile_path() != null && !board.getFile_path().isEmpty()) { %>
            <p>
                <a href="<%= request.getContextPath() + "/" + board.getFile_path() %>" target="_blank" class="btn btn-link">
                    View/Download File
                </a>
            </p>
            <% } else { %>
            <p class="text-muted">No file uploaded.</p>
            <% } %>
        </div>

        <!-- 새 파일 업로드 -->
        <div class="mb-3">
            <label for="photo" class="form-label">Upload New File</label>
            <input type="file" id="photo" name="photo" class="form-control">
        </div>

        <!-- Submit 버튼 -->
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">Update</button>
            <a href="list.jsp" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
<%@ include file="inc/bottom.jsp" %>
