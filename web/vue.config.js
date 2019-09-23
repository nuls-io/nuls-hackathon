module.exports = {
  publicPath:'./',
  productionSourceMap: false,
  devServer: {
    //host:'10.106.137.245',
    host:'192.168.8.79',
    open:true,
    port: 8080,
    proxy: {
      '/Index': {
        target: 'http://52.82.14.217:7015/v1/Index',
        ws: true,
        changeOrigin: true,
        pathRewrite: { "^/Index": "" }
      },
    }
  }
}