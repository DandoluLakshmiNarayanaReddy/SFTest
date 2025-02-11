import { LightningElement } from 'lwc';

const DELAY = 300;

export default class MovieSearch extends LightningElement {

    selectedType = '';

    selectedsearch = '';

    loading = false;

    selectedPageNo = '1';

    searchResults = [];

    typeoptions = [

        { label: 'None', value: '' },

        { label: 'Movie', value: 'movie' },

        { label: 'Series', value: 'series' },

        { label: 'Episode', value: 'episode' }

    ];

    handleChange(event) {

        let { name, value } = event.target;

        this.loading = true;

        if (name === 'type') {

            this.selectedType = value;

        } else if (name === 'search') {

            this.selectedsearch = value;

        } else if (name === 'pageno') {

            this.selectedPageNo = value;

        }

        clearTimeout(this.delayTimeout);

        this.delayTimeout = setTimeout(() => {

            this.searchMovies();

        }, DELAY);

    }

    async searchMovies() {

        const url = `https://www.omdbapi.com/?s=${this.selectedsearch}&type=${this.selectedType}&page=${this.selectedPageNo}&apikey=928edd42`;

        const res = await fetch(url);

        const data = await res.json();

        console.log('Movies Search Output', data);

        if (data.Search) {

            this.searchResults = data.Search;

        } else {

            this.searchResults = [];

        }

        this.loading = false;

    }

}