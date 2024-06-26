# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]

  def index
    @exercises = current_user.exercises.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show; end

  def new
    @exercise = Exercise.new
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.user_id = current_user.id

    if @exercise.save
      if @exercise.public
        success = create_associated_records(@exercise)
        if !success
          render :new # Re-render the form with errors
        else
          redirect_to exercises_path(selected_exercise_id: @exercise.id),
                      notice: 'Vingrinājums tika veiksmīgi izveidots.'
        end
      else
        redirect_to exercises_path(selected_exercise_id: @exercise.id), notice: 'Vingrinājums tika veiksmīgi izveidots.'
      end
    else
      render :new
    end
  end

  def update
    @exercise = Exercise.find(params[:id])
    old_exercise_type = @exercise.exercise_type
    old_animal_type = @exercise.animal_type
    was_public = @exercise.public?

    if @exercise.update(exercise_params)
      if !@exercise.public?
        remove_associated_records(@exercise)
        redirect_to exercises_path(selected_exercise_id: @exercise.id),
                    notice: 'Vingrinājums tika veiksmīgi atjaunināts'
      else
        if was_public && (old_exercise_type != @exercise.exercise_type || old_animal_type != @exercise.animal_type)
          remove_associated_records(OpenStruct.new(exercise_type: old_exercise_type, animal_type: old_animal_type,
                                                   id: @exercise.id))
        end
        success = create_associated_records(@exercise)
        if !success
          render :edit # Re-render the form with errors
        else
          redirect_to exercises_path(selected_exercise_id: @exercise.id),
                      notice: 'Vingrinājums tika veiksmīgi atjaunināts.'
        end
      end
    else
      render :edit
    end
  end

  def destroy
    remove_associated_records(@exercise)
    if @exercise.destroy
      redirect_to exercises_url, notice: 'Vingrinājums tika veiksmīgi dzēsts.'
    else
      redirect_to exercises_path(selected_exercise_id: @exercise.id), alert: 'Neizdevās izdzēst vingrinājumu.'
      Rails.logger.error "Dzēšana neizdevās ar kļūdām: #{@exercise.errors}"
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:user_id, :exercise_name, :exercise_description, :animal_type, :exercise_type,
                                     :public, :completed, :canvas_data, :canvas_image)
  end

  def remove_associated_records(exercise)
    case exercise.exercise_type
    when 'vingrinajums'
      case exercise.animal_type
      when 'Ponijs'
        # Remove associated records from pony_exercises table
        PonyExercise.where(exercise_id: exercise.id).destroy_all
      when 'Zirgs'
        # Remove associated records from horse_exercises table
        HorseExercise.where(exercise_id: exercise.id).destroy_all
      end
    when 'marsruts'
      case exercise.animal_type
      when 'Ponijs'
        # Remove associated records from pony_courses table
        PonyCourse.where(exercise_id: exercise.id).destroy_all
      when 'Zirgs'
        # Remove associated records from horse_courses table
        HorseCourse.where(exercise_id: exercise.id).destroy_all
      end
    end
  end

  def create_associated_records(exercise)
    # Ja vingrinājums ir publisks un vingrinājuma veids ir 'vingrinajums'
    if exercise.public? && exercise.exercise_type == 'vingrinajums'
      # Ja dzīvnieka tips ir 'Ponijs'
      if exercise.animal_type == 'Ponijs'
        # Meklē esošu PonyExercise ar tādu pašu nosaukumu
        existing_record = PonyExercise.find_by(title: exercise.exercise_name)
        # Ja eksistējošs ieraksts un tas nav saistīts ar pašreizējo vingrinājumu, pievieno kļūdu un atgriež false
        if existing_record && existing_record.exercise_id != exercise.id
          exercise.errors.add(:base, 'Nosaukums jau eksistē, lai padarītu publiski to nomainiet!')
          return false
        end
        # Izveido vai atrod PonyExercise ar attiecīgajām īpašībām
        PonyExercise.create_with(description: exercise.exercise_description, canvas_image: exercise.canvas_image)
                    .find_or_create_by(title: exercise.exercise_name, exercise_id: exercise.id)
      # Ja dzīvnieka tips ir 'Zirgs'
      elsif exercise.animal_type == 'Zirgs'
        # Meklē esošu HorseExercise ar tādu pašu nosaukumu
        existing_record = HorseExercise.find_by(title: exercise.exercise_name)
        # Ja eksistējošs ieraksts un tas nav saistīts ar pašreizējo vingrinājumu, pievieno kļūdu un atgriež false
        if existing_record && existing_record.exercise_id != exercise.id
          exercise.errors.add(:base, 'Nosaukums jau eksistē, lai padarītu publiski to nomainiet!')
          return false
        end
        # Izveido vai atrod HorseExercise ar attiecīgajām īpašībām
        HorseExercise.create_with(description: exercise.exercise_description, canvas_image: exercise.canvas_image)
                     .find_or_create_by(title: exercise.exercise_name, exercise_id: exercise.id)
      end
    # Ja vingrinājums ir publisks un vingrinājuma veids ir 'marsruts'
    elsif exercise.public? && exercise.exercise_type == 'marsruts'
      # Ja dzīvnieka tips ir 'Ponijs'
      if exercise.animal_type == 'Ponijs'
        # Meklē esošu PonyCourse ar tādu pašu nosaukumu
        existing_record = PonyCourse.find_by(title: exercise.exercise_name)
        # Ja eksistējošs ieraksts un tas nav saistīts ar pašreizējo vingrinājumu, pievieno kļūdu un atgriež false
        if existing_record && existing_record.exercise_id != exercise.id
          exercise.errors.add(:base, 'Nosaukums jau eksistē, lai padarītu publiski to nomainiet!')
          return false
        end
        # Izveido vai atrod PonyCourse ar attiecīgajām īpašībām
        PonyCourse.create_with(description: exercise.exercise_description, canvas_image: exercise.canvas_image)
                  .find_or_create_by(title: exercise.exercise_name, exercise_id: exercise.id)
      # Ja dzīvnieka tips ir 'Zirgs'
      elsif exercise.animal_type == 'Zirgs'
        # Meklē esošu HorseCourse ar tādu pašu nosaukumu
        existing_record = HorseCourse.find_by(title: exercise.exercise_name)
        # Ja eksistējošs ieraksts un tas nav saistīts ar pašreizējo vingrinājumu, pievieno kļūdu un atgriež false
        if existing_record && existing_record.exercise_id != exercise.id
          exercise.errors.add(:base, 'Nosaukums jau eksistē, lai padarītu publiski to nomainiet!')
          return false
        end
        # Izveido vai atrod HorseCourse ar attiecīgajām īpašībām
        HorseCourse.create_with(description: exercise.exercise_description, canvas_image: exercise.canvas_image)
                   .find_or_create_by(title: exercise.exercise_name, exercise_id: exercise.id)
      end
    end
    # Ja visi nosacījumi ir izpildīti, atgriež true
    true
  end
end
