import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

const propTypes = {
  queryString: PropTypes.string.isRequired,
  testTextString: PropTypes.string.isRequired,
  queryContentMatch: PropTypes.bool.isRequired,
  queryContentMatchFetching: PropTypes.bool.isRequired,
  helpModalOpen: PropTypes.bool.isRequired,
  closeHelpModal: PropTypes.func.isRequired,
  onChangeQueryString: PropTypes.func.isRequired,
  onChangeTestTextString: PropTypes.func.isRequired,
}

function P1HelpModal({
  queryString,
  testTextString,
  queryContentMatch,
  queryContentMatchFetching,
  helpModalOpen,
  closeHelpModal,
  onChangeQueryString,
  onChangeTestTextString,
}) {
  if (helpModalOpen) {
    $("#help-modal").modal({backdrop: 'static', keyboard: false});
  } else {
    $("#help-modal").modal('hide');
  }
  let matchView = null;
  if (!testTextString) {
    matchView = null;
  } else if (queryContentMatchFetching) {
    matchView = (
      <div>
        <i className="fa fa-spinner" aria-hidden="true"></i>
      </div>
    );
  } else if (queryContentMatch) {
    matchView = (
      <div className="text-success">
        Matches! <i className="fa fa-check-circle-o" aria-hidden="true"></i>
      </div>
    );
  } else {
    matchView = (
      <div className="text-error">
        Doesn't Match! <i className="fa fa-times-circle-o" aria-hidden="true"></i>
      </div>
    );
  }

  return (
    <div id="help-modal" className="modal fade" tabIndex="-1" role="dialog">
      <div className="modal-dialog modal-confirm" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h1 className="modal-title center white">Query Tester <i className="fa fa-question-circle-o"></i></h1>
            <button
              onClick={closeHelpModal}
              type="button"
              className="close"
              data-dismiss="modal"
              aria-label="Done"
            >
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div className="modal-body">
            <label htmlFor="test-query">Your query</label>
            <input
              id="test-query"
              type="text"
              className="form-control is-large"
              name="query"
              autoComplete="off"
              onChange={onChangeQueryString}
              value={queryString}
            />
            <br/>

            <div className="form-group">
              <label htmlFor="test-text">Test Text</label>
              <textarea
                className="form-control"
                id="test-text"
                rows="3"
                onChange={onChangeTestTextString}
                value={testTextString}
              >
              </textarea>
            </div>

            {matchView}
          </div>
          <div className="modal-footer">
            <button
              type="button"
              className="btn btn-primary"
              onClick={closeHelpModal}
              >Close</button>
          </div>
        </div>
      </div>
    </div>

  );
}

P1HelpModal.propTypes = propTypes;
export default P1HelpModal;
