// FISIERE SEPARATE JS 

// UTILIZAREA DE SELECTOR DOM DUPA ID
const divCeas = document.getElementById('ceas')

// MODIFICARE DE STILURI CSS 
divCeas.style.justifyContent = 'right'
divCeas.style.fontSize = "20px"
divCeas.style.fontWeight = "bold"

// UTILIZAREA SETTIMEOUT CU UN SENS BINE DEFINIT (CEAS)
function checkTime(i) {
  if (i < 10) {
      i = "0" + i
    }
  return i
}
function startTime() {
  const today = new Date()
  let h = today.getHours()
  let m = today.getMinutes()
  let s = today.getSeconds()
  m = checkTime(m)
  s = checkTime(s)
  divCeas.innerHTML =  h + ":" + m + ":" + s
  setTimeout(startTime, 1000)
}

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