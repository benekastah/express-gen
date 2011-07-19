helpers = require :helpers

module.exports = [
   [:get, '/', { view: 'home/index', locals: { title: "Home Page" } }]
]
