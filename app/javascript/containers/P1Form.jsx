import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import {
  nextFormStepAndValidate,
  changeQueryString,
  changeTestTextString,
  changeTestText,
  openHelpModal,
  closeHelpModal,
  submitQueryContentMatchCheck,
} from 'actions';
import P1HelpModal from 'containers/P1HelpModal'

const mapStateToProps = state => ({
  queryString: state.p1.queryString,
  queryContentMatch: state.p1.queryContentMatch,
  queryContentMatchFetching: state.p1.queryContentMatchFetching,
  testTextString: state.p1.testTextString,
  helpModalOpen: state.modalReducer.helpModalOpen,
  validationErrors: state.validation.validationErrors.p1,
});

const mapDispatchToProps = dispatch => ({
  onChangeQueryString: (e) => {
    dispatch(changeQueryString(e.target.value));
    dispatch(submitQueryContentMatchCheck());
  },
  onChangeTestTextString: (e) => {
    dispatch(changeTestTextString(e.target.value));
    dispatch(submitQueryContentMatchCheck());
  },
  onKeyPress: (e) => {
    if (e.key == 'Enter') {
      dispatch(nextFormStepAndValidate());
    }
  },
  openHelpModal: (e) => {
    e.preventDefault();
    dispatch(openHelpModal());
  },
  closeHelpModal: (e) => {
    e.preventDefault();
    dispatch(closeHelpModal());
  },
});

const propTypes = {
  queryString: PropTypes.string.isRequired,
  testTextString: PropTypes.string.isRequired,
  queryContentMatch: PropTypes.bool.isRequired,
  queryContentMatchFetching: PropTypes.bool.isRequired,
  helpModalOpen: PropTypes.bool.isRequired,
  onChangeQueryString: PropTypes.func.isRequired,
  onChangeTestTextString: PropTypes.func.isRequired,
  onKeyPress: PropTypes.func.isRequired,
  openHelpModal: PropTypes.func.isRequired,
  closeHelpModal: PropTypes.func.isRequired,
  className: PropTypes.string.isRequired,
  validationErrors: PropTypes.object.isRequired,
}

function P1Form({
  queryString,
  testTextString,
  queryContentMatch,
  queryContentMatchFetching,
  helpModalOpen,
  onChangeQueryString,
  onChangeTestTextString,
  openHelpModal,
  closeHelpModal,
  className,
  onKeyPress,
  validationErrors,
}) {
  let queryStringErrorMessage = validationErrors.queryString;
  let inputClassName = 'form-control line-input is-large';
  if (queryStringErrorMessage) {
    inputClassName += ' animated shake is-invalid';
  }
  return (
    <div className={className}>
      <label className="main-form-input" htmlFor="query-input">Whats your keyword?</label>
      <input
        autoFocus={true}
        type="text"
        className={inputClassName}
        id="query-input"
        placeholder='tech internships'
        name="query"
        autoComplete="off"
        
        onChange={onChangeQueryString}
        onKeyPress={onKeyPress}
        value={queryString}
      />

      <p className="text-muted">
        Use <b>|</b> for <b>and's</b> and <b>,</b> for <b>or's</b>. <a onClick={openHelpModal} href="#">Help</a>
      </p>

      <P1HelpModal
        queryString={queryString}
        onChangeQueryString={onChangeQueryString}
        testTextString={testTextString}
        onChangeTestTextString={onChangeTestTextString}
        helpModalOpen={helpModalOpen}
        closeHelpModal={closeHelpModal}
        queryContentMatch={queryContentMatch}
        queryContentMatchFetching={queryContentMatchFetching}
      />
    </div>
  );
}

P1Form.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(P1Form);
