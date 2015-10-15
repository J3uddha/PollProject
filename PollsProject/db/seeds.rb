# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ActiveRecord::Base.transaction do
  jake = User.create!(
    :user_name  => "j3uddha",
  )

  ursula = User.create!(
    :user_name  => "goldstiiin",
  )

  dummy = User.create!(
    :user_name  => "Nidalee",
  )

  first_poll = jake.authored_polls.create!(
    :title => "Favorite Game"
  )

  first_question =  first_poll.questions.create!(
    :text => "League, or Hearthstone?"
    #:poll_id  => first_poll.id
  )

  second_poll = ursula.authored_polls.create!(
    :title => "Favorite Champion?",
  )

  second_question =  second_poll.questions.create!(
    :text => "Ashe, Nunu or Zed?"
    # :poll_id  => second_poll.id
  )

  third_question =  second_poll.questions.create!(
    :text => "Varus, Poppy, Renekton?"
  )

  first_answer_choice = first_question.answer_choices.create!(
    :text => "League of Legends"
  #:question_id => first_question.id
  )

  second_answer_choice = first_question.answer_choices.create!(
    :text => "Hearthstone"
  #:question_id => first_question.id
  )

  third_answer_choice = second_question.answer_choices.create!(
    :text => "Ashe"
  #:question_id => second_question.id
  )

  fourth_answer_choice = second_question.answer_choices.create!(
    :text => "Nunu"
  #:question_id => second_question.id
  )

  fifth_answer_choice = second_question.answer_choices.create!(
    :text => "Zed"
  #:question_id => second_question.id
  )

  sixth_answer_choice = third_question.answer_choices.create!(
    :text => "Varus"
  #:question_id => second_question.id
  )

  seventh_answer_choice = third_question.answer_choices.create!(
    :text => "Poppy"
  #:question_id => second_question.id
  )

  eigth_answer_choice = third_question.answer_choices.create!(
    :text => "Renekton"
  #:question_id => second_question.id
  )

  first_response = ursula.responses.create!(
    :answerchoice_id => first_answer_choice.id
  )

  second_response = fourth_answer_choice.responses.create!(
    :user_id => jake.id
  )

  third_response = dummy.responses.create!(
    :answerchoice_id => fifth_answer_choice.id
  )

  fourth_response = second_answer_choice.responses.create!(
    :user_id => dummy.id
  )


#   comment1 = first_post.comments.create!(
#     :body => "Great job first posting!",
#     :author_id => jonathan.id
#   )
#
#   comment2 = comment1.replies.create!(
#     :body      => "Thanks!",
#     :post_id   => comment1.post_id,
#     :author_id => ned.id
#   )
end
