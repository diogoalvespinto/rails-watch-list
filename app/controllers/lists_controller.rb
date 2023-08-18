class ListsController < ApplicationController
  before_action :set_list, only: %i[show destroy]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.photo.attached?
        if @list.save
          format.html { redirect_to list_path(@list), notice: 'List was successfully created.' }
          format.json { render :show, status: :created, location: @list }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show; end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
