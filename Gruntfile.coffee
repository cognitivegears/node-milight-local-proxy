module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/command.js': ['src/command.litcoffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default', ['coffee']
