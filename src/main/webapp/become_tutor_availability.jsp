<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./style/become_tutor_availability.css">
<title>Become a Tutor - Availability</title>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <h2>Багш болох</h2>
            <div class="progress-container">
                <div class="step">
                    <div class="step-number active">1</div>
                    <div class="step-label active">Тухай</div>
                </div>
                <div class="step">
                    <div class="step-number active">2</div>
                    <div class="step-label active">Зураг</div>
                </div>
                <div class="step">
                    <div class="step-number active">3</div>
                    <div class="step-label active">Тайлбар</div>
                </div>
                <div class="step">
                    <div class="step-number active">4</div>
                    <div class="step-label active">Цагийн хуваарь</div>
                </div>
                <div class="step">
                    <div class="step-number">5</div>
                    <div class="step-label">Цагийн үнэлгээ</div>
                </div>
            </div>
        </aside>
        <main class="content">
            <div class="info-box">
                <p><strong>Илүү олон сурагч авахын тулд оргил цагуудыг нэмээрэй</strong><br>Олон сурагчид 17:00-19:00 цагийн хооронд хичээлээ захиалдаг. Захиалга авах боломжоо нэмэгдүүлэхийн тулд эдгээр оргил цагаар цагийн хуваарийг нэмээрэй.</p>
            </div>
            <div class="form-header">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/79227c0ee227ecb876bd59c2805a55f6f3fe28068616f59329a9987685b138c7?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="icon" width="32" height="32"> 
                <h2>Цагийн хуваарь</h2>
                
            </div>
                <p>Өөрийн боломжит цагийн хуваариа оруулаарай</p>
                <p>Боломжтой байдал нь таны боломжит ажлын цагийг харуулдаг. Сурагчид энэ цагт хичээлээ захиалж болно.</p>
            <form id="availability-form" action="become_tutor_availability_process.do" method="POST">
                <!-- Form groups will be inserted here by JavaScript -->
            </form>
        </main>
    </div>
     <script src="./js/become_tutor_availability.js"></script>
</body>
</html>
