<%@ include file="inc/top.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.hw4.bean.BoardVO" %>
<%@ page import="org.example.hw4.dao.BoardDAO" %>
<%
    BoardDAO dao = new BoardDAO();
    List<BoardVO> boards = dao.getBoardList();
    request.setAttribute("boards", boards);
%>

<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-12">
            <h2 class="text-center mb-4">Board List</h2>
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Writer</th>
                    <th>Score</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="board" items="${boards}">
                    <tr>
                        <td>${board.id}</td>
                        <td><a href="view.jsp?id=${board.id}" class="text-decoration-none">${board.title}</a></td>
                        <td>${board.writer}</td>
                        <td>${board.score}</td>
                        <td>
                            <a href="edit.jsp?id=${board.id}" class="btn btn-warning btn-sm">Edit</a>
                            <a href="delete_ok.jsp?id=${board.id}" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="inc/bottom.jsp" %>
