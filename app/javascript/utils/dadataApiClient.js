const KEY = '7b8a2911a971dc55b54efd46225f98734c52d4a1';
const NAME_URL =
  'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party';

export default class dadataApiClient {
  constructor(query) {
    this.query = query;
  }
  async organizations() {
    const json = await fetch(NAME_URL, {
      method: 'POST',
      headers: new Headers({
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: `Token ${KEY}`,
      }),
      body: JSON.stringify({ query: this.query }),
    }).then(res => res.json());
    return json;
  }
}
