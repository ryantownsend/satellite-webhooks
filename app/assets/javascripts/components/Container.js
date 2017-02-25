import React from 'react'
import '../../stylesheets/components/o-container.css'

export default class Container extends React.Component {
  render() {
    return <div className='o-container'>{this.props.children}</div>;
  }
}
