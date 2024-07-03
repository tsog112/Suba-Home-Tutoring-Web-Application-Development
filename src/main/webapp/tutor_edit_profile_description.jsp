<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="BAGSH.dbconn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Profile</title>
<link rel="stylesheet" href="./style/tutor_edit_profile_description.css">
</head>
<body>
<%
    String id = (String) session.getAttribute("id");
    String introduction = "";
    String lesson_experience = "";
    String motivation = "";
    String catchy_title = "";
    boolean noHigherEducation = false;
    List<Map<String, String>> educationList = new ArrayList<>();

    if (id != null) {
        dbconn db = new dbconn();
        Connection conn = db.getConn();
        String query = "SELECT introduction, lesson_experience, motivation, catchy_title, no_higher_education FROM Tutors WHERE tutor_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            introduction = rs.getString("introduction");
            lesson_experience = rs.getString("lesson_experience");
            motivation = rs.getString("motivation");
            catchy_title = rs.getString("catchy_title");
            noHigherEducation = rs.getBoolean("no_higher_education");
        }
        rs.close();
        ps.close();
        
        // Fetch education details
        String educationQuery = "SELECT university, degree, specialization, start_year, end_year FROM Education WHERE tutor_id = ?";
        PreparedStatement educationPs = conn.prepareStatement(educationQuery);
        educationPs.setString(1, id);
        ResultSet educationRs = educationPs.executeQuery();
        while (educationRs.next()) {
            Map<String, String> education = new HashMap<>();
            education.put("university", educationRs.getString("university"));
            education.put("degree", educationRs.getString("degree"));
            education.put("specialization", educationRs.getString("specialization"));
            education.put("start_year", educationRs.getString("start_year"));
            education.put("end_year", educationRs.getString("end_year"));
            educationList.add(education);
        }
        educationRs.close();
        educationPs.close();
        conn.close();
    }

    String message = (String) session.getAttribute("message");
%>
<main class="profile-edit-container">
    <div class="profile-edit-content">
        <aside class="sidebar">
            <a href="index.do" class="back-button">&larr; Буцах</a>
            <ul>
                <li><a href="student_edit_profile_account.do">Бүртгэл</a></li>
                <li><a href="student_edit_profile_password.do">Нууц үг</a></li>
                <li><a href="#" class="active">Тайлбар</a></li>
                <li><a href="tutor_edit_profile_price.do">Цагийн үнэлгээ</a></li>
            </ul>
        </aside>
        <section class="description-settings">
            <h2>Тайлбар</h2>
            <form class="description-form" action="tutor_edit_profile_description_process.do" method="POST">
                <div class="form-group">
                    <label for="introduce-yourself">1. Өөрийгөө танилцуулаарай</label>
                    <textarea id="introduce-yourself" name="introduction" placeholder="Сайн уу? намайг... би тэнд амьдардаг..."><%= introduction %></textarea>
                    <p class="note">⚠️ Өөрийн овог нэрээ бүү оруул, эсвэл CV хэлбэрээр мэдээллээ бүү үзүүл</p>
                </div>
                <div class="form-group">
                    <label for="lesson-experiences">2. Өөрийн туршлагаа оруулаарай</label>
                    <textarea id="lesson-experiences" name="lesson_experience" placeholder="би 5 жилийн турш англи хэлний багшаар ажиллаж байсан..."><%= lesson_experience %></textarea>
                </div>
                <div class="form-group">
                    <label for="motivate-students">3. Сурагчиддаа мотивац өгсөн үг бичээрэй</label>
                    <textarea id="motivate-students" name="motivation" placeholder="хамтдаа хичээж илүү их зүйлийг сурцгаая."><%= motivation %></textarea>
                </div>
                <div class="form-group">
                    <label for="catchy-title">4. Сонирхолтой гарчиг бичээрэй</label>
                    <textarea id="catchy-title" name="catchy_title" placeholder="надтай хамт суралц"><%= catchy_title %></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="save-button">Хадгалах</button>
                </div>
            </form>

            <h2>Боловсрол</h2>
            <form class="education-form" action="tutor_edit_profile_education_process.do" method="POST">
                <div class="form-group">
                    <label>
                        <input type="checkbox" id="no-higher-education" name="no_higher_education" <%= noHigherEducation ? "checked" : "" %>> Надад ямар нэгэн боловсролын зэрэг байхгүй
                    </label>
                </div>
                <div id="education-section" style="<%= noHigherEducation ? "display:none;" : "" %>">
                    <% if (educationList.isEmpty()) { %>
                        <div class="education-fields">
                            <div class="form-group">
                                <label for="university">Боловсрол</label>
                                <input type="text" id="university" name="university" placeholder="E.g., Inha Technical College">
                            </div>
                            <div class="form-group">
                                <label for="degree">Зэрэг</label>
                                <input type="text" id="degree" name="degree" placeholder="E.g., Bachelor's degree in Computer Science">
                            </div>
                            <div class="form-group">
                                <label for="specialization">Мэргэжил</label>
                                <input type="text" id="specialization" name="specialization" placeholder="E.g., Teach computer languages in an easy way">
                            </div>
                            <div class="form-group years-of-study">
                                <label for="start-year">Суралцсан он</label>
                                <div class="years-of-study-selects">
                                    <select id="start-year" name="start_year">
                                        <option value="">Эхлэх</option>
                                        <option value="2023">2023</option>
                                        <option value="2022">2022</option>
                                        <option value="2021">2021</option>
                                    </select>
                                    <span> - </span>
                                    <select id="end-year" name="end_year">
                                        <option value="">Дуусах</option>
                                        <option value="2023">2023</option>
                                        <option value="2022">2022</option>
                                        <option value="2021">2021</option>
                                    </select>
                                </div>
                            </div>
                            <button type="button" class="remove-education" style="display:none;">Устгах</button>
                        </div>
                    <% } else { %>
                        <% for (Map<String, String> education : educationList) { %>
                            <div class="education-fields">
                                <div class="form-group">
                                    <label for="university">Их сургууль</label>
                                    <input type="text" id="university" name="university" placeholder="E.g., Inha Technical College" value="<%= education.get("university") %>">
                                </div>
                                <div class="form-group">
                                    <label for="degree">Зэрэг</label>
                                    <input type="text" id="degree" name="degree" placeholder="E.g., Bachelor's degree in Computer Science" value="<%= education.get("degree") %>">
                                </div>
                                <div class="form-group">
                                    <label for="specialization">Мэргэжил</label>
                                    <input type="text" id="specialization" name="specialization" placeholder="E.g., Teach computer languages in an easy way" value="<%= education.get("specialization") %>">
                                </div>
                                <div class="form-group years-of-study">
                                    <label for="start-year">Суралцсан он</label>
                                    <div class="years-of-study-selects">
                                        <select id="start-year" name="start_year">
                                            <option value="">Эхлэх</option>
                                            <option value="2023" <%= "2023".equals(education.get("start_year")) ? "selected" : "" %>>2023</option>
                                            <option value="2022" <%= "2022".equals(education.get("start_year")) ? "selected" : "" %>>2022</option>
                                            <option value="2021" <%= "2021".equals(education.get("start_year")) ? "selected" : "" %>>2021</option>
                                        </select>
                                        <span> - </span>
                                        <select id="end-year" name="end_year">
                                            <option value="">Дуусах</option>
                                            <option value="2023" <%= "2023".equals(education.get("end_year")) ? "selected" : "" %>>2023</option>
                                            <option value="2022" <%= "2022".equals(education.get("end_year")) ? "selected" : "" %>>2022</option>
                                            <option value="2021" <%= "2021".equals(education.get("end_year")) ? "selected" : "" %>>2021</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="button" class="remove-education" style="display:none;">Устгах</button>
                            </div>
                        <% } %>
                    <% } %>
                </div>
                <div class="add-education-container">
                    <a href="#" class="add-education">Өөр боловсролын зэрэг нэмэх</a>
                </div>
                <div class="form-actions">
                    <button type="submit" class="save-button">Хадгалах</button>
                </div>
            </form>
        </section>
    </div>
</main>
<script>
    document.getElementById('no-higher-education').addEventListener('change', function() {
        const educationSection = document.getElementById('education-section');
        if (this.checked) {
            educationSection.style.display = 'none';
        } else {
            educationSection.style.display = 'block';
        }
    });

    document.querySelector('.add-education').addEventListener('click', function(e) {
        e.preventDefault();
        const educationSection = document.getElementById('education-section');
        const newFields = educationSection.firstElementChild.cloneNode(true);
        newFields.querySelectorAll('input').forEach(input => input.value = '');
        newFields.querySelector('select[name="start_year"]').value = '';
        newFields.querySelector('select[name="end_year"]').value = '';
        newFields.querySelector('.remove-education').style.display = 'block';
        educationSection.appendChild(newFields);
    });

    document.getElementById('education-section').addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-education')) {
            e.target.parentElement.remove();
        }
    });

    <% if (message != null) { %>
        alert('<%= message %>');
        <% session.removeAttribute("message"); %>
    <% } %>
</script>
</body>
</html>
