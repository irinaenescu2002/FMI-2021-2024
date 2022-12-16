// const http = require('http');
// const dt = require('./dt');

// http.createServer(function (req, res) {
//   res.writeHead(200, {'Content-Type': 'text/html'});
//   res.write(`Current path is ${req.url}`);
//   res.end('\nHello World!');
// }).listen(8080);

const { response } = require('express');
const express = require('express');
const app = express();
const port = 3000;

/// asta apare in chrome - localhost:3000
app.get('/', (req, res) => {
    res.send("Hello world!");
})

/// daca punem localhost:3000/welcome o sa afiseze asta, nu Hello world!
/// deoarece suntem pe ruta welcome 
app.get('/welcome', (req, res) => {
    res.send("I am on route welcome");
})


/// CODURI RES (STATUS CODE)

/// CODURI BUNE (ok, s-a executat bine cererea)
/// 200 - s-a executat corect cererea
/// 201 - cereri de tip post (ex. inserare carte noua in baza de carti)
/// 204 - s-a executat cu succes, dar la unele date nu am nimic in raspuns
/// 304 - not modified 

/// ERORI CARE TIN DE CLIENT (front-end)
/// 400 - bad request (cand cerem sa introducem ce nu corespunde formatului)
/// 401 - nu avem voie sa accesam resursa respectiva (am uitat sa trimitem element de securitate pentru a avea acces)
/// In server trebuie protejate datele accesate prin usermane (ex. parola)
/// 402 - payment required 
/// 403 - forbidden 
/// 404 - not found (adresa scrisa gresit) :)

/// ERORI CARE TIN DE SERVER (back-end)
/// 500 - problema pe server (logica de pe server e gresita, incearca sa acceseze ceva ce nu exista etc)


/// asta apare in terminal 
app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

 