import Shuffle from 'shufflejs';

document.addEventListener("turbolinks:load", function() {
	const shuffleInstance = new Shuffle(document.querySelector('.scrapbook'), {
		itemSelector: '.scrap',
		sizer: '.sizer'
	});
})