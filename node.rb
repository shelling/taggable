class Node  < ActiveRecord::Base
  has_many :nodes, as: :parent, class_name: 'Node'
  belongs_to :parent, polymorphic: true

  enum kind: [
    :tag,
    :content,
  ]

  def self.create(params = {})
    node = super(params.slice(:parent, :kind, :content))

    (params[:children] || []).each do |child|
      if child[0] == :content
        Node.create(parent: node, kind: :content, content: child[1])
      else
        Node.create(parent: node, kind: :tag, content: child[0], children: child[1])
      end
    end

    node
  end

  def dump
    case kind
    when "tag"
      [content.to_sym, (nodes.empty? ? nil : nodes.all.map(&:dump))]
    when "content"
      [:content, content]
    end
  end
end
