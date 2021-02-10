const express = require('express');
const morgan = require('morgan');

//Ruta de vistas ejs
const path=require('path');
const viewsDirectory=path.join(__dirname,'views');

//Inicialización
const app = express();

//Configuraciones
app.set('port', process.env.PORT || 4000);
app.set('views',viewsDirectory)
app.set('view engine','ejs')

//Middlewares
app.use(morgan('dev'));

//Variables globales

//Routes
app.use(require('./routes')); 

//Static Files
app.use(express.static(path.join(__dirname,"public")));

//Empezar  servidor
app.listen(app.get('port'), () => {
    console.log('Servidor en ', app.get('port'));
});
