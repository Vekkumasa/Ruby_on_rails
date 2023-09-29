const BEERS = {};

const handleResponse = (beers) => {
  BEERS.list = beers;
  BEERS.show();
};

const createTableRow = (beer) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const beername = tr.appendChild(document.createElement("td"));
  beername.innerHTML = beer.name;
  const style = tr.appendChild(document.createElement("td"));
  style.innerHTML = beer.style.name;
  const brewery = tr.appendChild(document.createElement("td"));
  brewery.innerHTML = beer.brewery.name;

  return tr;
};

BEERS.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("beertable");

  BEERS.list.forEach((beer) => {
    const tr = createTableRow(beer);
    table.appendChild(tr);
  });
};

BEERS.sortByName = () => {
  BEERS.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BEERS.sortByStyle = () => {
  BEERS.list.sort((a, b) => {
    return a.style.name.toUpperCase().localeCompare(b.style.name.toUpperCase());
  });
};

BEERS.sortByBrewery = () => {
  BEERS.list.sort((a, b) => {
    return a.brewery.name
      .toUpperCase()
      .localeCompare(b.brewery.name.toUpperCase());
  });
};

const beers = () => {
  if (document.querySelectorAll("#beertable").length < 1) return;
  
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByName();
    BEERS.show();
  });

  document.getElementById("style").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByStyle();
    BEERS.show();
  });

  document.getElementById("brewery").addEventListener("click", (e) => {
    e.preventDefault;
    BEERS.sortByBrewery();
    BEERS.show();
  });

  fetch("beers.json")
    .then((response) => response.json())
    .then(handleResponse);
};

// Breweries

const BREWERIES = {};

const handleBreweryResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createBreweryTableRow = (brewery) => {
  console.log(brewery)
  const tr = document.createElement("tr");
  tr.classList.add("brewerytablerow");
  const breweryName = tr.appendChild(document.createElement("td"));
  breweryName.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const count = tr.appendChild(document.createElement("td"));
  count.innerHTML = brewery.beers.length;
  const isActive = tr.appendChild(document.createElement("td"));
  isActive.innerHTML = brewery.active ? "Active" : "Retired";

  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll(".brewerytablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createBreweryTableRow(brewery);
    table.appendChild(tr);
  });
};;

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return b.year - a.year;
  });
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => {
    return b.beers.length - a.beers.length;
  });
};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  document.getElementById("breweryName").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("breweryYear").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("breweryBeerCount").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleBreweryResponse);
};

export { beers, breweries };