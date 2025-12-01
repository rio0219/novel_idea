import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["consultations", "latest", "spinner", "form"]

  connect() {
    console.log("✅ ai-chat controller loaded")
  }

  async submit(event) {
    event.preventDefault()

    const form = this.formTarget // event.target でもOKだけど、target名で取る方が安全
    const formData = new FormData(form)

    // ① いま表示されている「最新の相談」を退避しておく
    const previousLatestHtml = this.latestTarget.innerHTML

    // ② latest に thinking 表示
    const thinkingElement = document.createElement("div")
    thinkingElement.className =
      "bg-gray-100 text-gray-600 p-3 rounded-xl my-2 text-sm text-center"
    thinkingElement.textContent = "AIが考え中…"

    this.latestTarget.innerHTML = ""
    this.latestTarget.appendChild(thinkingElement)

    this.spinnerTarget.classList.remove("hidden")

    try {
      const response = await fetch(form.action, {
        method: form.method,
        body: formData,
        headers: { Accept: "application/json" },
        credentials: "same-origin",
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const data = await response.json()

      // ③ thinking を消してスピナーを止める
      this.latestTarget.innerHTML = ""
      this.spinnerTarget.classList.add("hidden")

      // ④ さっきまで「最新の相談」だったものを
      //    「過去の相談」のいちばん上に移動する
      if (previousLatestHtml && previousLatestHtml.trim() !== "") {
        this.consultationsTarget.insertAdjacentHTML(
          "afterbegin",
          previousLatestHtml
        )
      }

      // ⑤ 今回の相談＋AI回答を「最新の相談」として表示
      this.latestTarget.innerHTML = data.html

      // ⑥ フォームリセット
      form.reset()
    } catch (error) {
      console.error("❌ fetchエラー:", error)

      this.spinnerTarget.classList.add("hidden")
      this.latestTarget.innerHTML = `
        <div class="bg-red-50 text-red-700 p-3 rounded-xl my-2 text-sm text-center">
          応答を取得できませんでした。時間をおいて再度お試しください。
        </div>
      `
    }
  }
}
