## Twitter [(raw)](https://gist.githubusercontent.com/timothy1ee/b9b1860c8ecb4b0b1c18/raw/2adc3f63677d81644e00245cee891eee88907767/gistfile1.md)

This is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).
### Assignment 4
Time spent: `12`

### Features

##Hamburger menu
- [X] Dragging anywhere in the view should reveal the menu.
- [X] The menu should include links to your profile, the home timeline, and the mentions view.
- [X] The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.

##Profile page
- [X] Contains the user header view
- [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Optional: Implement the paging view for the user description.
- [X] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
- [ ] Optional: Pulling down the profile page should blur and resize the header image.

##Home Timeline
- [X] Tapping on a user image should bring up that user's profile page

##Optional: Account switching
- [ ] Long press on tab bar to bring up Account view with animation
- [ ] Tap account to switch to
- [ ] Include a plus button to Add an Account
- [ ] Swipe to delete an account

### Walkthrough

![Video Walkthrough](https://raw.githubusercontent.com/anooptomar1/ios-simple-twitter/master/Menu_screenshot.gif)

### Assignment 3

Time spent: `14`

### Features

#### Required

- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [X] User can pull to refresh
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] User can retweet, favorite, and reply to the tweet directly from the timeline feed.

#### Optional

- [X] When composing, you should have a countdown in the upper right for the tweet limit.
- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [X] Retweeting and favoriting should increment the retweet and favorite count.
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [X] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough

![Video Walkthrough](https://raw.githubusercontent.com/anooptomar1/ios-simple-twitter/master/screenshot.gif)

### Login walkthrough
![Video Walkthrough](https://raw.githubusercontent.com/anooptomar1/ios-simple-twitter/master/Login_screenshot.gif)
