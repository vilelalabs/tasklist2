const axios = require('axios');
const { onUpdated } = require('vue');


// axios.get('http://127.0.0.1:3001/data')
//     .then((res) => {
//         console.log(res.data);
//     })
//     .catch((err) => {
//         console.log(err);
//     });


// axios.post('http://localhost:3001/data', { name: 'Fazer curso de Vue' })
//     .then((res) => {
//         console.log(res.data);
//     })
//     .catch((err) => {
//         console.log(err);
//     });



// Variables will come from the user interface
let updatedAtDate = new Date();
updatedAtDate = updatedAtDate.toISOString();
//updatedStatus = 'playing';
 updatedStatus = 'stopped';


axios.put('http://localhost:3001/data', {
    id: 3,
    status: updatedStatus,
    updated_at: updatedAtDate
})
    .then((res) => {
        console.log(res.data);
    })
    .catch((err) => {
        console.log(err);
    });
