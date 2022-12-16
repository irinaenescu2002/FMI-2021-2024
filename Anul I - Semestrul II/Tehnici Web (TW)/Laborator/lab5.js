let myDiv1 = document.getElementsByTagName("div")[0];
let myDiv2 = document.getElementsByTagName("div")[1];

// DECLARARE SI ATRIBUIRE VECTOR LA PRIMUL DIV 
// const arr = [" Paste 🍝 ", " Salata 🥗 ", " Pizza 🍕 "];
// myDiv1.innerHTML = arr;

// PRIMUL ELEMENT SI LUNGIMEA 
// myDiv2.innerHTML = arr[0]; 
// myDiv2.innerHTML = arr.length;

// PUSH SI POP 
// myDiv2.innerHTML = arr.push(" Dulciuri 🧁 ");
// myDiv1.innerHTML = arr;
// arr.pop();
// myDiv1.innerHTML = arr;
// myDiv2.innerHTML = arr.length;

// FACE COPIE
// const copy = arr.slice();
// myDiv2.innerHTML = copy;

// FACE COPIE DE LA 0 LA 1
// const copy = arr.slice(0, 1);
// myDiv2.innerHTML = copy;

// ALTA VERSIUNE DE COPY - returneaza un nou vector
// const copy = [...arr];
// myDiv2.innerHTML = copy;

// PUTEM ADAUGA
// const copy = [...arr, " Dulciuri 🧁 "];
// myDiv2.innerHTML = copy;

// OPERATOR DE DESTRUCTURARE 
// const[paste, salata, dulciuri] = arr;
// myDiv2.innerHTML = paste;

// SELECTIE DE ELEMENTE - cele care contin P
// myDiv2.innerHTML = arr.filter(str => str.includes("P"));

// MODIFICARE ELEMENTE 
// myDiv2.innerHTML = arr.map(str => str + "yey");

// const copy = arr.map(str => ({name: "John", food: str}));
// console.log(copy);

// CAUTA CE INCLUDE PASTE
// console.log(copy.find(person => person.food.includes("Paste")));

// ORDONARE
// const copy = arr.sort((p1, p2) => p2-p1);
// console.log(copy);

// AFISARE SLICE PE STRING
// const str = "s t r i n g"
// myDiv1.innerHTML = str;
// myDiv2.innerHTML = str.slice(0,4);
// console.log(copy);

// ADAUGARE
// myDiv2.innerHTML = str + " YEY"

// AFISARE DIVERSE TIPURI DE DATE
// myDiv2.innerHTML = `Numar oameni: ${5 + 12}`

// AFISARE DATA CURENTA
// myDiv2.innerHTML = `DATA: ${new Date()}`

// LOCATIE FISIER
// myDiv1.innerHTML = window.location

// AFISARE ALERTA SUS
// window.alert("Ai CAstIgAt Un AiFoN 13 !!")
