class Question < ActiveRecord::Base
  default_scope { order('id DESC') }
  scope :public_questions, -> {where(shared: true)}
  scope :private_questions, -> {where(shared: false)}
  scope :solved, -> {where(solved: true)}
  scope :unsolved, -> {where(solved: false)}
  belongs_to :user, validate: true
  has_many :answers, dependent: :destroy

  validates_associated :user
  validates_presence_of :user, :body

  searchable do
    text :body, :answer_body
    string :username
    time :created_at
    time :updated_at do
      last_updated_at
    end
    boolean :shared
    boolean :solved
    integer :answers_count
    integer :manifestation_id, multiple: true do
      answers.collect(&:items).flatten.collect{|i| i.manifestation.id}
    end
  end

  acts_as_taggable_on :tags

  paginates_per 10

  def answer_body
    text = ""
    self.reload
    self.answers.each do |answer|
      text += answer.body
    end
    return text
  end

  def username
    self.user.try(:username)
  end

  def last_updated_at
    if answers.last
      time = answers.last.updated_at
    end
    if time
      if time > updated_at
        time
      else
        updated_at
      end
    else
      updated_at
    end
  end

end

# == Schema Information
#
# Table name: questions
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)        not null
#  body          :text
#  shared        :boolean          default(TRUE), not null
#  answers_count :integer          default(0), not null
#  deleted_at    :datetime
#  state         :string
#  solved        :boolean          default(FALSE), not null
#  note          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
