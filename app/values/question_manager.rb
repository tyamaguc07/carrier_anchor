class QuestionManager
  def initialize(questions)
    @questions = questions
  end

  def answers
    @questions.map(&:answer)
  end
end
