import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { nextFormStepAndValidate, changeQueryString } from 'actions';

const mapStateToProps = state => ({
  queryString: state.p1.queryString,
  validationErrors: state.validation.validationErrors.p1,
});

const mapDispatchToProps = dispatch => ({
  onChangeQueryString: (e) => {
    dispatch(changeQueryString(e.target.value));
  },
  onKeyPress: (e) => {
    if (e.key == 'Enter') {
      dispatch(nextFormStepAndValidate());
    }
  },
});

const propTypes = {
  queryString: PropTypes.string.isRequired,
  onChangeQueryString: PropTypes.func.isRequired,
  onKeyPress: PropTypes.func.isRequired,
  className: PropTypes.string.isRequired,
  validationErrors: PropTypes.object.isRequired,
}

function P1Form({
  queryString,
  onChangeQueryString,
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
        
        onChange={onChangeQueryString}
        onKeyPress={onKeyPress}
        value={queryString}
      />
    </div>
  );
}

P1Form.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(P1Form);
