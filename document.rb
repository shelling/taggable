class Document < ActiveRecord::Base
  has_many :nodes, as: :parent

  def self.create(nodes)
    document = super()

    nodes.each do |node|
      if node[0] == :content
        Node.create(parent: document, kind: :content, content: node[1])
      else
        Node.create(parent: document, kind: :tag, content: node[0], children: node[1])
      end
    end

    document
  end

  def dump
    nodes.map(&:dump)
  end
end
