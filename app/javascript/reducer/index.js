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
  VALIDATION_FAILED,
  OPENED_MODAL,
  CLOSED_MODAL,
  OPENED_HELP_MODAL,
  CLOSED_HELP_MODAL,
  QUERY_CONTENT_MATCH_CHECK_REQUEST,
  QUERY_CONTENT_MATCH_CHECK_SUCCESS,
  QUERY_CONTENT_MATCH_CHECK_FAILURE,
} from 'constants/actionTypes';

import { combineReducers } from 'redux';

function mainFormReducer(state={
  formStep: 0,
}, action) {
  switch(action.type) {
    case NEXT_FORM_STEP:
      return Object.assign({}, state, {
        formStep: Math.max(Math.min(state.formStep + 1, 3), 0),
      });
    default:
      return state;
  }
}

function p1Reducer(state={
  queryString: '',
  testTextString: '',
  queryContentMatch: false,
  queryContentMatchFetching: false,
}, action) {
  switch(action.type) {
    case CHANGE_QUERY_STRING:
      return Object.assign({}, state, {
        queryString: action.queryString,
      });
    case CHANGE_TEST_TEXT_STRING:
      return Object.assign({}, state, {
        testTextString: action.testTextString,
      });
    case QUERY_CONTENT_MATCH_CHECK_REQUEST:
      return Object.assign({}, state, {
        queryContentMatchFetching: true,
      });
    case QUERY_CONTENT_MATCH_CHECK_SUCCESS:
      return Object.assign({}, state, {
        queryContentMatchFetching: false,
        queryContentMatch: action.match,
      });
    case QUERY_CONTENT_MATCH_CHECK_FAILURE:
      return Object.assign({}, state, {
        queryContentMatchFetching: false,
      });
    default:
      return state;
  }
}

function p2Reducer(state={
  hackerNewsCheck: false,
  redditCheck: false,
  subredditString: '',
  subreddits: [],
  subredditSuggestions: [],
  subredditSuggestionsLoading: false
}, action) {
  switch(action.type) {
    case CHANGE_HACKER_NEWS_CHECK:
      return Object.assign({}, state, {
        hackerNewsCheck: action.hackerNewsCheck,
      });
    case CHANGE_REDDIT_CHECK:
      return Object.assign({}, state, {
        redditCheck: action.redditCheck,
      });
    case CHANGE_SUBREDDIT_STRING:
      return Object.assign({}, state, {
        subredditString: action.subredditString,
      });
    case ADD_SUBREDDIT:
      return Object.assign({}, state, {
        subredditString: '',
        subreddits: [...state.subreddits, state.subredditString],
      });
    case REMOVE_SUBREDDIT:
      return Object.assign({}, state, {
        subreddits: state.subreddits.filter((subreddit, index) => {
          return !(action.subredditIndex === index);
        }),
      });
    case ADD_SUBREDDIT_SUGGESTION:
      return Object.assign({}, state, {
        subreddits: [...state.subreddits, action.subreddit],
      });
    case SUBREDDIT_SUGGESTIONS_REQUEST:
      return Object.assign({}, state, {
        subredditSuggestionsLoading: true,
      });
    case SUBREDDIT_SUGGESTIONS_SUCCESS:
      return Object.assign({}, state, {
        subredditSuggestions: action.subredditSuggestions,
        subredditSuggestionsLoading: false,
      });
    case SUBREDDIT_SUGGESTIONS_FAILURE:
      return Object.assign({}, state, {
        subredditSuggestionsLoading: false,
      });
    case REMOVE_SUBREDDIT_SUGGESTION:
      return Object.assign({}, state, {
        subredditSuggestions: state.subredditSuggestions.filter((subreddit, index) => {
          return !(action.subredditIndex === index);
        }),
      });
    default:
      return state;
  }
}

function p3Reducer(state={
  phoneNumberString: '',
  emailString: '',
}, action) {
  switch(action.type) {
    case CHANGE_PHONE_NUMBER_STRING:
      return Object.assign({}, state, {
        phoneNumberString: action.phoneNumberString,
      });
    case CHANGE_EMAIL_STRING:
      return Object.assign({}, state, {
        emailString: action.emailString,
      });
    default:
      return state;
  }
}

function validationReducer(state={
  validationErrors: {
    mainForm: {},
    p1: {},
    p2: {},
    p3: {},
  }
}, action) {
  switch(action.type) {
    case VALIDATION_FAILED:
      return Object.assign({}, state, {
        validationErrors: action.validationErrors,
      });
    default:
      return state;
  }
}

function modalReducer(state={
  modalOpen: false,
  helpModalOpen: false,
}, action) {
  switch(action.type) {
    case OPENED_MODAL:
      return Object.assign({}, state, {
        modalOpen: true,
      });
    case CLOSED_MODAL:
      return Object.assign({}, state, {
        modalOpen: false,
      });
    case OPENED_HELP_MODAL:
      return Object.assign({}, state, {
        helpModalOpen: true,
      });
    case CLOSED_HELP_MODAL:
      return Object.assign({}, state, {
        helpModalOpen: false,
      });
    default:
      return state;
  }
}

export default combineReducers({
  mainForm: mainFormReducer,
  p1: p1Reducer,
  p2: p2Reducer,
  p3: p3Reducer,
  validation: validationReducer,
  modalReducer: modalReducer,
})
