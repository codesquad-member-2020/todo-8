class Controller {
  constructor() {
    this.initialize()
  }

  initialize() {
    this.dragAndDrop()
    this.eventHandler()
    this.eventLog = {

    }
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
        case 'ui green ok inverted button' :
          this.updateCheckBtn()
          break;
        case 'ui red basic cancel inverted button' :
          this.updateCancelBtn()
          break;
        default :
          break;
      }
    })

    document.addEventListener("dblclick", event => {
      if(event.target.closest('.todo-items') === null) return
      this.todoListValue = event.target.closest('.todo-items').firstElementChild.innerText
      this.targetListValue = event.target.closest('.todo-items').firstElementChild
      this.setTodoCard(event)
    })

    document.addEventListener("input", event => {

      switch(event.target.className) {
        case 'todo-textarea' :
          this.inputTodoEvent(event)
          break;
        case 'todo-input-value' : 
          this.updateTodoCard(event)
      }
    })
  }

  toggleTodoTextArea({target}) {
    target.closest('.column').querySelector('.todo-add-area').classList.toggle("active")
  }

  removeTotoCard({target}) {
    if(confirm("선택하신 카드를 삭제하시겠습니까?") == true) {
      const parentNode = target.closest('.column')
      target.closest('.todo-items').remove();
      this.changeCardNumber(parentNode)
    } else {
      return false;
    }
  }

  inputTodoEvent(event) {
    const {target: { value }} = event
    const TEXT_LIMIT_LENGTH = 15
    const addCardBtn = event.target.closest('.todo-add-area').querySelector('.base-add-btn')

    value ? 
      (
        addCardBtn.style.opacity = "1",
        addCardBtn.disabled = false
        ) : (
        addCardBtn.style.opacity = "0.5",
        addCardBtn.disabled = true
      );

    if(value.length > TEXT_LIMIT_LENGTH) {
      alert("15자 이하로 작성해 주세요.")
      event.target.value = event.target.value.substr(0, TEXT_LIMIT_LENGTH)
    }
  }

  addTodoBtn(event) {
    const parentNode = event.target.closest('.column')
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
    this.initTextarea(event.target)
    this.inputTodoEvent(event)
    this.changeCardNumber(parentNode)
  }

  cancelTodoBtn(event) {
    this.initTextarea(event.target)
    this.inputTodoEvent(event)
  }

  initTextarea(targetEl) {
    const parentNode = targetEl.closest('.column')
    parentNode.querySelector('.todo-textarea').value = ''
  }

  changeCardNumber(parentNode) {
    const todoNumber = parentNode.querySelector('.todo-list').childElementCount
    parentNode.querySelector('.todo-num').innerText = todoNumber
  }

  dragAndDrop() {
    $( ".droppable-area1, .droppable-area2, .droppable-area3" ).sortable({
      connectWith: ".todo-list",
      stack: '.todo-list ul'
    }).disableSelection();
  }

  setTodoCard(event) {
    jb('.ui.basic.modal').modal('show');
    document.querySelector('.todo-input-value').value = this.todoListValue
  }

  updateTodoCard(event) {
    const TEXT_LIMIT_LENGTH = 15
    const updateBtn = document.querySelector('.ok.inverted.button')
    this.todoListValue = event.target.value
    
    event.target.value ? 
      (
        updateBtn.style.opacity = "1",
        updateBtn.disabled = false
        ) : (
        updateBtn.style.opacity = "0.5",
        updateBtn.disabled = true
      );

    if(this.todoListValue.length > TEXT_LIMIT_LENGTH) {
      event.target.value = event.target.value.substr(0, TEXT_LIMIT_LENGTH)
      alert("15자 이하로 작성해 주세요.")
    }
  }

  updateCheckBtn(event) {
    this.targetListValue.querySelector('span').innerHTML = this.todoListValue
  }

  updateCancelBtn() {
    return
  }
}

export default Controller