import { todoApi } from '../api/TodoRequest.js'

class MainModel {
  constructor() {
    this.initialize()
  }

  initialize() {
    this.fetchInitRenderData()
  }

  fetchInitRenderData() {
    const URL = 'http://34.236.252.205/api/board'
    todoApi.initRenderRequest(URL)
      .then(data => console.log(data))
  }
}

export default MainModel