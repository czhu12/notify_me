# README
# TODO
Build some landing page for each listener created
- What kind of information do we want to show on this page?
- Do this on a per LISTENER basis so we can just send them an email.
- Each listener has sources from
  1. Hacker News
    - Story
    - Comment
  2. Reddit Stories
  3. Reddit Comments
  Lets just show a historical feed since thats what you'd get from your phone/email
- Build some way to stop a listener.
- Send out initial email when someone subscribes to a new listener.
  1. This should have a link to manage the listener
  2. Bookmark this email/text to cancel the listener.

# Sources Supported
### CURRENTLY
1. hacker news
2. reddit
### POTENTIALLY
1. facebook
2. twitter

# Destinations Supported
### CURRENTLY
1. text
2. email
3. slack
### POTENTIALLY
1. messenger

# BRAINSTORMING
1. Add a way to be able to reply through the channel (text, slack, email) -> (hacker news, reddit)
2. Add tracking for youtube comments? - Nah...
3. Add tracking for facebook groups and twitter messages?
4. What should the message be like?
  - Could also have other things... like, content of the message
  - "[czhu12](https://news.ycombinator.com/user?id=czhu12) mentioned **`amazon|tech|interview|`** [here](https://news.ycombinator.com/item?id=17531916)"
5. We need a filter for importance probably, at least 10 retweets, 10 likes, etc
