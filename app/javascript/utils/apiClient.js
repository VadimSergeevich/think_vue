export default class apiClient {
  constructor(url, params = {}) {
    this.url = url;
    this.params = params;
  }
  async get() {
    const url = compileUrl(this.url, this.params);
    const json = await fetch(url, {
      method: 'GET',
      headers: new Headers({
        'Content-Type': 'application/json',
      }),
      credentials: 'same-origin',
    }).then(res => res.json());
    return json;
  }
  async post() {
    const json = await fetch(this.url, {
      method: 'POST',
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      }),
      body: JSON.stringify(this.params),
      credentials: 'same-origin',
    }).then(res => res.json());
    return json;
  }
  async patch() {
    const json = await fetch(this.url, {
      method: 'PATCH',
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      }),
      body: JSON.stringify(this.params),
      credentials: 'same-origin',
    }).then(res => res.json());
    return json;
  }
  async delete() {
    const json = await fetch(this.url, {
      method: 'DELETE',
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-CSRF-Token': getCSRFToken(),
      }),
      credentials: 'same-origin',
    }).then(res => res.json());
    return json;
  }
}
const serialize = (obj, prefix) => {
  var str = [],
    p;
  for (p in obj) {
    if (obj.hasOwnProperty(p)) {
      var k = prefix ? prefix + '[' + p + ']' : p,
        v = obj[p];
      str.push(
        v !== null && typeof v === 'object'
          ? serialize(v, k)
          : encodeURIComponent(k) + '=' + encodeURIComponent(v),
      );
    }
  }
  return str.join('&');
};
const compileUrl = (url, params) => {
  return Object.keys(params).length == 0 ? url : url + '?' + serialize(params);
};
const getCSRFToken = () =>
  document.querySelector('meta[name=csrf-token]').getAttribute('content');
