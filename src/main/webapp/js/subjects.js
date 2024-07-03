
const categories = {
    'foreign-languages': [
        { subject: 'Англи хэл', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/dc261dacd5b7bab17429f936c05b95758f21d9e33c89ddd8916ba7e9d0debfb0?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'English', tutors: 37 },
        { subject: 'Солонгос хэл', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/67d277e9-7cae-4df0-be1e-195f907775f4?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Korean', tutors: 46 },
        { subject: 'Хятад хэл', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/b99a0facef7de88af58b1e191ae1b85f70328a99ad4995f0219821591b24531a?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Chinese', tutors: 168 },
        { subject: 'Франц хэл', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/7058a770ccce2bf4040e1c2a1ee2a0dfeea4262c491ce6f066e5b52cb9cf8ea6?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'French', tutors: 73 }
    ],
    'science': [
        { subject: 'Математик', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/37430eeee52b0d4e4eef3b21cc44e73374956bc1203d0d60bd9d4c79f8ec2552?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Mathematics', tutors: 37 },
        { subject: 'Физик', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/a6ce678a6a3b5da87a47353e26d4b8ea74a050cbc52d92a768d31eae552b77ee?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Physics', tutors: 46 },
        { subject: 'Биологи', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/55327808a5952b5161b57641f4e194587e823c27b96456a73e7638859e8e8e19?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Biology', tutors: 168 },
        { subject: 'Хими', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Chemistry', tutors: 73 }
    ],
    'social-studies': [
        { subject: 'Эдийн засаг', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/837a6256c1e09f477891b97b023cc24ff116dee8fac6ef7ad238d18ab32eaeda?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Economics', tutors: 37 },
        { subject: 'Газар зүй', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/6709773b-ba68-4a94-bcb6-fed6c9354f50?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Geography', tutors: 46 },
        { subject: 'Дэлхийн түүх', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/837a6256c1e09f477891b97b023cc24ff116dee8fac6ef7ad238d18ab32eaeda?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'World History', tutors: 168 },
        { subject: 'Улс төр', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'Government', tutors: 73 }
    ],
    'international-exams': [
        { subject: 'sat', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'SAT', tutors: 37 },
        { subject: 'toefl', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'TOEFL', tutors: 46 },
        { subject: 'ielts', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'IELTS', tutors: 168 },
        { subject: 'topik', img: 'https://cdn.builder.io/api/v1/image/assets/TEMP/e65b79add1a68dd13a9b4303a06d066817859b992d71b01376690514f9e49966?apiKey=57152f1071394277ae0234a3c334b9e4&', title: 'TOPIK', tutors: 73 }
    ]
};
document.addEventListener('DOMContentLoaded', () => {
    for (const [categoryId, cards] of Object.entries(categories)) {
        const categoryElement = document.getElementById(categoryId);
        cards.forEach(card => {
            const cardElement = document.createElement('div');
            cardElement.classList.add('card');
            cardElement.setAttribute('data-subject', card.subject);
            cardElement.innerHTML = `
                <img src="${card.img}" alt="${card.title}">
                <h3>${card.title}</h3>
                <p>${card.tutors} tutors</p>
            `;
            categoryElement.appendChild(cardElement);

            // Add event listener to redirect to find_tutor page
            cardElement.addEventListener('click', () => {
                const subject = card.subject;
                window.location.href = `find_tutor.jsp?subject=${subject}`;
            });
        });
    }

    const cardWidth = 270; // Width of each card plus margin

    function moveLeft(categoryId) {
        const category = document.getElementById(categoryId);
        const lastCard = category.lastElementChild;
        category.insertBefore(lastCard, category.firstElementChild);
        category.style.transition = 'none';
        category.style.transform = `translateX(-${cardWidth}px)`;
        requestAnimationFrame(() => {
            category.style.transition = 'transform 0.3s ease-in-out';
            category.style.transform = 'translateX(0)';
        });
    }

    function moveRight(categoryId) {
        const category = document.getElementById(categoryId);
        const firstCard = category.firstElementChild;
        category.appendChild(firstCard);
        category.style.transition = 'none';
        category.style.transform = `translateX(${cardWidth}px)`;
        requestAnimationFrame(() => {
            category.style.transition = 'transform 0.3s ease-in-out';
            category.style.transform = 'translateX(0)';
        });
    }

    document.querySelectorAll('.nav-button.left').forEach(button => {
        button.addEventListener('click', () => {
            const categoryId = button.nextElementSibling.querySelector('.cards').id;
            moveLeft(categoryId);
        });
    });

    document.querySelectorAll('.nav-button.right').forEach(button => {
        button.addEventListener('click', () => {
            const categoryId = button.previousElementSibling.querySelector('.cards').id;
            moveRight(categoryId);
        });
    });
});
