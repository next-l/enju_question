class QuestionSweeper < ActionController::Caching::Sweeper
  observe Answer
  include ExpireEditableFragment

  def after_save(record)
    case record.to_s.to_sym
    when :Answer
      record.items.each do |item|
        expire_editable_fragment(item.manifestation)
      end
    end
  end

  def after_destroy(record)
    after_save(record)
  end
end
