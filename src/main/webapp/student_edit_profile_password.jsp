<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile</title>
<link rel="stylesheet" href="./style/student_edit_profile_password.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%
    String error = (String) request.getAttribute("error");
    String message = (String) session.getAttribute("message");
    session.removeAttribute("message"); // Clear message after displaying
    String usertype = (String) session.getAttribute("usertype");
%>
<main class="profile-edit-container">
    <div class="profile-edit-content">
        <aside class="sidebar">
            <a href="index.do" class="back-button">&larr; Буцах</a>
            <ul>
                <li><a href="student_edit_profile_account.do">Бүртгэл</a></li>
                <li><a href="student_edit_profile_password.do" class="active">Нууц үг</a></li>
                <% if ("student".equals(usertype)) { %>
                <li><a href="student_edit_profile_payment.do">Төлбөр</a></li>
                <% } else if ("tutor".equals(usertype)) { %>
                <li><a href="tutor_edit_profile_description.do">Тайлбар</a></li>
                <li><a href="tutor_edit_profile_price.do">Цагийн үнэлгээ</a></li>
                <% } %>
            </ul>
        </aside>
        <section class="password-settings">
            <h2>Нууц үгээ шинчлэх</h2>
            <% if (error != null) { %>
                <div class="error-message"><%= error %></div>
            <% } %>
            <form class="password-form" action="student_edit_profile_password_process.do" method="POST">
                <div class="form-group">
                    <label for="current-password">Одоогийн нууц үг</label>
                    <div class="password-input-wrapper">
                        <input type="password" name="password" id="current-password" placeholder="Одоогийн нууц үг">
                        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
                    </div>
                    <a href="#" class="forgot-password">Нууц үгээ мартсан?</a>
                </div>
                <div class="form-group">
                    <label for="new-password">Шинэ нууц үг</label>
                    <div class="password-input-wrapper">
                        <input type="password" name="new_password" id="new-password" placeholder="Шинэ нууц үг">
                        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirm-password">Шинэ нууц үг баталгаажуулах</label>
                    <div class="password-input-wrapper">
                        <input type="password" name="confirm_password" id="confirm-password" placeholder="Шинэ нууц үг баталгаажуулах">
                        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="change-password-button">Хадгалах</button>
                </div>
            </form>
        </section>
    </div>
</main>

<% if (message != null) { %>
    <script>
        alert('<%= message %>');
    </script>
<% } %>

<script>
document.querySelectorAll('.password-toggle-icon').forEach(item => {
    item.addEventListener('click', function () {
        const input = this.previousElementSibling;
        if (input.type === 'password') {
            input.type = 'text';
            this.innerHTML = '<i class="fas fa-eye-slash"></i>';
        } else {
            input.type = 'password';
            this.innerHTML = '<i class="fas fa-eye"></i>';
        }
    });
});
</script>
</body>
</html>
