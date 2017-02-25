export const REQUEST_WEBHOOKS = 'REQUEST_WEBHOOKS'
export const RECEIVE_WEBHOOKS = 'RECEIVE_WEBHOOKS'

function requestWebhooks() {
  return {
    type: REQUEST_WEBHOOKS
  }
}

function receiveWebhooks(json) {
  return {
    type: RECEIVE_WEBHOOKS,
    webhooks: json.data.map(child => child.attributes)
  }
}

export function fetchWebhooks() {
  return dispatch => {
    dispatch(requestWebhooks())
    return fetch(`/api/v1/webhooks`, {
      headers: {
        'Accept': 'application/vnd.api+json'
      }
    })
      .then(response => response.json())
      .then(json => dispatch(receiveWebhooks(json)))
  }
}
