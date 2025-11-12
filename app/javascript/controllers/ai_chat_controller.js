import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["consultations", "spinner", "form"]

  connect() {
    console.log("✅ ai-chat controller loaded")
  }

  async submit(event) {
    event.preventDefault()
    console.log("🟡 submit開始")

    const form = event.target
    const formData = new FormData(form)

    // --- thinkingメッセージを挿入 ---
    console.log("consultationsTarget:", this.consultationsTarget) 
    const thinkingElement = document.createElement("div")
    thinkingElement.className = "bg-gray-100 text-gray-600 p-3 rounded-xl my-2 text-sm text-center"
    thinkingElement.textContent = "🤔 AIが考え中…"
    this.consultationsTarget.appendChild(thinkingElement)

    // --- スピナーを表示 ---
    this.spinnerTarget.classList.remove("hidden")

    try {
      const response = await fetch(form.action, {
        method: form.method,
        body: formData,
        headers: { "Accept": "application/json" },
        credentials: "same-origin",
      })
      const data = await response.json()

      console.log("📩 response受信:", data)

      // --- thinking削除 & スピナー非表示 ---
      thinkingElement.remove()
      this.spinnerTarget.classList.add("hidden")

      // --- 応答追加 ---
      this.consultationsTarget.insertAdjacentHTML("beforeend", data.html)

      // --- フォームリセット ---
      form.reset()
    } catch (error) {
      console.error("❌ fetchエラー:", error)
      this.spinnerTarget.classList.add("hidden")
      thinkingElement.textContent = "⚠️ 応答を取得できませんでした"
    }
  }
}
