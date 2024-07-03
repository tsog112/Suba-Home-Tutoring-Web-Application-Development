<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./style/header.css">
<script src="./js/header.js"></script>
</head>
<body>
    <header class="header">
    <img src="./picture/logo.png" alt="Company Logo" class="logo_pic" />
    <nav class="navigation">
      <a href="index.do" class="nav-link active">Нүүр хуудас</a>
      <a href="find_tutor.do" class="nav-link">Багш хайх</a>
      <a href="subjects.do" class="nav-link">Хичээл</a>
    </nav>
    <% if (session.getAttribute("id") == null) { %>
    <div class="user-actions">
      <a href="login.do" class="login-link">Нэвтрэх</a>
      <a href="signup.do" class="signup-link">Бүртгүүлэх</a>
      <a href="become_tutor_about.do" class="cta-button">Багш болох</a>
    </div>
    <% } else { 
        String profilePicture = (String) session.getAttribute("profile_picture");
    %>
    <div class="header-actions">
        <form class="search-form">
            <input type="text" placeholder="Хайх..." class="search-input">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/ce4caeb17473e187b16bb6ee9aa96ec0a38d34bedabab8bd74fcd585a26449af?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Search Icon" class="search-icon" />
        </form>
        <button class="icon-button">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/3b3b0d52ca8c216be141285b97e54e75c3279638c0139094a3b4f937fd90af1d?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Notifications" class="icon-image">
        </button>
        <button class="icon-button">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/fa2a4de42b3fa66aadb8243d8e99d96ef5798cc3319cd79634317ba77f891d42?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Messages" class="icon-image">
        </button>
        <div class="profile-dropdown">
          <img src="<%= profilePicture != null ? "data:image/jpeg;base64," + profilePicture : "https://cdn.builder.io/api/v1/image/assets/TEMP/a278e709f39155a5c4e87dd1c81eb829994ac3c16242252d2f885cbd0cf92a7d?apiKey=57152f1071394277ae0234a3c334b9e4&" %>" alt="User" class="profile-image">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/d0cd449d3560d5d9f385e8004d8d8d16ef42646a6b1759ef67f0172f05247b7a?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Dropdown" class="dropdown-icon">
          <div class="dropdown-content">
            <a href="student_edit_profile_account.do" class="dropdown-item">тохиргоо</a>
            <a href="logout.do" class="dropdown-item">гарах</a>
          </div>
        </div>
      </div>
    <% } %>
</header>
</body>
</html>