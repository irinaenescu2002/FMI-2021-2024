// FISIERE SEPARATE JS 

// UTILIZARE DE SELECTOR DOM DUPA CLASA
const imagineC = document.getElementsByTagName("img")[0]

// MODIFICARE DE HTML
let ok = 'normal'
const changeImg = () => {
    if (ok == 'normal'){
        imagineC.src = 'rlogo.jpg'
        ok = 'reverse'
    } else {
        imagineC.src = 'logo.jpg'
        ok = 'normal'
    }
}

// UTILIZARE EVENIMENTE PENTRU MOUSE
imagineC.addEventListener("click", () => changeImg())

// SISTEM LOGIN SI LOGOUT + FORMULAR 
const formular = document.getElementsByClassName("formm")[0]
const formularDoi = document.querySelector('.formm')
const sistem = document.getElementsByClassName("sistem")[0]
const buttonLogin = document.getElementsByClassName("login")[0]
const buttonLogout = document.getElementsByClassName("logout")[0]
const text = document.getElementsByClassName("text")[0]
const butSubmit = document.getElementsByClassName("submit")[0]
const butAno = document.getElementsByClassName("another")[0]
const rec = document.getElementsByClassName("rec")[0]
const butAppo = document.getElementById("appo")

// definire variabila ce stabileste daca utilizatorul este logat sau nu 
// ok = false --> nu e logat
// ok = true --> este logat

localStorage.ok = 'false'

if(localStorage.idProgramare === undefined) {
    localStorage.idProgramare = 1;
}

// daca nu e logat afisam sistemul de login si ascundem formularul si sistemul de logout
// altfel afisam formularul
if (localStorage.ok == 'false'){
    formular.style.display = 'none';
    sistem.style.display = 'flex';
    butAno.style.display = 'none'
    rec.style.display = 'none'
}
else {
    formular.style.display = 'flex'
}

// VALIDARE EMAIL SI PAROLA
const emailRegex = /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/;
const passRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

const verifEmail = document.getElementsByTagName("input")[0]
const verifPass = document.getElementsByTagName("input")[1]
const message = document.createElement('div')

buttonLogin.addEventListener('click', () => { 
    if (verifEmail.value === ''){
        message.innerHTML = 'You forgot to type your email!'
        message.style.color = 'red'
        message.style.alignSelf = 'left'
        message.style.marginTop = '10px'
        sistem.appendChild(message)
    }
    else if (verifPass.value === ''){
        message.innerHTML = 'You forgot to type your password!'
        message.style.color = 'red'
        message.style.alignSelf = 'left'
        message.style.marginTop = '10px'
        sistem.appendChild(message)
    }
    else if (emailRegex.test(verifEmail.value) == false){
        message.innerHTML = 'Invalid email!'
        message.style.color = 'red'
        message.style.alignSelf = 'left'
        message.style.marginTop = '10px'
        sistem.appendChild(message)
    }
    else if (passRegex.test(verifPass.value) == false){
        message.innerHTML = 'Invalid password! Your password must contain minimum eight characters, at least one letter, one number and one special character!'
        message.style.color = 'red'
        message.style.alignContent = 'left'
        message.style.alignSelf = 'left'
        message.style.marginTop = '10px'
        sistem.appendChild(message)
    }
    else {
        verifEmail.value = ''
        verifPass.value = ''
        localStorage.ok = 'true'
        formular.style.display = 'flex'
        sistem.style.display = 'none'
    }
})

buttonLogout.addEventListener('click', () => {
    localStorage.ok = 'false'
    formular.style.display = 'none'
    sistem.style.display = 'flex'
    butAno.style.display = 'none'
    rec.style.display = 'none'
})

butSubmit.addEventListener('click', () => {
    formular.style.display = 'none'
    butAno.style.display = 'flex'
    rec.style.display = 'flex'

    let info = {
        id: localStorage.idProgramare, 
        name: formular.elements['firstname'].value,
        phone: formular.elements['phonee'].value,
        date: formular.elements['datapr'].value,
        time: formular.elements['ora'].value,
        activity: formular.elements['tip'].value
    }

    localStorage.idProgramare = +localStorage.idProgramare + 1

    fetch('http://localhost:5000/appointments', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }, 
        body: JSON.stringify(info)
    })
    .then()
})

butAno.addEventListener('click', () => {
    formular.style.display = 'flex'
    butAno.style.display = 'none'
    rec.style.display = 'none'
})

butAppo.addEventListener('click', () => {
    window.location.href = "http://localhost:5000/appointments"
    fetch('http://localhost:5000/appointments', {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        }
    })
    .then()
})
