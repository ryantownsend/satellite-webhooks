import React from 'react'

export default class Navbar extends React.Component {
  render() {
    return <div className='c-navbar'>{this.props.children}</div>;
  }
}
