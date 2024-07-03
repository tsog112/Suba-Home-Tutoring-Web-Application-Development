<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Profile</title>
    <link rel="stylesheet" href="./style/tutor_profile.css">
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
    <div class="container">
        <div class="tutor-details">
            <div class="tutor-card">
                <img src="<%= request.getAttribute("profilePicture") %>" alt="Tutor Image" class="tutor-image" style="width: 230px; height: 230px; object-fit: cover; border-radius: 10%; margin-right: 20px;">
                <div class="tutor-info">
                    <h2><%= request.getAttribute("fullName") %></h2>
                    <p><%= request.getAttribute("catchyTitle") %></p>
                    <div class="tutor-meta">
                        <p><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/e6b67ab907949583091a7cb435c8e2b9ea32e57b512677acf82693b9174d5981?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Icon"> Заах хичээл: <%= request.getAttribute("subjects") %></p>
                        <p><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/0396775d92560bea063b7e2b4ec5ee3d3cb7f50d5a92f4954ac62d2635b1fcb2?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Icon"> Туршлага: <%= request.getAttribute("experienceYears") %> years</p>
                        <p><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/18ec72497ed6bf1559b2c7ccb4d2108dab630987f50710de602ccbb41b39a33d?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Icon"> <%= request.getAttribute("lessonsTaught") %> нийт сурагчид</p>
                    </div>
                </div>
            </div>
            <div class="tabs">
                <button class="tab active" data-tab="about">Тухай</button>
                <button class="tab" data-tab="schedule">Цагийн хуваарь</button>
                <button class="tab" data-tab="reviews">Сэтгэгдэл</button>
                <button class="tab" data-tab="resume">Боловсрол</button>
            </div>
            <div class="tab-content">
                <div id="about" class="tab-pane active">
                    <h3>Багшийн тухай</h3>
                    <p><%= request.getAttribute("introduction") %></p>
                    <a href="#" class="read-more">Нуух</a>
                </div>
                <div id="schedule" class="tab-pane">
                    <h3>Цагийн хуваарь</h3>
                    <div class="schedule-calendar">
                        <table>
                            <thead>
                                <tr>
                                    <th>7 хоног</th>
                                    <th>Эхлэх цаг</th>
                                    <th>Дуусах цаг</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    JSONArray schedules = (JSONArray) request.getAttribute("schedules");
                                    if (schedules != null) {
                                        for (int i = 0; i < schedules.length(); i++) {
                                            JSONObject schedule = schedules.getJSONObject(i);
                                            String dayOfWeek = schedule.getString("dayOfWeek");
                                            String startTime = schedule.getString("startTime");
                                            String endTime = schedule.getString("endTime");
                                %>
                                <tr>
                                    <td><%= dayOfWeek %></td>
                                    <td><%= startTime %></td>
                                    <td><%= endTime %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3">Хараахан хуваариа оруулаагүй байна</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="reviews" class="tab-pane">
                    <h3>Сурагчидын сэтгэгдэл</h3>
                    <div class="reviews-list" id="reviews-list">
                        <%
                            JSONArray reviews = (JSONArray) request.getAttribute("reviews");
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            if (reviews != null) {
                                for (int i = 0; i < reviews.length(); i++) {
                                    JSONObject review = reviews.getJSONObject(i);
                                    String studentId = review.getString("studentId");
                                    int rating = review.getInt("rating");
                                    String comment = review.getString("comment");
                                    long createdAtLong = review.getLong("createdAt");
                                    Timestamp createdAt = new Timestamp(createdAtLong);
                        %>
                        <div class="review-item">
                            <div class="review-header">
                                <img src="path/to/student_icon.png" alt="Student Image" class="reviewer-image">
                                <div class="reviewer-info">
                                    <p class="reviewer-name"><%= studentId %></p>
                                    <p class="review-date"><%= sdf.format(createdAt) %></p>
                                </div>
                            </div>
                            <div class="review-content">
                                <div class="stars">
                                    <%
                                        for (int j = 0; j < rating; j++) {
                                            out.print("★");
                                        }
                                        for (int j = rating; j < 5; j++) {
                                            out.print("☆");
                                        }
                                    %>
                                </div>
                                <p><%= comment %></p>
                            </div>
                        </div>
                        <%
                                }
                            } else {
                        %>
                        <p>Хараахан сэтгэгдэл байхгүй байна</p>
                        <%
                            }
                        %>
                    </div>
                    <button class="more-reviews">Дэлгэрэнгүй</button>
                </div>
                <div id="resume" class="tab-pane">
                    <h3>Боловсролын гэрчилгээ</h3>
                    <%
                        JSONArray education = (JSONArray) request.getAttribute("education");
                        if (education != null) {
                            for (int i = 0; i < education.length(); i++) {
                                JSONObject edu = education.getJSONObject(i);
                                String university = edu.getString("university");
                                String degree = edu.getString("degree");
                                String specialization = edu.getString("specialization");
                                int startYear = edu.getInt("startYear");
                                int endYear = edu.getInt("endYear");
                    %>
                    <div class="resume-item">
                        <div class="resume-year"><%= startYear %> — <%= endYear %></div>
                        <div class="resume-details">
                            <p><%= university %></p>
                            <p><%= degree %> in <%= specialization %></p>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>Хараахан боловсролын зэргээ оруулаагүй байна</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-info">
                    <div class="tutor-review-price">
                        <div class="rating-group">
                            <div class="rating"><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/1a435912708a0b56624769dac7b47c25d88c6df17af45727840c44e94b164236?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Star Icon"><span><%= request.getAttribute("averageRating") %></span></div>
                            <div class="reviews"><%= request.getAttribute("reviewCount") %> reviews</div>
                        </div>
                        <div class="price-group">
                            <div class="price">₮<%= request.getAttribute("hourlyRate") %></div>
                            <div class="onehour">1 цагийн үнэ</div>
                        </div>
                    </div>
                    <div class="buttons">
                        <button class="message-button">Мессеж илгээх</button>
                        <button class="book-button">Захиалах</button>
                    </div>
                </div>
            </div>
            <div class="review-summary">
                <h3><%= request.getAttribute("averageRating") %>/5</h3>
                <p>(<%= request.getAttribute("reviewCount") %> сэтгэгдэл)</p>
                <div class="stars">
                    <span>
                        <%
                            double averageRating = (double) request.getAttribute("averageRating");
                            int fullStars = (int) averageRating;
                            for (int i = 0; i < fullStars; i++) {
                                out.print("★");
                            }
                            for (int i = fullStars; i < 5; i++) {
                                out.print("☆");
                            }
                        %>
                    </span>
                </div>
                <div class="review-breakdown">
                    <%
                        JSONObject ratingSummary = (JSONObject) request.getAttribute("ratingSummary");
                        int reviewCount = (int) request.getAttribute("reviewCount");
                        if (ratingSummary != null && reviewCount > 0) {
                            for (int i = 5; i >= 1; i--) {
                                int count = ratingSummary.optInt(String.valueOf(i), 0);
                                int percentage = count * 100 / reviewCount;
                    %>
                    <div class="review-bar">
                        <span class="rating-label"><%= i %></span>
                        <div class="bar">
                            <div class="bar-filled" style="width: <%= percentage %>%;"></div>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>Хараахан сэтгэгдэл байхгүй байна</p>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="education">
                <h3>Боловсрол</h3>
                <%
                    if (education != null) {
                        for (int i = 0; i < education.length(); i++) {
                            JSONObject edu = education.getJSONObject(i);
                            String university = edu.getString("university");
                            String degree = edu.getString("degree");
                            String specialization = edu.getString("specialization");
                            int startYear = edu.getInt("startYear");
                            int endYear = edu.getInt("endYear");
                %>
                <p><%= university %><br>
                    <span><%= startYear %> - <%= endYear %></span><br>
                    <%= degree %> in <%= specialization %></p>
                <%
                        }
                    } else {
                %>
                <p>Хараахан боловсролын зэргээ оруулаагүй байна</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const tabs = document.querySelectorAll('.tab');
            const tabPanes = document.querySelectorAll('.tab-pane');

            tabs.forEach(tab => {
                tab.addEventListener('click', () => {
                    tabs.forEach(t => t.classList.remove('active'));
                    tab.classList.add('active');

                    const tabContent = tab.getAttribute('data-tab');
                    tabPanes.forEach(pane => {
                        if (pane.id === tabContent) {
                            pane.classList.add('active');
                        } else {
                            pane.classList.remove('active');
                        }
                    });
                });
            });

            const messageButton = document.querySelector('.message-button');
            messageButton.addEventListener('click', () => {
                window.location.href = 'chat.html';
            });
        });
    </script>
</body>
</html>
