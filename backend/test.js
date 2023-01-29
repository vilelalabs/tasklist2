const axios = require('axios');

// axios.get('http://127.0.0.1:3001/data')
//     .then((res) => {
//         console.log(res.data);
//     })
//     .catch((err) => {
//         console.log(err);
//     });


// axios.post('http://localhost:3001/data', { name: 'Fazer curso de HTML' })
//     .then((res) => {
//         console.log(res.data);
//     })
//     .catch((err) => {
//         console.log(err);
//     });



// // Variables will come from the user interface
// let updatedAtDate = new Date();
// updatedAtDate = updatedAtDate.toISOString();
// //updatedStatus = 'playing';
//  updatedStatus = 'stopped';

// axios.put('http://localhost:3001/data', {
//     id: 3,
//     status: updatedStatus,
//     updated_at: updatedAtDate
// })
//     .then((res) => {
//         console.log(res.data);
//     })
//     .catch((err) => {
//         console.log(err);
//     });


axios.delete('http://localhost:3001/data', {
    params: {
        id: 11
    }
})
    .then((res) => {
        console.log(res.data);
    })
    .catch((err) => {
        console.log(err.response.data);
    });