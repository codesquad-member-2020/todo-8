class Controller {
  constructor() {
    this.initialize()
  }

  initialize() {
    this.eventHandler()
  }

  eventHandler() {
    document.addEventListener("click", event => {
      this.toggleTodoTextArea(event)
    })
  }

  toggleTodoTextArea({target}) {
    if(target.className !== 'plus icon') return
    target.closest('.column').querySelector('.todo-add-area').classList.toggle("active")
  }

  addCard() {

  }

}

export default Controller