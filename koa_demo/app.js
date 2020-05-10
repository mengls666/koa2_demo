const Koa = require('koa')
const koajwt = require('koa-jwt');
const jwt= require('jsonwebtoken');
const secret = "it's a secret";
const app = new Koa()
const views = require('koa-views')
const json = require('koa-json')
const onerror = require('koa-onerror')
const bodyparser = require('koa-bodyparser')
const logger = require('koa-logger')
const cors = require('koa2-cors');


// error handler
onerror(app)
app.use(cors({
  origin:function(ctx){
    return '*'
  },
  exposeHeaders: ['WWW-Authenticate', 'Server-Authorization'],
  maxAge: 5,
  credentials: true,
  allowMethods: ['GET', 'POST', 'OPTIONS','DELETE'],
  allowHeaders: ['Content-Type', 'Authorization', 'Accept']
}))
// middlewares
app.use(bodyparser({
  enableTypes:['json', 'form', 'text']
}))
app.use(json())
app.use(logger())
function getJWTPayload(token) {
  // 验证并解析JWT
  return jwt.verify(token.split(' ')[1], secret);
}
app.use(async(ctx, next)=> {
  var token = ctx.headers.authorization;
  if(token == undefined){
      await next();
  }else{
          ctx.state = {
              data:getJWTPayload(token)
          };

      await next();
  }
})
// eslint-disable-next-line no-undef
app.use(require('koa-static')(__dirname + '/public'))

// eslint-disable-next-line no-undef
app.use(views(__dirname + '/views', {
  extension: 'ejs'
}))

// logger
app.use(async (ctx, next) => {
  const start = new Date()
  ctx.set('Access-Control-Allow-Origin', '*');
  ctx.set('Access-Control-Allow-Headers', 'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild');
  ctx.set('Access-Control-Allow-Methods', 'PUT, POST, GET, DELETE, OPTIONS');
  if (ctx.method == 'OPTIONS') {
    ctx.body = 200; 
  } else {
    await next();
  }
  const ms = new Date() - start
  console.log(`${ctx.method} ${ctx.url} - ${ms}ms`)
})
app.use(koajwt({
  secret
 }).unless({
   path: [/\/userLogin/,/\/userRegister/]
 }));
const index = require('./routes/index')
const users = require('./routes/users')
const items = require('./routes/items')

// routes
app.use(index.routes(), index.allowedMethods())
app.use(users.routes(), users.allowedMethods())
app.use(items.routes(), items.allowedMethods())
// error-handling
app.on('error', (err, ctx) => {
  console.error('server error', err, ctx)
});


module.exports = app


