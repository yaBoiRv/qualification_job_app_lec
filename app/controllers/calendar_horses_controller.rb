# frozen_string_literal: true

class CalendarHorsesController < ApplicationController
  class CalendarHorsesController < ApplicationController
    before_action :set_calendar_group
    before_action :set_calendar_horse, only: %i[show edit update destroy]

    def index
      @calendar_horses = @calendar_group.calendar_horses
    end

    def show; end

    def new
      @calendar_horse = CalendarHorse.new
    end

    def create
      @calendar_horse = CalendarHorse.new(calendar_horse_params)
      if @calendar_horse.save
        redirect_to @calendar_horse.calendar_group, notice: 'Zirgs veiksmīgi pievienots.'
      else
        render :new
      end
    end

    def edit
      @calendar_group = CalendarGroup.find(params[:calendar_group_id])
      @calendar_horse = @calendar_group.horses.find(params[:id])
    end

    def update
      if @calendar_horse.update(calendar_horse_params)
        redirect_to @calendar_horse.calendar_group, notice: 'Zirgs veiksmīgi atjaunināts.'
      else
        render :edit
      end
    end

    def destroy
      @calendar_horse.destroy
      redirect_to @calendar_horse.calendar_group, notice: 'Zirgs veiksmīgi dzēsts.'
    end

    private

    def set_calendar_group
      @calendar_group = CalendarGroup.find(params[:calendar_group_id])
    end

    def set_calendar_horse
      @calendar_horse = @calendar_group.calendar_horses.find(params[:id])
    end

    def calendar_horse_params
      params.require(:calendar_horse).permit(:horse_name, :description, :calendar_group_id)
    end
  end
end
