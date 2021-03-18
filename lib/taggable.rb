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
      elements.map(&:tokenize)
    end
  end

  class Text < Treetop::Runtime::SyntaxNode
    def tokenize
      [[:content, text_value]]
    end
  end

  class T < Treetop::Runtime::SyntaxNode
    def tokenize
      [name.text_value.to_sym, ([Text, T].include?(content.class) ? content.tokenize : (content.elements.empty? ? nil : content.elements.map(&:tokenize)))]
    end
  end
end
