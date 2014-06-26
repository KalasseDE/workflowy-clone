module ItemsHelper

  def breadcrumbs(item)
    ancestors = []
    parent = @nested_items[item.id][:parent][:item]

    until parent == nil
      ancestors.unshift(parent)
      parent = @nested_items[parent.id][:parent][:item]
    end

    ancestors.map do |item|
      "<a href=\"#{item_path(item)}\">#{h(item.title)}</a> >"
    end .join('')
  end
end
