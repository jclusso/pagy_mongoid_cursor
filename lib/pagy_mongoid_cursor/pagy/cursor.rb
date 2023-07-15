class Pagy
  class Cursor < Pagy

    def initialize(vars)
      normalize_vars(vars)
      setup_items_var
      setup_params_var
      @page = vars[:page]
    end

    def finalize(prev_id, next_id, last_id)
      @prev = prev_id
      @next = next_id
      @last = last_id
      self
    end

    def series(*, **)
      []
    end

  end
end
