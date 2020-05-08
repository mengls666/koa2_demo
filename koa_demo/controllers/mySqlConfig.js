var mysql = require('mysql');
var config = require('./defaultConfig.js');
//创建线程池
var pool = mysql.createPool({
    host: config.database.HOST,
    user: config.database.USERNAME,
    password: config.database.PASSWORD,
    database: config.database.DATABASE,
    port: config.database.PORT
});

//统一连接数据库的方法
let allServices = {
    query: function (sql,values) {

        return new Promise((resolve, reject) => {
            pool.getConnection(function (err, connection) {
                if (err) {
                    reject(err)
                } else {                  
                    connection.query(sql,values, (err, rows) => {

                        if (err) {
                            reject(err)
                        } else {      
                            resolve(rows);
                        }
                        connection.release()
                    })
                }
            })
        })

    }   
}
    //读取所有 users 表数据，测试数据链接
    let getAllUsers = function(){
        let _sql = `select * from users;`
        return allServices.query(_sql);
    }
    //需要export出去，用过es6的应该都知道

/**
 * 注册用户
 */
let insertUser = function (value){
    let _sql = `insert into users set username=?,userpwd=?,nickname=?;`
    return allServices.query(_sql,value);
}
/**
 * 查找用户
 */
let findUser = function (username){
    let _sql = `select * from users where username="${username}";`
    return allServices.query(_sql);
}
/**
 * 用户登陆
 */
let userLogin = function (username,userpwd){
    let _sql = `select * from users where username="${username}" 
    and userpwd="${userpwd}";`
    return allServices.query(_sql);
}
let findMarket = function (userid) {
    let _sql = `select market.id,users.nickname, market.amount, market.name, price from market left join users on owner_id like concat("%",users.id,"%")  where owner_id<>${userid} and market.amount <> 0;`
    return allServices.query(_sql);
}
let myMarket = function (userid) {
    let _sql = `select market.id,users.nickname, market.amount, market.name, price  from market left join users on owner_id like concat("%",users.id,"%")  where owner_id=${userid} and market.amount <> 0;`
    return allServices.query(_sql);
}
let myHouse = function (userid) {
    let _sql = `select * from house where owner_id=${userid} and amount <> 0;`
    return allServices.query(_sql);
}
let buy = function (value) {
    let _sql = `insert into order_detail set buyer=?,name=?,amount=?,market_id=?;`
    return allServices.query(_sql,value);
}
let sell = function (value) {
    let _sql = `insert into market set name=?,owner_id=?,amount=?,price=?;`
    return allServices.query(_sql,value);
}
let addStock = function (name,owner_id,amount) {
    let _sql = `INSERT INTO house set name ="${name}", owner_id = ${owner_id},amount = ${amount}
    ON DUPLICATE KEY UPDATE amount = amount + ${amount};`
    return allServices.query(_sql);
}
let pop = function (user_id,amount) {
    let _sql = `update house set amount = amount - ${amount} where (owner_id=${user_id} and amount >=${amount});`
    return allServices.query(_sql);
}
let getAmount = function (user_id) {
    let _sql = `select amount from users where id = ${user_id};`
    return allServices.query(_sql);
}
module.exports = {
    getAllUsers,
    findUser,
    insertUser,
    userLogin,
    findMarket,
    myMarket,
    myHouse,
    buy,
    sell,
    addStock,
    pop,
    getAmount
}