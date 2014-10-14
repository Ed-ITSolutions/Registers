module.exports = function(grunt){
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-install-dependencies');

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
          {expand: true, src: ['./package.json', 'LICENSE.markdown', 'README.markdown'], dest: 'build/<%= pkg.version %>/', filter: 'isFile'},
          {src: 'build/<%= pkg.version %>/lib/application.js', dest: 'build/<%= pkg.version %>/lib/index.js', filter: 'isFile'},
          {src: 'build/<%= pkg.version %>/lib/client/client.js', dest: 'build/<%= pkg.version %>/lib/client/index.js', filter: 'isFile'}
        ]
      }
    },

    'install-dependencies':{
      options: {
        cwd: 'build/<%= pkg.version %>'
      }
    },

    shell: {
      launch: {
        command: 'C:\\AtomShell\\16.2\\atom.exe C:\\Github\\repos\\Registers'
      }
    }

  });

  grunt.registerTask('build', ['coffee', 'copy', 'install-dependencies']);
  grunt.registerTask('default', ['shell:launch']);
}
