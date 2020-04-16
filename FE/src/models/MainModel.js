import { todoApi } from '../api/TodoRequest.js'

class MainModel {
  constructor() {
  }

  async fetchInitRenderData(URL) {
    const todoData = await todoApi.initRenderRequest(URL)
    return todoData
  }

  async fetchAddCard(URL, data) {
    const responseAddCard = todoApi.post(URL, data)
    return responseAddCard
  }

  async fetchRemoveCard(URL) {
    const responseRemoveCard = todoApi.delete(URL)
    return responseRemoveCard
  }

  async fetchUpdateCard(URL, data) {
    const responseUpdateCard = todoApi.put(URL, data)
    return responseUpdateCard
  }
}

export default MainModel