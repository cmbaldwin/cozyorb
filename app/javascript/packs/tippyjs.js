//Tippy.js for tooltips
import tippy from 'tippy.js';
window.tippy = tippy;
import {roundArrow} from 'tippy.js';

// Tippy.js intialization
$(document).on('turbolinks:load', function () {

  // Tippys
  tippy('.help_tip', {
    allowHTML: true,
    animation: 'scale',
    inertia: true,
    theme: 'tip',
    arrow: roundArrow,
    maxWidth: 300,
    duration: [300,0],
    interactive: true,
    interactiveBorder: 15,
    touch: true
  });
  tippy('.tippy', {
    animation: 'scale',
    inertia: true,
    arrow: roundArrow,
    duration: [300,0],
    touch: true
  });
});