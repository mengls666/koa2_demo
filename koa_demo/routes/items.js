const router = require('koa-router')()
const itemService = require ('../controllers/mySqlConfig')

module.exports = router
router.prefix('/items')
router.get('/', function (ctx, next) {
    ctx.body = 'this is a items response!'
  })
router.get('/findMarket', async(ctx, next) =>{
    var _user = ctx.request.query.user_id
    await itemService.findMarket(_user).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err
        }
    });
})
router.get('/myMarket', async(ctx, next) =>{
    var _user = ctx.request.query.user_id
    await itemService.myMarket(_user).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err
        }
    });
})
router.get('/myHouse', async(ctx, next) =>{
    var _user = ctx.request.query.user_id
    await itemService.myHouse(_user).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err
        }
    });
})
router.get('/buy', async(ctx, next) =>{
    var _buyer = ctx.request.query.buyer
    var _name = ctx.request.query.name
    var _amount = ctx.request.query.amount
    var _marketid = ctx.request.query.market_id
    let data = [_buyer,_name,_amount,_marketid]
    await itemService.buy(data).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err,
            mess: err.sqlMessage
        }
    });
})
router.get('/sell', async(ctx, next) =>{
    var _seller = ctx.request.query.id
    var _name = ctx.request.query.name
    var _amount = ctx.request.query.amount
    var _price = ctx.request.query.price
    let data = [_name,_seller,_amount,_price]
    await itemService.sell(data).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err,
            mess: err.sqlMessage
        }
    });
})
router.get('/pop', async(ctx, next) =>{
    var _id = ctx.request.query.id
    var _amount = ctx.request.query.amount
    var _name = ctx.request.query.name
    await itemService.pop(_id,_name,_amount).then((res)=>{
        if(res.affectedRows==1) {
            ctx.body = {
                code:"800000",
                data: '',
                mess:"ok"
            }  
        } else {
            ctx.body = {
                code:"800003",
                data: '',
                mess: '库存不足！'
            }
        }
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err,
            mess: err.sqlMessage
        }
    });
})
router.get('/addstock', async(ctx, next) =>{
    var _name = ctx.request.query.name
    var _amount = ctx.request.query.amount
    var _id = ctx.request.query.id
    await itemService.addStock(_name,_id,_amount).then((res)=>{
        ctx.body = {
            code:"800000",
            data: res,
            mess:"ok"
        }  
    }).catch((err)=>{
        ctx.body = {
            code:"800002",
            data: err,
            mess: err.sqlMessage
        }
    });
})