# Start coding your hackernews scraper here!
require 'open-uri'
require 'nokogiri'

class Post
	attr_accessor :title, :url, :points, :item_id
	attr_reader :comments
	def initialize
		@comments = []
	end
	def comments 
		@comments
	end

	def add_comment(comment)
		@comments << comment 
	end
end

class Comment
	attr_reader :texts
	def initialize(texts)
		@texts = texts
	end
end

url = ARGV[0].to_s
nokogiri_doc = Nokogiri::HTML(open(url))
post = Post.new
post.title = nokogiri_doc.at_css('.title > a:first-child').text
post.url = nokogiri_doc.at_css('.title > a:first-child')['href']
post.points = nokogiri_doc.at_css('.subtext > span:first-child').text
post.item_id = nokogiri_doc.at_css('.athing')['id'].to_i

nokogiri_doc.css('.c00').each do |c|
	post.add_comment(Comment.new(c.text))
end

puts "\nPost title: #{post.title}\n\n"
puts "Url the post points to: #{post.url}\n\n"
puts "Post points :#{post.points}\n\n"
puts "Post item id: #{post.item_id}\n\n"
puts "Number of comments: #{post.comments.length}\n\n"
puts "Last comment read as: #{post.comments.last.texts}"