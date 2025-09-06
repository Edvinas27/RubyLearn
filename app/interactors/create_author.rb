class CreateAuthor
  include Interactor

  def call
    author = AuthorFinderOrCreator.call(context.author_params)
    context.author = author

  rescue => e
    context.fail!(error: e.record.errors.full_messages)
  end
end
