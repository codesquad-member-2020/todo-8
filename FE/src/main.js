import Controller from './controller/controller.js'
import MainModel from './models/MainModel.js'
import TodoView from './views/TodoView.js'

import HeaderComponent from './components/HeaderComponent.js'
import MenuComponent from './components/MenuComponent.js'
import ColumnComponent from './components/ColumnComponent.js'


const headerComponent = new HeaderComponent()
const menuComponent = new MenuComponent()
const columnComponent = new ColumnComponent()

const todoView = new TodoView({
  headerComponent,
  menuComponent,
  columnComponent
})
const mainModel = new MainModel()

const controller = new Controller({
  mainModel,
  todoView
})

document.addEventListener("DOMContentLoaded", () => {
  controller  
})