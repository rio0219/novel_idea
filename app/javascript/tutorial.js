document.addEventListener("turbo:load", () => {
  const overlay = document.getElementById("tutorial-overlay");
  if (!overlay) return;

  const slides = document.querySelectorAll(".tutorial-slide");
  const nextBtn = document.getElementById("slide-next");
  const prevBtn = document.getElementById("slide-prev");
  const finishBtn = document.getElementById("slide-finish");

  let current = 0;

  const currentPage = document.body.dataset.controller;
  const isWorkIndex = currentPage === "works-index";
  const forceFromParam = new URLSearchParams(window.location.search).get("tutorial") === "1";
  const firstVisit = !localStorage.getItem("tutorial_shown");

  // ===== work#indexでも?tutorial=1でもない → 絶対に非表示 =====
  if (!isWorkIndex && !forceFromParam) {
    overlay.style.display = "none";
    overlay.classList.add("hidden");
    return;
  }

  // === 表示条件 ===
  if ((isWorkIndex && firstVisit) || forceFromParam) {
    overlay.style.display = "block";
    overlay.classList.remove("hidden");
  }

  // === スライド切替 ===
  const showSlide = (index) => {
    slides.forEach((s, i) => {
      s.classList.toggle("hidden", i !== index);
    });
    prevBtn.classList.toggle("hidden", index === 0);
    nextBtn.classList.toggle("hidden", index === slides.length - 1);
    finishBtn.classList.toggle("hidden", index !== slides.length - 1);
  };

  nextBtn?.addEventListener("click", () => {
    current = Math.min(current + 1, slides.length - 1);
    showSlide(current);
  });

  prevBtn?.addEventListener("click", () => {
    current = Math.max(current - 1, 0);
    showSlide(current);
  });

  finishBtn?.addEventListener("click", () => {
    overlay.style.display = "none";
    overlay.classList.add("hidden");
    localStorage.setItem("tutorial_shown", "true");
  });
});
