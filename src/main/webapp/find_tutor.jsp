<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find a Tutor</title>
    <link rel="stylesheet" href="./style/find_tutor.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <style>
        .hidden {
            display: none;
        }
        .show {
            display: block;
        }
        .dropdown-content {
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .extra-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
    <main>
        <h1>Өөрт тохирох багшаа хайя</h1>
        <div class="filter-container">
            <div class="main-filters">
                <div class="filter-group">
                    <label for="subjects">Би сурахыг хүсэж байна</label>
                    <select id="subjects">
                        <option value="all">Бүх хичээл</option>
                        
                        <option value="english">Англи хэл</option>
                        <option value="korean">Солонгос хэл</option>
                        <option value="chinese">Хятад хэл</option>
                        <option value="french">Франц хэл</option>
                        
                        <option value="math">Математик</option>
                        <option value="physics">Физик</option>
                        <option value="biology">Биологи</option>
                        <option value="chemistry">Хими</option>
                        
                        <option value="economics">Эдийн засаг</option>
                        <option value="geography">Газар зүй</option>
                        <option value="world-history">Дэлхийн түүх</option>
                        <option value="government">Улс төр</option>
                        
                        <option value="sat">SAT</option>
                        <option value="toefl">TOEFL</option>
                        <option value="ielts">IELTS</option>
                        <option value="topik">TOPIK</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="price">Нэг цагийн үнэлгээ</label>
                    <div class="custom-select">
                        <button id="price-dropdown-button">₮1,000 - ₮50,000+</button>
                        <div class="price-slider-container hidden">
                            <input type="range" id="price-range" min="1000" max="50000" step="500" value="10000">
                            <span id="price-range-value">₮1,000 - ₮10,000</span>
                        </div>
                    </div>
                </div>
                <div class="filter-group">
                    <label for="availability">Боломжит цагийн хуваарь</label>
                    <div class="custom-select">
                        <button id="availability-button">хэдийд ч</button>
                        <div id="availability-dropdown" class="dropdown-content hidden">
                            <div class="time-section">
                                <h3>Цаг</h3>
                                <h4>Өдрийн цаг</h4>
                                <div class="time-options">
                                    <button class="time-btn" data-time="9-12">9-12</button>
                                    <button class="time-btn" data-time="12-15">12-15</button>
                                    <button class="time-btn" data-time="15-18">15-18</button>
                                </div>
                                <h4>Оройн цаг</h4>
                                <div class="time-options">
                                    <button class="time-btn" data-time="18-21">18-21</button>
                                    <button class="time-btn" data-time="21-24">21-24</button>
                                    <button class="time-btn" data-time="0-3">0-3</button>
                                </div>
                                <h4>Өглөөний цаг</h4>
                                <div class="time-options">
                                    <button class="time-btn" data-time="3-6">3-6</button>
                                    <button class="time-btn" data-time="6-9">6-9</button>
                                </div>
                            </div>
                            <div class="day-section">
                                <h3>Гараг</h3>
                                <div class="day-options">
                                    <button class="day-btn" data-day="Sun">Ням</button>
                                    <button class="day-btn" data-day="Mon">Даваа</button>
                                    <button class="day-btn" data-day="Tue">Мягмар</button>
                                    <button class="day-btn" data-day="Wed">Лхагва</button>
                                    <button class="day-btn" data-day="Thu">Пүрэв</button>
                                    <button class="day-btn" data-day="Fri">Баасан</button>
                                    <button class="day-btn" data-day="Sat">Бямба</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <button class="more-filters">Илүү нарвийчлалтай</button>
            </div>
            <div id="extra-filters" class="extra-filters hidden">
                <div class="filter-group">
                    <label for="specialties">Мэргэжил</label>
                    <select id="specialties">
                        <option>Багш</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="gender">Хүйс</label>
                    <select id="gender">
                        <option>Бүгд</option>
                        <option>Эрэгтэй</option>
                        <option>Эмэгтэй</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="age">Нас</label>
                    <select id="age">
                        <option>Бүгд</option>
                        <option value="10-20">10-20</option>
                        <option value="20-30">20-30</option>
                        <option value="30-40">30-40</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label for="sort">Англилах</label>
                    <select id="sort">
                        <option value="top-picks">Топ үнэлгээтэй</option>
                        <option value="price-low-high">Үнэ: Багаас ихрүү</option>
                        <option value="price-high-low">Үнэ: Ихээс багаруу</option>
                        <option value="rating">Өндөр сэтгэгдэлтэй</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="main-content">
            <div class="tutor-list">
                <!-- Tutor cards will be injected here by JavaScript -->
            </div>
            <aside class="profile-sidebar">
                <div id="profile-card" class="profile-card hidden">
                    <img src="https://via.placeholder.com/300" alt="Profile Image">
                    <div class="profile-info">
                        <h2>Jay Rutherford</h2>
                        <p>Struggling with English? I am here to help!</p>
                        <div class="rating">
                            <span>4.8</span>
                            <span>71 reviews</span>
                        </div>
                        <div class="price">
                            <span>₩15,000</span>
                            <span>1-hour lesson</span>
                        </div>
                        <button class="send-message-button">Мессеж илгээх</button>
                        <button class="book-button">Захиалах</button>
                        <div class="review-summary">
                            <h3>4.8/5</h3>
                            <p>(1000+ reviews)</p>
                            <div class="stars">
                                <span>★★★★★</span>
                            </div>
                        </div>
                        <div class="education">
                            <h3>Боловсрол</h3>
                            <p>Hanyang University Graduate School</p>
                            <p>September 2016 - August 2018</p>
                            <p>Finance and Insurance Major</p>
                            <p>Hanyang University</p>
                            <p>March 2008 - August 2016</p>
                            <p>Department of Applied Mathematics</p>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
        <div class="pagination">
            <button class="pagination-btn" data-page="1">1</button>
            <button class="pagination-btn" data-page="2">2</button>
            <button class="pagination-btn" data-page="3">3</button>
        </div>
    </main>
    <script src="./js/find_tutor.js"></script>
    <!-- <script>
        document.addEventListener('DOMContentLoaded', () => {
        const availabilityButton = document.getElementById('availability-button');
        const availabilityDropdown = document.getElementById('availability-dropdown');

        availabilityButton.addEventListener('click', function(event) {
            event.stopPropagation();
            availabilityDropdown.classList.toggle('show');
            console.log('Toggling availability dropdown visibility');
            console.log('Availability dropdown class list:', availabilityDropdown.classList);
        });

        document.addEventListener('click', function(event) {
            if (!availabilityDropdown.contains(event.target) && !availabilityButton.contains(event.target)) {
                availabilityDropdown.classList.remove('show');
                console.log('Hiding availability dropdown');
            }
        });

        const timeButtons = document.querySelectorAll('.time-btn');
        const dayButtons = document.querySelectorAll('.day-btn');

        timeButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.classList.toggle('active');
                updateAvailability();
            });
        });

        dayButtons.forEach(button => {
            button.addEventListener('click', function() {
                this.classList.toggle('active');
                updateAvailability();
            });
        });

        function updateAvailability() {
            const activeTimes = Array.from(document.querySelectorAll('.time-btn.active')).map(btn => btn.dataset.time);
            const activeDays = Array.from(document.querySelectorAll('.day-btn.active')).map(btn => btn.dataset.day.toLowerCase());
            const availabilityText = [...activeTimes, ...activeDays].join(', ') || 'Any time';
            availabilityButton.textContent = availabilityText;

            filters.availability.days = activeDays;
            filters.availability.times = activeTimes;

            fetchTutors();
        }

        });
    </script> -->
</body>
</html>
