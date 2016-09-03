class Books {
    constructor() {
    }

    fetchData () {
        return fetch("https://data.bathhacked.org/resource/csxi-j67h.json").then((response) => {
            return response.json();
        });
    }

    getBook (data) {
        var index = Math.round(Math.random() * (data.length - 0) + 0);

        return data[index]['isbn'];
    }

}
