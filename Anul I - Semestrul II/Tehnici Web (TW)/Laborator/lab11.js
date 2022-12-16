// Importam cu REQUIRE 
// const js = require("./numefisier.json");

// Alta varianta de import 
// const fs = require("fs");

// Citire - arata intreg fisierul
// fs.readFile ("./numefisier.json", "utf8", (err, string) => {
//     if(err) {
//         console.log("FAIL", err)
//         return
//     }
//     console.log(string);
// })

// Citire - impartim informatiile => obiect
// fs.readFile ("./numefisier.json", "utf8", (err, string) => {
//     if(err) {
//         console.log("FAIL", err)
//         return
//     }
//     console.log(string);
//     const ob = JSON.parse(string);
//     console.log(ob);
// })

// Scriere in fisier
// Avem deja obiectul obtinut prin:
//     console.log(string);
//     const ob = JSON.parse(string);
//     console.log(ob);
// Apoi:
// jsonSTring = JSON.stringify(ob);
// fs.write("./numefisier.json", jsonstring, err => {
//     if(err) {
//         console.log("CACA", err);
//     } else {
//         console.log("YEY A MERS");
//     }
// })

// DACA VREM SA FACEM UPDATE COMBINAM CITIREA CU SCRIEREA
// citim --> modificam --> suprascriem tot fisierul cu textul modificat
// modificare --> ob.numefisier = [...obj.numefisier, (valoare1: "...", valoare2: "...")];

