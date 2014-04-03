LOCALS = require("./locals.json")
gulp = require("gulp")
$ = require("gulp-load-plugins")(lazy: false) #plugins

# if port is in use and  Error: listen EADDRINUSE is thrown run
# $ netstat -a -t -p
# get pid of proccess using portand kill like so
# kill -9 PID

gulp.task "connect", $.connect.server(
  host: "0.0.0.0"
  root: ["dist"]
  port: 3000
  livereload:
    port: 4000
)

gulp.task "jade", ->
  gulp.src("./source/*.jade")
    .pipe $.jade(locals: LOCALS)
    .pipe gulp.dest("./dist/")
    .pipe $.connect.reload()
    .pipe $.notify(message: "Jade task complete")

gulp.task "coffee", ->
  gulp.src("./source/scripts/**/*.coffee")
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()
    .pipe $.coffee(bare: true).on("error", $.util.log)
    .pipe $.concat("main.js")
    .pipe gulp.dest("./dist/scripts")
    .pipe $.rename(suffix: ".min")
    .pipe $.uglify()
    .pipe gulp.dest("./dist/scripts")
    .pipe $.connect.reload()
    .pipe $.notify(message: "Scripts task complete")

gulp.task "stylus", ->
  gulp.src("./source/styles/*.styl")
    .pipe $.stylus(
      use: ["nib"]
      import: ["nib"]
    )
    .pipe gulp.dest("./dist/styles")
    .pipe $.connect.reload()
    .pipe $.notify(message: "Styles task complete")

gulp.task "images", ->
  gulp.src("./source/images/**/*")
    .pipe $.newer("dist/images")
    .pipe $.imagemin(
      optimizationLevel: 3
      progressive: true
      interlaced: true
    )
    .pipe $.connect.reload()
    .pipe gulp.dest("dist/images")
    .pipe $.notify(message: "Images task complete")

gulp.task "clean", ->
  gulp.src("dist/", read: false)
    .pipe $.clean()
    .pipe $.notify(message: "Clean task complete")

gulp.task "default", ["clean"], ->
  gulp.start "stylus", "coffee", "images", "jade"
  return

gulp.task "watch", ["connect"], ->
  gulp.watch "source/styles/**/*.styl", ["stylus"]
  gulp.watch "source/scripts/**/*.coffee", ["coffee"]
  gulp.watch "source/images/**/*", ["images"]
  gulp.watch "source/*.jade", ["jade"]
  return
