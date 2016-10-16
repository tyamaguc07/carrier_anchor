class Question
  attr_accessor :type, :text, :answer

  def initialize(type, text, answer=nil)
    @type, @text, @answer = type, text, answer
  end

  def pick
    @andwer += 4
  end
end
