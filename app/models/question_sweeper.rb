class QuestionSweeper < ActionController::Caching::Sweeper
  observe Answer
  include ExpireEditableFragment

  def after_save(record)
    case
    when record.is_a?(Answer)
      record.items.each do |item|
        expire_editable_fragment(item.manifestation, ['detail'])
      end
    end
  end

  def after_destroy(record)
    after_save(record)
  end
end
