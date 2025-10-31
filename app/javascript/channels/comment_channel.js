import consumer from "./consumer"

document.addEventListener("turbo:load", () => {
  const commentsContainer = document.getElementById("comments")
  const postId = commentsContainer?.dataset.postId

  if (!postId) return

  consumer.subscriptions.create(
    { channel: "CommentChannel", post_id: postId },
    {
      received(data) {
        const commentHTML = `
          <div class="comment-item p-3 mb-2 bg-yellow-50 rounded-xl shadow-sm">
            <p class="font-bold">${data.user}</p>
            <p>${data.content}</p>
          </div>
        `
        commentsContainer.insertAdjacentHTML("beforeend", commentHTML)
      }
    }
  )
})
