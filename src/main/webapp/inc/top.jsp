<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Board Application</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        header {
            background: linear-gradient(90deg, #1d3557, #457b9d);
            color: white;
        }
        header h1 {
            font-size: 2rem;
            font-weight: bold;
        }
        .navbar-brand {
            font-weight: bold;
            color: #f1faee !important;
        }
        .navbar-nav .nav-link {
            color: #f1faee !important;
            transition: color 0.3s ease;
        }
        .navbar-nav .nav-link:hover {
            color: #a8dadc !important;
        }
    </style>
</head>
<body>
<header>
    <div class="container py-3 text-center">
        <h1>Board Application</h1>
        <p class="mb-0">A Simple CRUD Web App with JSP and MariaDB</p>
    </div>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Home</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="list.jsp">Board List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="write.jsp">Write Post</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="search.jsp">Search</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
