class Controller {
  constructor() {
    this.initialize()
  }

  initialize() {
    this.eventHandler()
  }

  eventHandler() {
    document.addEventListener("click", event => {
      switch(event.target.className) {
        case 'plus icon' :
          this.toggleTodoTextArea(event)
          break;
        case 'x icon' :
          this.removeTotoCard(event)
        default :
          return
      }
    })
  }

  toggleTodoTextArea({target}) {
    target.closest('.column').querySelector('.todo-add-area').classList.toggle("active")
  }

  removeTotoCard({target}) {
    target.closest('.todo-items').remove()
  }

}

export default Controller