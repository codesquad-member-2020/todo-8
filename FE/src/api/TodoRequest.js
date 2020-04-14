const todoApi = {
  async initRenderRequest(url) {
    const config = {
      method: "GET",
      mode: "cors",
      headers: { 
        "Content-Type": "application/json" 
      }
    };
    const res = await fetch(url, config);
    const initRenderData = await res.json();
    return initRenderData
  }
};

export { todoApi }