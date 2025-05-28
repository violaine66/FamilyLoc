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
  email:  ENV['GMAIL_ADDRESS'],
  nom_complet: "Violaine Soulas",
  password: "loulou",
  password_confirmation: "loulou",
  admin: true
)

User.create!(
  email: "jordisoulas@gmail.com",
  nom_complet: "Jordi Soulas",
  password: "family",
  password_confirmation: "family",
  nom_complet: "Jordi",
  admin: true
)

User.create!(
  email: "coco@app.fr",
  password: "cocococo",
  password_confirmation: "cocococo",
  nom_complet: "Coco",
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
