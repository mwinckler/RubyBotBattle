module Actions
  class Result
    attr_accessor :success, :animations

    def initialize(success, animations = nil)
      @success = success
      @animations = animations || []
    end
  end
end