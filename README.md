# README

* Ruby version
	- Ruby 2.3.7 

* Gems
	- Rails 5.2.3
	- Devise

* Database
	- sqllite3

* Deployment
	-Unicorn

* Running Tests
	- Run tests on an installed project using ```rails test```

* Deployment instructions on AWS
	Note these steps are for a testing application, do use proper directory creation and user permissions for a production server.
	- Create a new ECS Linux based server
	- SSH into the server and run the follow:
		sudo yum update
		sudo yum -y install git
		sudo yum install nodejs --enablerepo=epel
		git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
		git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
		echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
		echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
		source ~/.bash_profile
		sudo yum install gcc openssl-devel readline-devel sqlite-devel
		rbenv install 2.3.7 
		rbenv global 2.3.7 
		gem update --system
		gem install --no-ri --no-rdoc rails
		gem install bundler
		gem install sqlite3
		gem install unicorn
		gem install rails -v 5.2.3
		rbenv rehash
		rails -v
		sudo mkdir /var/www/html
		git clone https://github.com/DanielMoreno/AirbnbTestApp.git /var/www/html/AirbnbTestApp
		sudo mkdir /var/run/unicorn
		sudo chmod 777 /var/run/unicorn
		Confirm ngnix is installed, else: sudo amazon-linux-extras install nginx1.12
		sudo chown -R nginx:ec2-user /var/www/html
		sudo chmod 2777 /var/www -R
