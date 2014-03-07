# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Subject.destroy_all
Subject.create! code: "A", name: "Nature of Matter"
Subject.create! code: "B", name: "Life Science"
Subject.create! code: "C", name: "Physical Science"
Subject.create! code: "D", name: "Earth & Space Science"
