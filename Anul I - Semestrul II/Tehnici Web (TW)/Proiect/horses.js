// FISIERE SEPARATE JS 

// UTILIZAREA DE SELECTORI DOM DUPA CLASA 
const divImagine = document.getElementsByClassName("imagine")[0]

// UTILIZAREA CREATEELEMENT 
const divExcited = document.createElement("div")
divExcited.innerHTML = "How excited are you?"
divImagine.appendChild(divExcited)

// MODIFICARE DE STILURI CSS 
divExcited.style.height = "100px"
divExcited.style.width = "100%"
divExcited.style.justifyContent = "center"
divExcited.style.margin = "30px auto "
divExcited.style.background = "linear-gradient(#e6e8ea, white)"
divExcited.style.fontWeight = "bolder"
divExcited.style.fontSize = "20px"
divExcited.style.display = "flex"
divExcited.style.flexDirection = "column"
divExcited.style.alignContent = "center"

// UTILIZARE CREATEELEMENT 
const divLinie = document.createElement("div")
divExcited.appendChild(divLinie)

// MODIFICARE STILURI CSS 
divLinie.style.backgroundColor = "black"
divLinie.style.height = "10px"
divLinie.style.margin = "20px"

// SCHIMBAREA UNEI VALORI A UNEI PROPRIETATI IN ALEATORIU 
const changeWidth = (e) => {
    if (e.code == "Space"){
        divLinie.style.width = Math.floor(Math.random() * 90) + 'vw'
    }
}

// UTILIZAREA DE SELECTORI DOM DUPA TAG 
const tagBody = document.getElementsByTagName("body")[0]

// UTILIZARE EVENIMENTE PENTRU TASTATURA
tagBody.addEventListener("keydown", (e) => changeWidth(e))


