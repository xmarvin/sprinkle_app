package :mysql_proxy do
  description 'MySQL Proxy'
  apt %w( mysql-proxy )

  verify do
    has_executable 'mysql-proxy'
  end
end
