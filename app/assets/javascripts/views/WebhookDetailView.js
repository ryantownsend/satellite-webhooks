import React from 'react'
import { connect } from 'react-redux'
import { readEndpoint } from 'redux-json-api'
import { purgeState } from '../actions'
import moment from 'moment'

import '../../stylesheets/components/c-timeline.css'
import '../../stylesheets/components/c-status.css'
import '../../stylesheets/components/u-padding.css'

import Container from '../components/Container'
import Row from '../components/Row'

class WebhookDetailView extends React.Component {
  componentDidMount() {
    let webhookId = this.props.match.params.id
    this.props.dispatch(purgeState())
    this.props.dispatch(readEndpoint(`webhooks/${webhookId}?include=deliveries&fields[webhooks]=url,status&fields[deliveries]=status,created_at`))
  }

  render() {
    if (this.props.isReading) {
      return <div></div>
    }

    let webhookId = this.props.match.params.id
    let webhook = this.props.webhooks.data.find((webhook) => { return webhook.id == webhookId })
    let deliveries = this.props.deliveries.data

    let [
      _,
      protocol,
      hostname,
      path
    ] = webhook.attributes.url.match(/^(https?)\:\/\/(.*?)(\/.*)?$/i)

    return <Container>
      <div className='c-box'>
        <Row>
          <div className='u-padding--md'>
            <h1>{ hostname }</h1>
            <p>POST { path || '/' }</p>
          </div>
          <div className='u-padding--md'>
            <p className={`c-status c-status--${webhook.attributes.status}`}>
              {webhook.attributes.status}
            </p>
          </div>
        </Row>
        <hr />
        <div className='c-timeline'>
          {deliveries.map((delivery) =>
            <div className='c-timeline__entry' key={delivery.id}>
              <h2>{delivery.attributes.status}</h2>
              <p>{moment(delivery.attributes.created_at).fromNow()}</p>
              <small>{moment(delivery.attributes.created_at).format('LLL')}</small>
            </div>
          )}
        </div>
      </div>
    </Container>;
  }
}

const mapStateToProps = (state) => {
  const webhooks = state.api.webhooks || { data: [] }
  const deliveries = state.api.deliveries || { data: [] }
  const isReading = (state.api.isReading || 0) > 0
  return { webhooks, deliveries, isReading }
}

export default connect(mapStateToProps)(WebhookDetailView)
