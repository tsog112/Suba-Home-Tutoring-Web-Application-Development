<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="./style/tutor_edit_profile_price.css">
</head>
<body>
    <main class="profile-edit-container">
        <div class="profile-edit-content">
            <aside class="sidebar">
                <a href="index.do" class="back-button">&larr; Буцах</a>
                <ul>
                    <li><a href="student_edit_profile_account.do">Бүртгэл</a></li>
                    <li><a href="student_edit_profile_password.do">Нууц үг</a></li>
                    <li><a href="tutor_edit_profile_description.do">Тайлбар</a></li>
                    <li><a href="#" class="active">Цагийн үнэлгээ</a></li>
                </ul>
            </aside>
            <section class="pricing-settings">
                <h2>Цагийн үнэлгээ</h2>
                <form class="pricing-form" action="tutor_edit_profile_price_process.do" method="POST">
                    <div class="form-group">
                        <label for="hourly-rate">Цагийн үндсэн тарифаа тохируулна уу</label>
                        <p>Өөрийн профайл руу илүү олон оюутан авахын тулд бид таны хичээлийн шинэ багш нарт цагийн 10'000₮-ийн үндсэн үнийг санал болгож байна.</p>
                        <div class="rate-input">
                            <input type="number" id="hourly-rate" name="hourly_rate" value='<%= request.getAttribute("hourly_rate")%>'>
                            
                            <span class="currency-symbol">₮</span>
                        </div>
                        <p class="note"><i class="fas fa-info-circle"></i> Зөвшөөрөгдсөний дараа тохиргооноос үндсэн тарифаа өөрчилнө үү</p>
                    </div>
                    <div class="form-group">
                        <label for="commission">Багшийн комисс</label>
                        <p>Бид энэ мөнгийг илүү олон оюутан авах, сургалтын платформоо байнга сайжруулахад зарцуулдаг</p>
                        <div class="checkbox-group">
                            <input type="checkbox" id="commission" name="commission" checked>
                            <label for="commission">Дараагийн бүх хичээлийн хувьд SUBA цагийн хөлсний тодорхой хувийг (10%) авдаг.</label>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="save-button">Хадгалах</button>
                    </div>
                </form>
            </section>
        </div>
    </main>
    
    <script>
        <% if (request.getAttribute("message") != null) { %>
            alert('<%= request.getAttribute("message") %>');
        <% } %>
    </script>
</body>
</html>
