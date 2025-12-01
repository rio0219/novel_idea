document.addEventListener("turbo:load", () => {
  // === work#index だけで動作 ===
  const isWorkIndex = document.body.dataset.controller === "works-index";
  if (!isWorkIndex) return;

  const overlay = document.getElementById("tutorial-overlay");
  if (!overlay) return;

  const slides = document.querySelectorAll(".tutorial-slide");
  const nextBtn = document.getElementById("slide-next");
  const prevBtn = document.getElementById("slide-prev");
  const finishBtn = document.getElementById("slide-finish");

  let current = 0;

  // スライド表示処理
  const showSlide = (index) => {
    slides.forEach((s, i) => {
      s.classList.toggle("hidden", i !== index);
    });

    prevBtn.classList.toggle("hidden", index === 0);
    nextBtn.classList.toggle("hidden", index === slides.length - 1);
    finishBtn.classList.toggle("hidden", index !== slides.length - 1);
  };

  // === 初回表示 / ?ボタン強制表示 ===
  const forceFromParam = new URLSearchParams(window.location.search).get("tutorial") === "1";

  if (forceFromParam || !localStorage.getItem("tutorial_shown")) {
    overlay.classList.remove("hidden");
  }

  // === ボタンイベント ===
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
