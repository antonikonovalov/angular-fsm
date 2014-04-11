'use strict';

module.exports = function(grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        uglify: {
            dest: {
                options: {
                    sourceMap: true,
                    sourceMapName: 'dist/angular-fsm.min.map'
                },
                files: {
                    'dist/angular-fsm.min.js': ['src/fsm.js']
                }
            }
        },
        bump: {
            options: {
                updateConfigs: ['pkg','bower.json'],
                commitFiles: ['package.json','bower.json','CHANGELOG.md'],
                commitMessage: 'chore: release v%VERSION%',
                pushTo: 'upstream'
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-bump');
    grunt.loadNpmTasks('grunt-conventional-changelog');
}
