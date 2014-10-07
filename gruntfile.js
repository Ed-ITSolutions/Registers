module.exports = function(grunt){
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'lib/',
        src: ['**/*.coffee'],
        dest: 'build/<%= pkg.version %>/lib/',
        ext: '.js'
      }
    },

    copy: {
      main: {
        files: [
          {expand: true, src: ['assets/**'], dest: 'build/<%= pkg.version %>/'},
          {expand: true, src: ['./package.json', 'LICENSE.markdown', 'README.markdown'], dest: 'build/<%= pkg.version %>/', filter: 'isFile'}
        ]
      }
    }
  });

  grunt.registerTask('build', ['coffee', 'copy']);
}
