# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Service.create(
    [
        {
            name: "Corte",
            duration: 30
        },
        {
            name: "Corte y brushing",
            duration: 45
        },
        {
            name: "Tintura global",
            duration: 90
        },
        {
            name: "Mechas",
            duration: 120
        },
        {
            name: "Mechas y corte",
            duration: 150
        },
        {
            name: "Tintura y mechas",
            duration: 180
        },
        {
            name: "Tintura y corte",
            duration: 120
        },
        {
            name: "Alisado",
            duration: 180
        },
        {
            name: "Alisado y corte",
            duration: 210
        },
        {
            name: "Sólo brushing",
            duration: 30
        }
    ]
)
