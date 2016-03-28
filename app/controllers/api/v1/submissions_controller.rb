class Api::V1::SubmissionsController < Api::BaseController
  before_action :find_submission, only: :update

  def update
    # f = LocalFile.new(params[:file].tempfile.path)
    # byebug
    # @submission.files << file
    # if @submission.save
    #   head :ok
    # else
    #   render json: { errors: @submission.errors.full_messages }
    # end

    result = { status: "failed" }

    begin
      params[:file] = parse_image_data(params[:file]) if params[:file]
      item = Item.new
      item.image = params[:file]

      if item.save
        result[:status] = "success"
      end
    rescue Exception => e
      Rails.logger.error "#{e.message}"
    end

    render json: result.to_json
    ensure
      clean_tempfile
    end
  end

  def parse_image_data(image_data)
    @tempfile = Tempfile.new('item_image')
    @tempfile.binmode
    @tempfile.write Base64.decode64(image_data[:content])
    @tempfile.rewind

    uploaded_file = ActionDispatch::Http::UploadedFile.new(
      tempfile: @tempfile,
      filename: image_data[:filename]
    )

   uploaded_file.content_type = image_data[:content_type]
    uploaded_file
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

  private

  def find_submission
    info_request = InfoRequest.find params[:info_request_id]
    info_request.submission ||= Submission.new
    @submission = info_request.submission
  end
end
