import { enhance } from './utils';
import Dropkick from 'dropkickjs';

export default enhance('link-dropdown', element => {
  element.addEventListener('change', () => {
    window.location = element.value;
  });

  new Dropkick(element, {
    mobile: false,
  });
});
