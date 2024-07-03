<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="BAGSH.subject" %>
<%@ page import="BAGSH.student_edit_profile_account_process" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./style/student_edit_profile_account.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Edit Profile</title>
</head>
<body>
<%
    String id = (String) session.getAttribute("id");
    String fullname = (String) session.getAttribute("fullname");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String password = (String) session.getAttribute("password");
    String gender = (String) session.getAttribute("gender");
    String birthdate = (String) session.getAttribute("birthdate");
    String usertype = (String) session.getAttribute("usertype");
    String profile_picture = (String) session.getAttribute("profile_picture");
    String message = (String) session.getAttribute("message");
    Integer selectedSubject = (Integer) session.getAttribute("selected_subject");

    student_edit_profile_account_process servlet = new student_edit_profile_account_process();
    List<subject> subjects = servlet.getAllSubjects();
%>
<% if (message != null) { %>
<script>
    alert("<%= message %>");
    <% session.removeAttribute("message"); %> <!-- Remove the message after showing it -->
</script>
<% } %>
<script>
    function previewImage() {
        const file = document.getElementById('profilePictureInput').files[0];
        const reader = new FileReader();
        reader.onloadend = function() {
            document.getElementById('profileImage').src = reader.result;
        };
        if (file) {
            reader.readAsDataURL(file);
        } else {
            document.getElementById('profileImage').src = '<%= profile_picture != null ? "data:image/jpeg;base64," + profile_picture : "https://via.placeholder.com/100" %>';
        }
    }

    function confirmDelete() {
        if (confirm("Are you sure you want to delete your account?")) {
            document.getElementById("delete-form").submit();
        }
    }

    async function uploadProfilePicture(event) {
        event.preventDefault();
        const form = document.getElementById('account-form');
        const formData = new FormData(form);

        try {
            const response = await fetch('student_edit_profile_account_process.do', {
                method: 'POST',
                body: formData
            });

            const result = await response.json();
            if (result.success) {
                alert('Profile picture updated successfully.');
                document.getElementById('profileImage').src = 'data:image/jpeg;base64,' + result.profilePicture;
                sessionStorage.setItem("profile_picture", result.profilePicture);
                window.location.reload();  // Reload the page to update session attributes
            } else {
                alert('Failed to update profile picture: ' + result.message);
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while updating the profile picture.');
        }
    }
</script>
<main class="profile-edit-container">
    <div class="profile-edit-content">
        <aside class="sidebar">
            <a href="index.do" class="back-button">&larr; Буцах</a>
            <ul>
                <li><a href="student_edit_profile_account.do" class="active">Бүртгэл</a></li>
                <li><a href="student_edit_profile_password.do">Нууц үг</a></li>
                <% if ("student".equals(usertype)) { %>
                <li><a href="student_edit_profile_payment.do">Төлбөр</a></li>
                <% } else if ("tutor".equals(usertype)) { %>
                <li><a href="tutor_edit_profile_description.do">Тайлбар</a></li>
                <li><a href="tutor_edit_profile_price.do">Цагийн үнэлгээ</a></li>
                <% } %>
            </ul>
        </aside>
        <section class="account-settings">
            <h2>Бүртгэлийн тохиргоо</h2>
            <form class="account-form" id="account-form" action="student_edit_profile_account_process.do" method="POST" enctype="multipart/form-data" onsubmit="uploadProfilePicture(event)">
                <div class="profile-image-section">
                    <img src="<%= profile_picture != null ? "data:image/jpeg;base64," + profile_picture : "https://via.placeholder.com/100" %>" alt="Profile Image" class="profile-image" id="profileImage">
                    <div class="profile-image-actions">
                        <input type="file" name="profilePicture" id="profilePictureInput" onchange="previewImage()">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="full-name">Овог нэр</label>
                        <input type="text" name="fullname" id="full-name" value="<%= fullname %>">
                    </div>
                    <div class="form-group">
                        <label for="id">ID</label>
                        <label id="id"><%= id %></label>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone-number">Утасны дугаар</label>
                        <input type="text" name="phone" id="phone-number" value="<%= phone %>">
                    </div>
                    <div class="form-group">
                        <label for="email">И-мэйл</label>
                        <input type="email" name="email" id="email" value="<%= email %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="date-of-birth">Төрсөн огноо</label>
                        <input type="date" name="birthdate" id="date-of-birth" value="<%= birthdate %>">
                    </div>
                </div>
                <% if ("tutor".equals(usertype)) { %>
                <div class="form-row">
                    <div class="form-group">
                        <label for="subject">Заах хичээл</label>
                        <select id="subject" name="subject">
				    <% 
				        if (selectedSubject == null || selectedSubject == 0) {
				            // No subject selected, show a default option
				            out.print("<option value=''>Хичээлээ сонго</option>");
				        } else {
				            // A subject is selected, show the selected subject
				            for (subject sub : subjects) { 
				                String selected = selectedSubject != null && sub.getId() == selectedSubject ? "selected" : "";
				                out.print("<option value='" + sub.getId() + "' " + selected + ">" + sub.getName() + "</option>");
				            }
				        }
				    %>
				</select>

                    </div>
                </div>
                <% } %>
                <div class="form-actions">
                    <button type="submit" class="save-button">Хадгалах</button>
                </div>
            </form>
            <br>
            <form id="delete-form" action="delete_process.do" method="POST">
                <button type="button" class="delete-button" onclick="confirmDelete()">Бүртгэл устгах</button>
            </form>
        </section>
    </div>
</main>
</body>
</html>
