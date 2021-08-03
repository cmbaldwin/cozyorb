//Tippy.js for tooltips
import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css'; // optional for styling
window.tippy = tippy;
import 'tippy.js/animations/scale.css';

// Tippy.js intialization
$(document).on('turbolinks:load', function () {
	// Tippys
	tippy('.tippy', {
		allowHTML: true,
		animation: 'scale',
		inertia: true,
		theme: 'tip',
		duration: [300,0],
		interactive: true,
		interactiveBorder: 15,
		touch: true
	});
});