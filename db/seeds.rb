# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Create horse courses
# Seed fails, lai aizpildītu tabulas ar reāliem datiem

# Izveidojiet lietotājus

User.create!(
  name: 'Jānis',
  surname: 'Bērziņš',
  username: 'janis.berzins',
  email: 'janis.berzins@example.com',
  password: 'parole123' # Mainiet paroli pēc vajadzības
)

User.create!(
  name: 'Līga',
  surname: 'Ozola',
  username: 'liga.ozola',
  email: 'liga.ozola@example.com',
  password: 'parole123' # Mainiet paroli pēc vajadzības
)

User.create!(
  name: 'Pēteris',
  surname: 'Lauva',
  username: 'peteris.lauva',
  email: 'peteris.lauva@example.com',
  password: 'parole123' # Mainiet paroli pēc vajadzības
)
# Izveidojiet zirgu kursus
10.times do
  Exercise.offset(rand(Exercise.count)).first

  HorseCourse.create!(
    title: 'Zirga kursa nosaukums',
    description: 'Šis ir apraksts par zirga kursu. Tas ir ļoti interesants un piedāvā daudz labu informāciju par zirgu kopšanu un audzināšanu.'
  )
end

# Izveidojiet poni kursus
10.times do
  Exercise.offset(rand(Exercise.count)).first

  PonyCourse.create!(
    title: 'Poni kursa nosaukums',
    description: 'Šis ir apraksts par poni kursu. Tas sniedz daudz noderīgas informācijas par poni kopšanu un audzināšanu, kā arī par jāšanu un sacensībām.'
  )
end

# Izveidojiet zirgu vingrinājumus
10.times do
  Exercise.offset(rand(Exercise.count)).first

  HorseExercise.create!(
    title: 'Zirga vingrinājuma nosaukums',
    description: 'Šis ir apraksts par zirga vingrinājumu. Tas ir ļoti labs vingrinājums, lai uzlabotu zirga izturību un paklausību.'
  )
end

# Izveidojiet poni vingrinājumus
10.times do
  Exercise.offset(rand(Exercise.count)).first

  PonyExercise.create!(
    title: 'Poni vingrinājuma nosaukums',
    description: 'Šis ir apraksts par poni vingrinājumu. Tas ir piemērots poni izturības un apmācības uzlabošanai.'
  )
end

# Izveidojiet kalendāra grupas
10.times do
  admin = User.offset(rand(User.count)).first

  CalendarGroup.create!(
    admin:,
    group_name: 'Kalendāra grupas nosaukums'
  )
end

# Izveidojiet zirgu kalendāra ierakstus
10.times do
  CalendarGroup.offset(rand(CalendarGroup.count)).first

  CalendarHorse.create!(
    horse_name: 'Zirga nosaukums',
    description: 'Šis ir apraksts par zirgu, kas ir daļa no kalendāra grupas. Zirgs ir labs sporta līdzeklis un draugs.'
  )
end

# Izveidojiet poni kalendāra ierakstus
10.times do
  CalendarGroup.offset(rand(CalendarGroup.count)).first

  CalendarPony.create!(
    pony_name: 'Poni nosaukums',
    description: 'Šis ir apraksts par poni, kas ir daļa no kalendāra grupas. Poni ir mazs, bet ļoti spēcīgs un draudzīgs.'
  )
end

# Izveidojiet dalībniekus kalendāra ierakstos
10.times do
  group = CalendarGroup.offset(rand(CalendarGroup.count)).first
  user = User.offset(rand(User.count)).first

  CalendarParticipant.create!(
    group:,
    user:
  )
end

# Izveidojiet vingrinājumu dalībniekus
10.times do
  exercise = Exercise.offset(rand(Exercise.count)).first
  user = User.offset(rand(User.count)).first

  case exercise.animal_type
  when 'horse'
    HorseExercisesUser.create!(
      user:,
      horse_exercise: exercise,
      used: [true, false].sample,
      saved: [true, false].sample
    )
  when 'pony'
    PonyExercisesUser.create!(
      user:,
      pony_exercise: exercise,
      used: [true, false].sample,
      saved: [true, false].sample
    )
  end
end

# Izveidojiet kursu dalībniekus
10.times do
  course = HorseCourse.offset(rand(HorseCourse.count)).first
  user = User.offset(rand(User.count)).first

  HorseCoursesUser.create!(
    user:,
    horse_course: course,
    used: [true, false].sample,
    saved: [true, false].sample
  )
end

10.times do
  course = PonyCourse.offset(rand(PonyCourse.count)).first
  user = User.offset(rand(User.count)).first

  PonyCoursesUser.create!(
    user:,
    pony_course: course,
    used: [true, false].sample,
    saved: [true, false].sample
  )
end

puts 'Seed fails ir veiksmīgi izveidots!'
