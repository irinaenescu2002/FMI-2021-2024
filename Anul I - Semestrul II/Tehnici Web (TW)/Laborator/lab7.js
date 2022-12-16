const buttonNode = document.getElementsByTagName("button")[0];
const bodyNode = document.getElementsByTagName("body")[0];
const div = document.getElementById("box")
const selectNode = document.getElementsByTagName("select")[0];
const inputNode = document.getElementsByTagName("input")[0];
const textPar = document.getElementsByTagName("p")[1];
const checkbox = document.getElementById("checkbox");
const formNode = document.getElementsByTagName("form")[0];
 
const changeBgColor = (color) => {
    bodyNode.style.backgroundColor = color;
}
 
const callFunction = () => {
    changeBgColor("salmon");
}
 
buttonNode.addEventListener("click", () => changeBgColor("salmon"))
 
buttonNode.addEventListener("click", (e) => {console.log(e.target)})
 
// buttonNode.removeEventListener("click", callFunction)
 
selectNode.addEventListener("change", (e) => changeBgColor(e.target.value))
 
inputNode.addEventListener("change", (e) => {
    textPar.innerHTML = e.target.value;
    console.log(e.target)
})
 
inputNode.addEventListener("focus", () => {
    inputNode.style.backgroundColor = "salmon"
})
 
inputNode.addEventListener("blur", () => {
    inputNode.style.backgroundColor = "white"
})
 
checkbox.addEventListener("click", (e) => {
    e.preventDefault()
})
 
document.getElementById("button").addEventListener("click", (e) => {
    e.preventDefault()
})
 
inputNode.addEventListener("change", (e) =>{
    textPar.innerHTML=e.target.value;
} )

// URMATOARELE EVENIMENTE APELEAZA PENTRU SCHIMBARI IN TOT DOCUMENTUL, NU DOAR IN ELEMENTE 
// Axa y incepe de sus in jos. 

// COORDONATE MOUSE 
// document.addEventListener("click", (e) => {
//     console.log("X, Y:", e.pageX, e.pageY)
//     div.style.marginTop = `${e.clientY}px`;
//     div.style.marginLeft = `${e.clientX}px`;
// })
 
// e.code genereaza codul tastelor apasate 
// parseInt transforma sirul de caractere in intreg 
// exemplu: daca apas S --> patratul se misca in jos 
//          daca apas W --> patratul se misca in sus
// break deoarece fara el se apeleaza si urmatorul pas 

// document.addEventListener("keydown", (e) => {
//     switch(e.code) {
//         case 'KeyW': 
//             div.style.marginTop = `${parseInt(div.style.marginTop.slice(0, -2)) - 10}px`;
//             break;
//         case 'KeyS': 
//             div.style.marginTop = `${parseInt(div.style.marginTop.slice(0, -2)) + 10}px`;
//             break;
//     }
// })