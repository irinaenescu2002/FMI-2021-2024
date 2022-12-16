const express = require('express')
const {json} = require('express/lib/response')
const fs = require('fs')
const bodyParser = require("body-parser")
const app = express()
const port = 5000

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

app.use(express.static('public'))
app.use(express.static('views'))
app.use(express.urlencoded({ extended: true }))
app.set('view engine', 'ejs')

const cors=require("cors");
const corsOptions ={
   origin:'*', 
   credentials:true,   
   optionSuccessStatus:200,
}

app.use(cors(corsOptions))

// SHOW 
app.get('/appointments', (req, res) => {
    fs.readFile('./programari.json', 'utf8', (err, jsonString) => {
        if(err) { 
            console.error(err)
            return
        }
        let programariFacute = JSON.parse(jsonString);
        console.log(programariFacute);
        res.render('./appointments', {
            obj: programariFacute.programari
        });
    });
});

//ADD
app.post('/appointments', (req, res) => {
    fs.readFile('./programari.json', 'utf8', (err, jsonString) => {
        if(err) {
            console.error(err)
            return
        }
        let programariFacute = JSON.parse(jsonString)
        programariFacute.programari.push(req.body)
        let jsonUpdate = JSON.stringify(programariFacute)
        fs.writeFile('./programari.json', jsonUpdate, 'utf8', err => {
            if(err) { 
                console.error(err)
                return
            }
            console.log('Scris cu succes!');
        });
    });
});

//CHANGE
app.put('/appointments', (req, res) => {
    fs.readFile('./programari.json', 'utf8', (err, jsonString) => {
        if(err) { 
            console.error(err)
            return
        }
        let programariFacute = JSON.parse(jsonString)
        for(let i = 0; i < programariFacute.programari.length; i++) {
            if(req.body.id == programariFacute.programari[i].id ) {
                programariFacute.programari[i].activity = req.body.activity  
            }
        }
        let jsonUpdate = JSON.stringify(programariFacute);
        fs.writeFile('./programari.json', jsonUpdate, 'utf8', err => {
            if(err) { 
                console.error(err) 
                return
            }
            console.log('Scris cu succes!');
        });
    });
});

// DELETE 
app.delete('/appointments', (req, res) => {
    fs.readFile('./programari.json', 'utf8', (err, jsonString) => {
        if(err) { 
            console.error(err)
            return
        }
        let programariFacute = JSON.parse(jsonString);
    
        let newObj = {programari: []};

        for(let i = 0; i < programariFacute.programari.length; i++) {
            if( req.body.id !=  programariFacute.programari[i].id ) {
                newObj.programari.push(programariFacute.programari[i]);
            }
        }

        let jsonUpdate = JSON.stringify(newObj);
        fs.writeFile('./programari.json', jsonUpdate, 'utf8', err => {
            if(err) { 
                console.error(err)
                return
            }
            console.log('Scris cu succes!');
        });
    });

});

app.listen(port, () => console.log(`Server started on port ${port}`));