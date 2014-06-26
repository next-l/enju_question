# -*- encoding: utf-8 -*-
class Question < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  default_scope {order('id DESC')}
  scope :public_questions, -> {where(:shared => true)}
  scope :private_questions, -> {where(:shared => false)}
  scope :solved, -> {where(:solved => true)}
  scope :unsolved, -> {where(:solved => false)}
  belongs_to :user, :validate => true
  has_many :answers, :dependent => :destroy

  validates_associated :user
  validates_presence_of :user, :body

  index_name "#{name.downcase.pluralize}-#{Rails.env}"

  after_commit on: :create do
    index_document
  end

  after_commit on: :update do
    update_document
  end

  after_commit on: :destroy do
    delete_document
  end

  settings do
    mappings dynamic: 'false', _routing: {required: false} do
      indexes :body
      indexes :answer_body
      indexes :note
      indexes :shared, type: 'boolean'
      indexes :solved, type: 'boolean'
      indexes :created_at, type: 'date'
      indexes :updated_at, type: 'date'
      indexes :manifestation_id, type: 'integer'
      indexes :answers_count, type: 'integer'
    end
  end

  def as_indexed_json(options={})
    as_json.merge(
      answer_body: answer_body,
      username: user.try(:username),
      updated_at: last_updated_at,
      manifestation_id: answers.collect(&:items).flatten.collect{|i| i.manifestation.id}
    )
  end

  acts_as_taggable_on :tags
  enju_ndl_crd

  paginates_per 10

  def self.crd_per_page
    5
  end

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
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  body          :text
#  shared        :boolean          default(TRUE), not null
#  answers_count :integer          default(0), not null
#  deleted_at    :datetime
#  state         :string(255)
#  solved        :boolean          default(FALSE), not null
#  note          :text
#  created_at    :datetime
#  updated_at    :datetime
#
