class Admin::SongRequestsController < AdminController
  before_action :set_song_request, only: [:show, :destroy]

  # GET /song_requests
  # GET /song_requests.json
  def index
    @song_requests = SongRequest.all
  end

  # GET /song_requests/1
  # GET /song_requests/1.json
  def show
  end

  # POST /song_requests
  # POST /song_requests.json
  def create
    @song_request = SongRequest.new(song_request_params.merge(ip: request.remote_ip))

    respond_to do |format|
      if @song_request.save
        begin
          NotificationMailer.new_song_request(@song_request).deliver
        rescue => e
          Rails.logger.error e
        end
        format.html { redirect_to root_path, notice: 'Song Request was successfully submitted.' }
        format.json { render json: { status: :ok, notice: "Thank you for your request! We’ll see what we can do." }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { status: :error, errors: @song_request.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_requests/1
  # DELETE /song_requests/1.json
  def destroy
    @song_request.destroy
    respond_to do |format|
      format.html { redirect_to song_requests_url, notice: 'Song request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /song_requests/search
  def search
    search = SpotifySearch.new(params[:search])
    render json: { status: :ok, html: render_to_string(partial: 'result', collection: search.results) }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_song_request
    @song_request = SongRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_request_params
    params.require(:song_request).permit(:name, :artist, :album).tap do |whitelisted|
      whitelisted[:info] = JSON.parse(params[:song_request][:info]) if params.dig(:song_request, :info).present?
    end
  end

  def action_is_public?
    action_name.in? %w(create search)
  end
end
