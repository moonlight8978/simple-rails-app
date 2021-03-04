class ImportNotesController < ApplicationController
  def new
    @error = nil
  end

  # TODO Refactor error handling
  def create
    Services::ImportCsv
      .perform(params[:csv], Csvs::Import::Iterators::Note.new(current_user))
    redirect_to({ action: :new }, notice: "Success")
  rescue StandardError => e
    @error = e.message
    render :new
  end
end
