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

export default enhance('sub-navigation', () => {
  const subNavigation = document.querySelector('.js-sub-navigation');
  const subNavigationItems = document.querySelectorAll('.js-sub-navigation-item');
  const supportsPassive = detectPassiveScrollSupport();

  window.addEventListener(
    'scroll',
    () => {
      requestAnimationFrame(() => {
        const offsetY = window.pageYOffset;
        if (offsetY > 120) {
          subNavigationItems.forEach(node => node.classList.add('sub-navigation-item--small'));
          subNavigation.classList.add('sub-navigation--small');
        } else {
          subNavigation.classList.remove('sub-navigation--small');
          subNavigationItems.forEach(node => node.classList.remove('sub-navigation-item--small'));
        }
      });
    },
    // Use our detect's results. passive applied if supported, capture will be false either way.
    supportsPassive ? { passive: true } : false,
  );
});
