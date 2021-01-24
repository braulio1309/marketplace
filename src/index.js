const express = require('express');
const morgan = require('morgan');

//Inicialización
const app = express();

//Configuraciones
app.set('port', process.env.PORT || 4000);

//Middlewares
app.use(morgan('dev'));

//Variables globales

//Routes
app.use(require('./routes')); 

//Empezar  servidor
app.listen(app.get('port'), () => {
    console.log('Servidor en ', app.get('port'));
});
