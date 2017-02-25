import { combineReducers } from 'redux'
import webhooks from './reducers/webhooks'

const rootReducer = combineReducers({
  webhooks
})

export default rootReducer
