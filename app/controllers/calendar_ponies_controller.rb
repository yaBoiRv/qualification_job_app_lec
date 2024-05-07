# frozen_string_literal: true

class CalendarPoniesController < ApplicationController
  before_action :set_calendar_group
  before_action :set_calendar_pony, only: %i[show edit update destroy]

  def index
    @calendar_ponies = @calendar_group.calendar_ponies
  end

  def show; end

  def new
    @calendar_pony = CalendarPony.new
  end

  def create
    @calendar_pony = CalendarPony.new(calendar_pony_params)
    if @calendar_pony.save
      redirect_to @calendar_pony.calendar_group, notice: 'Ponijs ir veiksmīgi pievienots'
    else
      render :new
    end
  end

  def edit
    @calendar_pony = @calendar_group.ponies.find(params[:id])
  end

  def update
    if @calendar_pony.update(calendar_pony_params)
      redirect_to calendar_group_calendar_pony_path(@calendar_group, @calendar_pony),
                  notice: 'Ponijs ir veiksmīgi atjaunināts'
    else
      render :edit
    end
  end

  def destroy
    @calendar_pony.destroy
    redirect_to calendar_group_calendar_ponies_path(@calendar_group), notice: 'Ponijs ir veiksmīgi dzēsts'
  end

  private

  def set_calendar_group
    @calendar_group = CalendarGroup.find(params[:calendar_group_id])
  end

  def set_calendar_pony
    @calendar_pony = @calendar_group.ponies.find(params[:id])
  end

  def calendar_pony_params
    params.require(:calendar_pony).permit(:pony_name, :description, :calendar_group_id)
  end
end
