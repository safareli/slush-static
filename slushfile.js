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
    var prompts = [{
        name: 'appName',
        message: 'What is the app name?'
    }, {
        name: 'appDescription',
        message: 'What is the description?'
    }, {
        name: 'appVersion',
        message: 'What is the module version?',
        default: '0.1.0'
    }, {
        name: 'authorName',
        message: 'What is the author name?',
    }, {
        name: 'authorEmail',
        message: 'What is the author email?',
    }, {
        name: 'userName',
        message: 'What is the github username?',
    }, {
        type: 'list',
        name: 'license',
        message: 'Choose your license type',
        choices: ['MIT', 'BSD'],
        default: 'MIT'
    }];
    //Ask
    inquirer.prompt(prompts,
        function(answers) {
            if (!answers.appName) {
                return done();
            }
            answers.appNameSlug = _.slugify(answers.appName);
            var d = new Date();
            answers.year = d.getFullYear();
            answers.date = d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate();
          
            files.push('!' + __dirname + '/templates/LICENSE_' + ((answers.license === 'MIT') ? 'BSD' :'MIT'));
          
            gulp.src(__dirname + '/templates/**')
                .pipe(template(answers))
                .pipe(rename(function(file) {
                    file.basename = file.basename.replace('LICENSE_' + answers.license, 'LICENSE');;
                  
                    if (file.basename[0] === '_') {
                        file.basename = '.' + file.basename.slice(1);
                    }
                }))
                .pipe(conflict('./'))
                .pipe(gulp.dest('./'))
                .pipe(install())
                .on('end', function() {
                    done();
                });
        });
});
