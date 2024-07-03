<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style/become_tutor_about.css">
    <title>Become a Tutor</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
                    <div class="step-number">2</div>
                    <div class="step-label">Зураг</div>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <div class="step-label">Тайлбар</div>
                </div>
                <div class="step">
                    <div class="step-number">4</div>
                    <div class="step-label">Цагийн хуваарь</div>
                </div>
                <div class="step">
                    <div class="step-number">5</div>
                    <div class="step-label">Цагийн үнэлгээ</div>
                </div>
            </div>
        </aside>
        <main class="content">
            <div class="info-box">
                <p>Олон нийтийн багшийн профайлыг бий болгох. Хэсэг бүрийг бөглөхөд таны ахиц дэвшил автоматаар хадгалагдах болно. Бүртгэлээ дуусгахын тулд хүссэн үедээ буцаж болно.</p>
            </div>
            <div class="form-header">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/28bb3b81b3dee980e070160cc93697a26a94ee8839075c5af352e496789601a3?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="icon" width="32" height="32">
                <h2>About</h2>
            </div>
            <form id="tutor-form" action="become_tutor_about_process.do" method="POST">
                <div class="form-row">
                    <div class="form-field">
                        <label for="full-name">Овог нэр</label>
                        <input type="text" name="fullname" id="full-name" placeholder="Овог нэр">
                    </div>
                    <div class="form-field">
                        <label for="id">ID</label>
                        <input type="text" name="id" id="id" placeholder="ID">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field form-field-password">
                        <label for="password">Нууц үг</label>
                        <input type="password" name="password" id="password" placeholder="Нууц үг">
                        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
                    </div>
                    <div class="form-field form-field-password">
                        <label for="confirm-password">Нууц үг баталгаажуулах</label>
                        <input type="password" name="confirm-password" id="confirm-password" placeholder="Нууц үг баталгаажуулах">
                        <span class="password-toggle-icon"><i class="fas fa-eye"></i></span>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="phone-number">Утасны дугаар</label>
                        <input type="tel" name="phone" id="phone-number" placeholder="(976)99119911">
                    </div>
                    <div class="form-field">
                        <label for="email">И-Мэйл</label>
                        <input type="email" name="email" id="email" placeholder="И-Мэйл">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="subject">Заах хичээл</label>
                        <select name="subject" id="subject">
                            <option value="" disabled selected>Хичээлээ сонго</option>
                            <option value="1">Англи хэл</option>
						    <option value="2">Солонгос хэл</option>
						    <option value="3">Хятад хэл</option>
						    <option value="4">Франц хэл</option>
						    <option value="5">Математик</option>
						    <option value="6">Физик</option>
						    <option value="7">Биологи</option>
						    <option value="8">Хими</option>
						    <option value="9">Эдийн засаг</option>
						    <option value="10">Газар зүй</option>
						    <option value="11">Дэлхийн түүх</option>
						    <option value="12">Улс төр</option>
						    <option value="13">SAT</option>
						    <option value="14">TOEFL</option>
						    <option value="15">IELTS</option>
						    <option value="16">TOPIK</option>
                        </select>
                    </div>
                    <div class="form-field form-field-dob">
                        <label for="birthdate">Төрсөн огноо</label>
                        <input type="date" name="birthdate" id="birthdate" class="birthdate-input"/>
                    </div>
                </div>
                <div class="form-footer">
                    <p class="gender-label">Хүйс</p>
                    <div class="form-field-sex">
                        <label for="male"><input type="radio" name="gender" id="male" value="male"> Эрэгтэй </label>
                        <label for="female"><input type="radio" name="gender" id="female" value="female"> Эмэгтэй</label>
                    </div>
                    <div class="form-field-confirm">
                        <label for="confirm-age"><input type="checkbox" id="confirm-age"> Би 18-с дээш настай</label>
                    </div>
                    <button type="submit" class="form-submit">Үргэлжлүүлэх</button>
                </div>
            </form>
        </main>
    </div>
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

        document.getElementById('tutor-form').addEventListener('submit', function(event) {
            event.preventDefault();
            
            const fullName = document.getElementById('full-name').value;
            const id = document.getElementById('id').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const phoneNumber = document.getElementById('phone-number').value;
            const email = document.getElementById('email').value;
            const subject = document.getElementById('subject').value;
            const birthdate = document.getElementById('birthdate').value;
            const gender = document.querySelector('input[name="gender"]:checked');
            const confirmAge = document.getElementById('confirm-age').checked;

            if (
                fullName && id && password && confirmPassword && 
                phoneNumber && email && subject && birthdate && 
                gender && confirmAge
            ) {
                this.submit();
            } else {
                alert('Please fill in all fields.');
            }
        });
    </script>
</body>
</html>
