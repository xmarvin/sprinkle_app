package :redis do
  description 'Redis'
  apt %w( redis-server )

  verify do
    has_executable 'redis-server'
  end
end
