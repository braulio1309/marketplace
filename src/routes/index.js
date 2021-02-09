const express = require('express');
const router = express.Router();
const bodyParser= require('body-parser');
const {check,validationResult}=require('express-validator');
const urlencodedparser=bodyParser.urlencoded({extended:false});
const dbFunc= require('../bd_functions/bdFunctions.js');
var idUsuario=0;


const frases=[" “El precio de la luz es menor que el costo de la oscuridad.” – Arthur C. Nielsen"," “Los datos! ¡Los datos! Los datos! “, gritó con impaciencia. “No puedo hacer ladrillos sin arcilla!” – Sherlock Holmes"," “La información es el aceite del Siglo  XXI, y la analítica es el motor de combustión.” – Peter Sondergaard"," “Los datos se están convirtiendo en la nueva materia prima de los negocios.” –Craig Mundie"," “El producto más valioso que conozco es la información.” – Gordon Gekko , Wall Street"]

router.get('/', async(req, res) => {
    console.log(await dbFunc.getUser('ricardito@gmai.com'));
    res.render('signin',{title:'Marketplace-Registro',footerText:frases[Math.floor(Math.random() * frases.length)]});
});

router.get('/product/:id',async(req,res)=>{
    let data=await dbFunc.getProduct(req.params.id);
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(data)
    res.render('product',{title:`Marketplace-${data.nombre}`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});
router.get('/categoria/:id',async(req,res)=>{
    let data=await dbFunc.getProductByCategory(req.params.id);
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(data)
    res.render('searchPage',{title:`Marketplace-Catalogo`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});
router.get('/tienda/:id',async(req,res)=>{
    let data=await dbFunc.getProductByStore(req.params.id);
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(data)
    res.render('searchPage',{title:`Marketplace-Catalogo`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});
router.get('/search',async(req,res)=>{
    let data=await dbFunc.getAllProducts();
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(data2)
    console.log(idUsuario+"usaurio")
    res.render('searchPage',{title:`Marketplace-Catalogo`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});

router.get('/home',async(req,res)=>{
    let data=await dbFunc.getAllProducts();
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(data2)
    res.render('home',{title:`Marketplace`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});

router.get('/car/:productInfo',async(req,res)=>{
    let idProduct=req.params.productInfo.id;
    let CantProduct=req.params.productInfo.cant; 
    let flag=await dbFunc.existCar({user:idUsuario,producto:idProduct})
    let aux=await dbFunc.getProduct(idProduct)
    let costo=aux.precio - (aux.precio*aux.descuento_porcentaje*100)
    costo=costo*CantProduct
    
    if(flag){
        await dbFunc.updateCar(idUsuario,idProduct,CantProduct,costo)
    }else{
        
        await dbFunc.InsertTable("carrito",{cantidad:CantProduct,costo:costo,usuario_id_pkey:idUsuario,producto_id_pkey:idProduct,estado:1})
    }
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    res.render('car',{title:`Marketplace-Catalogo`,store:data3,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});
router.get('/car',async(req,res)=>{
    let datacar= await dbFunc.getCar(idUsuario)
    console.log(idUsuario)
    let product=[]
    await datacar.forEach(async(item)=>{
        let aux=await dbFunc.getProduct(item.producto_id_pkey)
        console.log(item.producto_id_pkey)
        product.push(aux)
    })
    console.log("2"+product)
    let data2=await dbFunc.getCategoriesName();
    let data3=await dbFunc.getStoresName();
    console.log(3)
    res.render('car',{title:`Marketplace-Catalogo`,datacar:datacar,products:product,store:data3,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
});

router.get('/login', (req, res) => {
    
    res.render('login',{title:'Marketplace-Ingreso',footerText:frases[Math.floor(Math.random() * frases.length)]});
});

router.post('/validateLog', urlencodedparser,[
    check('email','Correo invalido').isEmail().normalizeEmail(),
    check('email','Correo no registrado').custom(async(value, { req }) => {
        let rows=await dbFunc.getUser(value);
        if (rows === undefined) {
          throw new Error('Correo no registrado');
        }
        idUsuario=rows.usuario_id_pkey;
        return true;
    }),
    check('password','Contraseña Incorrecta').custom(async (value, { req }) => {
        let flag=await dbFunc.decrypt(value,req.body.email); 
        if (!flag) {
          throw new Error('Contraseña Incorrecta');
        }
        return true;
    })
],async(req, res) => {
    const errors=validationResult(req);
    if(!errors.isEmpty()){
        const alert= errors.array();
        res.render('login',{title:'Marketplace-Ingreso',footerText:frases[Math.floor(Math.random() * frases.length)],alert});
    }else{    
        let data=await dbFunc.getAllProducts();
        let data2=await dbFunc.getCategoriesName();
        let data3=await dbFunc.getStoresName();
        console.log(data2)
        res.render('home',{title:`Marketplace`,store:data3,product:data,categoria:data2,footerText:frases[Math.floor(Math.random() * frases.length)]});
    }
    

});

router.post('/validateRegister', urlencodedparser,[
    check('email','Correo invalido').isEmail().normalizeEmail(),
    check('nombres','Por favor ingresar un nombre valido, no mayor a 35 caracteres').exists().isLength({max:35}),
    check('apellidos','Por favor ingresar unos apellidos validos, no mayor a 35 caracteres').exists().isLength({max:35}),
    check('password','Ingresar una contraseña de al menos 8 caracteres').isLength({min:8}),
    check('password2','Las contraseñas no coinciden').custom((value, { req }) => {
        if (value !== req.body.password) {
          throw new Error('Las contraseñas no coinciden');
        }
        return true;
    }),
    check('email','Ya existe una cuenta con el email introducido').custom(async (value, { req }) => {
        let aux = 0;

        aux = await (dbFunc.getUser(value));
        console.log("hola");

        if (!(aux === undefined)) {
            console.log(aux)
            throw new Error('Ya existe una cuenta con el email introducido');
        }
        aux = 0;
        return true;
    })
],(req, res) => {
    const errors=validationResult(req);

    if(!errors.isEmpty()){
        const alert= errors.array();
        res.render('signin',{title:'Marketplace-Ingreso',footerText:frases[Math.floor(Math.random() * frases.length)],alert});
    }else{
        if(req.body.admTienda=='1'){
            req.body.admTienda=2;
        }else{
            req.body.admTienda=1;
        }
        console.log(req.body);
        let params={
            nombres:req.body.nombres,
            apellidos:req.body.apellidos,
            correo_usuario:req.body.email,
            telefono:req.body.telefono,
            contraseña:dbFunc.encrypt(req.body.password),
            tipo_de_usuario:req.body.admTienda
        }
        dbFunc.InsertTable('usuarios',params);
        res.render('login',{title:'Marketplace-Ingreso',footerText:frases[Math.floor(Math.random() * frases.length)]});
    }

});


module.exports = router;