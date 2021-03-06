require 'twitter'
require 'json'

@follow_and_retweet = Hash.new(0)
@follow_and_retweet_history = JSON.parse(File.read('data/users_and_retweets.json'))
number_of_contests_to_enter = 10

rest_client = Twitter::REST::Client.new do |config|
  config.consumer_key       = 'ZYztcGvW08hh513W354Ix2MVu'
  config.consumer_secret    = 'ZvV0sGsCjN8c0n2roZJPK7krjsJ6dpvdvOo8xHQIc1iXZz3iy6'
  config.access_token        = '3307168590-cYjuX5LQqnzOBp9eIfYkcCG3sMBTqp04UgOxWlo'
  config.access_token_secret = 'JtA75M9d5KFdlmELadPzLV33K3Ekg861DyAEw7fotdpCu'
end

enter_to_win = "RT follow enter win"
rest_client.search(enter_to_win, result_type: "recent").take(number_of_contests_to_enter).collect do |object|
	count = 0
  if object.retweeted_status && object.is_a?(Twitter::Tweet)
  	if @follow_and_retweet.has_key? object.retweeted_status.user.id.to_i or @follow_and_retweet_history.has_key? object.retweeted_status.user.id.to_i
  		puts "Already added #{object.retweeted_status.user.id.to_i} to list...\n\n"
  	else
  		@follow_and_retweet.merge! object.retweeted_status.user.id.to_i => object.retweeted_status.id.to_i
  		puts "#{object.retweeted_status.text}\n"
  		puts "Added user: #{object.retweeted_status.user.id}, tweet: #{object.retweeted_status.id} to follower/retweet list\n"
  		@follow_and_retweet.each do |user|
  			count+=1
  		end
  		puts "#{count}/#{number_of_contests_to_enter}\n\n"
  	end
  elsif object.quoted_status && object.is_a?(Twitter::Tweet)
  	puts "Dumb Quote\n\n"
  else
  	puts "Nobody cares\n\n"
  end
  sleep(2)
  break if count >= number_of_contests_to_enter
end

puts "Time to follow the users we found and retweet their tweets TO WIN BIG...."
puts "/////////////////////////////////////////////////////////////////////////"

@follow_and_retweet.each do |user, tweet|
	begin
		rest_client.follow user
		puts "Followed user: #{user}"
    sleep(1)
		# rest_client.retweet tweet
		# puts "Retweeted tweet: #{tweet}"
	rescue => error
    puts error
		next
	end
end

puts "\nBacking up...\n"

begin
  file = File.write("data/users_and_retweets.json", @follow_and_retweet.to_json)
  file = File.write("data/users_and_retweets.json", @follow_and_retweet_history.to_json)
rescue IOError => e
  #some error occur, dir not writable etc.
ensure
  # file.close unless file.nil?
end




puts "\n~~~~\n"
puts "Fini."
puts "\n~~~~\n"