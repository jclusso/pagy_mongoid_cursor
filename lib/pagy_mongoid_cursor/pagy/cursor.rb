class Pagy
  class Cursor < Pagy
    attr_reader :before, :after

    def initialize(vars)
      normalize_vars(vars)
      setup_items_var
      setup_params_var

      direction, id = vars[:page].split(':') if vars[:page]

      if direction == 'before'
        @before = id
      elsif direction == 'after'
        @after = id
      end
    end

    def finalize(before_id, after_id, last_id)
      @prev = "before:#{before_id}" if before_id
      @next = "after:#{after_id}" if after_id
      @last = "after:#{last_id}" if last_id
      self
    end

    def series(*, **)
      []
    end

  end
end
