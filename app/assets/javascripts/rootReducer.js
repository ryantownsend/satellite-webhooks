import { combineReducers } from 'redux'
import reduceReducers from 'reduce-reducers'
import { reducer } from 'redux-json-api'
import { PURGE_STATE } from './actions'

// this reducer listens for purge events and wipes out the state
// there will soon (hopefully) be a native implementation of this,
// see: https://github.com/dixieio/redux-json-api/pull/117
const purgeState = (state, action) => {
  let newState = Object.assign({}, state)
  // if we're not purging, return the state
  if (action.type !== PURGE_STATE) {
    return newState
  // if we are purging, only select the data to keep
  } else {
    const { isCreating, isReading, isUpdating, isDeleting, endpoint } = newState
    return { isCreating, isReading, isUpdating, isDeleting, endpoint }
  }
}

// this merges two reducers under the same namespace so the state key will be the same
const api = reduceReducers(reducer, purgeState)

// this means: use the `api` reducer defined above and use `api` as the state key
const rootReducer = combineReducers({ api })

export default rootReducer
