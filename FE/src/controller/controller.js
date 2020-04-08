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
    if(confirm("선택하신 카드를 삭제하시겠습니까?") == true) {
      target.closest('.todo-items').remove();
    } else {
      return false;
    }
    
  }

}

export default Controller