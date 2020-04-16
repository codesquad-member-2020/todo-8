import { URL } from '../utils/ApiUrl.js'

class Controller {
  constructor({
    mainModel,
    todoView
  }) {
    this.mainModel = mainModel
    this.todoView = todoView
    this.initialize()
  }

  initialize() {
      this.mainModel.fetchInitRenderData(URL.MOCKUP.INIT_RENDER)
      .then(data => this.todoView.render(data))
      .then(() => {
        this.menuBtnEvent()
        this.dragAndDrop()
        this.eventHandler()
      })
    this.todoStatus = ''
    this.eventLog = {
      time: '방금',
      event: '',
      title: '',
      column: ''
    }
    this.todoCardData = {
      "categoryId" : "",
    	"author" : "nigayo",
	    "title" : "",
	    "contents" : ""
    }
  }

  menuBtnEvent() {
    jb('.menu-btn').on("click", () => 
    jb('.menu-container')
      .transition('fly left')
    )

    jb('.menu-close-btn').on("click", () => {
    jb('.menu-container')
      .transition('fly left')
    })
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
          this.addTodoCard(event)
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

  setLogMessage(event, title, column) {
    this.eventLog.event = event
    this.eventLog.title = title
    this.eventLog.column = column
  }

  addTodoCard(event) {
    const parentNode = event.target.closest('.column')
    const todoValue = parentNode.querySelector('.todo-textarea').value
    this.todoView.addCardRender(parentNode, todoValue)
    this.initTextarea(event.target);
    this.inputTodoEvent(event);
    this.changeCardNumber(parentNode);
    const addColumn = parentNode.querySelector('.todo-column-title').innerText;
    this.setLogMessage('added', todoValue, addColumn);
    this.activityLogEvent();
    this.todoCardData.categoryId = parentNode.dataset.columnId
    this.todoCardData.title = todoValue
    this.mainModel.fetchAddCard(`${URL.MOCKUP.BASE_URL}cards`, this.todoCardData)
  }

  removeTotoCard({target}) {
    if(confirm("선택하신 카드를 삭제하시겠습니까?") == true) {
      const parentNode = target.closest('.column')
      target.closest('.todo-items').remove();
      const removeTitle = target.closest('.todo-items').querySelector('span').innerText.trim()
      const removeColumn = parentNode.querySelector('.todo-column-title').innerText
      this.changeCardNumber(parentNode)
      this.setLogMessage('removed', removeTitle, removeColumn)
      this.activityLogEvent();
      const targetCardId = target.closest('.todo-items').dataset.cardId
      this.mainModel.fetchRemoveCard(`${URL.MOCKUP.BASE_URL}cards/${targetCardId}`)
        .then(data => console.log(data))
    } else {
      return false;
    }
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
      stack: '.todo-list ul',
      opacity: 0.5,
      // beforeStop: function( event, ui ) { console.log(event)}
      beforeStop: function(event, ui) {
        console.log(event)
        console.log(ui)
      },
      // start: function( event, ui ) {
      //   console.log(event, ui)
      // }

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
    const updateColumn = this.targetListValue.closest('.column').querySelector('.todo-column-title').innerText
    this.setLogMessage('updated', this.todoListValue, updateColumn)
    this.activityLogEvent()
    const targetCardId = this.targetListValue.closest('.todo-items').dataset.cardId
    this.todoCardData.categoryId = targetCardId
    this.todoCardData.title = this.todoListValue
    this.mainModel.fetchUpdateCard(`${URL.MOCKUP.BASE_URL}cards/${targetCardId}`, this.todoCardData)
  }

  updateCancelBtn() {
    return
  }

  activityLogEvent() {
    this.addLogMessage(this.eventLog)
  }

  addLogMessage({time, event, title, column}) {
    const addEventMessage = `
    <div class="ui feed">
          <div class="event">
            <div class="label">
              <img src="./assets/image/cat.jpeg" />
            </div>
            <div class="content">
              <div class="date">
                <font style="vertical-align: inherit;">
                  ${time} 
                </font>
              </div>
              <div class="summary">
                <a>
                  <font style="vertical-align: inherit;">@huey</font>
                </a>
                  <font style="vertical-align: inherit;"> ${event} </font>
                <a>
                  <font style="vertical-align: inherit;">
                    ${title}
                  </font>
                </a>
                <font style="vertical-align: inherit;">
                  to ${column}
                </font>
              </div>
            </div>
          </div>
        </div>
    `
    document.querySelector('.feed-container').insertAdjacentHTML('afterbegin', addEventMessage)
  }
}

export default Controller