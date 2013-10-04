package :mysql, :provides => :database do
  description 'MySQL Database'
  apt %w( mysql-server mysql-client libmysqlclient-dev ) do
    post :install, "sudo mysqladmin password toor"
  end
  requires :mysql_grants
  verify do
    has_executable 'mysql'
    has_executable 'mysqld'
  end
end

package :mysql_grants do
  description "MySQL: Default access roles/rights (grants)"

  grants_template = ERB.new(File.read(File.join(File.join(File.dirname(__FILE__), '..', 'assets'), 'mysql.database.sql'))).result

  runner %{mysql -uroot -ptoor < #{grants_template}}

  verify do
    # TODO: Check that grants got set.
  end
end

package :postgresql, :provides => :database do
  description 'PostgreSQL database'
  version = '8.4'

  apt ["postgresql-#{version}", "postgresql-client-#{version}", "libpq-dev", "postgresql-server-dev-#{version}", "postgis", "postgresql-8.4-postgis"] do
    post :install, "sudo -u postgres createuser -S -d -R deployer; echo \"alter user deployer with password 'ployer'\" | sudo -u postgres psql"
#    post :install, "sudo chmod g+w /etc/postgresql/#{version}/main/postgresql.conf"
    post :install, "usermod -G postgres -a deployer"
  end
  
  verify do
    has_executable 'psql'
    has_executable 'pgsql2shp'
    has_file "/usr/lib/postgis/1.5.1/postgres/8.4/lib/postgis-1.5.so"
  end
end

package :mongodb, :provides => :database do
  apt %w(mongodb mongodb-server mongodb-dev mongodb-clients)
  
  verify do
    has_executable 'mongod'
  end
end
