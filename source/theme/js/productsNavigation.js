import { enhance } from './utils';

export default enhance('products-navigation', () => {
  const productsTrigger = document.querySelector('.js-products-trigger');
  const productsNavigation = document.querySelector('.js-products-navigation');

  const PRODUCTS_CLASS = 'has-products-visible';

  productsTrigger.addEventListener('click', event => {
    event.preventDefault();
  });

  document.addEventListener('click', event => {
    if (event.target !== productsTrigger) {
      productsTrigger.classList.remove(PRODUCTS_CLASS);
      productsNavigation.classList.remove(PRODUCTS_CLASS);
    }
  });
});
