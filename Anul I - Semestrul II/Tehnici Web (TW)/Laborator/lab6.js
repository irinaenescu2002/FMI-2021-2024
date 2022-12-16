// SELECTARE ELEMENT DUPA ID
//const paragraph = document.getElementById("par");

// SELECTARE DUPA TAG --> un vector cu toate elementele lui p
// [0] --> primul element din paragraf 
//const paragraph= document.getElementsByTagName("p")[0]

// SELECTARE DUPA CLASA --> vector 
// const paragraphs = document.getElementsByClassName("cls");

// PARCURGERE VECTOR + SUBLINIERE ELEMENTE DIN PARAGRAF (mai multe)
// for(let par of paragraphs) {
//     par.style.textDecoration = "underline"
// }

// SUBLINIERE PARAGRAF
//paragraph.style.textDecoration = "underline";

// INITIERE + ADAUGARE PARAGRAF CU H1 LA BODY 
// const newP = document.createElement("p");
// newP.innerHTML = "<h1> Hello </h1>"
// const bodyNode = document.getElementsByTagName("body")[0];
// bodyNode.appendChild(newP)

// INITIERE + ADAUGARE PARAGRAF SIMPLU LA BODY 
// INNERHTML schimba continutul dintr-un tag
// const newP = document.createElement("p");
// newP.innerHTML = "Hello!"
// const bodyNode = document.getElementsByTagName("body")[0];
// bodyNode.appendChild(newP)

// SCRIPTUL TREBUIE LASAT LA FINAL, DECI VOM FOLOSI INSERT BEFORE
// const bodyNode = document.getElementsByTagName("body")[0];
// const newP = document.createElement("p");
// newP.innerHTML = "Hello!"
// const scriptNode = document.getElementsByTagName("script")[0];
// bodyNode.insertBefore(newP, scriptNode);

// STERGEREA UNUI ELEMENT 
// bodyNode.removeChild(newP);

// ADAUGARE CUVANT LA PARAGRAF 
// const paragraphs = document.getElementsByClassName("cls");
// paragraphs[0].innerHTML  += "Hello";

// SCHIMBARE IMAGINE 
// const imag = document.getElementsByTagName("img")[0];
// imag.src = "https://scms.machteamsoft.ro/uploads/photos/652x450/652x450_134756-vrei-o-broscuta-testoasa-iata-3-specii-care-raman-mereu-micute.jpg";

// REDIMENSIONARE IMAGINE
// imag.style.height = "50vh";
// imag.style.width = "50vw";

// ALTA VARIANTA --> PX
// imag.height = "600";
// imag.width = "600";

// MODIFICARE AL DOILEA ELEMENT DIN CLASA
// const paragraphs = document.getElementsByClassName("cls");
// paragraphs[1].classList.add("boldened")
// putem face si remove
// paragraphs[1].classList.remove("boldened")

// // JOCULET -- schimbare culoare la reincarcare pagina 
// // FACEM UN DIV SI IL ADAUGAM INAINTE DE SCRIPT 
// const newDiv = document.createElement("div");
// const scriptNode = document.getElementsByTagName("script")[0];
// const bodyNode = document.getElementsByTagName("body")[0];
// bodyNode.insertBefore(newDiv, scriptNode);
// // II SETAM DIMENSIUNILE SI UN MESAJ (initial are dimensiuni 0)
// newDiv.style.height = "30px";
// newDiv.style.width = "50px";
// newDiv.innerHTML = "EXIST";
// // DEFINIM O FUNCTIE CE GENEREAZA O CULOARE RANDOM 
// const getRandomColor = () => {
//     // facem o lista cu valorile necesare generarii culorii 
//     const letters = "0123456789abcdef";
//     let color = "#";
//     // folosim math.random --> numar rational din (0, 1)
//     // folosim math.floor --> rotunjim numere la partea intreaga --> 5,78 => 5
//     // inmultim numarul zecinal cu 16 deoarece avem 16 litere, apoi rotunjim sa obtinem index
//     // 0,1 * 16 => 1,6 => 1
//     // 0,99 * 16 => 15,9 => 15
//     for (let i = 0; i < 6; i++){
//         color += letters[Math.floor(Math.random()*16)];
//     }
//     return color;
// }
// // DAM CULOAREA 
// newDiv.style.backgroundColor = getRandomColor();
// // verificam in consola rezultatul 
// console.log(getRandomColor());

// JOCULET -- schimbare culoare la click buton 
// FACEM UN DIV SI IL ADAUGAM INAINTE DE SCRIPT 
const newDiv = document.createElement("div");
const scriptNode = document.getElementsByTagName("script")[0];
const bodyNode = document.getElementsByTagName("body")[0];
bodyNode.insertBefore(newDiv, scriptNode);
// II SETAM DIMENSIUNILE SI UN MESAJ (initial are dimensiuni 0)
newDiv.style.height = "30px";
newDiv.style.width = "50px";
newDiv.innerHTML = "EXIST";
// DEFINIM O FUNCTIE CE GENEREAZA O CULOARE RANDOM 
const getRandomColor = () => {
    // facem o lista cu valorile necesare generarii culorii 
    const letters = "0123456789abcdef";
    let color = "#";
    // folosim math.random --> numar rational din (0, 1)
    // folosim math.floor --> rotunjim numere la partea intreaga --> 5,78 => 5
    // inmultim numarul zecinal cu 16 deoarece avem 16 litere, apoi rotunjim sa obtinem index
    // 0,1 * 16 => 1,6 => 1
    // 0,99 * 16 => 15,9 => 15
    for (let i = 0; i < 6; i++){
        color += letters[Math.floor(Math.random()*16)];
    }
    return color;
}
newDiv.style.backgroundColor = getRandomColor();
// FACEM BUTON
const newButton  = document.createElement("button");
newButton.innerHTML = "Click me";
bodyNode.insertBefore(newButton, scriptNode);
// FACEM EVENIMENTUL
newButton.onclick = () => newDiv.style.backgroundColor = getRandomColor();
// verificam in consola rezultatul 
console.log(getRandomColor());

