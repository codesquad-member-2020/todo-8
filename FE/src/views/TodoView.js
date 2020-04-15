class TodoView {
  constructor({
    headerComponent,
    menuComponent,
    columnComponent,
    cardComponent
  }) {
    this.headerComponent = headerComponent;
    this.menuComponent = menuComponent;
    this.columnComponent = columnComponent;
    this.cardComponent = cardComponent
    this.todoApp = document.querySelector('.wrapper')
  }

  render(todoData) {
    this.todoApp.insertAdjacentHTML('afterbegin', this.headerComponent.render())
    this.todoApp.insertAdjacentHTML('beforeend', this.menuComponent.render(todoData.activity))
    this.todoApp.insertAdjacentHTML('beforeend', this.columnComponent.render(todoData.category))

    // console.log(todoData)
  }
}

export default TodoView