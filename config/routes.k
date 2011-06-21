
module.exports = [
   [:get, '/', { view: 'home/index', locals: { title: "Home Page" } }]
   , [:get, '/new-page', -> { "New page!" }]
]