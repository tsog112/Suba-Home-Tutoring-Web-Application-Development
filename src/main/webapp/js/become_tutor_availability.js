document.addEventListener('DOMContentLoaded', function () {
    const days = ['Даваа', 'Мягмар', 'Лхагва', 'Пүрэв', 'Баасан', 'Бямба', 'Ням'];
    const form = document.getElementById('availability-form');

    days.forEach(day => {
        const dayLower = day.toLowerCase();
        const formGroup = document.createElement('div');
        formGroup.className = 'form-group';

        formGroup.innerHTML = `
            <input type="checkbox" id="${dayLower}" name="${dayLower}">
            <label for="${dayLower}">${day}</label>
            <div class="time-selects" id="${dayLower}-times" style="display: none;">
                <div class="time-slot">
                    <label>From</label>
                    <select name="${dayLower}_from[]">
                        <option>09:00</option>
                        <option>10:00</option>
                        <option>11:00</option>
                        <option>12:00</option>
                        <option>13:00</option>
                        <option>14:00</option>
                        <option>15:00</option>
                        <option>16:00</option>
                        <option>17:00</option>
                        <option>18:00</option>
                        <option>19:00</option>
                        <option>20:00</option>
                        <option>21:00</option>
                        <option>22:00</option>
                        <option>23:00</option>
                        <option>24:00</option>
                        <option>01:00</option>
                        <option>02:00</option>
                        <option>03:00</option>
                        <option>04:00</option>
                        <option>05:00</option>
                        <option>06:00</option>
                        <option>07:00</option>
                        <option>08:00</option>
                        <!-- Add more options as needed -->
                    </select>
                    <label>To</label>
                    <select name="${dayLower}_to[]">
                        <option>10:00</option>
z                    <option>11:00</option>
                    <option>12:00</option>
                    <option>13:00</option>
                    <option>14:00</option>
                    <option>15:00</option>
                    <option>16:00</option>
                    <option>17:00</option>
                    <option>18:00</option>
                    <option>19:00</option>
                    <option>20:00</option>
                    <option>21:00</option>
                    <option>22:00</option>
                    <option>23:00</option>
                    <option>24:00</option>
                    <option>01:00</option>
                    <option>02:00</option>
                    <option>03:00</option>
                    <option>04:00</option>
                    <option>05:00</option>
                    <option>06:00</option>
                    <option>07:00</option>
                    <option>08:00</option>
                    <option>09:00</option>
                        <!-- Add more options as needed -->
                    </select>
                </div>
                <button type="button" class="add-timeslot">Add another timeslot</button>
            </div>
        `;

        form.appendChild(formGroup);
    });

    const formFooter = document.createElement('div');
    formFooter.className = 'form-footer';
    formFooter.innerHTML = `
        <button type="button" class="back-btn" onclick="history.back()">← Буцах</button>
        <button type="submit" class="continue-btn">Үргэлжлүүлэх →</button>
    `;
    form.appendChild(formFooter);

    const formGroups = document.querySelectorAll('.form-group input[type="checkbox"]');
    formGroups.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            const timeSelects = this.parentElement.querySelector('.time-selects');
            if (this.checked) {
                timeSelects.style.display = 'flex';
            } else {
                timeSelects.style.display = 'none';
            }
        });
    });

    const addTimeslotButtons = document.querySelectorAll('.add-timeslot');
    addTimeslotButtons.forEach(function (button) {
        button.addEventListener('click', function () {
            const timeSelects = this.parentElement;
            const newTimeSlot = document.createElement('div');
            newTimeSlot.classList.add('time-slot');
            newTimeSlot.innerHTML = `
                <label>From</label>
                <select name="${this.parentElement.id}_from[]">
                    <option>09:00</option>
                    <option>10:00</option>
                    <option>11:00</option>
                    <option>12:00</option>
                    <option>13:00</option>
                    <option>14:00</option>
                    <option>15:00</option>
                    <option>16:00</option>
                    <option>17:00</option>
                    <option>18:00</option>
                    <option>19:00</option>
                    <option>20:00</option>
                    <option>21:00</option>
                    <option>22:00</option>
                    <option>23:00</option>
                    <option>24:00</option>
                    <option>01:00</option>
                    <option>02:00</option>
                    <option>03:00</option>
                    <option>04:00</option>
                    <option>05:00</option>
                    <option>06:00</option>
                    <option>07:00</option>
                    <option>08:00</option>
                    <!-- Add more options as needed -->
                </select>
                <label>To</label>
                <select name="${this.parentElement.id}_to[]">
                    <option>10:00</option>
                    <option>11:00</option>
                    <option>12:00</option>
                    <option>13:00</option>
                    <option>14:00</option>
                    <option>15:00</option>
                    <option>16:00</option>
                    <option>17:00</option>
                    <option>18:00</option>
                    <option>19:00</option>
                    <option>20:00</option>
                    <option>21:00</option>
                    <option>22:00</option>
                    <option>23:00</option>
                    <option>24:00</option>
                    <option>01:00</option>
                    <option>02:00</option>
                    <option>03:00</option>
                    <option>04:00</option>
                    <option>05:00</option>
                    <option>06:00</option>
                    <option>07:00</option>
                    <option>08:00</option>
                    <option>09:00</option>
                    
                    <!-- Add more options as needed -->
                </select>
                <button type="button" class="remove-timeslot">Remove</button>
            `;

            timeSelects.insertBefore(newTimeSlot, this);

            const removeTimeslotButtons = newTimeSlot.querySelectorAll('.remove-timeslot');
            removeTimeslotButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    newTimeSlot.remove();
                });
            });
        });
    });
});
