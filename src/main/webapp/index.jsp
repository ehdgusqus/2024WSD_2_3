<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="inc/top.jsp" %>

<!-- Hero Section -->
<div class="container mt-5">
    <div class="jumbotron bg-light text-center py-5">
        <h1 class="display-4">Welcome to My Board Application</h1>
        <p class="lead">This is a simple CRUD web application using JSP and MariaDB.</p>
        <hr class="my-4">
    </div>
</div>

<!-- Application Features -->
<div class="container mt-4">
    <div class="row text-center">
        <!-- View Board List -->
        <div class="col-md-4 mb-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5 class="card-title">View Board List</h5><br>
                    <a href="list.jsp" class="btn btn-primary">View List</a>
                </div>
            </div>
        </div>

        <!-- Write a New Post -->
        <div class="col-md-4 mb-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5 class="card-title">Write a New Post</h5><br>
                    <a href="write.jsp" class="btn btn-success">Write Post</a>
                </div>
            </div>
        </div>

        <!-- Search Posts -->
        <div class="col-md-4 mb-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5 class="card-title">Search Posts</h5><br>
                    <a href="search.jsp" class="btn btn-info">Search</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="inc/bottom.jsp" %>
