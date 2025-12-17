import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ["messages"]
  static values = { currentUserId: Number }

  connect() {
    this.observeMessages()
    this.markMessages()
    this.scrollToBottom()
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  resetForm(event) {
    if (event.detail.success) {
      event.target.reset()
    }
    this.scrollToBottom()
  }

  observeMessages() {
    this.observer = new MutationObserver(() => {
      this.markMessages()
      this.scrollToBottom()
    })
    this.observer.observe(this.messagesTarget, { childList: true, subtree: false })
  }

  markMessages() {
    const currentId = String(this.currentUserIdValue)
    this.messagesTarget.querySelectorAll("[data-sender-id]").forEach((node) => {
      const mine = node.dataset.senderId === currentId
      node.classList.toggle("chat-message--mine", mine)
      node.classList.toggle("chat-message--theirs", !mine)
    })
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
  }
}
