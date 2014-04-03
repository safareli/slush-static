/*
 * slush-static
 * https://github.com/Safareli/slush-static
 *
 * Copyright (c) 2014, Irakli Safareli
 * Licensed under the MIT license.
 */

// https://www.npmjs.org/package/gulp-rename
// todo rename dirs: scripts, source, iamges,styles, dest
// todo use template in template dir files

'use strict';



var gulp = require('gulp'),
    install = require('gulp-install'),
    conflict = require('gulp-conflict'),
    template = require('gulp-template'),
    rename = require('gulp-rename'),
    _ = require('underscore.string'),
    inquirer = require('inquirer');

gulp.task('default', function(done) {
    
    inquirer.prompt(require('./prompts.js'),function(answers) {
        if (!answers.appName) {
            return done();
        }
        answers.appNameSlug = _.slugify(answers.appName);
        var d = new Date();
        answers.year = d.getFullYear();
        answers.date = d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate();
        
        var files = [
            __dirname + '/templates/**', 
            '!' + __dirname + '/templates/node_modules/**',
            '!' + __dirname + '/templates/node_modules/',
            '!' + __dirname + '/templates/LICENSE_' + ((answers.license === 'MIT') ? 'BSD' : 'MIT')
        ];
        
        var answersLookup = function(key) { 
            return answers[key] || key;
        };
        
        gulp.src(files)
            .pipe(template(answers))
            .pipe(rename(function(file) {
                
                file.basename = file.basename.replace('LICENSE_' + answers.license, 'LICENSE');

                file.dirname = file.dirname.replace(/\w*_dir/g,answersLookup);
                file.basename = file.basename.replace(/\w*_dir/g,answersLookup);
                
                if (file.basename[0] === '_') {
                    file.basename = '.' + file.basename.slice(1);
                }
            }))
            .pipe(conflict('./'))
            .pipe(gulp.dest('./'))
            .pipe(install())
        .on('end',done);
    });
});
