class ColumnComponent {
  constructor({ cardComponent }) {
    this.cardComponent = cardComponent
  }

  render(todoData) {
    const todoList = todoData.reduce((list, column) => {
      list += `
        <div class="todo-column column" data-type="column" data-column-id=${column.id}> 
          <div class="todo-column-header">
            <span class="todo-num">${column.cards.length}</span>
            <span class="todo-column-title">${column.title}</span>
            <button class="todo-column-add-btn todo-add-btn btn">
              <i class="plus icon"></i>
            </button>
            <button class="todo-column-remove-btn btn">
              <i class="x icon"></i>
            </button>
          </div>
          <div class="todo-add-area">
            <textarea class="todo-textarea" placeholder="Enter a note" name="" id=""></textarea>
            <div class="todo-btn-container">
              <button class="base-add-btn" disabled>Add</button>
              <button class="base-cancel-btn">Cancel</button>
            </div>
          </div>
          <ul class="todo-list droppable-area1">
            ${this.cardComponent.render(column.cards)}
          </ul>
        </div>
      `
      return list
    } ,"") 
    return `
    <div class="content-container">
      ${todoList}
      <div class="add-column">
        <div class="add-text"> + Add column</div>
      </div>
    </div>
    `
  }

  addColumn(value) {
    return `
    <div class="todo-column column" data-type="column"> 
    <div class="todo-column-header">
      <span class="todo-num">0</span>
      <span class="todo-column-title">${value}</span>
      <button class="todo-column-add-btn todo-add-btn btn">
        <i class="plus icon"></i>
      </button>
      <button class="todo-column-remove-btn btn">
        <i class="x icon"></i>
      </button>
    </div>
    <div class="todo-add-area">
      <textarea class="todo-textarea" placeholder="Enter a note" name="" id=""></textarea>
      <div class="todo-btn-container">
        <button class="base-add-btn" disabled>Add</button>
        <button class="base-cancel-btn">Cancel</button>
      </div>
    </div>
    <ul class="todo-list droppable-area1">
    </ul>
  </div>
    `
  }

  changeCardNumber() {
    document.querySelectorAll('.todo-list').forEach(column => 
      column.closest('.column').querySelector('.todo-num').innerText = column.childElementCount
    )
  }
}

export default ColumnComponent