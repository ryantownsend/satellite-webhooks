import React from 'react'
import { connect } from 'react-redux'
import { readEndpoint } from 'redux-json-api'
import { purgeState } from '../actions'

import '../../stylesheets/components/c-data-table.css'

import Container from '../components/Container'
import Row from '../components/Row'
import WebhookTableRow from '../components/WebhookTableRow'

class WebhookIndexView extends React.Component {
  componentDidMount() {
    this.props.dispatch(purgeState())
    this.props.dispatch(readEndpoint('webhooks?sort=-created_at'))
  }

  render() {
    return <Container>
      <div className='c-box'>
        <Row>
          <div className='c-tabs'>
            <a href='#' className='c-tabs__tab c-tabs__tab--active'>
              Queued <small className='c-counter'>10</small>
            </a>

            <a href='#' className='c-tabs__tab'>
              Delivered <small className='c-counter'>10</small>
            </a>

            <a href='#' className='c-tabs__tab'>
              Retrying <small className='c-counter'>10</small>
            </a>

            <a href='#' className='c-tabs__tab'>
              Failed <small className='c-counter'>10</small>
            </a>
          </div>

          <form className='c-search-form'>
            <input type='text' className='c-text-input' placeholder='Search&hellip;' />
          </form>
        </Row>

        <table className='c-data-table'>
          <thead>
            <tr>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left' colSpan='2'>Endpoint</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left'>Queued</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left'>Event</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-right'>Action</th>
            </tr>
          </thead>

          <tbody>
            {this.props.webhooks.data.map((webhook) =>
              <WebhookTableRow webhook={webhook} key={webhook.id} />
            )}
          </tbody>
        </table>
      </div>
    </Container>;
  }
}

const mapStateToProps = (state) => {
  const webhooks = state.api.webhooks || { data: [] }
  return { webhooks }
}

export default connect(mapStateToProps)(WebhookIndexView)
