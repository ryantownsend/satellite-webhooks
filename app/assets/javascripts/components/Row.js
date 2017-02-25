import React from 'react'
import '../../stylesheets/components/o-row.css'

export default class Row extends React.Component {
  render() {
    return <div className='o-row'>{this.props.children}</div>;
  }
}
