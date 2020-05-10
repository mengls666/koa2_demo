module.exports = {
    "env": {
        "browser": true,
        "commonjs": true,
        "es6": true
    },
    "extends": "eslint:recommended",
    "globals": {
        "Atomics": "readonly",
        "SharedArrayBuffer": "readonly"
    },
    "parserOptions": {
        "ecmaVersion": 11
    },
    "rules": {
        'no-unused-vars': [2, { 
            // 允许声明未使用变量
            "vars": "local",
            // 参数不检查
            "args": "none" 
          }],
    }
};
