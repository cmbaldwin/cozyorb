// When the link with class .search-toggle is clicked, flip the arrow icon on the link from ⬇️ to ⬆️ and toggle the 'hidden' class on the element with class .custom-search
document.addEventListener('turbolinks:load', () => {
  document.querySelector('.search-toggle').addEventListener('click', (el) => {
    const up = el.target.textContent == '↑'
    up ? el.target.textContent = '↓' : el.target.textContent = '↑';
    document.querySelector('.custom-search').classList.toggle('hidden');
  });
});