class QuestionManagerFactory
  def new_question_manager(answers)
    questions = Settings.questions.map { |question|
      [question.type, question.text]
    }.zip(answers).map {|ary|
      Question.new(*ary)
    }

    QuestionManager.new(questions)
  end
end
