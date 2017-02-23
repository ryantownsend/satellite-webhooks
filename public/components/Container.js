import React from 'react'

export default class Container extends React.Component {
  render() {
    return <div className='o-container'>{this.props.children}</div>;
  }
}
