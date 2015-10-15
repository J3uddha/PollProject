class Question < ActiveRecord::Base
  validates :poll_id, uniqueness: true
  validates :poll_id, :text, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )


  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

# N+1!
  # def results
  #   poll_counts = {}
  #   self.answer_choices.each do |answer_choices|
  #     poll_counts[answer_choices.text] = answer_choices.responses.count
  #   end
  #
  #   poll_counts
  # end

# includes / eager / AKA not N+1!
  # def results
  #   answer_choices = self.answer_choices.includes(:responses)
  #
  #   poll_counts = {}
  #   answer_choices.each do |choice|
  #     poll_counts[choice.text] = choice.responses.length
  #   end
  #
  #   poll_counts
  # end

  # SQL version

  def results
    choices_w_counts = ActiveRecord::Base.connection.execute(<<-SQL)
                    SELECT
                      answer_choices.*, COUNT(responses.id) AS choice_count
                    FROM
                      answer_choices
                    LEFT OUTER JOIN
                      responses
                    ON
                      responses.answerchoice_id = answer_choices.id
                    WHERE
                      answer_choices.question_id = #{self.id}
                    GROUP BY
                      answer_choices.id
                    SQL

    # poll_counts = {}
    # choices_w_counts.each do |choice|
    #    poll_counts[choice.text] = choice.choice_count
    #  end
    #
    # poll_counts
  end


#AWESOMENESS!
  # def results
  #   choices_w_counts = self
  #                   .answer_choices
  #                   .select("answer_choices.*, COUNT(responses.id) AS choice_count")
  #                   .joins(<<-SQL).group("answer_choices.id")
  #                   LEFT OUTER JOIN
  #                     responses ON responses.answerchoice_id = answer_choices.id
  #                   SQL
  #   poll_counts = {}
  #   choices_w_counts.each do |choice|
  #      poll_counts[choice.text] = choice.choice_count
  #    end
  #
  #   poll_counts
  # end

end
