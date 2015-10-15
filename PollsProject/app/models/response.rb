
class Response < ActiveRecord::Base
  validates :user_id, :answerchoice_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answerchoice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  def sibling_responses
    self.question
        .responses
        .where("? IS NULL OR answerchoice_id != ?", self.id, self.id)
  end

  has_one(
    :question,
    through: :answer_choice,
    source: :question)

private

def respondent_has_not_already_answered_question
  if sibling_responses.exists?(:user_id => self.user_id)
    errors[:response] << "you've already chosen an answer! no backsies"
  end
end

end
