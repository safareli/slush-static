LOCALS = require("./locals.json")
isWatching = false
{dir, server} = require("./config.json")
gulp = require("gulp")
$ = require("gulp-load-plugins")(lazy: false) #plugins

# if port is in use and Error: listen EADDRINUSE is thrown run
# $ netstat -a -t -p
# get pid of proccess using port and kill it like so
# $kill -9 PID

gulp.task "connect", $.connect.server(
  host: server.hostname
  root: [dir.build]
  port: server.port
  livereload:
    port: server.livereload
)

gulp.task "jade", ->
  gulp.src(dir.source + "/*.jade")
    .pipe $.jade(locals: LOCALS)
    .pipe gulp.dest(dir.build)
    .pipe (if isWatching then $.connect.reload() else $.util.noop())
    .pipe $.notify(message: "Jade task complete")

gulp.task "coffee", ->
  gulp.src(dir.source + dir.scripts + "**/*.coffee")
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()
    .pipe $.coffee(bare: true).on("error", $.util.log)
    .pipe $.concat("main.js")
    .pipe gulp.dest(dir.build + dir.scripts)
    .pipe $.rename(suffix: ".min")
    .pipe $.uglify()
    .pipe gulp.dest(dir.build + dir.scripts)
    .pipe (if isWatching then $.connect.reload() else $.util.noop())
    .pipe $.notify(message: "Scripts task complete")

gulp.task "stylus", ->
  gulp.src(dir.source + dir.styles + "*.styl")
    .pipe $.stylus(
      use: ["nib"]
      import: ["nib"]
    )
    .pipe gulp.dest(dir.build + dir.styles)
    .pipe (if isWatching then $.connect.reload() else $.util.noop())
    .pipe $.notify(message: "Styles task complete")

gulp.task "images", ->
  gulp.src(dir.source + dir.images + "**/*")
    .pipe $.newer(dir.build + dir.images)
    .pipe $.imagemin(
      optimizationLevel: 3
      progressive: true
      interlaced: true
    )
    .pipe (if isWatching then $.connect.reload() else $.util.noop())
    .pipe gulp.dest(dir.build + dir.images)
    .pipe $.notify(message: "Images task complete")

gulp.task "clean", ->
  gulp.src(dir.build, read: false)
    .pipe $.clean()
    .pipe $.notify(message: "Clean task complete")

gulp.task "default", ["clean"], ->
  gulp.start "stylus", "coffee", "images", "jade"
  return

gulp.task "watch", ["connect"], ->
  isWatching = true;
  gulp.watch dir.source + dir.styles + "**/*.styl", ["stylus"]
  gulp.watch dir.source + dir.scripts + "**/*.coffee", ["coffee"]
  gulp.watch dir.source + dir.images + "**/*", ["images"]
  gulp.watch dir.source + "*.jade", ["jade"]
  return
