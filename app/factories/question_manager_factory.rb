class QuestionManagerFactory
  def create(answers = [])
    questions = Settings.questions.zip(answers).map do |question, answer|
      Question.new(question.type, question.text, answer)
    end

    QuestionManager.new(questions)
  end
end
