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
        case 'x icon card-remove' :
          this.removeTotoCard(event)
        default :
          return
      }
    })

    document.addEventListener("input", event => {
      this.inputTodoEvent(event)
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

  inputTodoEvent(event) {
    const {target: { value }} = event
    const addCardBtn = event.target.closest('.todo-add-area').querySelector('.base-add-btn')

    value ? 
      (
        addCardBtn.disabled = true,
        addCardBtn.style.opacity = "1"
      ) : (
        addCardBtn.disabled = false,
        addCardBtn.style.opacity = "0.5"
      );

    if(value.length > 20) {
      alert("20자 이하로 작성해 주세요.")
      e.target.value = e.target.value.substr(0, 20)
      
    }
  }

  addBtnDisabed() {
    
  }

  addTodoBtn() {

  }

}

export default Controller