let webpack = require('webpack');

module.exports = {
  entry: './main.js',
  devtool: 'source-map',
  output: {
    filename: './bundle.js'
  },
  watch: true,
  plugins: [
       new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        'window.jQuery': 'jquery',
      })
  ],
};