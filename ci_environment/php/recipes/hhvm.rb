include_recipe "hhvm"

phpenv_path = "#{node.travis_build_environment.home}/.phpenv"
hhvm_path   = "#{phpenv_path}/versions/hhvm"

directory hhvm_path do
  owner     node.travis_build_environment.user
  group     node.travis_build_environment.group
  action    :create
end

directory "#{hhvm_path}/bin" do
  owner     node.travis_build_environment.user
  group     node.travis_build_environment.group
  action    :create
end

file "#{hhvm_path}/bin/php" do
  owner  node.travis_build_environment.user
  group  node.travis_build_environment.group
  mode   00755
  content <<-CONTENT
#!/usr/bin/env bash
hhvm "$@"
  CONTENT
end

# Install composer
remote_file "#{hhvm_path}/bin/composer.phar" do
  source "http://getcomposer.org/composer.phar"
  owner  node.travis_build_environment.user
  group  node.travis_build_environment.group
end

file "#{hhvm_path}/bin/composer" do
  owner  node.travis_build_environment.user
  group  node.travis_build_environment.group
  mode   00755
  content <<-CONTENT
#!/usr/bin/env bash
hhvm "#{hhvm_path}/bin/composer.phar" "$@"
  CONTENT
end

# Install phpunit
remote_file "#{hhvm_path}/bin/phpunit.phar" do
  source "https://phar.phpunit.de/phpunit.phar"
  owner  node.travis_build_environment.user
  group  node.travis_build_environment.group
end

file "#{hhvm_path}/bin/phpunit" do
  owner  node.travis_build_environment.user
  group  node.travis_build_environment.group
  mode   00755
  content <<-CONTENT
#!/usr/bin/env bash
hhvm "#{hhvm_path}/bin/phpunit.phar" "$@"
  CONTENT
end
