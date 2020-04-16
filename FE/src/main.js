import Controller from './controller/controller.js'
import MainModel from './models/MainModel.js'
import TodoView from './views/TodoView.js'

import HeaderComponent from './components/HeaderComponent.js'
import MenuComponent from './components/MenuComponent.js'
import ColumnComponent from './components/ColumnComponent.js'
import CardComponent from './components/CardComponent.js'
import ModalComponent from './components/ModalComponent.js'

const headerComponent = new HeaderComponent()
const menuComponent = new MenuComponent()
const cardComponent = new CardComponent()
const columnComponent = new ColumnComponent({
  cardComponent
})
const modalComponent = new ModalComponent()

const todoView = new TodoView({
  headerComponent,
  menuComponent,
  columnComponent,
  cardComponent,
  modalComponent
})
const mainModel = new MainModel()

const controller = new Controller({
  mainModel,
  todoView
})

document.addEventListener("DOMContentLoaded", () => {
  controller  
})