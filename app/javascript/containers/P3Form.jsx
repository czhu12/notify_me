import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { changePhoneNumberString, changeEmailString } from 'actions';

const mapStateToProps = state => ({
  phoneNumberString: state.p3.phoneNumberString,
  emailString: state.p3.emailString,
  validationErrors: state.validation.validationErrors.p3,
});

const mapDispatchToProps = dispatch => ({
  onChangePhoneNumberString: (e) => {
    dispatch(changePhoneNumberString(e.target.value));
  },
  onChangeEmailString: (e) => {
    dispatch(changeEmailString(e.target.value));
  },
});

const propTypes = {
  phoneNumberString: PropTypes.string.isRequired,
  emailString: PropTypes.string.isRequired,
  onChangePhoneNumberString: PropTypes.func.isRequired,
  onChangeEmailString: PropTypes.func.isRequired,
  className: PropTypes.string.isRequired,
  validationErrors: PropTypes.object.isRequired,
}

function P3Form({
  phoneNumberString,
  emailString,
  onChangePhoneNumberString,
  onChangeEmailString,
  className,
  validationErrors,
}) {
  let emailStringErrorMessage = validationErrors.emailString;
  let phoneNumberStringErrorMessage = validationErrors.phoneNumberString;
  let emailInputClassName = 'form-control line-input';
  let phoneNumberInputClassName = 'form-control line-input';
  if (emailStringErrorMessage) {
    emailInputClassName += ' animated shake is-invalid';
  }
  if (phoneNumberStringErrorMessage) {
    phoneNumberInputClassName += ' animated shake is-invalid';
  }

  return (
    <div className={className}>
      <label className="main-form-input" htmlFor="phone-number">How do we notify you?</label>
      <br/>
      <label>Phone Number</label>
      <input
        type="text"
        className={emailInputClassName}
        id="phone-number"
        name="phone_number"
        placeholder="1234567890"
        value={phoneNumberString}
        onChange={onChangePhoneNumberString}
       />
      <br/>

      <label>Email</label>
      <input
        type="text"
        className={phoneNumberInputClassName}
        id="email"
        name="email"
        placeholder="email@example.com"
        value={emailString}
        onChange={onChangeEmailString}
       />
    </div>
  );
}

P3Form.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(P3Form);
