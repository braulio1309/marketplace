const mysql= require('mysql2');
const bcrypt = require('bcryptjs');

//Hash

//Mysql

const pool=mysql.createPool({
    connectionLimit:100,
    host:'labs-dbservices01.ucab.edu.ve',
    user:'usr_bd2_27202818',
    password:'27202818',
    database:'bd2_grupo2'
})
const promisePool = pool.promise();

var functions = {
    getAllUsers: async () => {
        const [rows, fields] = await promisePool.query('SELECT * from usuarios')

        

        return rows;
    },
    getUser: async (email) => {

        const [rows, fields] = await promisePool.query('SELECT * from usuarios WHERE correo_usuario=?',[email])

        return rows[0];
    },
    getAllProducts: async () => {
        const [rows, fields] = await promisePool.query('SELECT * from productos p,productos_imagenes i WHERE p.producto_id_pkey=i.producto_id_foreign')
        
        return rows;
    },
    getProduct: async (id) => {

        const [rows, fields] = await promisePool.query(
        'SELECT * from productos p,productos_imagenes i WHERE producto_id_pkey=? AND p.producto_id_pkey=i.producto_id_foreign',
        [id]
        )
        const [rows2, fields2] = await promisePool.query(`SELECT categoria_id_pkey AS idCat, nombre AS nombreCat from categorias c,categorias_productos cp 
        WHERE c.categoria_id_pkey=cp.categoria_id_foreign
        AND cp.producto_id_foreign=?`,[id])
        if(rows2[0]!==undefined){
            rows[0].categorias=[]
            rows2.forEach(categoria=>{
                rows[0].categorias.push(categoria);
            })
        }

        return rows[0];
    },
    getProductByCategory:async (id) => {

        const [rows, fields] = await promisePool.query(
        'SELECT p.*,i.* from productos p,productos_imagenes i,categorias_productos cp WHERE cp.categoria_id_foreign=? AND p.producto_id_pkey=cp.producto_id_foreign AND p.producto_id_pkey=i.producto_id_foreign',
        [id]
        )
        if(rows[0]!==undefined){
            for(let i=0;i<rows.length;i++){
            rows[i].categorias=[]
            let [rows2, fields2] = await promisePool.query(`SELECT categoria_id_pkey AS idCat, nombre AS nombreCat from categorias c,categorias_productos cp 
            WHERE c.categoria_id_pkey=cp.categoria_id_foreign
            AND cp.producto_id_foreign=?`,[rows[i].producto_id_pkey])
            if(rows2[0]!==undefined){
                rows2.forEach(categoria=>{
                    rows[i].categorias.push(categoria);
                })
            }
            }
        }

        return rows;
    },
    getProductByStore:async (id) => {

        const [rows, fields] = await promisePool.query(
        'SELECT p.*,i.* from productos p,productos_imagenes i WHERE p.tienda_id_pkey=? AND p.producto_id_pkey=i.producto_id_foreign',
        [id]
        )
        
        if(rows[0]!==undefined){
            for(let i=0;i<rows.length;i++){
            rows[i].categorias=[]
            let [rows2, fields2] = await promisePool.query(`SELECT categoria_id_pkey AS idCat, nombre AS nombreCat from categorias c,categorias_productos cp 
            WHERE c.categoria_id_pkey=cp.categoria_id_foreign
            AND cp.producto_id_foreign=?`,[rows[i].producto_id_pkey])
            if(rows2[0]!==undefined){
                rows2.forEach(categoria=>{
                    rows[i].categorias.push(categoria);
                })
            }
            }
        }

        return rows;
    },
    getCar:async(id)=>{
        var [rows, fields] = await promisePool.query('SELECT * from carrito WHERE usuario_id_pkey=?',id);
        if(rows[0]===undefined){
            rows=[]
        }
        return rows; 
    },
    existCar:async (id)=>{
        const [rows, fields] = await promisePool.query('SELECT * from carrito WHERE usuario_id_pkey=? AND producto_id_pkey=?',[id.user,id.producto]);
        if(rows[0]===undefined){
            return false;
        }else
            return true;
    },
    updateCar:async(user,prod,cant,cost)=>{

        await promisePool.query(
        'UPDATE carrito SET cantidad=?,costo=? WHERE usuario_id_pkey=? AND producto_id_pkey=?',
        [cant,cost,user,prod]
        )

    },
    getCategoriesName:async () => {
        const [rows, fields] = await promisePool.query('SELECT categoria_id_pkey,nombre,img_ruta from categorias')
        
        return rows;
    },
    getStoresName:async () => {
        const [rows, fields] = await promisePool.query('SELECT tienda_id_pkey,nombre from tiendas')
        
        return rows;
    },
    InsertTable: async function insertTable(tableName,params) {
            
        await promisePool.query(
          `INSERT INTO ${tableName} SET ?`,params
        )
      
    },
    encrypt: function encrypt(text){
        var hash = bcrypt.hashSync(text, 10);
        return hash;
    },
    decrypt: async function decrypt(text,email){
        let aux=await this.getUser(email).catch(err=>{
            throw new Error("Error al buscar al usuario" + err);
        });
        if(aux===undefined){
            return 0;
        }else{
            return bcrypt.compareSync(text,aux.contraseña); 
            
        }
    }
}


module.exports = functions;