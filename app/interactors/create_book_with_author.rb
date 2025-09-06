class CreateBookWithAuthor
  include Interactor::Organizer

  organize CreateAuthor, CreateBook

  def self.call(*args)
    result = nil
    ActiveRecord::Base.transaction do
      result = super
      raise ActiveRecord::Rollback if result.failure?
    end
    result
  end
end
