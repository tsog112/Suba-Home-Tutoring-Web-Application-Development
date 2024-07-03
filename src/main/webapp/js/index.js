document.addEventListener('DOMContentLoaded', () => {
  // Dropdown menu
  const profileDropdown = document.querySelector('.profile-dropdown');
  const dropdownContent = profileDropdown.querySelector('.dropdown-content');

  if (profileDropdown) {
    profileDropdown.addEventListener('click', (event) => {
      event.stopPropagation();
      dropdownContent.classList.toggle('show');
      profileDropdown.classList.toggle('open');
    });

    window.addEventListener('click', (event) => {
      if (!profileDropdown.contains(event.target)) {
        dropdownContent.classList.remove('show');
        profileDropdown.classList.remove('open');
      }
    });

    document.querySelectorAll('.dropdown-item').forEach(item => {
      item.addEventListener('click', (event) => {
        event.stopPropagation();
      });
    });
  }

  // Tutors grid
  const tutors = [
    {
      name: 'Kim',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/2d96bde17be8df6282a778bb983936ce70f914b0b0e0073e3e062edcda05d873?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/ca12fc5f192d4889b36bcb469554c8597585dce8854f5be478af1825b47c8009?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '10 жилийн туршлагатай',
      subjects: 'Математик'
    },
    {
      name: 'Park',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/20e137404c12e358103e0d0b9cd420fcd6ec5211234044c1eeee216e30be9d82?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/2a652b0be3758c7bc63a9d5fe7d1ab8453d8cc9b7873136e34b12d9d5723a6be?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '7 жилийн туршлагатай',
      subjects: 'Математик'
    },
    {
      name: 'Lee',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/f10d10343dbfebd83cdb6683efcb80822f567764e4f6a0ebbc5c33b584a69531?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d9c1d115bc9cbde9bffda47c2ac483d301931b7f8202d84b533e34e1603d8078?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '2 жилийн туршлагатай ',
      subjects: 'Биологи'
    },
    {
      name: 'Hong',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/aa15a37fe7877819c6ba38a658089c50da5207b2f6e59aeec0ff5eeb8d5121cc?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/2531830473ad7dc45c06cb03fd40c5751808c76aae512a967719d7ca2a1e1926?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '4 жилийн туршлагатай',
      subjects: 'Солонгос хэл'
    },
    {
      name: 'Lee',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/18afe6820b0937b020621efaf3ce79db71ceb37ecdee142039809b6d6c33fbb0?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/08c95a17d37c815e5ac4d8a779dfef26354b12fbcd0bbac18598204edd7f75c4?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '10 жилийн туршлагатай',
      subjects: 'Англи хэл'
    },
    {
      name: 'Kim',
      imageUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/0b03c83e1353556d759860401bdc89740aa567a6f0f1c4c086a82cf03fb0b383?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      ratingUrl: 'https://cdn.builder.io/api/v1/image/assets/TEMP/d1c5b8e5847c9af2c6e5eeffa48ab40fedf3a1926eec78ec111f50ffa4696b7e?apiKey=01d6ff4430824618bdce123ab4a16eeb&',
      experience: '13 жилийн туршлагатай',
      subjects: 'Англи хэл'
    }
  ];

  const tutorsGrid = document.getElementById('tutors-grid');
  
  tutors.forEach(tutor => {
    const tutorCard = document.createElement('a');
    tutorCard.href = `/tutor-${tutor.name.toLowerCase()}`;
    tutorCard.className = 'tutor-card';
    tutorCard.innerHTML = `
      <div class="tutor-info">
        <div class="tutor-header">
          <img src="${tutor.imageUrl}" alt="Tutor ${tutor.name}'s avatar" class="tutor-avatar" />
          <div class="tutor-name-container">
            <span class="tutor-name">${tutor.name}</span>
            <img src="${tutor.ratingUrl}" alt="Tutor ${tutor.name}'s rating" class="tutor-rating" />
          </div>
        </div>
        <div class="tutor-experience">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/b8c34d5a4648253dd3c2f6b763f3a9254128f334e269a7e26ecf4fd0c78ac860?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="" class="experience-icon" />
          <span class="experience-text">${tutor.experience}</span>
        </div>
        <div class="tutor-subject">
          <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/03781386153a63e8c53ce41f7efcae42be194b0337b7fc7352abb7aa6ab115f8?apiKey=01d6ff4430824618bdce123ab4a16eeb&" alt="" class="subject-icon" />
          <span class="subject-text">${tutor.subjects}</span>
        </div>
      </div>
    `;
    tutorsGrid.appendChild(tutorCard);
  });

  // Subject selection container
  const subjects = document.getElementById('subjects');
  const subjectCards = document.querySelectorAll('.subject-card');
  const cardWidth = 280; // Width of each card plus margin

  const moveLeft = () => {
    const lastCard = subjects.lastElementChild;
    subjects.insertBefore(lastCard, subjects.firstElementChild);
    subjects.style.transition = 'none';
    subjects.style.transform = `translateX(-${cardWidth}px)`;
    requestAnimationFrame(() => {
      subjects.style.transition = 'transform 0.3s ease-in-out';
      subjects.style.transform = 'translateX(0)';
    });
  };

  const moveRight = () => {
    const firstCard = subjects.firstElementChild;
    subjects.appendChild(firstCard);
    subjects.style.transition = 'none';
    subjects.style.transform = `translateX(${cardWidth}px)`;
    requestAnimationFrame(() => {
      subjects.style.transition = 'transform 0.3s ease-in-out';
      subjects.style.transform = 'translateX(0)';
    });
  };

  document.getElementById('nextButton').addEventListener('click', moveRight);
  document.getElementById('prevButton').addEventListener('click', moveLeft);

  subjectCards.forEach(card => {
    card.addEventListener('click', () => {
      const subject = card.getAttribute('data-subject');
      window.location.href = `subjects.html?subject=${subject}`;
    });
  });
});
