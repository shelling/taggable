$:.unshift(".")
require 'database'

$:.unshift("lib")
require 'taggable'

puts "---"

result = Taggable::Parser.new.parse("hello world").tokenize
puts result.inspect
document = Document.create(result)
puts document.dump.inspect

result = Taggable::Parser.new.parse("<xml>hello world</xml><xml></xml>").tokenize
puts result.inspect
document = Document.create(result)
puts document.dump.inspect

result = Taggable::Parser.new.parse("<html><head></head><body>body here</body></html>").tokenize
puts result.inspect
document = Document.create(result)
puts document.dump.inspect

result = Taggable::Parser.new.parse("<html><head><script></script><link></link></head><body>body here</body></html>").tokenize
puts result.inspect
document = Document.create(result)
puts document.dump.inspect

result = Taggable::Parser.new.parse('<a><b><c>foo</c></b><d>bar</d></a><e>pqr</e>').tokenize
puts result.inspect
document = Document.create(result)
puts document.dump.inspect
