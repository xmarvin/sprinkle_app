package :mailutils, :provides => :mail do
  apt ['sendmail', 'mailutils']

  verify do
    has_executable 'mail'
  end
end

package :mailx, :provides => :mail do
  apt ['sendmail', 'bsd-mailx'] 

  verify do
    has_executable 'mail'
  end
end