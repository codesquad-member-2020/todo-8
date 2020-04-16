class CardComponent {
  constructor() {}
  
  render(todoData) {
    const todoCard = todoData.reduce((list, card) => {
      list += `
        <li class="todo-items" draggable="true" data-type="card" data-card-id=${card.id}>
          <div class="todo-items-title">
            <i class="file alternate outline icon"></i>
            <span>${card.title}</span>
            <button class="todo-items-btn btn"><i class="x icon card-remove"></i></button>
          </div>
          <div class="todo-writer-container">
            <span class="todo-items-writer">Added by Huey</span>
          </div>
        </li>
      `
      return list
    }, "")
    return todoCard
  }
}

export default CardComponent