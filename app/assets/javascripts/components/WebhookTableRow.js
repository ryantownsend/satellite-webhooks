import React from 'react'
import { Link } from 'react-router-dom'
import moment from 'moment'

import '../../stylesheets/components/c-data-table.css'

import IconInsecure from '../../images/icon-insecure.svg'
import IconSecure from '../../images/icon-secure.svg'
import IconInspect from '../../images/icon-inspect.svg'

export default class WebhookTableRow extends React.Component {
  render() {
    let { webhook } = this.props

    let [
      _,
      protocol,
      hostname,
      path
    ] = webhook.attributes.url.match(/^(https?)\:\/\/(.*?)(\/.*)?$/i)

    let lockIcon = (protocol == 'https') ? IconSecure : IconInsecure

    let createdAt = moment(webhook.attributes.created_at)
    let eventSource = webhook.attributes.event_source || {}

    return <tr className='c-data-table__row'>
      <td className='c-data-table__cell u-text-left' width='24'>
        <img src={lockIcon} className='c-icon c-icon--medium' />
      </td>
      <td className='c-data-table__cell u-text-left'>
        <p className='c-data-table__title'>{hostname}</p>
        <small className='c-data-table__tertiary'>POST {path || '/'}</small>
      </td>
      <td className='c-data-table__cell u-text-left'>
        <p className='c-data-table__primary'>
          {createdAt.fromNow()}
        </p>
        <small className='c-data-table__tertiary'>
          {createdAt.format('LLL')}
        </small>
      </td>
      <td className='c-data-table__cell u-text-left'>
        <p className='c-data-table__primary'>{eventSource.description}</p>
        <small className='c-data-table__tertiary'>#{eventSource.id}</small>
      </td>
      <td className='c-data-table__cell u-text-right'>
        <Link to={`/webhooks/${webhook.id}`} className='c-btn c-btn--outline'>
          <img src={IconInspect} className='c-icon c-icon--btn' />
          Inspect
        </Link>
      </td>
    </tr>;
  }
}
