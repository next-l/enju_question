class User < ActiveRecord::Base
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, # , :validatable
         :lockable, lock_strategy: :none, unlock_strategy: :none

  include EnjuSeed::EnjuUser
  include EnjuQuestion::EnjuUser
end

Manifestation.include(EnjuQuestion::EnjuManifestation)
Question.include(EnjuNdl::EnjuQuestion)
Item.include(EnjuQuestion::EnjuItem)
