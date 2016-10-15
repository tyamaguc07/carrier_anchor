class Question
  attr_accessor :text, :answer

  def initialize(type, text, answer=nil)
    @type, @text, @answers = type, text, answer
  end
end
