repechage
==============
Piggy backing off the Gizmodo article with a bot that tries to win big
http://gizmodo.com/i-wrote-a-bot-that-won-twitter-contests-1722126436

Install
```
gem install twitter
gem install whenever
```

Just run with:
```
ruby main.rb
```

I'm guessing at this point what the output of the tweet object is based off other Twitter libraries I've used.
Best results at the moment are to hit it with a cronjob:
```
cd repechage
whenever
```




