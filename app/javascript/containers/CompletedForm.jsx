import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { closeModal } from 'actions';

const mapStateToProps = state => ({
  modalOpen: state.modalReducer.modalOpen,
  queryString: state.p1.queryString,
});

const mapDispatchToProps = dispatch => ({
  closeModal: () => {
    dispatch(closeModal());
  },
});

const propTypes = {
  modalOpen: PropTypes.bool.isRequired,
  queryString: PropTypes.string.isRequired,
  closeModal: PropTypes.func.isRequired,
}

function CompletedForm({
  modalOpen,
  queryString,
  closeModal,
}) {
  if (modalOpen) {
    $("#completion-modal").modal({backdrop: 'static', keyboard: false});
  } else {
    $("#completion-modal").modal('hide');
  }

  return (
    <div id="completion-modal" className="modal fade" tabIndex="-1" role="dialog">
      <div className="modal-dialog modal-confirm" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h1 className="modal-title center"><i className="fa fa-check-circle-o white"></i></h1>
            <button onClick={closeModal} type="button" className="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div className="modal-body center">
            <h4>Nice!</h4>
            <p>Created a listener for <b>{queryString}</b></p>
          </div>
          <div className="modal-footer center">
            <button
              type="button"
              className="btn btn-primary"
              onClick={closeModal}
              >Create Another One</button>
          </div>
        </div>
      </div>
    </div>

  );
}

CompletedForm.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(CompletedForm);
