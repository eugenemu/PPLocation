var express = require('express');
var app = express();
var bodyParser = require('body-parser');

app.use(bodyParser.json());

app.set('port', 5000);
var server = app.listen(5000, function() {
  console.log('App listening on Port 5000');
});


var users = {};

var io = require("socket.io").listen(server);
io.sockets.on("connection", function(socket) {

    users[socket.id] = {name: "", location: []};
    
    socket.on("userEntered", function(data) {
        users[socket.id].name = data;
    })
    
    socket.on("locationEntered", function(data) {
        users[socket.id].location = data;
        console.log(users);
    })

    socket.on("pullLocation", function() {
        socket.emit("giveLocations", users);
    })

    socket.on("disconnect", function() {
        console.log(socket.id, "disconnected");
        delete users[socket.id];
    });
});

