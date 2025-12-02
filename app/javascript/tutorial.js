document.addEventListener("turbo:load", () => {
  const overlay = document.getElementById("tutorial-overlay");
  if (!overlay) return;

  const slides = document.querySelectorAll(".tutorial-slide");
  const nextBtn = document.getElementById("slide-next");
  const prevBtn = document.getElementById("slide-prev");
  const finishBtn = document.getElementById("slide-finish");

  let current = 0;

  // === どのページか判定 ===
  const currentPage = document.body.dataset.controller;  // 例: "works-index"

  // === ?ボタン押したとき（tutorial=1） ===
  const forceFromParam = new URLSearchParams(window.location.search).get("tutorial") === "1";

  // === 初回表示（work#index のみ）===
  const isWorkIndex = currentPage === "works-index";
  const firstVisit = !localStorage.getItem("tutorial_shown");

  if ((isWorkIndex && firstVisit) || forceFromParam) {
    overlay.classList.remove("hidden");
  }

  // === スライド表示 ===
  const showSlide = (index) => {
    slides.forEach((s, i) => {
      s.classList.toggle("hidden", i !== index);
    });

    prevBtn.classList.toggle("hidden", index === 0);
    nextBtn.classList.toggle("hidden", index === slides.length - 1);
    finishBtn.classList.toggle("hidden", index !== slides.length - 1);
  };

  // === ボタン操作 ===
  nextBtn?.addEventListener("click", () => {
    current = Math.min(current + 1, slides.length - 1);
    showSlide(current);
  });

  prevBtn?.addEventListener("click", () => {
    current = Math.max(current - 1, 0);
    showSlide(current);
  });

  finishBtn?.addEventListener("click", () => {
    overlay.classList.add("hidden");
    localStorage.setItem("tutorial_shown", "true");
  });
});
