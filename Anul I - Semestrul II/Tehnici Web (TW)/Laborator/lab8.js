const timeInMs = 500;
const body = document.getElementsByTagName("body")[0];
const buttons = document.getElementsByTagName("button");
const div = document.getElementsByTagName("div")[0]
const h1 = document.getElementsByTagName("h1")[0];
 

/// ADDED AFTER apare in pagina dupa ce a expirat timpul precizat 
const id = setTimeout(() => {
    h1.innerHTML = `Added after ${timeInMs}ms`
}, timeInMs)

/// Functia are un ID ce o identifica si care poate fi afisat in consola
console.log(id);

/// Se poate bloca executia ei cu:
// clearTimeout(id);

/// Codul asicron nu blocheaza executia celorlalte linii de cod !!
// setTimeout(() => {console.log("this is the first message")}, 5000);
// setTimeout(() => {console.log("this is the second message")}, 3000);
// setTimeout(() => {console.log("this is the third message")}, 1000);
 

/// CEAS 
// const id2 = setInterval(() => {
//     h1.innerHTML = `Current date: ${new Date()}`;
// }, timeInMs)
 
// console.log(id2)
 
/// BLOCAREA EXECUTIEI 
// setTimeout(() => {
//     clearInterval(id2)
// }, 1500)


// /// INSPECT - APLICATION - LOCAL STORAGE 

// /// Aflarea si afisarea valorii
// const userInfo = localStorage.getItem('animal');
 
// div.innerHTML += `Value in localstorage: ${JSON.parse(userInfo).password}`
 
// /// Functia de set apelata - la o anumita cheie setam o anumita valoare
// /// DUpa ce e setata, ramane 4ever
// buttons[0].addEventListener("click", () => {
//     localStorage.setItem('animal', JSON.stringify({user: "user", password: "pass"}))
// })
 
// /// Se sterge doar un singur element 
// buttons[1].addEventListener("click", () => {
//     localStorage.removeItem("animal")
// })
 
// /// Se sterge tot 
// // localStorage.clear()
 

// /// MODEL FORMULAR 

// const emailRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
// const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})/;
 
// // // h1.innerHTML = passRegex.test("Parola1@");

// const h1 = document.getElementsByTagName("h1")[0];
// const errorText = document.getElementsByClassName("error")[0];
// const content = document.getElementById("content");
// const inputs = document.getElementsByTagName("input");
// const button = document.getElementsByName("button")[0];
// const loggedIn = document.getElementById("loggedIn")

// button.addEventListener("click", () => {
//     const email = inputs[0].value;
//     const password = inputs[1].value;
//     if(emailRegex.test(email) && passRegex.test(password)) {
//         localStorage.setItem("email", email);
//         content.style.display = "none";
//         content.style.display = "block";
//     }
// })
 
// let isEmailValid = false;
// let isPasswordValid = false;
 
// if(localStorage.getItem("email")) {
//     content.style.display = "none";
// } else {
//     // content.style.display = "block flex";
//     // if(emailRegex.test(email) && passRegex.test(password)) {
//     //     console.log()
//     //     button.disabled = "false";
//     // }
// }