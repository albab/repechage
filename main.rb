require 'tweetstream'

users_to_follow = []

TweetStream.configure do |config|

end

TweetStream::Client.new.track('rt enter follow win') do |status|
	if status.retweeted_status
		puts "#{status.retweeted_status.text}"
		puts "User: #{status.retweeted_status.user.id}\n\n"
		users_to_follow.push(status.retweeted_status.user.id)

	elsif status.quoted_status
		puts "Dumb Quote\n\n"
	else 
  	puts "#{status.text}"
  	puts "User: #{status.user.id}\n\n"
  	users_to_follow.push(status.user.id)
	end
end