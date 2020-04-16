class ColumnComponent {
  constructor() {}

  initialize() {}

  render(todoData) {
    console.log(todoData)
    const todoList = todoData.reduce((list, log) => {
      list += `
        <div class="todo-column column" data-type="column" data-column-id=${log.id}> 
          <div class="todo-column-header">
            <span class="todo-num">${log.cards.length}</span>
            <span class="todo-column-title">${log.title}</span>
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
          <ul class="todo-list droppable-area1"></ul>
        </div>
      `
      return list
    } ,"") 
    return `
    <div class="content-container">${todoList}</div>
    `
  }
}

export default ColumnComponent