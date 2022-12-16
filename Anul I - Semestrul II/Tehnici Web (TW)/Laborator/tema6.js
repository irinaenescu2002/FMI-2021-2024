/// EXERCITIUL 1
const bodi = document.getElementsByTagName("body")[0];
const newDiv = document.createElement("div");
newDiv.style.width = "100vw";
newDiv.style.height = "100vh";
newDiv.style.display = "flex";
newDiv.style.justifyContent = "space-around";
bodi.appendChild(newDiv);

/// EXERCITIUL 2
const getRandomTopMargin = (element) => {
    const elementHeight = parseInt(element.style.height)
    return Math.floor(Math.random() * (window.innerHeight - elementHeight))
}

/// EXERCITIUL 3
const newDivU = document.createElement("div");
newDivU.style.width = "300px";
newDivU.style.height = "300px";
newDivU.style.position = "relative";
newDivU.style.background = "red";
newDivU.style.top = getRandomTopMargin(newDivU) + 'px';
newDivU.innerHTML = "BUNA SUNT DIV UNU";

const newDivD = document.createElement("div");
newDivD.style.width = "300px";
newDivD.style.height = "300px";
newDivD.style.position = "relative";
newDivD.style.background = "green";
newDivD.style.top = getRandomTopMargin(newDivD) + 'px';
newDivD.innerHTML = "BUNA SUNT DIV DOI";

const newDivT = document.createElement("div");
newDivT.style.width = "300px";
newDivT.style.height = "300px";
newDivT.style.position = "relative";
newDivT.style.background = "yellow";
newDivT.style.top = getRandomTopMargin(newDivT) + 'px';
newDivT.innerHTML = "BUNA SUNT DIV TREI";

newDiv.appendChild(newDivU);
newDiv.appendChild(newDivD);
newDiv.appendChild(newDivT);
