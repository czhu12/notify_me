import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { nextFormStepAndValidate, submitCreateListener } from 'actions';

import P1Form from 'containers/P1Form'
import P2Form from 'containers/P2Form'
import P3Form from 'containers/P3Form'

const mapStateToProps = state => ({
  formStep: state.mainForm.formStep,
});

const mapDispatchToProps = dispatch => ({
  changeForm: () => {
    dispatch(nextFormStepAndValidate());
  },
  submitForm: () => {
    dispatch(submitCreateListener())
  },
});

const propTypes = {
  formStep: PropTypes.number.isRequired,
  changeForm: PropTypes.func.isRequired,
  submitForm: PropTypes.func.isRequired,
}

function MainForm({
  formStep,
  changeForm,
  submitForm,
}) {
  let buttonText = formStep == 3 ? "Submit" : "Continue";
  let buttonFn = formStep == 3 ? submitForm : changeForm;
  return (
    <div className="container">
      <div className="row">
        <div className="col-md-10 offset-md-1">
          <div className="form-group">
            <P1Form className={(formStep == 0 || formStep == 3) ? "form-step" : "form-step hide"} />
            <P2Form className={(formStep == 1 || formStep == 3) ? "form-step" : "form-step hide"} />
            <P3Form className={(formStep == 2 || formStep == 3) ? "form-step" : "form-step hide"} />

            <button
              id="next-button"
              className="btn btn-lg btn-success float-right"
              onClick={buttonFn}
            >
              {buttonText}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

MainForm.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(MainForm);
