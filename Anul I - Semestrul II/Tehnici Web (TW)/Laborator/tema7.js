const bila = document.getElementById("ball")
const style = getComputedStyle(bila)
let topValue = parseInt(style.top)
let leftValue = parseInt(style.left)

document.addEventListener("keydown", (e) => {
    switch(e.code) {
        case 'KeyW':
            topValue = parseInt(style.top)
            bila.style.top = `${topValue - 10}px`
            break;
        case 'KeyS': 
            topValue = parseInt(style.top)
            bila.style.top = `${topValue + 10}px`
            break;
        case 'KeyA': 
            leftValue = parseInt(style.left)
            bila.style.left = `${leftValue - 10}px`
            break;
        case 'KeyD': 
            leftValue = parseInt(style.left)
            bila.style.left = `${leftValue + 10}px`
            break;
    }
})

const body = document.getElementsByTagName("body")[0]

function addDiv (x, y){
    let newDiv = document.createElement("div")
    newDiv.setAttribute("class", "square")
    newDiv.style.top = y + 'px'
    newDiv.style.left = x + 'px'
    body.appendChild(newDiv)
}

document.addEventListener("click", (e) => {
    let x = e.pageX
    let y = e.pageY
    if( x > 100){
        addDiv(x, y)
    }
})

const buttonClick = document.getElementsByTagName("button")[0]
buttonClick.addEventListener("click", function(){
    const squares = document.getElementsByClassName("square")
    for(let square of squares){
        square.style.display = "none"
    }
})