class TodoView {
  constructor({
    loadingSpinner,
    headerComponent,
    menuComponent,
    columnComponent,
    cardComponent,
    modalComponent
  }) {
    this.loadingSpinner = loadingSpinner
    this.headerComponent = headerComponent;
    this.menuComponent = menuComponent;
    this.columnComponent = columnComponent;
    this.cardComponent = cardComponent;
    this.modalComponent = modalComponent;
    this.todoApp = document.querySelector('.wrapper')
  }

  renderSpinner() {
    this.todoApp.insertAdjacentHTML('afterbegin', this.loadingSpinner.render())
  }

  render(todoData) {
    this.todoApp.insertAdjacentHTML('afterbegin', this.headerComponent.render())
    this.todoApp.insertAdjacentHTML('beforeend', this.columnComponent.render(todoData.response.category))
    this.todoApp.insertAdjacentHTML('beforeend', this.menuComponent.render(todoData.response.activity))
    this.todoApp.insertAdjacentHTML('beforeend', this.modalComponent.render())
  }

  addCardRender(targetNode, targetValue) {
    this.cardComponent.addTodoCard(targetNode, targetValue)
  }

  addLogRender(logData) {
    this.menuComponent.addLogMessage(logData)
  }
}

export default TodoView