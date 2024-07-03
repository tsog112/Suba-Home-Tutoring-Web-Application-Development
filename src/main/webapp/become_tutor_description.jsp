<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Become a Tutor</title>
    <link rel="stylesheet" href="./style/become_tutor_description.css">
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
           
            <div class="form-header">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/79227c0ee227ecb876bd59c2805a55f6f3fe28068616f59329a9987685b138c7?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="icon" width="32" height="32">
                <h2>Профайл тайлбар</h2>
            </div>
            <form action="become_tutor_description_process.do" method="POST">
                <div class="form-row">
                    <div class="form-field">
                        <label for="introduce">1. Өөрийгөө танилцуулаарай</label>
                        <textarea id="introduce" name="introduce" placeholder="Сайн уу, намайг ..."></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="experience">2. Туршалгаа хуваалцаарай</label>
                        <textarea id="experience" name="experience" placeholder="би англи хэлний хичээл 5 жилийн турш зааж байна..."></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="motivate">3. Сурагчиддаа мотивац өгөөрэй</label>
                        <textarea id="motivate" name="motivate" placeholder="хамтдаа эхний хичээлээ эхлүүлцгээе..."></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-field">
                        <label for="title">4. Сонирхолтой гарчиг бичээрэй</label>
                        <textarea id="title" name="title" placeholder="англи хэлийг илүү хөгжилтэй сурцгаая"></textarea>
                    </div>
                </div>
                <div class="form-header">
                    <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/79227c0ee227ecb876bd59c2805a55f6f3fe28068616f59329a9987685b138c7?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Education Icon" width="32" height="32">
                    <h2>Боловсрол</h2>
                </div>
                <div class="form-field">
                    <label>
                        <input type="checkbox" id="no-higher-education" > Надад ямар нэгэн боловсролын зэрэг байхгүй
                    </label>
                </div>
                <div id="education-section">
                    <div class="form-field">
                        <label for="university">Их сургууль</label>
                        <input type="text" id="university" name="university" placeholder="E.g., Ithaca Technical College">
                    </div>
                    <div class="form-field">
                        <label for="degree">Зэрэг</label>
                        <input type="text" id="degree" name="degree" placeholder="E.g., Bachelor's degree in Computer Science">
                    </div>
                    <div class="form-field">
                        <label for="specialization">Мэргэжил</label>
                        <input type="text" id="specialization" name="specialization" placeholder="E.g., Teach computer languages in an easy way">
                    </div>
                    <div class="form-field years-of-study">
                        <label for="start-year">Суралцсан огноо</label>
                        <div class="years-of-study-selects">
                            <select id="start-year" name="start_year">
                                <option value="">Эхлэл</option>
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                                <!-- Add more years as needed -->
                            </select>
                            <span>-</span>
                            <select id="end-year" name="end_year">
                                <option value="">Дуусах</option>
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                                <!-- Add more years as needed -->
                            </select>
                        </div>
                    </div>
                    <button type="button" class="remove-education" style="display:none;">Устгах</button>
                   
                </div>
                <div class="form-navigation">
                    <button type="button" class="back-btn" onclick="history.back()">← Буцах</button>
                    <button type="submit" class="continue-btn">Үргэлжлүүлэх →</button>
                </div>
            </form>
        </main>
    </div>
    <script>
        document.getElementById('no-higher-education').addEventListener('change', function() {
            const educationSection = document.getElementById('education-section');
            if (this.checked) {
                educationSection.style.display = 'none';
            } else {
                educationSection.style.display = 'block';
            }
        });
        
    </script>
</body>
</html>
