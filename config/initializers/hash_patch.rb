class Hash
 def compact
   self.delete_if { |k, v| v.blank? }
 end
end