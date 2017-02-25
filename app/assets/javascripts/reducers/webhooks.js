import { REQUEST_WEBHOOKS, RECEIVE_WEBHOOKS } from '../actions'

const webhooks = (state = {}, action) => {
  switch (action.type) {
    case REQUEST_WEBHOOKS:
    case RECEIVE_WEBHOOKS:
      console.log('webhooks reducer', state, action)
      return Object.assign({}, state, {
        webhooks: action.webhooks
      })
    default:
      return state
  }
}

export default webhooks
