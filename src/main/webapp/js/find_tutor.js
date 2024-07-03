document.addEventListener('DOMContentLoaded', () => {
    const profileCard = document.getElementById('profile-card');
    const tutorList = document.querySelector('.tutor-list');
    const subjectsSelect = document.getElementById('subjects');
    const priceRange = document.getElementById('price-range');
    const genderSelect = document.getElementById('gender');
    const ageSelect = document.getElementById('age');
    const specialtiesSelect = document.getElementById('specialties');
    const sortSelect = document.getElementById('sort');
    const priceDropdownButton = document.getElementById('price-dropdown-button');
    const moreFiltersButton = document.querySelector('.more-filters');
    const availabilityButton = document.getElementById('availability-button');
    const availabilityDropdown = document.getElementById('availability-dropdown');

    const dayOfWeek = {
        'sun': 'sunday',
        'mon': 'monday',
        'tue': 'tuesday',
        'wed': 'wednesday',
        'thu': 'thursday',
        'fri': 'friday',
        'sat': 'saturday'
    };

    const timeRanges = {
        '9-12': ['09:00:00', '11:59:59'],
        '12-15': ['12:00:00', '14:59:59'],
        '15-18': ['15:00:00', '17:59:59'],
        '18-21': ['18:00:00', '20:59:59'],
        '21-24': ['21:00:00', '23:59:59'],
        '0-3': ['00:00:00', '02:59:59'],
        '3-6': ['03:00:00', '05:59:59'],
        '6-9': ['06:00:00', '08:59:59']
    };

    let filters = {
        subject: 'all',
        minPrice: 1000,
        maxPrice: 50000,
        availability: {
            days: [],
            times: []
        },
        gender: 'all',
        age: 'all',
        specialty: 'all',
        sortBy: 'none'
    };

    let tutors = [];
    let currentPage = 1;
    const tutorsPerPage = 6;

    function fetchTutors() {
        console.log('Fetching tutors with filters:', filters);
        fetch('find_tutor_process.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(filters)
        })
        .then(response => response.json())
        .then(data => {
            console.log('Fetched tutors:', data);
            tutors = data;
            displayTutors(currentPage);
            updatePagination();
        })
        .catch(error => console.error('Error fetching tutors:', error));
    }

    function displayTutors(page) {
        console.log('Displaying tutors for page:', page);
        tutorList.innerHTML = '';
        const start = (page - 1) * tutorsPerPage;
        const end = start + tutorsPerPage;
        const paginatedTutors = tutors.slice(start, end);

        paginatedTutors.forEach(tutor => {
            const tutorCard = document.createElement('div');
            tutorCard.classList.add('tutor-card');
            tutorCard.innerHTML = `
                <div class="tutor-info">
                    <div class="tutor-image">
                        <img src="${tutor.image}" alt="Tutor Image">
                    </div>
                    <div class="tutor-details">
                        <div class="tutor-name">${tutor.name}</div>
                        <div class="tutor-meta"><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/e6b67ab907949583091a7cb435c8e2b9ea32e57b512677acf82693b9174d5981?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Icon">Зааж буй хичээл: ${tutor.subject}</div>
                        <div class="tutor-meta"><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/0396775d92560bea063b7e2b4ec5ee3d3cb7f50d5a92f4954ac62d2635b1fcb2?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Icon">Туршлага: ${tutor.experience} years</div>
                        <div class="tutor-description">${tutor.introduction}</div>
                        <a href="tutor_profile.do?tutorId=${tutor.id}" class="read-more">Дэлгэрэнгүй</a>
                    </div>
                </div>
                <div class="tutor-review-price">
                    <div class="price-group">
                        <div class="price">₮${tutor.price}</div>
                        <div class="onehour">1 цагийн үнэ</div>
                    </div>
                    <div class="rating-group">
                        <div class="rating"><img src="https://cdn.builder.io/api/v1/image/assets/TEMP/1a435912708a0b56624769dac7b47c25d88c6df17af45727840c44e94b164236?apiKey=57152f1071394277ae0234a3c334b9e4&" alt="Star Icon"><span>${tutor.average_rating ? tutor.average_rating.toFixed(1) : '0.0'}</span></div>
                        <div class="reviews">${tutor.rating_count ? tutor.rating_count : 0} сэтгэгдэл</div>
                    </div>
                </div>
            `;
            tutorCard.addEventListener('mouseover', () => showTutorProfile(tutor));
            tutorCard.addEventListener('click', () => {
                window.location.href = `tutor_profile.do?tutorId=${tutor.id}`;
            });
            tutorList.appendChild(tutorCard);
        });
    }

    function showTutorProfile(tutor) {
        profileCard.classList.remove('hidden');
        profileCard.querySelector('img').src = tutor.image;
        profileCard.querySelector('h2').innerText = tutor.name;
        profileCard.querySelector('.profile-info p').innerText = tutor.introduction;
        profileCard.querySelector('.profile-card .rating span:first-child').innerText = tutor.average_rating ? tutor.average_rating.toFixed(1) : '0.0';
        profileCard.querySelector('.profile-card .rating span:last-child').innerText = `${tutor.rating_count ? tutor.rating_count : 0} сэтгэгдэл`;
        profileCard.querySelector('.profile-card .price span:first-child').innerText = tutor.price;

        const reviewSummary = profileCard.querySelector('.review-summary');
        reviewSummary.querySelector('h3').innerText = `${tutor.average_rating ? tutor.average_rating.toFixed(1) : '0.0'}/5`;
        reviewSummary.querySelector('p').innerText = `(${tutor.rating_count ? tutor.rating_count : 0} сэтгэгдэл)`;
        reviewSummary.querySelector('.stars span').innerText = '★'.repeat(Math.round(tutor.average_rating));

        const education = profileCard.querySelector('.education');
        education.innerHTML = '<h3>Боловсрол</h3>';
        const uniqueEducation = [];
        tutor.education.forEach(edu => {
            const eduText = `${edu.university} ${edu.degree} ${edu.specialization} ${edu.start_year} - ${edu.end_year}`;
            if (!uniqueEducation.includes(eduText)) {
                uniqueEducation.push(eduText);
                education.innerHTML += `<p>${edu.university}</p><p>${edu.degree}</p><p>${edu.specialization}</p><p>${edu.start_year} - ${edu.end_year}</p>`;
            }
        });
    }

    function updatePriceRangeValue() {
        const priceRangeValue = document.getElementById('price-range-value');
        priceRangeValue.innerText = `₮1,000 - ₮${priceRange.value}`;
        priceDropdownButton.innerText = `₮1,000 - ₮${priceRange.value}+`;
    }

    function updatePagination() {
        const paginationContainer = document.querySelector('.pagination');
        const totalPages = Math.ceil(tutors.length / tutorsPerPage);
        console.log('Total pages:', totalPages);
        paginationContainer.innerHTML = '';

        for (let i = 1; i <= totalPages; i++) {
            const pageButton = document.createElement('button');
            pageButton.classList.add('pagination-btn');
            pageButton.dataset.page = i;
            pageButton.innerText = i;
            if (i === currentPage) {
                pageButton.classList.add('active');
            }
            pageButton.addEventListener('click', () => {
                currentPage = i;
                displayTutors(currentPage);
                updatePagination(); // Update pagination buttons to reflect the active page
            });
            paginationContainer.appendChild(pageButton);
        }
    }

    availabilityButton.addEventListener('click', function(event) {
        event.stopPropagation();
        availabilityDropdown.classList.toggle('show');
    });

    document.addEventListener('click', function(event) {
        if (!availabilityDropdown.contains(event.target) && !availabilityButton.contains(event.target)) {
            availabilityDropdown.classList.remove('show');
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
        const activeDays = Array.from(document.querySelectorAll('.day-btn.active')).map(btn => btn.dataset.day);

        const availabilityText = [...activeTimes, ...activeDays].join(', ') || 'Any time';
        availabilityButton.textContent = availabilityText;

        filters.availability.days = activeDays.map(day => dayOfWeek[day]);
        filters.availability.times = activeTimes.map(time => timeRanges[time]);

        fetchTutors();
    }

    priceDropdownButton.addEventListener('click', function () {
        const priceSliderContainer = document.querySelector('.price-slider-container');
        console.log('Toggling price slider container visibility');
        priceSliderContainer.classList.toggle('hidden');
    });

    priceRange.addEventListener('input', function (event) {
        const value = event.target.value;
        document.getElementById('price-range-value').textContent = `₩1,000 - ₩${value}+`;
        priceDropdownButton.textContent = `₮1,000 - ₮${value}+`;
        filters.minPrice = 1000;
        filters.maxPrice = parseInt(value);
        fetchTutors();
    });

    moreFiltersButton.addEventListener('click', function() {
        const extraFilters = document.getElementById('extra-filters');
        console.log('Toggling extra filters visibility');
        extraFilters.classList.toggle('hidden');
    });

    subjectsSelect.addEventListener('change', () => {
        filters.subject = subjectsSelect.value;
        fetchTutors();
    });

    genderSelect.addEventListener('change', () => {
        filters.gender = genderSelect.value;
        fetchTutors();
    });

    ageSelect.addEventListener('change', () => {
        filters.age = ageSelect.value;
        fetchTutors();
    });

    specialtiesSelect.addEventListener('change', () => {
        filters.specialty = specialtiesSelect.value;
        fetchTutors();
    });

    sortSelect.addEventListener('change', () => {
        filters.sortBy = sortSelect.value;
        fetchTutors();
    });

    // Read URL parameters and set filters accordingly
    const urlParams = new URLSearchParams(window.location.search);
    const subjectParam = urlParams.get('subject');
    if (subjectParam) {
        filters.subject = subjectParam;
        subjectsSelect.value = subjectParam;
    }

    fetchTutors(); // Initial fetch on page load
});
