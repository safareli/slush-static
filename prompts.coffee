__homeDir = process.env.HOME or process.env.HOMEPATH or process.env.USERPROFILE
__workingDirName = process.cwd().split("/").pop()
__userName = __homeDir and __homeDir.split("/").pop() or "root"
getUser = (->
  user = undefined
  (key) ->
    return user[key]  if user
    config_file = __homeDir + "/.gitconfig"
    if require("fs").existsSync(config_file)
      user = require("iniparser").parseSync(config_file).user  
    user = user or {}
    user.name = user.name or __userName
    user.email = user.email or `undefined`
    user[key]
)()

module.exports = [{
    name: "appName"
    message: "What is the app name?"
    default: __workingDirName
  }, {
    name: "appDescription"
    message: "What is the description?"
  }, {
    name: "appVersion"
    message: "What is the module version?"
    default: "0.0.1"
  }, {
    name: "authorName"
    message: "What is the author name?"
  }, {
    name: "authorEmail"
    message: "What is the author email?"
    default: getUser("email")
  }, {
    name: "userName"
    message: "What is the github username?"
    default: getUser("name")
  }, {
    type: "list"
    name: "license"
    message: "Choose your license type"
    choices: [
      "MIT"
      "BSD"
    ]
    default: "MIT"
  }, {
    name: "source_dir"
    message: "Specify source directory?"
    default: "source"
  }, {
    name: "build_dir"
    message: "Specify build directory?"
    default: "build"
  }, {
    name: "scripts_dir"
    message: "Specify scripts directory?"
    default: "scripts"
  }, {
    name: "images_dir"
    message: "Specify images directory?"
    default: "images"
  }, {
    name: "styles_dir"
    message: "Specify styles directory?"
    default: "styles"
  }, {
    name: "livereload_port"
    message: "Specify livereload port?"
    default: "35729"
  }, {
    name: "server_port"
    message: "Specify web server port?"
    default: "3000"
  }, {
    name: "server_hostname"
    message: "Specify server hostname?"
    default: "localhost"
}]