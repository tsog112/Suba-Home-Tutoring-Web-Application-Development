/**
 * 
 */document.addEventListener('DOMContentLoaded', () => {
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
  });