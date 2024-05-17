# frozen_string_literal: true

class CoursePositionsController < ApplicationController
  def show_positions
    choice = params[:choice]

    case choice
    when 'Poniju maršruti'
      @pony_courses = PonyCourse.order(created_at: :desc).page(params[:page]).per(8)
    when 'Poniju vingrinājumi'
      @pony_exercises = PonyExercise.order(created_at: :desc).page(params[:page]).per(8)
    when 'Zirgu maršruti'
      @horse_courses = HorseCourse.order(created_at: :desc).page(params[:page]).per(8)
    when 'Zirgu vingrinājumi'
      @horse_exercises = HorseExercise.order(created_at: :desc).page(params[:page]).per(8)
    else
      redirect_to course_positions_path, notice: 'Notika kļūda'
    end
  end

  def save_horse_exercise
    @exercise = HorseExercise.find(params[:id])
    if current_user.horse_exercises_users.exists?(horse_exercise_id: @exercise.id, saved: true)
      flash[:alert] = 'Vingrinājums jau ir saglabāts.'
    else
      current_user.horse_exercises << @exercise
      @exercise.horse_exercises_users.find_or_create_by(user_id: current_user.id).update(saved: true)
      flash[:notice] = 'Vingrinājums veiksmīgi saglabāts'
    end
    redirect_back(fallback_location: welcome_page_path)
  end

  def save_horse_course
    @exercise = HorseCourse.find(params[:id])
    if current_user.horse_courses_users.exists?(horse_course_id: @exercise.id, saved: true)
      flash[:alert] = 'Maršruts jau ir saglabāts.'
    else
      current_user.horse_courses << @exercise
      @exercise.horse_courses_users.find_or_create_by(user_id: current_user.id).update(saved: true)
      flash[:notice] = 'Maršruts veiksmīgi saglabāts'
    end
    redirect_back(fallback_location: welcome_page_path)
  end

  def save_pony_course
    @exercise = PonyCourse.find(params[:id])
    if current_user.pony_courses_users.exists?(pony_course_id: @exercise.id, saved: true)
      flash[:alert] = 'Maršruts jau ir saglabāts.'
    else
      current_user.pony_courses << @exercise
      @exercise.pony_courses_users.find_or_create_by(user_id: current_user.id).update(saved: true)
      flash[:notice] = 'Maršruts veiksmīgi saglabāts'
    end
    redirect_back(fallback_location: welcome_page_path)
  end

  def save_pony_exercise
    @exercise = PonyExercise.find(params[:id])
    if current_user.pony_exercises_users.exists?(pony_exercise_id: @exercise.id, saved: true)
      flash[:alert] = 'Vingrinājums jau ir saglabāts.'
    else
      current_user.pony_exercises << @exercise
      @exercise.pony_exercises_users.find_or_create_by(user_id: current_user.id).update(saved: true)
      flash[:notice] = 'Vingrinājums veiksmīgi saglabāts'
    end
    redirect_back(fallback_location: welcome_page_path)
  end

  def unsave_horse_exercise
    @exercise = HorseExercise.find(params[:id])
    horse_exercise_user = current_user.horse_exercises_users.find_by(horse_exercise_id: @exercise.id)
    if horse_exercise_user&.used
      horse_exercise_user.update(saved: false)
      redirect_to profile_path, notice: 'Vingrinājums ir veiksmīgi noņemts'
    else
      current_user.horse_exercises.delete(@exercise)
    end
  end

  def unsave_horse_course
    @exercise = HorseCourse.find(params[:id])
    horse_course_user = current_user.horse_courses_users.find_by(horse_course_id: @exercise.id)
    if horse_course_user&.used
      horse_course_user.update(saved: false)
      redirect_to profile_path, notice: 'Maršruts ir veiksmīgi noņemts'
    else
      current_user.horse_courses.delete(@exercise)
    end
  end

  def unsave_pony_course
    @exercise = PonyCourse.find(params[:id])
    pony_course_user = current_user.pony_courses_users.find_by(pony_course_id: @exercise.id)
    if pony_course_user&.used
      pony_course_user.update(saved: false)
      redirect_to profile_path, notice: 'Maršruts ir veiksmīgi noņemts'
    else
      current_user.pony_courses.delete(@exercise)
    end
  end

  def unsave_pony_exercise
    @exercise = PonyExercise.find(params[:id])
    pony_exercise_user = current_user.pony_exercises_users.find_by(pony_exercise_id: @exercise.id)
    if pony_exercise_user&.used
      pony_exercise_user.update(saved: false)
      redirect_to profile_path, notice: 'Vingrinājums ir veiksmīgi noņemts'
    else
      current_user.pony_exercises.delete(@exercise)
    end
  end

  def mark_used_horse_exercise
    @exercise = HorseExercise.find(params[:id])
    horse_exercise_user = current_user.horse_exercises_users.find_by(horse_exercise_id: @exercise.id)
    horse_exercise_user.update(used: true)
    redirect_to profile_path, notice: 'Vingrinājums ir atzīmēts kā izmantots'
  end

  # Mark Horse Exercise as unused
  def mark_unused_horse_exercise
    @exercise = HorseExercise.find(params[:id])
    horse_exercise_user = current_user.horse_exercises_users.find_by(horse_exercise_id: @exercise.id)
    horse_exercise_user.update(used: false)
    redirect_to profile_path, notice: 'Vingrinājums ir atzīmēts kā neizmantots'
  end

  # Mark Horse Course as used
  def mark_used_horse_course
    @course = HorseCourse.find(params[:id])
    horse_course_user = current_user.horse_courses_users.find_by(horse_course_id: @course.id)
    horse_course_user.update(used: true)
    redirect_to profile_path, notice: 'Maršruts ir atzīmēts kā izmantots'
  end

  # Mark Horse Course as unused
  def mark_unused_horse_course
    @course = HorseCourse.find(params[:id])
    horse_course_user = current_user.horse_courses_users.find_by(horse_course_id: @course.id)
    horse_course_user.update(used: false)
    redirect_to profile_path, notice: 'Maršruts ir atzīmēts kā neizmantots'
  end

  # Mark Pony Exercise as used
  def mark_used_pony_exercise
    @exercise = PonyExercise.find(params[:id])
    pony_exercise_user = current_user.pony_exercises_users.find_by(pony_exercise_id: @exercise.id)
    pony_exercise_user.update(used: true)
    redirect_to profile_path, notice: 'Vingrinājums ir atzīmēts kā izmantots'
  end

  # Mark Pony Exercise as unused
  def mark_unused_pony_exercise
    @exercise = PonyExercise.find(params[:id])
    pony_exercise_user = current_user.pony_exercises_users.find_by(pony_exercise_id: @exercise.id)
    pony_exercise_user.update(used: false)
    redirect_to profile_path, notice: 'Vingrinājums ir atzīmēts kā neizmantots'
  end

  # Mark Pony Course as used
  def mark_used_pony_course
    @course = PonyCourse.find(params[:id])
    pony_course_user = current_user.pony_courses_users.find_by(pony_course_id: @course.id)
    pony_course_user.update(used: true)
    redirect_to profile_path, notice: 'Maršruts ir atzīmēts kā izmantots'
  end

  # Mark Pony Course as unused
  def mark_unused_pony_course
    @course = PonyCourse.find(params[:id])
    pony_course_user = current_user.pony_courses_users.find_by(pony_course_id: @course.id)
    pony_course_user.update(used: false)
    redirect_to profile_path, notice: 'Maršruts ir atzīmēts kā neizmantots'
  end
end
