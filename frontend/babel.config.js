module.exports = {
  "presets":[
    ['@babel/preset-env',
    {
      useBuiltIns: 'usage',
      corejs: 3,
    }],
  ]
}
// https://stackoverflow.com/questions/61551044/babel-polyfill-is-deprecated-warning-in-create-react-app