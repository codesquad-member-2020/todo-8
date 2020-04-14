import Controller from './controller/controller.js'
import MainModel from './models/MainModel.js'

const mainModel = new MainModel()
const controller = new Controller({
  mainModel
})

document.addEventListener("DOMContentLoaded", () => {
  controller  
})