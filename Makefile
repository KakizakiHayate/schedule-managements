PRODUCT_NAME := ScheduleManagements
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

.PHONY:
start_app:
	bundle exec pod install
	open ./${WORKSPACE_NAME}

.PHONY: install_rbenv
install_rbenv:
	brew install rbenv

.PHONY: install_ruby
install_ruby:
	rbenv install 3.2.2
	rbenv local 3.2.2

.PHONY: install_gem
install_gem:
	gem install bundler

.PHONY: install_pod
install_pod:
	gem install cocoapods -v 1.12.1

.PHONY: set_up
set_up: install_rbenv install_ruby install_gem install_pod
