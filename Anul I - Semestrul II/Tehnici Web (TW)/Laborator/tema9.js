const express = require('express');
const fs = require('fs');
const app = express();
const port = 4000;

app.set('view engine', 'ejs');

app.get('/', (req, res) => {
    fs.readFile('./students.json', 'utf8', (err, jsonString) => {
        if(err) {
            console.error(err);
            return;
        } else {
            const studentss = JSON.parse(jsonString);
            
            res.render('./tema9', {
                students: studentss.students
            });
        }
    });
});

app.listen(port, () => {
    console.log(`Serverul a pornit la portul: ${port}`);
});