class MenuComponent { 
  constructor() {

  }

  render(logData) {
    const logList = logData.reduce((list, log) => {
      list += `
      
      `
      return logList
    } ,"") 
    return `
      <div class="menu-container">
        <div class="menu-area">
          <i class="bars icon"></i>
          <span>Menu</span>
        </div>
        <div class="menu-noti">
          <i class="bell icon"></i>
          <span>Activity</span>
        </div>
      </div>
    `
  }
}

export default MenuComponent