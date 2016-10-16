class QuestionManager
  attr_reader :questions, :reselect_num

  def initialize(questions)
    @questions = questions
    @reselect_num = Settings.max_reselect_num
  end

  def result
    @questions.each_with_object({}) do |question, hash|
      hash[question.type] ||= 0.0
      hash[question.type] += question.answer / 5.0
    end
  end

  def answer_to(question, answer)
    @questions.find {|q| q.object_id == question.object_id }.answer = answer
  end

  def reselect(question)
    pick(question)
    @reselect_questions.delete_if {|q| q.object_id == question.object_id }
    @reselect_num -= 1
  end

  def need_reselect?
    reselect_questions.present? && !@reselect_num.zero?
  end

  def reselect_questions
    @reselect_questions ||= begin
      result = []

      answers = question_with_answers.keys.compact.sort.reverse

      answers.each do |answer|
        questions = question_with_answers[answer]

        if questions.size > @reselect_num
          result = questions
          break
        end

        questions.each {|question| pick(question) }

        if questions.size == @reselect_num
          @reselect_num = 0
          break
        else
          @reselect_num -= questions.size
        end
      end

      result
    end
  end

  private

  def pick(question)
    @questions.find {|q| q.object_id == question.object_id }.answer += 4
  end

  def question_with_answers
    @question_with_answers ||= begin
      @questions.each_with_object({}) do |question, hash|
        hash[question.answer] ||= []
        hash[question.answer] << question
      end
    end
  end
end
