class MenuComponent { 
  constructor() {
    this.computedLogTime()
  }

  computedLogTime() {
    let date = new Date()
    console.log(date);
  }

  render(logData) {
    const logList = logData.reduce((list, log) => {
      list += `
      <div class="ui feed" data-id=${log.id}>
            <div class="event">
              <div class="label">
                <img src="./assets/image/cat.jpeg" />
              </div>
              <div class="content">
                <div class="date">
                  <font style="vertical-align: inherit;">
                    ${log.createdTime}
                  </font>
                </div>
                <div class="summary">
                  <a>
                    <font style="vertical-align: inherit;">@${log.author}</font>
                  </a>
                    <font style="vertical-align: inherit;">${log.action}</font>
                  <a>
                    <font style="vertical-align: inherit;">
                      ${log.targetName}
                    </font>
                  </a>
                  <font style="vertical-align: inherit;">
                    to 하는중
                  </font>
                </div>
              </div>
            </div>
          </div>
      `
      return list
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
        <div class="feed-container">${logList}</div>
        <button class="menu-close-btn">
          <i class="x icon"></i>
        </button>
      </div>
    `
  }
}

export default MenuComponent