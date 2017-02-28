import React from 'react'
import { render } from 'react-dom'

import { BrowserRouter as Router, Route, NavLink } from 'react-router-dom'

import { Provider } from 'react-redux'
import { setEndpointHost, setEndpointPath, setAccessToken, setHeaders } from 'redux-json-api'
import rootReducer from './rootReducer'
import configureStore from './configureStore'

import WebhookIndexView from './views/WebhookIndexView'
import WebhookDetailView from './views/WebhookDetailView'
import Navbar from './components/Navbar'

const store = configureStore()

store.dispatch(setEndpointHost('http://localhost:3000'))
store.dispatch(setEndpointPath('/api/v1'))

render(
  <Provider store={store}>
    <Router>
      <div>
        <Navbar>
          <div className='c-navbar__item'>
            <NavLink to='/' className='c-navbar__link' activeClassName='c-navbar__link--active'>
              Webhooks
            </NavLink>
          </div>
        </Navbar>

        <Route exact path='/' component={WebhookIndexView}/>
        <Route exact path='/webhooks/:id' component={WebhookDetailView}/>
      </div>
    </Router>
  </Provider>,
  document.getElementById('app')
)
