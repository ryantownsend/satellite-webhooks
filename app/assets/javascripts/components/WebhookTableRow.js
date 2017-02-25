import React from 'react'
import '../../stylesheets/components/c-data-table.css'

import IconInsecure from '../../images/icon-insecure.svg'
import IconSecure from '../../images/icon-secure.svg'
import IconInspect from '../../images/icon-inspect.svg'

export default class WebhookTableRow extends React.Component {
  render() {
    let [
      _,
      protocol,
      hostname,
      path
    ] = this.props.webhook.url.match(/^(https?)\:\/\/(.*?)(\/.*)?$/i)

    let lockIcon = (protocol == 'https') ? IconSecure : IconInsecure

    return <tr className='c-data-table__row'>
      <td className='c-data-table__cell u-text-left' width='24'>
        <img src={lockIcon} className='c-icon c-icon--medium' />
      </td>
      <td className='c-data-table__cell u-text-left'>
        <h2 className='c-data-table__title'>{hostname}</h2>
        <small className='c-data-table__tertiary'>POST {path || '/'}</small>
      </td>
      <td className='c-data-table__cell u-text-left'>
        <p className='c-data-table__primary'>5 minutes ago</p>
        <small className='c-data-table__tertiary'>Today @ 12:21</small>
      </td>
      <td className='c-data-table__cell u-text-left'>
        <p className='c-data-table__primary'>Updated Asset</p>
        <small className='c-data-table__tertiary'>#123456</small>
      </td>
      <td className='c-data-table__cell u-text-right'>
        <a href='#' className='c-btn c-btn--outline'>
          <img src={IconInspect} className='c-icon c-icon--btn' />
          Inspect
        </a>
      </td>
    </tr>;
  }
}
