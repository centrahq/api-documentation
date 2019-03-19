import { enhance } from './utils';

// Test via a getter in the options object to see if the passive property is accessed
const detectPassiveScrollSupport = () => {
  let supportsPassive = false;
  try {
    let opts = Object.defineProperty({}, 'passive', {
      get: function() {
        supportsPassive = true;
      },
    });
    window.addEventListener('testPassive', null, opts);
    window.removeEventListener('testPassive', null, opts);
  } catch (e) {}

  return supportsPassive;
};

export default enhance('navigation', () => {
  const subNavigation = document.querySelector('.js-navigation');
  const subNavigationItems = document.querySelectorAll('.js-navigation-item');
  const supportsPassive = detectPassiveScrollSupport();

  window.addEventListener(
    'scroll',
    () => {
      requestAnimationFrame(() => {
        const offsetY = window.pageYOffset;
        if (offsetY > 120) {
          subNavigationItems.forEach(node => node.classList.add('navigation-item--small'));
          subNavigation.classList.add('navigation--small');
        } else {
          subNavigation.classList.remove('navigation--small');
          subNavigationItems.forEach(node => node.classList.remove('navigation-item--small'));
        }
      });
    },
    // Use our detect's results. passive applied if supported, capture will be false either way.
    supportsPassive ? { passive: true } : false,
  );
});
