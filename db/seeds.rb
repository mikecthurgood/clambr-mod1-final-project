# Wall.create(name: "Stronghold", location: "Tottenham Hale")
# Wall.create(name: "Harrowall", location: "Harrow")
# Wall.create(name: "The Climbing Hangar", location: "Parsons Green")
# Wall.create(name: "Mile End Climbing Centre", location: "Mile End")
# Wall.create(name: "White Spider Climbing", location: "Tolworth")
# Wall.create(name: "The Depot Climbing Centre", location: "Manchester")
# Wall.create(name: "The Works Climbing Centre", location: "Sheffield")
# Wall.create(name: "Hackney Wick Boulder Project", location: "Hackney Wick")
# Wall.create(name: "Colchester Climbing Project", location: "Colchester")
# Wall.create(name: "The Arch Climbing Wall", location: "Bermondsey")

# 100.times do
#     name = Faker::Name.unique.name
#     grade = rand(1..10)
#     Client.create(name: name, grade: grade )
# end

# 20.times do
#     name = Faker::Name.unique.name
#     grade = rand(8..15)
#     Trainer.create(name: name, grade: grade)
# end

# 15.times do
#     wall_id = rand(1..10)
#     client_id = rand(1..100)
#     trainer_id = rand(1..20)
#     Session.create(wall_id: wall_id, client_id: 108, trainer_id: trainer_id)
# end

Client.create(name: "Super Chrissy", grade: 10, email: "chrisk@super.user", password: "@super", superuser: true )
Client.create(name: "Super Mikey", grade: 10, email: "miket@super.user", password: "@super", superuser: true )




