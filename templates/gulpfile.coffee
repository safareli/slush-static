LOCALS = require("./locals.json")
isWatching = false
{dir, server} = require("./config.json")
gulp = require("gulp")
$ = require("gulp-load-plugins")(lazy: true) #plugins
nib = require("nib")

# if port is in use and Error: listen EADDRINUSE is thrown run
# $ netstat -a -t -p
# get {{PID}} of proccess using port and kill it like so
# $kill -9 {{PID}}
# or if you know proccess {{name}}
# $ killall {{name}} 

gulp.task "connect", ->
  $.connect.server(
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

gulp.task "stylus", ->
  gulp.src(dir.source + dir.styles + "*.styl")
    .pipe $.stylus(
      use: [nib()]
      import: ["nib"]
    )
    .pipe gulp.dest(dir.build + dir.styles)
    .pipe (if isWatching then $.connect.reload() else $.util.noop())

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

gulp.task "clean", ->
  gulp.src(dir.build, read: false)
    .pipe $.clean()

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
