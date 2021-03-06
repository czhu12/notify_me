import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import {
  toggleHackerNewsCheck,
  toggleRedditCheck,
  changeSubredditString,
  addSubreddit,
  removeSubreddit,
  addSubredditSuggestion,
  removeSubredditSuggestion,
} from 'actions';

const mapStateToProps = state => ({
  hackerNewsCheck: state.p2.hackerNewsCheck,
  redditCheck: state.p2.redditCheck,
  subredditString: state.p2.subredditString,
  subreddits: state.p2.subreddits,
  subredditSuggestions: state.p2.subredditSuggestions,
  subredditSuggestionsLoading: state.p2.subredditSuggestionsLoading,
  validationErrors: state.validation.validationErrors.p2,
});

const mapDispatchToProps = dispatch => ({
  onClickHackerNewsCheck: () => {
    dispatch(toggleHackerNewsCheck());
  },
  onClickRedditCheck: (e) => {
    dispatch(toggleRedditCheck());
  },
  onChangeSubredditString: (e) => {
    dispatch(changeSubredditString(e.target.value));
  },
  onAddSubreddit: (subreddit) => {
    dispatch(addSubreddit(subreddit));
  },
  onRemoveSubreddit: (subredditIndex) => {
    dispatch(removeSubreddit(subreddit));
  },
  onClickSubredditSuggestion: (suggestion, subredditIndex) => {
    dispatch(addSubredditSuggestion(suggestion));
    dispatch(removeSubredditSuggestion(subredditIndex));
  },
});

const propTypes = {
  hackerNewsCheck: PropTypes.bool.isRequired,
  redditCheck: PropTypes.bool.isRequired,
  subredditString: PropTypes.string.isRequired,
  subreddits: PropTypes.arrayOf(PropTypes.string).isRequired,
  subredditSuggestions: PropTypes.arrayOf(PropTypes.string).isRequired,
  onClickHackerNewsCheck: PropTypes.func.isRequired,
  onClickRedditCheck: PropTypes.func.isRequired,
  onChangeSubredditString: PropTypes.func.isRequired,
  onAddSubreddit: PropTypes.func.isRequired,
  onRemoveSubreddit: PropTypes.func.isRequired,
  onClickSubredditSuggestion: PropTypes.func.isRequired,
  className: PropTypes.string.isRequired,
  subredditSuggestionsLoading: PropTypes.bool.isRequired,
  validationErrors: PropTypes.object.isRequired,
}

function P2Form({
  queryString,
  onChangeQueryString,
  hackerNewsCheck,
  redditCheck,
  subredditString,
  subreddits,
  subredditSuggestions,
  onClickHackerNewsCheck,
  onClickRedditCheck,
  onChangeSubredditString,
  onAddSubreddit,
  onRemoveSubreddit,
  onClickSubredditSuggestion,
  className,
  subredditSuggestionsLoading,
  validationErrors,
}) {
  let subredditList = subreddits.map((subreddit) => {
    return (<li key={subreddit} className="list-group-item">{subreddit}</li>);
  });

  let subredditSuggestionList = subredditSuggestions.map((suggestion, index) => {
    return (
      <span
        key={suggestion}
        className="suggestion"
        data-subreddit={suggestion}
        onClick={onClickSubredditSuggestion.bind(null, suggestion, index)}
        >
          /r/{suggestion}
      </span>
    )
  });
  let atLeastOneSubredditErrorMessage = validationErrors.atLeastOneSubreddit;
  let atLeastOneOptionErrorMessage = validationErrors.atLeastOneOption;

  return (
    <div className={className} id="social-channel-form">
      <label className="main-form-input">What Channels?</label>
      <div id="channels">

        <div className="form-check">
          <i
            style={hackerNewsCheck ? {color: '#ff6600'} : {}}
            className="fa fa-hacker-news"
            aria-hidden="true"
            onClick={onClickHackerNewsCheck}
          ></i>

          <label className="form-check-label">
            Hacker News
          </label>
        </div>

        <div className="form-check">
          <i
            style={redditCheck ? {color: '#ff6314'} : {}}
            className="fa fa-reddit-square"
            aria-hidden="true"
            onClick={onClickRedditCheck}
          ></i>

          <label className="form-check-label">
            Reddit
          </label>

          {redditCheck ? (
            <div className="animated fadeIn">
              <div className="reddit-subreddits">
                {subredditList}
              </div>

              <div className="form-metadata">
                <div className="input-group mb-3">
                  <div className="input-group-prepend">
                    <span className="input-group-text">reddit.com/r/</span>
                  </div>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="cscareerquestions"
                    name="reddit[subreddit]"
                    onChange={onChangeSubredditString}
                    value={subredditString}
                  />

                  <div className="input-group-append">
                    <button
                      id="add-subreddit"
                      className="btn btn-outline-secondary"
                      type="button"
                      onClick={onAddSubreddit}
                    >
                      Add
                    </button>
                  </div>
                </div>
              </div>

              <div>
                <small className="text-danger">
                  {atLeastOneSubredditErrorMessage}
                </small>
              </div>

              <div>
                <b>Suggestions</b>: <span className="suggestions">
                  {subredditSuggestionsLoading ? (<div className="fa fa-spinner fa-spin"></div>) : null}

                  {subredditSuggestionList}
                </span>
              </div>
            </div>
          ) : null}

          <div>
            <small className="text-danger">
              {atLeastOneOptionErrorMessage}
            </small>
          </div>

        </div>

      </div>
    </div>
  );
}

P2Form.propTypes = propTypes;

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(P2Form);
