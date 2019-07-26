# AWS-本番環境
server '13.113.97.152', user: 'hajime', roles: %w{app db web}
set :ssh_options, keys: '~/.ssh/sokudoku-bunko_key_rsa'
