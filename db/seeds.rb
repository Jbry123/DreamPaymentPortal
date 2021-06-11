# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
Credential.create(secret_key: 'sk_test_P9ZSzx6MHQxlxqRd1ZyMOKwZ', publishable_key: 'pk_test_ALPHtS20X3sl0klNKgknTcgQ', client_id: 'ca_GNMJI68nk1rDCZHkkRQJ2ElN4RUdeUlZ', percentage_amount: 
10)
