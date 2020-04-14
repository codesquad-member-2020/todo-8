import { todoApi } from '../api/TodoRequest.js'

class MainModel {
  constructor() {
  }

  async fetchInitRenderData(URL) {
    this.todoData = await todoApi.initRenderRequest(URL)
    return this.todoData
  }
}

export default MainModel