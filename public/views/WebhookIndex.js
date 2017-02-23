import React from 'react'
import Container from '../components/Container'

export default class WebhookIndex extends React.Component {
  render() {
    return <Container>
      <div className='c-box'>
        <div className='o-row'>
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
        </div>

        <table className='c-data-table'>
          <thead>
            <tr>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left' colSpan="2">Endpoint</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left'>Queued</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-left'>Event</th>
              <th className='c-data-table__cell c-data-table__cell--header u-text-right'>Action</th>
            </tr>
          </thead>

          <tbody>
            <tr className='c-data-table__row'>
              <td className='c-data-table__cell u-text-left' width='24'>
                <svg className='c-icon c-icon--medium' width="24px" height="24px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg">
                  <path d="M12,1 L12,1 C9.2,1 7,3.2 7,6 L7,9 L17,9 L17,6 C17,3.2 14.8,1 12,1 Z" fill="none" stroke="#7F8FA4" strokeWidth="2" />
                  <rect fill="none" stroke="#7F8FA4" strokeWidth="2" x="4" y="9" width="16" height="14" rx="2" />
                  <circle fill="none" stroke="#7F8FA4" strokeWidth="2" cx="12" cy="15" r="2" />
                  <path d="M12,17 L12,19" fill="none" stroke="#7F8FA4" strokeWidth="2" />
                </svg>
              </td>
              <td className='c-data-table__cell u-text-left'>
                <h2 className='c-data-table__title'>www.example.com</h2>
                <small className='c-data-table__tertiary'>GET /path/to/endpoint</small>
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
                  <svg className='c-icon c-icon--btn' width="20px" height="14px" viewBox="0 0 20 14" version="1.1" xmlns="http://www.w3.org/2000/svg">
                    <path fill="none" stroke="currentColor" strokeWidth="1.5" d="M1.34000003,7.06666667 C1.34000003,7.06666667 4.8066667,1 10.0066667,1 C15.2066667,1 18.6733334,7.06666667 18.6733334,7.06666667 C18.6733334,7.06666667 15.2066667,13.1333333 10.0066667,13.1333333 C4.8066667,13.1333333 1.34000003,7.06666667 1.34000003,7.06666667 Z" />
                    <ellipse fill="none" stroke="currentColor" strokeWidth="1.5" cx="10" cy="7.07" rx="2.6" ry="2.6" />
                  </svg>
                  Inspect
                </a>
              </td>
            </tr>

            <tr className='c-data-table__row'>
              <td className='c-data-table__cell u-text-left' width='24'>
                <svg className='c-icon c-icon--medium' width="24px" height="24px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg">
                  <path d="M16.6,4 C15.8,2.2 14,1 12,1 L12,1 C9.2,1 7,3.2 7,6 L7,9" fill="none" stroke="#FFA2AD" strokeWidth="2" />
                  <circle fill="none" stroke="#FFA2AD" strokeWidth="2" strokeLinecap="square" cx="12" cy="15" r="2" />
                  <path d="M12,17 L12,19" fill="none" stroke="#FFA2AD" strokeWidth="2" strokeLinecap="square" />
                  <rect fill="none" stroke="#FFA2AD" strokeWidth="2" strokeLinecap="square" x="4" y="9" width="16" height="14" rx="2" />
                </svg>
              </td>
              <td className='c-data-table__cell u-text-left'>
                <h2 className='c-data-table__title'>www.example.com</h2>
                <small className='c-data-table__tertiary'>GET /path/to/endpoint</small>
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
                  <svg className='c-icon c-icon--btn' width="20px" height="14px" viewBox="0 0 20 14" version="1.1" xmlns="http://www.w3.org/2000/svg">
                    <path fill="none" stroke="currentColor" strokeWidth="1.5" d="M1.34000003,7.06666667 C1.34000003,7.06666667 4.8066667,1 10.0066667,1 C15.2066667,1 18.6733334,7.06666667 18.6733334,7.06666667 C18.6733334,7.06666667 15.2066667,13.1333333 10.0066667,13.1333333 C4.8066667,13.1333333 1.34000003,7.06666667 1.34000003,7.06666667 Z" />
                    <ellipse fill="none" stroke="currentColor" strokeWidth="1.5" cx="10" cy="7.07" rx="2.6" ry="2.6" />
                  </svg>
                  Inspect
                </a>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </Container>;
  }
}
