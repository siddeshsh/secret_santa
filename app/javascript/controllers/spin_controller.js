import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spin"
export default class extends Controller {
  static targets = ["wheel", "button"]

  connect() {
    console.log("Spin controller connected")
  }

  spinWheel(event) {
    event.preventDefault()
    
    const wheel = this.wheelTarget
    const button = this.buttonTarget
    
    // Disable button during spin
    button.disabled = true
    button.textContent = "SPINNING..."
    
    // Calculate random rotation (multiple full rotations + random angle)
    const minSpins = 5
    const maxSpins = 10
    const spins = Math.floor(Math.random() * (maxSpins - minSpins + 1)) + minSpins
    const randomDegree = Math.floor(Math.random() * 360)
    const totalRotation = (spins * 360) + randomDegree
    
    // Apply rotation
    wheel.style.transform = `rotate(${totalRotation}deg)`
    
    // After animation completes, submit the form
    setTimeout(() => {
      // Submit the form
      button.form.submit()
    }, 3000) // 3 seconds to match CSS transition
  }
}
