// Scrieti un document HTML care sa contina un formular cu un element select avand optiunile "mic", "mare", 
// un grup de doua butoane radio avand etichetele "e capitala", "nu e capitala" si un buton-submit. 
// La server se va defini si vectorul de obiecte,
// orase=[ { nume:"Aa", populatie:14000, capitala:true }, { nume:"Bb", populatie:7000, capitala:false }, 
// { nume:"Cc", populatie:19000, capitala:false }, { nume:"Dd", populatie:5000, capitala:false }, 
// { nume:"Ee", populatie:8000, capitala:true }, { nume:"Ff", populatie:12000, capitala:false }, 
// { nume:"Gg", populatie:20000, capitala:true } ]
// Scrieti aplicatia server app.js astfel incat, la submit pe formularul dat, sa se afiseze lista de orase cu 
// tipul selectat ("mic" insemnand sub 10000 locuitori, si "mare" peste 10000) si care sunt (sau nu) capitale 
// in functie de butonul radio bifat. Informatiile vor fi preluate din vectorul de orase aflat in app.js. 
// Afisarea poate fi in interiorul paginii sau in locul paginii cu formularul. 

const express = require('express');
const app=express();

app.use('/post',express.urlencoded({extended:true}));

orase=[
	{
		nume:"Aa",
		populatie:14000,
		capitala:true
	},
	{
		nume:"Bb",
		populatie:7000,
		capitala:false
	},
	{
		nume:"Cc",
		populatie:19000,
		capitala:false
	},
	{
		nume:"Dd",
		populatie:5000,
		capitala:false
	},
	{
		nume:"Ee",
		populatie:8000,
		capitala:true
	},
	{
		nume:"Ff",
		populatie:12000,
		capitala:false
	},
	{
		nume:"Gg",
		populatie:20000,
		capitala:true
	}
]

app.get("/p4.html", function(req,res){

	res.sendFile(__dirname+ "/p4.html");
	//res.sendFile("/home/carmen/Desktop/Curs_TehniciWeb/EXEMPLE-CURS12/Model_subiect/p4.html");
});


app.post("/post",function(req,res){

 let arr = [];
	console.log(req.body);
	for(let oras of orase) {
		if(req.body.tip == 'mic') {
			if(oras.populatie < 10000) {
				if(req.body.capitala == 'nu' && oras.capitala == false)
					arr.push(oras.nume);
				else if(req.body.capitala == 'da' && oras.capitala == true)
					arr.push(oras.nume); 
			}
		}
		else {
			if(oras.populatie >= 10000) {
				if(req.body.capitala == 'nu' && oras.capitala == false)
					arr.push(oras.nume);
				else if(req.body.capitala == 'da' && oras.capitala == true)
					arr.push(oras.nume); 
			}
		}		
	}
	res.send(arr);
});

app.listen(7000, function(){console.log("Serverul a pornit");});

