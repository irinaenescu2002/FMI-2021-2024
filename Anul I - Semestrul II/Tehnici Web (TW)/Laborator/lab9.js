fetch("https://jsonplaceholder.typicode.com/todos/1")
    .then(response => response.json())
    .then (data => data)
    .catch (e => console.warn(e))

/// then - stablim ce se intampla cand primim o promisiune
/// catch - stabilim ce se intampla cu eroarea
/// warn - apare cu galben 
/// error - apare cu rosu 
/// functia fetch returneaza o promisiune