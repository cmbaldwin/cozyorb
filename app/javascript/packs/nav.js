export const mobileNav = () => {
  const navBtn = document.querySelector('#navBtn');
  const nav = document.querySelector('#mobile-menu');

  navBtn.addEventListener('click', () => {
    nav.classList.toggle('hidden');
  });
}