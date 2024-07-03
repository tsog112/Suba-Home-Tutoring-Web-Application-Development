<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Subjects</title>
<link rel="stylesheet" href="./style/subjects.css">
</head>
<body>
<jsp:include page="header.jsp"/>
   <div class="container">
        <h1>Ямар <span>хичээл</span> хайж байна?</h1>

        <div class="category">
            <h2>Гадаад хэл</h2>
            <div class="carousel-container">
                <button class="nav-button left" id="foreign-languages-prev">&#60;</button>
                <div class="cards-wrapper">
                    <div class="cards" id="foreign-languages"></div>
                </div>
                <button class="nav-button right" id="foreign-languages-next">&#62;</button>
            </div>
        </div>

        <div class="category">
            <h2>Шинжлэх ухаан</h2>
            <div class="carousel-container">
                <button class="nav-button left" id="science-prev">&#60;</button>
                <div class="cards-wrapper">
                    <div class="cards" id="science"></div>
                </div>
                <button class="nav-button right" id="science-next">&#62;</button>
            </div>
        </div>

        <div class="category">
            <h2>Түүх нийгэм</h2>
            <div class="carousel-container">
                <button class="nav-button left" id="social-studies-prev">&#60;</button>
                <div class="cards-wrapper">
                    <div class="cards" id="social-studies"></div>
                </div>
                <button class="nav-button right" id="social-studies-next">&#62;</button>
            </div>
        </div>

        <div class="category">
            <h2>Олон улсын шалгалт</h2>
            <div class="carousel-container">
                <button class="nav-button left" id="international-exams-prev">&#60;</button>
                <div class="cards-wrapper">
                    <div class="cards" id="international-exams"></div>
                </div>
                <button class="nav-button right" id="international-exams-next">&#62;</button>
            </div>
        </div>
    </div>
    <script src="./js/subjects.js"></script>
</body>
</html>
