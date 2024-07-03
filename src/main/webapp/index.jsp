<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./style/index.css">
<title>Tutor Finder</title>
</head>
<body>
<header class="header">
    <img src="./picture/logo.png" alt="Company Logo" class="logo"/>
    <nav class="navigation">
      <a href="#" class="nav-link active">Нүүр хуудас</a>
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
            <input type="text" placeholder="хайх..." class="search-input">
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

<main>
    <div class="container">
      <div class="content-wrapper">
        <div class="row">
          <div class="left-column">
            <div class="hero-content">
              <h1 class="hero-title">
                <span>Тохирох <span style="color: rgb(23, 26, 31)">багшаа</span></span>
                <span style="color: rgb(110, 117, 209)">ол</span>
              </h1>
              <p class="hero-description">
                Хичээлийн хоцрогдол, элсэлтийн ерөнхий шалгалт гэх мэт бүхий л асуудлыг гэрийн багшдаа даатга
              </p>
              <button class="explore-button">Хайх</button>
            </div>
          </div>
          <div class="right-column">
            <div class="image-container">
              
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/f789351795eb04d663e21419ff43d1b46bab9e7033d72ffd4151f79b08ab9ae1?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Tutor" class="tutor-image" />
              <div class="speech-bubble">
                <div class="speech-bubble-row">
                  <div class="speech-bubble-left">
                    <div class="speech-bubble-text">Тийм ээ, би англи хэлээ сайжруулмаар байна</div>
                  </div>
                  <div class="speech-bubble-right">
                    <div class="speech-bubble-question">
                      <span style="color: rgb(23, 26, 31)">Чамд гэрийн багш</span>
                      <span style="color: rgb(110, 117, 209)">хэрэгтэй юу?</span>
                    </div>
                  </div>
                </div>
              </div>
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/2b73ff46bee0a6060e28f15a98c6809a4d73081de20033f142e03cfc1a8d9252?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Student" class="student-image" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <br><br><br>
    <div class="subject-selection-container">
      <h1>Ямар <span>хичээл</span> хайж байна?</h1><br><br>
      <div class="search-bar">
        <input type="text" placeholder="Хайх хичээлээ оруулна уу...">
        <button>Хайх</button>
      </div><br><br>
      <div class="subjects-carousel">
        <button class="nav-button" id="prevButton">&lt;</button>
        <div class="subjects-wrapper">
          <div class="subjects" id="subjects">
            <div class="subject-card" data-subject="math">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/2657e6448a9f3e42d760fefb76d8c32b8ff1ec24601559bcfda92dbad8276006?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Math">
              <h3>Гадаад хэл</h3>
              <p>37 багш</p>
            </div>
            <div class="subject-card" data-subject="physics">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/93c022f1e189e95d184d5a13bc62bb86ceea66dfbe5ec8f7378146aa28815471?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Physics">
              <h3>Шинжлэх ухаан</h3>
              <p>46 багш</p>
            </div>
            <div class="subject-card" data-subject="language">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/4e38c5b7824615a9ac448972b567cff2876203a40c58bf9ebdfa0761c7b517df?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Language">
              <h3>Түүх/Нийгэм</h3>
              <p>168 багш</p>
            </div>
            <div class="subject-card" data-subject="science">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/bf964753ebf96081121b49fb45050c37468734e7cc91d3d89c0c3abccb4d60c4?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Science">
              <h3>Олон улсын шалгалт</h3>
              <p>73 багш</p>
            </div>
            <!-- Additional cards can be added here -->
          </div>
        </div>
        <button class="nav-button" id="nextButton">&gt;</button>
      </div>
    </div>
    <section class="popular-tutors-section">
      <div class="popular-tutors-container">
        <h2 class="section-title">Яг одоо эрэлттэй буй багш нар</h2>
        <p class="section-description">Хичээлийн хоцрогдолоо тэдэнд даатга</p>
        <div class="tutors-grid" id="tutors-grid">
          <!-- Tutor cards will be injected here by JavaScript -->
        </div>
        <button class="see-more-button">Дэлгэрэнгүйг үзэх</button>
      </div>
    </section>
  </main>

  <footer class="footer">
    <div class="footer-content">
      <div class="footer-top">
        <img src="./picture/logo.png" alt="Brand logo" class="logo" loading="lazy" />
        <div class="footer-links">
          <div class="product-links">
            <h3 class="product-heading">Product</h3>
            <a href="#" class="all-tutors-link">All Tutors</a>
            <a href="#" class="subjects-link">Subjects</a>
          </div>
          <div class="resources-links">
            <h3 class="resources-heading">Resources</h3>
            <a href="#" class="blog-link">Blog</a>
            <a href="#" class="user-guides-link">User guides</a>
            <a href="#" class="webinars-link">Webinars</a>
          </div>
          <div class="company-links">
            <h3 class="company-heading">Company</h3>
            <a href="#" class="about-link">About</a>
            <a href="#" class="join-us-link">Join us</a>
          </div>
          <div class="newsletter-section">
            <h3 class="newsletter-heading">Subscribe to our newsletter</h3>
            <p class="newsletter-description">
              For product announcements and exclusive insights
            </p>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <span class="copyright">© 2024 Brand, Inc.</span>
        <span class="separator">•</span>
        <a href="#" class="privacy-link">Privacy</a>
        <span class="separator">•</span>
        <a href="#" class="terms-link">Terms</a>
        <span class="separator">•</span>
        <a href="#" class="sitemap-link">Sitemap</a>
      </div>
    </div>
  </footer>

  <script src="./js/index.js"></script>
</body>
</html>
