require 'pagy_mongoid_cursor/pagy/cursor'

class Pagy
  DEFAULT[:cursor_last_page_link] = true

  module CursorExtra
    private

    def pagy_cursor(collection, vars={})
      pagy = Pagy::Cursor.new(pagy_cursor_get_vars(collection, vars))
      [pagy, pagy_cursor_get_items(collection, pagy)]
    end

    def pagy_cursor_get_vars(_collection, vars)
      pagy_set_items_from_params(vars) if defined?(ItemsExtra)
      vars[:page] ||= params[vars[:page_param] || DEFAULT[:page_param]]
      vars
    end

    def pagy_cursor_get_items(collection, pagy)
      items = collection.order(id: :asc)

      if pagy.page.nil?
        items = items.limit(pagy.items + 1).to_a
      else
        items = items.where(:id.gte => pagy.page).limit(pagy.items + 1).to_a

        prev_items = collection.where(:id.lt => pagy.page).
                                order(id: :desc).
                                limit(pagy.items).
                                to_a.reverse
        prev_id = prev_items.first.id if prev_items.size == pagy.items
      end
      next_id = items.pop&.id if items.size > pagy.items

      if pagy.vars[:cursor_last_page_link]
        last_items = collection.order(id: :desc).
                                limit(pagy.items).
                                only(:id).to_a
        last_id = last_items.last.id if last_items.size == pagy.items
      end

      pagy.finalize(prev_id, next_id, last_id)
      items
    end

  end
  Backend.prepend CursorExtra
end
