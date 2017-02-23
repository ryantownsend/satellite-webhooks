import React from 'react'
import { render } from 'react-dom'
import WebhookIndex from './views/WebhookIndex'
import Navbar from './components/Navbar'

render(
  <div>
    <Navbar>
      <div className='c-navbar__item'>
        <a href='#' className='c-navbar__link'>Section</a>
      </div>

      <div className='c-navbar__item'>
        <a href='#' className='c-navbar__link'>Section</a>
      </div>

      <div className='c-navbar__item'>
        <a href='#' className='c-navbar__link'>Section</a>
      </div>

      <div className='c-navbar__item'>
        <a href='#' className='c-navbar__link'>Section</a>
      </div>

      <div className='c-navbar__item'>
        <a href='#' className='c-navbar__link c-navbar__link--active'>Section</a>
      </div>
    </Navbar>

    <Navbar>
      <div className='c-navbar__item'>
        <h1>Webhooks</h1>
      </div>
    </Navbar>

    <WebhookIndex />
  </div>,
  document.getElementById('app')
)
