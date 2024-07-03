<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style/signup.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<title>Signup</title>
</head>
<body>
	<main class="signup-container">
    <h1 class="signup-title"> Эхэлцгээе 🚀</h1>
    <p class="signup-subtitle">Өөрийн бүртгэлээ үүсгэ</p>
    <form action="signup_process.do" method="POST">
      <div class="input-wrapper fullname-input">
        <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/62f211e5f70cb90c4bb383e7469969bc5fc20d3a1ee5ff8803b530137ee06804?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Full name icon" class="input-icon" />
        <label for="fullname" class="visually-hidden">Овог нэр</label>
        <input type="text" name="fullname" id="fullname" placeholder="Овог нэр" class="input-placeholder" />
      </div>
      <div class="input-wrapper id-input">
        <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/62f211e5f70cb90c4bb383e7469969bc5fc20d3a1ee5ff8803b530137ee06804?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="ID icon" class="input-icon" />
        <label for="id" class="visually-hidden">ID</label>
        <input type="text" name="id" id="id" placeholder="ID" class="input-placeholder" />
      </div>
      <div class="input-wrapper phone-input">
        <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/f81ef7d5a3c1f3829cc319dc102f454f60694189a304937d2d391d06c93d97ba?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Phone icon" class="input-icon" />
        <label for="phone" class="visually-hidden">Утасны дугаар</label>
        <input type="tel" name="phone" id="phone" placeholder="Утасны дугаар" class="input-placeholder" />
      </div>
      <div class="input-wrapper email-input">
        <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/8ef8670ee5896a421234b6be7f732c99884a0192a1d4e3fff8934a150975dcc3?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Email icon" class="input-icon" />
        <label for="email" class="visually-hidden">И-Мэйл</label>
        <input type="email" name="email" id="email" placeholder="И-мэйл" class="input-placeholder" />
      </div>
      <div class="input-wrapper password-input">
        <div class="password-wrapper">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/f7038a527da51cc9c695baad75e98ed967cb8bcbf1a424efd3d9e481835102b8?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Password icon" class="input-icon" />
          <label for="password" class="visually-hidden">Нууц үг</label>
          <input type="password" name="password" id="password" placeholder="Нууц үг" class="input-placeholder" />
        </div>
        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
      </div>
      <div class="input-wrapper confirm-password-input">
        <div class="password-wrapper">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/f7038a527da51cc9c695baad75e98ed967cb8bcbf1a424efd3d9e481835102b8?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="Confirm password icon" class="input-icon" />
          <label for="confirm-password" class="visually-hidden">Нууц үг баталгаажуулах</label>
          <input type="password" name="confirm-password" id="confirm-password" placeholder="Нууц үг баталгаажуулах" class="input-placeholder" />
        </div>
        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
      </div>
      <div class="gender-wrapper">
        <p class="gender-label">Хүйс</p>
        <div class="gender-options">
          <label class="gender-option">
            <input type="radio" name="gender" id="gender-male" name="gender" value="male" />
            <span class="gender-label-text">Эрэгтэй</span>
          </label>
          <label class="gender-option">
            <input type="radio" name="gender" id="gender-female" name="gender" value="female" />
            <span class="gender-label-text">Эмэгтэй</span>
          </label>
        </div>
      </div>
      <div class="birthdate-wrapper">
        <label for="birthdate" class="birthdate-label">Төрсөн огноо</label>
        <input type="date" name="birthdate" id="birthdate" class="birthdate-input" />
      </div>
      <button type="submit" class="signup-button">Бүртгүүлэх</button>
    </form>
    <p class="terms-text">
     Үргэлжлүүлснээр та манай
      <a href="#" class="terms-link">Нөхцөл, Нууцлалын бодлогыг</a>
      
      <a href="#" class="terms-link">зөвшөөрч байна</a>
    </p>
    <div class="login-wrapper">
      <p class="login-text">Хэдийн бүртгэлтэй юу?</p>
      <a href="login.do" class="login-link">Нэвтрэх</a>
    </div>
  </main>
  <script>
    document.querySelectorAll('.password-toggle-icon').forEach(item => {
      item.addEventListener('click', function () {
        const input = this.previousElementSibling.querySelector('input');
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