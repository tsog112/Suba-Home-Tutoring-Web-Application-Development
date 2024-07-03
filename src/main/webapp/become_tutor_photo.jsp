<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style/become_tutor_photo.css">
    <title>Become a Tutor</title>
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
            <div class="form-header">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/79227c0ee227ecb876bd59c2805a55f6f3fe28068616f59329a9987685b138c7?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Profile Icon" class="header-icon">
                <h2>Профайл зураг</h2>
            </div>
            <form action="become_tutor_photo_process.do" method="POST" enctype="multipart/form-data">
                <div class="form-row">
                    <div class="photo-upload">
                        <h3>Анхны гайхалтай сэтгэгдэл төрүүлээрэй</h3>
                        <p>Найрсаг, мэргэжлийн харагддаг багш нар хамгийн олон оюутан авдаг</p>
                        <label class="upload-btn">
                            Зураг оруулах
                            <input type="file" name="photo" accept="image/*" required onchange="previewImage(event)">
                        </label>
                        <p>JPG эсвэл PNG формат, дээд тал нь 5MB</p>
                        <div class="photo-placeholder" id="photo-placeholder">
                            <img src="placeholder.png" alt="Photo Placeholder" id="photo-preview">
                        </div>
                    </div>
                    <div class="photo-tips">
                        <h3>Гайхамшигтай зураг оруулах зөвлөмжүүд</h3>
                        <ul>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Инээмсэглээд камер руу хараарай</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Толгой ба мөр хэсгээ гаргаарай</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Таны зураг төв хэсэгт, цэх байрлалтай байна</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Төвийг сахисан гэрэлтүүлэг, дэвсгэр ашиглаарай</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Таны царай, нүд бүрэн харагдаж байх ёстой шүү</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Лого болон холбоо барих мэдээллээс зайлсхийгээрэй</li>
                            <li><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/427a9dd3-6988-4c70-853c-253592150d07?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Check"> Зурган дээрх цорын ганц хүн байхыг хичээгээрэй</li>
                        </ul>
                    </div>
                </div>
                <div class="form-navigation">
                    <button type="button" class="back-btn" onclick="history.back()">← Буцах</button>
                    <button type="submit" class="continue-btn">Үргэлжлүүлэх →</button>
                </div>
            </form>
        </main>
    </div>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('photo-preview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
