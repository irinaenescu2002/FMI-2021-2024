if(localStorage.number === undefined){
    localStorage.number = 0
}
else {
    const numberInt = parseInt(localStorage.getItem('number'))
    let newNumber = numberInt + 1
    localStorage.setItem('number', newNumber)
    console.log(newNumber)
    var os = ''
    for(let i=0; i<newNumber; i++){
        os = os + 'o'
    }
    const h = document.getElementsByTagName("h1")[0]
    h.innerHTML = 'Hello' + os
}

const h = document.getElementsByTagName("h1")[0]
h.addEventListener("click", function() {
    localStorage.number = 0
    h.innerHTML = 'Hello'
})
