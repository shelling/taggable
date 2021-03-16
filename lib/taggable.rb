require "treetop"
Treetop.load(File.expand_path("taggable", File.dirname(__FILE__)))

module Taggable
  class Parser < Treetop::Runtime::CompiledParser
    include Taggable

    def call(string)
      if result = parse(string)
        result.tokenize
      else
        raise Exception, self.failure_reason
      end
    end
  end

  class Document < Treetop::Runtime::SyntaxNode
    def tokenize
      elements[0].tokenize
    end
  end

  class Text < Treetop::Runtime::SyntaxNode
    def tokenize
      text_value
    end
  end

  class T < Treetop::Runtime::SyntaxNode
    def tokenize
      [name.text_value.to_sym, content.elements.map(&:tokenize)]
    end
  end
end
