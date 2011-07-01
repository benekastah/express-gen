helpers = require(:helpers)
bytor = helpers.get_controller(:bytor)

module.exports = [
   [:get, '/', { view: 'home/index', locals: { title: "Home Page" } }]
   , [:get, '/new-page', bytor.index.bind bytor]
]