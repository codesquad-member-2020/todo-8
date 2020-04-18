class ModalComponent {
  constructor() {

  }

  render() {
    return `
      <div class="ui basic modal" id="update-modal">
        <div class="ui icon header">
          <i class="archive icon"></i>
          할 일을 수정해주세요!
        </div>
        <div class="content">
          <input value="" id="todo-input-Value" class="todo-input-value" type="text">
        </div>
        <div class="actions">
          <div class="ui red basic cancel inverted button">
            <i class="remove icon"></i>
            No
          </div>
          <div class="ui green ok inverted button">
            <i class="checkmark icon"></i>
            Yes
          </div>
        </div>
      </div>
    `
  }

  columnRedner() {
    return `
      <div class="ui basic column modal" id="column-modal">
        <div class="ui icon header">
          <i class="archive icon"></i>
          컬럼을 추가 해주세요!
        </div>
        <div class="content">
          <input value="" id="todo-column-Value" class="todo-column-value" type="text">
        </div>
        <div class="actions">
          <div class="ui red basic cancel inverted button">
            <i class="remove icon"></i>
            No
          </div>
          <div class="ui green ok inverted col button" id="column-add-btn">
            <i class="checkmark icon"></i>
            Yes
          </div>
        </div>
      </div>
    `
  }
}

export default ModalComponent