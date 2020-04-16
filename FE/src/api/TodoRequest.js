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
  },

  async post(url, data) {
    const config = {
        method: 'POST',
        mode: 'cors',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
    };
    const res = await fetch(url, config);
    const resPost = await res.json();
    return resPost;
  },

  async delete(url) {
    const config = {
        method: 'DELETE',
        mode: 'cors',
    };
    const res = await fetch(url, config);
    const resGet = await res.json();
    return resGet;
  },
};

export { todoApi }