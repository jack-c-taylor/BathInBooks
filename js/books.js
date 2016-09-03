class Books {
    constructor() {
        this.myData = {};
    }

    fetchData () {
        fetch("https://data.bathhacked.org/resource/csxi-j67h.json").then((response) => {
            return response.json();
        }).then((json) => {
            this.myData = json;

            return this.getBook(this.myData);
        });
    }

    getBook (data) {
        if (data) {
            var index = Math.round(Math.random() * (data.length - 0) + 0);
            console.log(data[index]['isbn']);
            return data[index]['isbn'];
        }
    }

}
