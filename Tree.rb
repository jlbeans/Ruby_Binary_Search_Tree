# frozen_string_literal: true

require_relative 'node'

# builds the binary tree using root nodes
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    sorted_arr = arr.sort.uniq
    return if sorted_arr.empty?

    start = 0
    mid = (sorted_arr.length - 1) / 2
    finish = sorted_arr.length - 1
    root = Node.new(sorted_arr[mid])
    root.left = build_tree(sorted_arr[start...mid])
    root.right = build_tree(sorted_arr[(mid + 1)..finish])

    root
  end

  def insert(new_data, node = @root)
    return nil if new_data == node.data

    if new_data < node.data
      node.left.nil? ? node.left = Node.new(new_data) : insert(new_data, node.left)
    elsif new_data > node.data
      node.right.nil? ? node.right = Node.new(new_data) : insert(new_data, node.right)
    end
  end

  def delete(data, node = @root)
    return node if node.nil?

    if node.data > data
      node.left = delete(data, node.left)
    else
      node.right = delete(data, node.right)
    end

    if node.data == data
      if node.left.nil?
        node = node.right
      elsif node.right.nil?
        node = node.left
      else
        remove_double_child_node(node)
      end
    end
    node
  end

  def remove_double_child_node(node)
    node.data = min_data(node.right)
    node.right = delete(node.data, node.right)
  end

  def min_data(node)
    node = node.left unless node.left.nil?
    node.data
  end

  def find(data, node = @root)
    return node if node.data == data
    return nil if node.nil?

    node.data > data ? find(data, node.left) : find(data, node.right)
  end

  def level_order(node = @root)
    printed_data = []
    queued_data = [node]
    until queued_data.empty?
      node = queued_data.shift
      printed_data << node.data
      queued_data << node.left unless node.left.nil?
      queued_data << node.right unless node.right.nil?
    end
    printed_data
  end

  def inorder(node = @root, printed_data = [])
    inorder(node.left, printed_data) unless node.left.nil?
    printed_data << node.data
    inorder(node.right, printed_data) unless node.right.nil?
    printed_data
  end

  def preorder(node = @root, printed_data = [])
    printed_data << node.data
    preorder(node.left, printed_data) unless node.left.nil?
    preorder(node.right, printed_data) unless node.right.nil?
    printed_data
  end

  def postorder(node = @root, printed_data = [])
    postorder(node.left, printed_data) unless node.left.nil?
    postorder(node.right, printed_data) unless node.right.nil?
    printed_data << node.data
    printed_data
  end

  def height(node = @root)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node)
    height(@root) - height(node)
  end

  def balanced?(node = @root)
    return true if node.nil?

    while height(node.left) - height(node.right).abs <= 1
      return true if balanced?(node.left) && balanced?(node.right)

      false
    end
  end

  def rebalance
    @root = build_tree(level_order)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
