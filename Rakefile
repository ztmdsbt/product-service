FileList['./lib/tasks/**/*.rake'].each { |task| load task }

task default: [:'db:migrate', :quality, :spec]
