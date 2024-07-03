<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style/become_tutor_pricing.css">
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
                    <div class="step-number active">3</div>
                    <div class="step-label active">Тайлбар</div>
                </div>
                <div class="step">
                    <div class="step-number active">4</div>
                    <div class="step-label active">Цагийн хуваарь</div>
                </div>
                <div class="step">
                    <div class="step-number active">5</div>
                    <div class="step-label active">Цагийн үнэлгээ</div>
                </div>
            </div>
        </aside>
        <main class="content">
            <h2>Цагийн үндсэн тарифаа тохируулна уу</h2>
            <p>Өөрийнхөө профайл руу илүү олон сурагч авахын тулд бид таны хичээлийн шинэ багш нарт цагийн 10,000₮ суурь үнийг санал болгож байна.</p>
           <form id="pricing-form" action="become_tutor_pricing_process.do" method="POST">
                <div class="form-group">
                    <label for="hourly_rate">Цагийн үнэлгээ</label>
                    <div class="price-input">
                        <input type="number" id="hourly_rate" name="hourly_rate" value="<%= request.getAttribute("hourlyRate") != null ? request.getAttribute("hourlyRate") : "10000" %>" min="0">
                        <span>₮</span>
                    </div>
                    <p>Зөвхөн төгрөгөөр</p>
                </div>
                <div class="info-box">
                    <p><i class="info-icon">ℹ️</i> Зөвшөөрөгдсөний дараа тохиргооноос үндсэн ханшаа өөрчилнө үү</p>
                </div>
                <div class="form-group">
                    <label>Багшийн комисс</label>
                    <p>Бид энэ мөнгийг илүү олон оюутан авах, сургалтын платформоо байнга сайжруулахад зарцуулдаг</p>
                    <div class="checkbox-group">
                        <input type="checkbox" id="suba-commission" name="suba-commission" checked>Дараагийн бүх хичээлийн хувьд SUBA цагийн хөлсний тодорхой хувийг (10%) авдаг.</label>
                    </div>
                </div>
                <div class="form-footer">
                    <button type="button" class="back-button" onclick="history.back()">← Буцах</button>
                    <button type="submit" class="continue-button">Бүртгэл баталгаажуулах →</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
