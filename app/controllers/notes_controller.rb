class NotesController < ApplicationController
  include ExportCsvConcern

  protect_actions :index

  def index
    @notes = current_user.notes

    respond_to do |format|
      format.html do
        @pagy, @notes = pagy(@notes)
      end

      format.csv do
        stream_csv("notes.csv") do |io|
          Services::ExportCsv.new(io)
            .perform(@notes, Csvs::Export::Iterators::Basic.with(Csvs::Export::Rows::Note))
        end
      end

      format.zip do
        stream_zip("user-notes.zip") do |writter|
          @notes.find_in_batches(batch_size: 1000).with_index do |notes, batch|
            writter.call("notes-#{batch + 1}.csv", proc do |io|
              Services::ExportCsv.new(io)
                .perform(notes, Csvs::Export::Iterators::Basic.with(Csvs::Export::Rows::Note), batch_size: nil)
            end)
          end

          writter.call("user.csv", proc do |io|
            Services::ExportCsv.new(io)
              .perform([current_user], Csvs::Export::Iterators::Basic.with(Csvs::Export::Rows::User), batch_size: nil)
          end)
        end
      end
    end
  end
end
