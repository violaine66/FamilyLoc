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
  admin: true
)

User.create!(
  email: ENV["GMAIL_ADDRESS"],
  nom_complet: ENV['NOM_COMPLET_ADMIN1'],
  password: ENV['PASSWORD_ADMIN1'],
  admin: true
)

# User.create!(
#   email: ENV["MAIL_B_S"],
#   nom_complet: "Bernard Soulas",
#   password: "family",
#   password_confirmation: "family",
#   admin: false
# )


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
