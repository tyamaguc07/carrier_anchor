question_manager = QuestionManagerFactory.new.create

puts '----------------------------------'
puts '以下の質問があなたに対してどのくらいピッタリあてはまるのかについて、1から6の数字を入力してください'
puts '1: 全然そう思わない'
puts '2: そう思うこともたまにはある（大）'
puts '3: そう思うこともたまにはある（小）'
puts '4: よくそう思う（小）'
puts '5: よくそう思う（大）'
puts '6: いつもそう思う'
puts '----------------------------------'

question_manager.questions.each.with_index(1) do |question, index|
  puts "[#{index}] #{question.text}"

  while answer = STDIN.gets.to_i
    next puts 'please input 1..6' if answer.zero? || answer > 6

    question_manager.answer_to(question, answer)
    break
  end
end


if question_manager.need_reselect?
  puts '----------------------------------'

  question_manager.reselect_questions.each do |question|
    puts question.text
  end

  puts "上記の設問からしっくり来るものを#{question_manager.reselect_num}つ選んでください"

  puts '----------------------------------'

  while question_manager.need_reselect?
    question_manager.reselect_questions.each do |question|
      puts "[#{question.text}] はしっくり来ますか？ [y/n] (default: n)"

      if STDIN.gets.chomp == 'y'
        question_manager.reselect(question)
        break if !question_manager.need_reselect?
      end
    end
  end
end

puts '----------------------------------'
puts '[結果]'
question_manager.result.each do |key, value|
  puts "#{key}: #{value.round(2)}"
end
