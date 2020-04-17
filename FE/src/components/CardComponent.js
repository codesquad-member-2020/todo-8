class CardComponent {
  constructor() {}

  render(todoData) {
    const todoCard = todoData.reduce((list, card) => {
      list += `
        <li class="todo-items" draggable="true" data-type="card" data-card-id=${card.id} data-card-index=${card.tabIndex}>
          <div class="todo-items-title">
            <i class="file alternate outline icon"></i>
            <span>${card.title}</span>
            <button class="todo-items-btn btn"><i class="x icon card-remove"></i></button>
          </div>
          <div class="todo-writer-container">
            <span class="todo-items-writer">Added by ttozzi</span>
          </div>
        </li>
      `
      return list
    }, "")
    return todoCard
  }

  addTodoCard(targetNode, targetValue) {
    const todoList = `
      <li class="todo-items" draggable="true">
        <div class="todo-items-title">
          <span>
            <i class="file alternate outline icon"></i>
          ${targetValue}</span>
          <button class="todo-items-btn btn"><i class="x icon card-remove"></i></button>
        </div>
        <div class="todo-writer-container">
          <span class="todo-items-writer">Added by ttozzi</span>
        </div>
      </li>
    `
    targetNode.querySelector('.todo-list').insertAdjacentHTML('afterbegin', todoList);
  }
}

export default CardComponent