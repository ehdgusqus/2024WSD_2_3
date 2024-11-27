<%@ include file="inc/top.jsp" %>
<%@ page import="org.example.hw4.bean.BoardVO" %>
<%@ page import="org.example.hw4.dao.BoardDAO" %>
<%@ page import="java.util.List" %>

<%
    // 검색 키워드 가져오기
    String keyword = request.getParameter("keyword");
    List<BoardVO> result = null;

    // 키워드가 비어 있지 않으면 검색 수행
    if (keyword != null && !keyword.trim().isEmpty()) {
        BoardDAO dao = new BoardDAO();
        result = dao.searchBoard(keyword, keyword); // 키워드를 제목과 내용 검색에 사용
        request.setAttribute("result", result); // JSP에서 JSTL로 접근 가능하도록 설정
    }
%>

<div class="container my-5">
    <h2 class="text-center">Search Board</h2>

    <!-- 검색 폼 -->
    <form action="search.jsp" method="get" class="d-flex mb-4">
        <input type="text" name="keyword" class="form-control me-2"
               placeholder="Search by Title or Content" value="<%= keyword != null ? keyword : "" %>" required>
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <!-- 검색 결과 -->
    <c:choose>
        <c:when test="${result != null && not empty result}">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Search Results</h3>
                </div>
                <div class="card-body">
                    <ul class="list-group">
                        <c:forEach var="board" items="${result}">
                            <li class="list-group-item">
                                <p><strong>ID:</strong> ${board.id}</p>
                                <p><strong>Title:</strong> ${board.title}</p>
                                <p><strong>Writer:</strong> ${board.writer}</p>
                                <p><strong>Score:</strong> ${board.score}</p>
                                <p><strong>Content:</strong> ${board.content}</p>
                                <p><strong>Date:</strong> ${board.create_date}</p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="card-footer text-end">
                    <a href="list.jsp" class="btn btn-secondary">Back to List</a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:if test="${keyword != null}">
                <p class="text-center text-muted">
                    No results found for "<strong>${keyword}</strong>".
                </p>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="inc/bottom.jsp" %>
