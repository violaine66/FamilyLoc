# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
puts "Dropping all existing data..."
User.destroy_all
Propriete.destroy_all

puts "Creating users..."
User.create!(
  email:  ENV['ADMIN2'],
  nom_complet: ENV['NOM_COMPLET_ADMIN2'],
  password: ENV['PASSWORD_ADMIN2'],
  password_confirmation: ENV['PASSWORD_ADMIN2'],
  admin: true
)

User.create!(
  email: ENV["GMAIL_ADDRESS"],
  nom_complet: ENV['NOM_COMPLET_ADMIN1'],
  password: ENV['PASSWORD_ADMIN1'],
  password_confirmation: ENV['PASSWORD_ADMIN1'],
  admin: true
)

User.create!(
  email: ENV["MAIL_BER_S"],
  nom_complet: ENV['NOM_COMPLET_BER_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_C_M"],
  nom_complet: ENV['NOM_COMPLET_C_M'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_AL_S"],
  nom_complet: ENV['NOM_COMPLET_AL_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_S_S"],
  nom_complet: ENV['NOM_COMPLET_S_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_CL_S"],
  nom_complet:ENV['NOM_COMPLET_CL_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_CA_S"],
  nom_complet: ENV['NOM_COMPLET_CA_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_BA_S"],
  nom_complet: ENV['NOM_COMPLET_BA_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)

User.create!(
  email: ENV["MAIL_T_S"],
  nom_complet: ENV['NOM_COMPLET_T_S'],
  password: ENV['PASSWORD_USERS'],
  password_confirmation: ENV['PASSWORD_USERS'],
  admin: false
)


puts "Utilisateur créé "

puts "Creating properties..."
Propriete.create!(
  nom: "Hendaye, appartement du haut",
  adresse: "Hendaye, haut"
)

Propriete.create!(
  nom: "Hendaye, appartement du bas",
  adresse: "Hendaye, bas"
)

Propriete.create!(
  nom: "Préchac",
  adresse: "Préchac"
)

puts "Propriétés créées"
