class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all.order(:to)
    if Reservation.exists?(params[:id])
      @reservation = @reservations.find(params[:id])
      redirect_to @reservation
    elsif params[:commit]
     redirect_to "/reservations/#{params[:id]}"
    end
  end

  # GET /reservations/1 
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit  
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Twoje auto będzie w końcu miało swoje miejsce na tym świecie pełnym przepełnionych parkingów :)' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Rezerwacja została poprawiona' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, method: "get", notice: 'Wywalone z bazy w kosmos' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      if !Reservation.exists?(params[:id])
        respond_to do |format|
          format.html { redirect_to reservations_url, method: "get", notice: 'Szukaliśmy długo i intensywnie, ale nie znaleźliśmy takiego ID :(' }
          format.json { head :no_content }
        end
      else @reservation = Reservation.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:name, :from, :to)
    end
end
