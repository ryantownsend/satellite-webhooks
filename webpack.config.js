const path = require('path')
const ExtractTextPlugin = require('extract-text-webpack-plugin')

module.exports = {
  entry: ['./app/assets/javascripts/index.js', './app/assets/stylesheets/app.css'],
  output: {
    path: './public',
    filename: 'bundle.js'
  },
  module: {
    rules: [
      {
        test: /\.(png|jpe?g|gif|svg)$/,
        use: ['file-loader']
      },
      {
        test: /\.(scss|css)$/,
        use: ['style-loader', 'css-loader']
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: ['babel-loader']
      }
    ]
  }
}
