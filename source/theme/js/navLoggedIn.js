/*
import { enhance } from './utils';

export default enhance('nav-logged-in', element => {
  if (document.cookie.indexOf('xxx') < 0) {
    return;
  }
  const item = element.querySelector('.js-login-nav-item');

  if (item) {
    item.style.display = 'none';
  }

  const link = element.querySelector('.js-signup-nav-link');

  if (link) {
    link.classList.add('is-dashboard');
    link.href = element.getAttribute('data-dashboard-url');
    link.textContent = 'Dashboard';
  }
});
*/