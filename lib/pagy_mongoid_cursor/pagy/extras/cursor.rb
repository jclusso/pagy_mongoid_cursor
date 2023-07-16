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
      if pagy.before
        # get extra item before the id so we can determine if there is another
        # page before this
        items = collection.order(id: :desc).where(
          :id.lt => pagy.before
        ).limit(pagy.items + 1).to_a.reverse
        # if there is an extra item that means we have another page before this
        # so we shift off the extra item and set the before id to the first item
        if items.size > pagy.items
          items.shift
          before_id = items.first.id
        end
        after_id = items.last.id
      else
        if pagy.after
          # get extra item after the id so we can determine if there is another
          # page after this
          items = collection.order(id: :asc).where(
            :id.gt => pagy.after
          ).limit(pagy.items + 1).to_a
          before_id = items.first&.id
        else
          items = collection.order(id: :asc).limit(pagy.items + 1).to_a
        end
        # if there is an extra item that means we have another page after this
        # we pop off the extra item and set the after id to the last item
        if items.size > pagy.items
          items.pop
          after_id = items.last&.id
        end
      end

      if pagy.vars[:cursor_last_page_link]
        last_id = collection.order(id: :desc).limit(
          pagy.items + 1
        ).pluck(:id).last
      end

      pagy.finalize(before_id, after_id, last_id)
      items
    end

  end
  Backend.prepend CursorExtra
end
