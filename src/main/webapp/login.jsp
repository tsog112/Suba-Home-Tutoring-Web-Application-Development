<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
 <link rel="stylesheet" href="./style/login.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
	<main class="container">
    <h1 class="heading">Эхэлцгээе 🚀</h1>
    <p class="subheading">Нэвтрэх</p>
    
         <c:choose>
	 	<c:when test="${error =='-1' }">
	 	<label>Буруу имэйл эсвэл нууц үгlabel>
	 		<!-- <script type="text/javascript">
	 			alert("");
	 		</script>
	 	 --></c:when>
	 </c:choose>
	 
    <form action ="login_process.do" method="POST">
      <div class="input-wrapper id-input">
        <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/62f211e5f70cb90c4bb383e7469969bc5fc20d3a1ee5ff8803b530137ee06804?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="" class="icon" />
        <label for="id" class="visually-hidden">Таны ID юу вэ</label>
        <input type="text" name="id" id="id" placeholder="Таны ID юу вэ?" class="input-placeholder" />
      </div>
      <div class="input-wrapper password-input">
        <div class="password-wrapper">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/840b83c849dd739aefac46e0de5978388ea16051a59e86cdc211187e1627a137?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="" class="icon" />
          <label for="password" class="visually-hidden">Нууц үг</label>
          <input type="password" name="password" id="password" placeholder="Нууц үгээ оруулна уу" class="password-placeholder" />
        </div>
        <span class="password-toggle-icon">
          <i class="fas fa-eye"></i>
        </span>
      </div>
      <a href="#" class="forgot-password">Нууц үгээ мартсан уу?</a>
      <button type="submit" class="login-button">Нэвтрэх</button>
    </form>
    <p class="terms-text">
      Үргэлжлүүлснээр та манай <a href="#" class="terms-link">Нөхцөл , Нууцлалын бодлогыг </a> зөвшөөрч байна <a href="#" class="terms-link"></a>
    </p>
    <div class="signup-section">
      <p class="signup-text">Бүртгэлтэй юу?</p>
      <a href="signup.do" class="signup-link">Бүртгүүлэх</a>
    </div>
  </main>
  <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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