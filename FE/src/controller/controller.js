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
          break;
        case 'base-add-btn' : 
          this.addTodoBtn(event)
          break;
        case 'base-cancel-btn' :
          this.cancelTodoBtn(event)
          break;
        default :
          break;
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
        addCardBtn.style.opacity = "1",
        addCardBtn.disabled = false
        ) : (
        addCardBtn.style.opacity = "0.5",
        addCardBtn.disabled = true
      );

    if(value.length > 15) {
      alert("15자 이하로 작성해 주세요.")
      event.target.value = event.target.value.substr(0, 15)
    }
  }

  addTodoBtn({ target }) {
    const parentNode = target.closest('.column')
    const todoValue = parentNode.querySelector('.todo-textarea').value
    const todoList = `
      <li class="todo-items" draggable="true">
        <div class="todo-items-title">
          <span>
            <i class="file alternate outline icon"></i>
          ${todoValue}</span>
          <button class="todo-items-btn btn"><i class="x icon card-remove"></i></button>
        </div>
        <div class="todo-writer-container">
          <span class="todo-items-writer">Added by Huey</span>
        </div>
      </li>
    `

    parentNode.querySelector('.todo-list').insertAdjacentHTML('afterbegin', todoList)
    this.initTextarea(target)
  }

  cancelTodoBtn({ target }) {
    this.initTextarea(target)
  }

  initTextarea(targetEl) {
    const parentNode = targetEl.closest('.column')
    parentNode.querySelector('.todo-textarea').value = ''
  }

}

export default Controller