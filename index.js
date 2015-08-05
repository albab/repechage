console.log("Booting up....");

var Twit        = require('twit');
var async       = require('async');

var T = new Twit({
})


var stream = T.stream('statuses/filter', { track: 'enter win follow RT' })

stream.on('tweet', function (tweet) {
	if (tweet.retweeted_status){
		console.log(tweet.retweeted_status.text);
  	console.log(tweet.retweeted_status.user.id);
  	console.log("\n");	
	} else if (tweet.quoted_status) {
		console.log("\n");
		console.log("Dumb Quote");
		console.log("\n");
	} else {
  	console.log(tweet.text);
  	console.log(tweet.user.id);
  	console.log("\n");
  }
})
