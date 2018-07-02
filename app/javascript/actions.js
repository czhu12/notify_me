import {
  NEXT_FORM_STEP,
  CHANGE_QUERY_STRING,
  CHANGE_TEST_TEXT_STRING,
  CHANGE_HACKER_NEWS_CHECK,
  CHANGE_REDDIT_CHECK,
  CHANGE_SUBREDDIT_STRING,
  ADD_SUBREDDIT,
  REMOVE_SUBREDDIT,
  ADD_SUBREDDIT_SUGGESTION,
  REMOVE_SUBREDDIT_SUGGESTION,
  CHANGE_PHONE_NUMBER_STRING,
  CHANGE_EMAIL_STRING,
  SUBREDDIT_SUGGESTIONS_REQUEST,
  SUBREDDIT_SUGGESTIONS_SUCCESS,
  SUBREDDIT_SUGGESTIONS_FAILURE,
  CREATE_LISTENER_REQUEST,
  CREATE_LISTENER_SUCCESS,
  CREATE_LISTENER_FAILURE,
  VALIDATION_FAILED,
  OPENED_MODAL,
  CLOSED_MODAL,
  OPENED_HELP_MODAL,
  CLOSED_HELP_MODAL,
  QUERY_CONTENT_MATCH_CHECK_REQUEST,
  QUERY_CONTENT_MATCH_CHECK_SUCCESS,
  QUERY_CONTENT_MATCH_CHECK_FAILURE,
} from './constants/actionTypes';

function hasValidationErrors({p1, p2, p3, mainForm}) {
  let validationErrors = {p1: {}, p2: {}, p3: {}, mainForm: {}};
  let hasError = false;
  if (!p1.queryString &&
    (mainForm.formStep === 0 || mainForm.formStep === 3)) {
    validationErrors.p1.queryString = "Query can't be blank.";
    hasError = true;
  }

  if (!p2.hackerNewsCheck && !p2.redditCheck &&
    (mainForm.formStep === 1 || mainForm.formStep === 3)) {
    // Choose either hacker news or reddit
    validationErrors.p2.atLeastOneOption = 'Please choose one of these options.';
    hasError = true;
  }

  if (p2.redditCheck && p2.subreddits.length === 0 &&
    (mainForm.formStep === 1 || mainForm.formStep === 3)) {
    // If reddit is chosen, have at least one subreddit
    validationErrors.p2.atLeastOneSubreddit = 'Please choose at least one subreddit to follow.';
    hasError = true;
  }

  if (!p3.phoneNumberString &&
    (mainForm.formStep === 2 || mainForm.formStep === 3)) {
    validationErrors.p3.phoneNumberString = "Phone number can't be blank.";
    hasError = true;
  }

  if (!p3.emailString &&
    (mainForm.formStep === 2 || mainForm.formStep === 3)) {
    validationErrors.p3.emailString = "Email can't be blank.";
    hasError = true;
  }
  return { validationErrors, hasError };
}

export function nextFormStepAndValidate() {
  return (dispatch, getState) => {
    const state = getState();
    return new Promise((resolve, reject) => {
      let { validationErrors, hasError } = hasValidationErrors(state);
      
      if (!hasError) {
        resolve();
      } else {
        reject(validationErrors);
      }
    }).then(() => {
      dispatch(nextFormStep())
      if (state.mainForm.formStep === 0) {
        dispatch(submitSubredditSuggestions());
      }
    }).catch(validationErrors => dispatch(validationFailed(validationErrors)));
  }
}

export function validationFailed(validationErrors) {
  return { validationErrors, type: VALIDATION_FAILED }
}

export function nextFormStep() {
  return { type: NEXT_FORM_STEP }
}

export function changeQueryString(queryString) {
  return {
    queryString,
    type: CHANGE_QUERY_STRING,
  }
}

export function changeTestTextString(testTextString) {
  return {
    testTextString,
    type: CHANGE_TEST_TEXT_STRING,
  }
}

export function changeHackerNewsCheck(hackerNewsCheck) {
  return {
    hackerNewsCheck,
    type: CHANGE_HACKER_NEWS_CHECK,
  }
}

export function changeRedditCheck(redditCheck) {
  return {
    redditCheck,
    type: CHANGE_REDDIT_CHECK,
  }
}

export function changeSubredditString(subredditString) {
  return {
    subredditString,
    type: CHANGE_SUBREDDIT_STRING,
  }
}

export function addSubreddit() {
  return {
    type: ADD_SUBREDDIT,
  }
}

export function removeSubreddit(subredditIndex) {
  return {
    subredditIndex,
    type: REMOVE_SUBREDDIT,
  }
}

export function addSubredditSuggestion(subreddit) {
  return {
    subreddit,
    type: ADD_SUBREDDIT_SUGGESTION,
  }
}

export function removeSubredditSuggestion(subredditIndex) {
  return {
    subredditIndex,
    type: REMOVE_SUBREDDIT_SUGGESTION,
  }
}

export function changePhoneNumberString(phoneNumberString) {
  return {
    phoneNumberString,
    type: CHANGE_PHONE_NUMBER_STRING,
  }
}

export function changeEmailString(emailString) {
  return {
    emailString,
    type: CHANGE_EMAIL_STRING,
  }
}

function subredditSuggestionsRequest() {
  return {
    type: SUBREDDIT_SUGGESTIONS_REQUEST
  }
}

function subredditSuggestionsSuccess(response) {
  return {
    subredditSuggestions: response.suggestions,
    type: SUBREDDIT_SUGGESTIONS_SUCCESS
  }
}

function subredditSuggestionsFailure(error) {
  return {
    error,
    type: SUBREDDIT_SUGGESTIONS_FAILURE
  }
}

function createListenerRequest() {
  return {
    type: CREATE_LISTENER_REQUEST
  }
}

function createListenerSuccess({ listener }) {
  return {
    listener,
    type: CREATE_LISTENER_SUCCESS
  }
}

function createListenerFailure(error) {
  return {
    error,
    type: CREATE_LISTENER_FAILURE
  }
}

export function submitCreateListener(stripeToken) {
  return (dispatch, getState) => {
    const state = getState();
    const redditWatchers = _.flatten(state.p2.subreddits.map(subreddit => {
      return [
        {
          metadata: {subreddit},
          source: 1,
          score: 1,
        },
        {
          metadata: {subreddit},
          source: 2,
          score: 1,
        },
      ];
    }));

    const hackerNewsWatchers = state.p2.hackerNewsCheck ? [{metadata: {}, source: 0, score:1}] : [];

    let csrfToken = $('meta[name="csrf-token"]').attr('content');
    const body = {
      listener: {
        query: state.p1.queryString,
        email: state.p3.emailString,
        phone_number: state.p3.phoneNumberString,
        social_watchers: redditWatchers.concat(hackerNewsWatchers),
      },
      stripe_token: stripeToken,
      authenticity_token: csrfToken,
    }

    return fetch(`/listeners`, {
      method: "POST",
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': csrfToken },
      body: JSON.stringify(body),
    }).then(
      response => response.json(),
      error => dispatch(createListenerFailure(error)),
    ).then(json => {
      dispatch(createListenerSuccess(json));
      dispatch(openModal());
      //location.href = `/listeners/${json.listener.token}`
    });
  }
}

export function submitSubredditSuggestions() {
  return (dispatch, getState) => {
    const state = getState();
    dispatch(subredditSuggestionsRequest());

    return fetch(`/suggestions?source=1&query=${state.p1.queryString}`, {
    }).then(
      response => response.json(),
      error => dispatch(subredditSuggestionsFailure(error)),
    ).then(
      json => dispatch(subredditSuggestionsSuccess(json))
    );
  }
}

export function openModal() {
  return { type: OPENED_MODAL }
}

export function closeModal() {
  return { type: CLOSED_MODAL }
}

export function openHelpModal() {
  return { type: OPENED_HELP_MODAL }
}

export function closeHelpModal() {
  return { type: CLOSED_HELP_MODAL }
}

function queryContentMatchCheckRequest() {
  return {
    type: QUERY_CONTENT_MATCH_CHECK_REQUEST
  }
}

function queryContentMatchCheckSuccess(response) {
  return {
    match: response.match,
    type: QUERY_CONTENT_MATCH_CHECK_SUCCESS
  }
}

function queryContentMatchCheckFailure(error) {
  return {
    error,
    type: QUERY_CONTENT_MATCH_CHECK_FAILURE
  }
}

export function submitQueryContentMatchCheck() {
  return (dispatch, getState) => {
    const state = getState();
    let content = state.p1.testTextString;
    let query = state.p1.queryString;
    if (!content || !query) {
      return;
    }

    dispatch(queryContentMatchCheckRequest());

    let csrfToken = $('meta[name="csrf-token"]').attr('content');
    return fetch('/listeners/matches_query', {
      method: "POST",
      headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': csrfToken },
      body: JSON.stringify({
        content,
        query,
      }),
    }).then(
      response => response.json(),
      error => dispatch(queryContentMatchCheckFailure(error)),
    ).then(
      json => dispatch(queryContentMatchCheckSuccess(json))
    );
  }
}
