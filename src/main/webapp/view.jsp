<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.WSD2_3.bean.BoardVO" %>
<%@ page import="org.example.WSD2_3.dao.BoardDAO" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));
  BoardDAO dao = new BoardDAO();
  BoardVO board = dao.getBoard(id);

  String filePath = board.getFile_path();
  String fileExt = "";
  if (filePath != null && !filePath.isEmpty()) {
    fileExt = filePath.substring(filePath.lastIndexOf(".") + 1).toLowerCase();
  }
%>
<div class="container my-5">
  <h2 class="text-center mb-4">View Post</h2>
  <div class="card">
    <div class="card-body">
      <h3 class="card-title mb-3"><%= board.getTitle() %></h3>
      <p><strong>Writer:</strong> <%= board.getWriter() %></p>
      <p><strong>Content:</strong></p>
      <p class="card-text"><%= board.getContent() %></p>
      <p><strong>Score:</strong> <%= board.getScore() %></p>
      <p><strong>View:</strong> <%= board.getView() %></p>
      <p><strong>Date:</strong> <%= board.getCreate_date() != null ? board.getCreate_date() : "No date available" %></p>
      <% if (filePath != null && !filePath.isEmpty()) { %>
      <p><strong>File:</strong></p>
      <%
        // 이미지 확장자인 경우
        if ("png".equals(fileExt) || "jpg".equals(fileExt)) {
      %>
      <img src="<%= application.getContextPath() + "/" + filePath %>"
           alt="Uploaded Image" class="img-fluid rounded" style="max-width: 300px; max-height: 300px;">
      <%
      } else { // 이미지가 아닌 경우
      %>
      <a href="<%= application.getContextPath() + "/" + filePath %>"
         target="_blank" class="btn btn-link">Download File</a>
      <%
        }
      %>
      <% } else { %>
      <p class="text-muted">No file uploaded.</p>
      <% } %>
    </div>
    <div class="card-footer text-end">
      <a href="list.jsp" class="btn btn-secondary">Back to List</a>
      <a href="edit.jsp?id=<%= board.getId() %>" class="btn btn-primary">Edit Post</a>
    </div>
  </div>
</div>
<%@ include file="inc/bottom.jsp" %>
