class Admin::RsvpsController < AdminController
  before_action :set_rsvp, only: [:show, :edit, :update, :destroy]

  # GET /rsvps
  # GET /rsvps.json
  def index
    @rsvps = Rsvp.all.order(:last_name, :first_name)
    @rsvp_count = Rsvp.head_count
  end

  # GET /rsvps/1
  # GET /rsvps/1.json
  def show
  end

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new
  end

  # GET /rsvps/1/edit
  def edit
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params.merge(ip: request.remote_ip))
    message = @rsvp.attending? ? 'We look forward to seeing you' : 'We’re sorry you can’t make it'

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to root_path, notice: "Thank you for your RSVP! #{message}." }
        format.json { render json: { status: :ok, notice: "Thank you for your RSVP! #{message}." }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { status: :error, errors: @rsvp.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rsvps/1
  # PATCH/PUT /rsvps/1.json
  def update
    @rsvp.assign_attributes(rsvp_params)

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to rsvps_path, notice: "The RSVP has been updated." }
        format.json { render json: { status: :ok, notice: "Your RSVP has been updated." }, status: :created }
      else
        format.html { render :edit }
        format.json { render json: { status: :error, errors: @rsvp.errors.full_messages.to_sentence }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rsvps/1
  # DELETE /rsvps/1.json
  def destroy
    @rsvp.destroy
    respond_to do |format|
      format.html { redirect_to rsvps_url, notice: 'RSVP was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rsvp
    @rsvp = Rsvp.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rsvp_params
    params.require(:rsvp).permit(:first_name, :last_name, :plus_one, :attending, :notes)
  end

  def action_is_public?
    action_name.in? %w(create)
  end
end
