'use strict';

module.exports = function(grunt) {

    grunt.initConfig({
        uglify: {
            dest: {
                options: {
                    sourceMap: true,
                    sourceMapName: 'dest/angular-fsm.min.map'
                },
                files: {
                    'dest/angular-fsm.min.js': ['src/fsm.js']
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
}
